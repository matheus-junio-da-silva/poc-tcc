#!/usr/bin/env python3
import argparse
import sys
from slither.slither import Slither
from slither.exceptions import SlitherError

def is_env_free(func):
    """
    Checks if a function uses msg.sender, msg.value, block.number, block.timestamp, etc.
    If it doesn't read these state variables, it is considered envfree.
    """
    env_vars = ["msg.sender", "msg.value", "msg.data", "msg.sig", 
                "tx.origin", "tx.gasprice", 
                "block.timestamp", "block.number", "block.coinbase", 
                "block.difficulty", "block.gaslimit", "block.basefee"]
    
    # Check variables read directly in the function
    reads = [v.name for v in func.solidity_variables_read]
    for e in env_vars:
        if e in reads:
            return False
            
    # Check variables read in modifiers
    for mod in func.modifiers:
        if hasattr(mod, 'solidity_variables_read'):
            mod_reads = [v.name for v in mod.solidity_variables_read]
            for e in env_vars:
                if e in mod_reads:
                    return False
            
    # Also need to check if internal calls read env vars
    for internal_call in func.internal_calls:
        if hasattr(internal_call, 'solidity_variables_read'):
            internal_reads = [v.name for v in internal_call.solidity_variables_read]
            for e in env_vars:
                if e in internal_reads:
                    return False
    return True

def generate_markdown_context(slither_instance, target_contract=None):
    md_lines = []
    
    for contract in slither_instance.contracts:
        if target_contract and contract.name != target_contract:
            continue
            
        md_lines.append(f"## Contract: {contract.name}")
        
        # Inheritance
        if contract.inheritance:
            parents = [c.name for c in contract.inheritance]
            md_lines.append(f"**Inheritance:** {', '.join(parents)}")
        else:
            md_lines.append("**Inheritance:** None")
            
        # 1. Constants (Roles & Magic Numbers)
        constants = [v for v in contract.state_variables if v.is_constant or v.is_immutable]
        if constants:
            md_lines.append("\n### Constants & Immutables (Roles/Config)")
            for c in constants:
                md_lines.append(f"- `{c.type} {c.visibility} {c.name}`")
        
        # 2. State Variables (Hooks Targets)
        state_vars = [v for v in contract.state_variables if not v.is_constant and not v.is_immutable]
        if state_vars:
            md_lines.append("\n### State Variables (Storage/Hooks)")
            for v in state_vars:
                md_lines.append(f"- `{v.type} {v.visibility} {v.name}`")
            
        # 3. Public / External functions
        md_lines.append("\n### Public/External Functions (Certora `methods` block)")
        
        has_entry = False
        for func in contract.functions:
            # Skip constructor and internal/private functions
            if func.is_constructor or func.visibility in ["internal", "private"]:
                continue
                
            has_entry = True
            
            # Signature & Returns
            returns_str = ""
            if func.returns:
                ret_types = [str(r.type) for r in func.returns]
                returns_str = f" returns ({', '.join(ret_types)})"
                
            sig = f"{func.name}({','.join([str(p.type) for p in func.parameters])}){returns_str}"
            
            # Env-Free check
            env_free = is_env_free(func)
            env_tag = "**[ENV-FREE]**" if env_free else "[REQUIRES-ENV]"
            
            # Modifiers
            modifiers = [m.name for m in func.modifiers]
            mods_str = ", ".join(modifiers) if modifiers else "None"
            
            # Protected
            is_protected = func.is_protected()
            
            # Writes
            writes = [v.name for v in func.state_variables_written]
            writes_str = ", ".join(writes) if writes else "None (View/Pure)"
            
            # Format
            md_lines.append(f"- **`{sig}`** `{func.visibility}` {env_tag}")
            md_lines.append(f"  - Modifiers: {mods_str}")
            md_lines.append(f"  - Protected: **{'Yes' if is_protected else 'NO (Vulnerable?)'}**")
            md_lines.append(f"  - Writes State: {writes_str}")
        
        if not has_entry:
            md_lines.append("- *No public/external functions detected.*")
            
        md_lines.append("\n---\n")
        
    return "\n".join(md_lines)

