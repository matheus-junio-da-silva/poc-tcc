#!/usr/bin/env python3
import argparse
import sys
from slither.slither import Slither
from slither.exceptions import SlitherError

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
            
        # Entry Points (Public / External functions that write to state)
        md_lines.append("\n### Entry Points (State-Mutating Public/External Functions)")
        
        has_entry = False
        for func in contract.functions:
            # Skip constructor and internal/private functions
            if func.is_constructor or func.visibility in ["internal", "private"]:
                continue
                
            # Skip functions that don't write state variables
            if not func.state_variables_written:
                continue
                
            has_entry = True
            
            # Extract modifiers
            modifiers = [m.name for m in func.modifiers]
            mods_str = ", ".join(modifiers) if modifiers else "None"
            
            # Use native Slither protection check
            is_protected = func.is_protected()
            
            # Write variables
            writes = [v.name for v in func.state_variables_written]
            writes_str = ", ".join(writes) if writes else "None"
            
            # Format
            md_lines.append(f"- **`{func.name}`** (`{func.visibility}`)")
            md_lines.append(f"  - Modifiers: {mods_str}")
            md_lines.append(f"  - Protected: **{'Yes' if is_protected else 'NO (Vulnerable?)'}**")
            md_lines.append(f"  - Writes State: {writes_str}")
        
        if not has_entry:
            md_lines.append("- *No state-mutating public/external functions detected.*")
            
        md_lines.append("\n---\n")
        
    return "\n".join(md_lines)

def main():
    parser = argparse.ArgumentParser(description="Extracts context from Solidity using Slither API.")
    parser.add_argument("input", help="Solidity target path (file or directory)")
    parser.add_argument("--target-contract", help="Filter results to a specific contract name", default=None)
    
    args = parser.parse_args()
    
    try:
        slither_instance = Slither(args.input)
        md_context = generate_markdown_context(slither_instance, args.target_contract)
        print(md_context)
    except SlitherError as e:
        print(f"Slither Error: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
