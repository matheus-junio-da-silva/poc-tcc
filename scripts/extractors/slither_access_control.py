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

def main():
    parser = argparse.ArgumentParser(description="Extracts Certora-optimized context using Slither API.")
    parser.add_argument("input", help="Solidity target path (file or directory)")
    parser.add_argument("--target-contract", help="Filter results to a specific contract name", default=None)
    parser.add_argument("--force-sandbox", action="store_true", help="Force recreate sandbox")
    
    args = parser.parse_args()
    
    # Import sandbox_manager
    import os
    import subprocess
    PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
    sys.path.append(os.path.join(PROJECT_ROOT, 'scripts', 'utils'))
    import sandbox_manager
    
    try:
        # 1. Create or retrieve sandbox
        sandbox_path = sandbox_manager.create_sandbox(args.input, force=args.force_sandbox)
        
        # 2. Update Python's PATH so Slither's subprocess uses the correct NVM Node version
        cmd = f"source $HOME/.nvm/nvm.sh && cd {sandbox_path} && nvm use > /dev/null && dirname $(which node)"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, executable="/bin/bash")
        if result.returncode == 0:
            node_bin_path = result.stdout.strip()
            # Explicitly prepend the NVM Node bin to the very beginning of the PATH
            # This guarantees that Slither uses the NVM node and not a system-wide node.
            os.environ["PATH"] = f"{node_bin_path}:{os.environ.get('PATH', '')}"
            
        # 3. Auto-detect real project root inside sandbox if nested
        target_slither_path = sandbox_path
        if os.path.isdir(sandbox_path) and not os.path.exists(os.path.join(sandbox_path, "contracts")):
            # Look for a subdirectory that has contracts/
            for item in os.listdir(sandbox_path):
                subpath = os.path.join(sandbox_path, item)
                if os.path.isdir(subpath) and os.path.exists(os.path.join(subpath, "contracts")):
                    target_slither_path = subpath
                    print(f"[Extractor] Auto-detected nested project root: {item}")
                    break
                    
        # 4. Run Slither on the detected path
        slither_instance = Slither(target_slither_path)
        md_context = generate_markdown_context(slither_instance, args.target_contract)
        
        # 5. Save context inside sandbox
        output_dir = os.path.join(sandbox_path, "slither_output")
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
        sys.exit(1)

if __name__ == "__main__":
    main()