# ─────────────────────────────────────────────────────────────
# Slither Execution Helpers
# ─────────────────────────────────────────────────────────────

def _inject_node_into_path(version: str = '22'):
    """
    Inject a specific Node.js version into the current process PATH via NVM.
    This allows Slither's Hardhat/Truffle detection to work correctly.
    """
    import os, subprocess
    cmd = f"source $HOME/.nvm/nvm.sh && nvm install {version} > /dev/null 2>&1 && nvm use {version} > /dev/null 2>&1 && dirname $(which node)"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, executable="/bin/bash")
    if result.returncode == 0 and result.stdout.strip():
        node_bin = result.stdout.strip()
        os.environ["PATH"] = f"{node_bin}:{os.environ.get('PATH', '')}"
        print(f"[Extractor] Injected Node {version} into PATH: {node_bin}")
    else:
        print(f"[Extractor] WARNING: NVM failed for Node {version}. "
              f"stderr: {result.stderr.strip()}", file=sys.stderr)


def _find_solc_binary(solc_version: str, venv_dir: str):
    """Find the solc binary path from solc-select installation."""
    import os
    candidates = [
        os.path.join(os.path.expanduser("~"), ".solc-select", "artifacts",
                     f"solc-{solc_version}", f"solc-{solc_version}"),
        os.path.join(venv_dir, ".solc-select", "artifacts",
                     f"solc-{solc_version}", f"solc-{solc_version}"),
    ]
    for path in candidates:
        if os.path.exists(path):
            return path
    return None


def _run_slither_hybrid(info, venv_dir: str):
    """
    Hybrid Slither execution strategy:
    1. For hardhat/truffle/foundry projects → use native framework detection (directory mode)
    2. For bare projects → use solc directly per-file
    3. If (1) fails → fallback to per-file solc approach
    """
    import os, glob

    slither_kwargs = {}
    solc_bin = _find_solc_binary(info.solc_version, venv_dir)

    # Add remappings if any
    if info.solc_remaps:
        slither_kwargs['solc_remaps'] = ';'.join(info.solc_remaps)
        print(f"[Extractor] Remappings: {slither_kwargs['solc_remaps']}")

    # Strategy 1: Use native framework detection for Hardhat/Truffle/Foundry
    if info.framework in ('hardhat', 'truffle', 'foundry'):
        print(f"[Extractor] Strategy: native {info.framework} compilation")
        try:
            if solc_bin:
                slither_kwargs['solc'] = solc_bin
            sl = Slither(info.project_path, **slither_kwargs)
            contracts = [c.name for c in sl.contracts]
            print(f"[Extractor] ✓ Native compilation succeeded: {len(contracts)} contracts")
            return sl
        except Exception as e:
            print(f"[Extractor] Native compilation failed: {e}")
            print(f"[Extractor] Falling back to per-file solc approach...")

    # Strategy 2: Per-file solc approach (bare projects or fallback)
    print(f"[Extractor] Strategy: per-file solc compilation")
    contracts_dir = info.contracts_dir or info.project_path
    sol_files = []
    for root, dirs, files in os.walk(contracts_dir):
        dirs[:] = [d for d in dirs if d not in ('node_modules', '.git', 'test', 'tests', 'mock', 'mocks')]
        for f in files:
            if f.endswith('.sol'):
                sol_files.append(os.path.join(root, f))

    if not sol_files:
        raise SlitherError(f"No .sol files found in {contracts_dir}")

    print(f"[Extractor] Found {len(sol_files)} .sol files to analyze")

    # Build solc kwargs for per-file mode
    file_kwargs = {}
    if solc_bin:
        file_kwargs['solc'] = solc_bin
    file_kwargs['solc_solcs_select'] = info.solc_version

    # Allow paths: project root + node_modules (for hardhat/console.sol etc.)
    allow_paths = [info.project_path]
    nm_path = os.path.join(info.project_path, 'node_modules')
    if os.path.isdir(nm_path):
        allow_paths.append(nm_path)
    file_kwargs['solc_args'] = f'--allow-paths {",".join(allow_paths)}'

    # Build remappings including hardhat/console.sol if node_modules exists
    remaps = list(info.solc_remaps) if info.solc_remaps else []
    hh_console = os.path.join(nm_path, 'hardhat', 'console.sol')
    if os.path.exists(hh_console):
        remaps.append(f"hardhat/={nm_path}/hardhat/")
    if remaps:
        file_kwargs['solc_remaps'] = ';'.join(remaps)

    # Sort by size descending to prioritize main contracts (more imports = more complete)
    sol_files.sort(key=lambda f: os.path.getsize(f), reverse=True)

    # Aggregate ALL successfully compiled contracts
    best_slither = None
    best_count = 0
    succeeded = 0
    failed = 0

    for sol_file in sol_files:
        try:
            sl = Slither(sol_file, **file_kwargs)
            contracts = [c.name for c in sl.contracts]
            if contracts:
                succeeded += 1
                print(f"[Extractor] ✓ {os.path.basename(sol_file)}: {contracts}")
                # Keep the Slither instance with the most contracts
                if len(contracts) > best_count:
                    best_slither = sl
                    best_count = len(contracts)
        except Exception as e:
            failed += 1
            # Only print first few warnings to avoid spam
            if failed <= 5:
                print(f"[Extractor] WARN: {os.path.basename(sol_file)}: {e}")
            elif failed == 6:
                print(f"[Extractor] ... suppressing further warnings")

    if best_slither is None:
        raise SlitherError(f"All {len(sol_files)} .sol files failed compilation")

    print(f"[Extractor] ✓ Analysis complete: {succeeded} succeeded, {failed} failed, "
          f"best result has {best_count} contracts")
    return best_slither


