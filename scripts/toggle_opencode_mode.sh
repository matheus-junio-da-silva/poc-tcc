#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") <assist|auto>"
  exit 1
}

mode="${1:-}"
case "$mode" in
  assist|auto) ;;
  *) usage ;;
esac

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

config_assist="$root_dir/opencode.assist.jsonc"
config_auto="$root_dir/opencode.autonomous.jsonc"
config_active="$root_dir/opencode.jsonc"

agents_dir="$root_dir/.opencode/agents"
agents_assist="$root_dir/.opencode/agents-assist"
agents_auto="$root_dir/.opencode/agents-autonomous"

timestamp() {
  date +%Y%m%d-%H%M%S
}

move_dir() {
  local src="$1"
  local dest="$2"
  local final_dest="$dest"

  if [[ -d "$dest" ]]; then
    final_dest="${dest}.bak-$(timestamp)"
  fi

  mv "$src" "$final_dest"
}

if [[ ! -f "$config_assist" ]]; then
  if [[ -f "$config_active" ]]; then
    cp "$config_active" "$config_assist"
  else
    echo "Missing $config_active"
    exit 1
  fi
fi

if [[ ! -f "$config_auto" ]]; then
  echo "Missing $config_auto"
  exit 1
fi

switch_to_auto() {
  if [[ -d "$agents_dir" ]]; then
    if [[ -d "$agents_auto" ]]; then
      move_dir "$agents_dir" "$agents_assist"
      mv "$agents_auto" "$agents_dir"
    else
      if [[ -d "$agents_assist" ]]; then
        echo "Agents already in auto mode."
      else
        echo "Warning: missing $agents_auto and $agents_assist; leaving $agents_dir as-is."
      fi
    fi
  else
    if [[ -d "$agents_auto" ]]; then
      mv "$agents_auto" "$agents_dir"
    else
      echo "Warning: missing $agents_dir and $agents_auto; agents not updated."
    fi
  fi

  cp "$config_auto" "$config_active"
  echo "Mode set to auto."
}

switch_to_assist() {
  if [[ -d "$agents_dir" ]]; then
    if [[ -d "$agents_assist" ]]; then
      move_dir "$agents_dir" "$agents_auto"
      mv "$agents_assist" "$agents_dir"
    else
      if [[ -d "$agents_auto" ]]; then
        echo "Agents already in assist mode."
      else
        echo "Warning: missing $agents_assist and $agents_auto; leaving $agents_dir as-is."
      fi
    fi
  else
    if [[ -d "$agents_assist" ]]; then
      mv "$agents_assist" "$agents_dir"
    else
      echo "Warning: missing $agents_dir and $agents_assist; agents not updated."
    fi
  fi

  cp "$config_assist" "$config_active"
  echo "Mode set to assist."
}

if [[ "$mode" == "auto" ]]; then
  switch_to_auto
else
  switch_to_assist
fi
