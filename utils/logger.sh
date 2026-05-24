#!/usr/bin/env bash
# =============================================================================
# utils/logger.sh — Funções de Log Centralizadas
# =============================================================================

# Define colors only if not already defined to avoid overwriting existing ones.
if [ -z "${RED:-}" ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  BLUE='\033[0;34m'
  CYAN='\033[0;36m'
  BOLD='\033[1m'
  NC='\033[0m'
fi

log_step()  { echo -e "\n${BOLD}${BLUE}==>${NC} ${BOLD}$1${NC}"; }
log_ok()    { echo -e "  ${GREEN}✓${NC} $1"; }
log_warn()  { echo -e "  ${YELLOW}⚠${NC}  $1"; }
log_err()   { echo -e "  ${RED}✗${NC} $1" >&2; }
log_info()  { echo -e "  ${CYAN}ℹ${NC}  $1"; }