def main():
    parser = argparse.ArgumentParser(description="Extracts Certora-optimized context using Slither API.")
    parser.add_argument("input", help="Solidity target (local path or GitHub URL)")
    parser.add_argument("--target-contract", help="Filter results to a specific contract name", default=None)
    parser.add_argument("--vuln-type", help="Vulnerability type to target", default="access_control")

    args = parser.parse_args()

    # Import project_manager
    import os
    import subprocess
    PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
    sys.path.append(os.path.join(PROJECT_ROOT, 'scripts', 'utils'))
    import project_manager

    VENV_DIR = os.path.join(PROJECT_ROOT, 'certora_venv')

    try:
        # 1. Prepare project (resolve input, detect framework/solc, install deps)
        pm = project_manager.ProjectManager()
        info = pm.prepare(args.input, args.vuln_type)

        print(f"[Extractor] Project: {info.project_path}")
        print(f"[Extractor] Framework: {info.framework}")
        print(f"[Extractor] Solc: {info.solc_version}")
        print(f"[Extractor] Remaps: {info.solc_remaps}")

        # 2. Inject Node 22 into PATH (for Hardhat/Truffle projects)
        if info.framework in ('hardhat', 'truffle'):
            _inject_node_into_path()

        # 3. Run Slither with hybrid strategy
        slither_instance = _run_slither_hybrid(info, VENV_DIR)
        md_context = generate_markdown_context(slither_instance, args.target_contract)

        # 4. Save context in output directory
        output_dir = os.path.join(info.output_dir, "slither_output")
        os.makedirs(output_dir, exist_ok=True)
        output_file = os.path.join(output_dir, "context.md")
        with open(output_file, "w") as f:
            f.write(md_context)

        print(f"Context extracted successfully. File saved at: {output_file}")

    except SlitherError as e:
        print(f"Slither Error: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()

