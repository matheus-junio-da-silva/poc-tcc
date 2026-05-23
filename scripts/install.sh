#!/usr/bin/env bash
# =============================================================================
# scripts/install.sh — Bootstrap installer (curl | bash)
# Repositorio: poc-tcc
# =============================================================================

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/matheus-junio-da-silva/poc-tcc.git}"
DEFAULT_DIR="${INSTALL_DIR:-$HOME/poc-tcc}"

find_repo_root() {
    local dir="$PWD"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/opencode.jsonc" ] || [ -f "$dir/opencode.json" ] || [ -d "$dir/.git" ]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

if repo_root="$(find_repo_root)"; then
    echo "==> Usando repo em: $repo_root"
    exec bash "$repo_root/install.sh"
fi

if ! command -v git &>/dev/null; then
    echo "Erro: git nao encontrado. Instale o git e rode novamente."
    exit 1
fi

read -r -p "Diretorio de instalacao [$DEFAULT_DIR]: " INSTALL_DIR
INSTALL_DIR="${INSTALL_DIR:-$DEFAULT_DIR}"

if [ -d "$INSTALL_DIR/.git" ]; then
    echo "==> Repo ja existe em: $INSTALL_DIR"
else
    echo "==> Clonando repo em: $INSTALL_DIR"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

exec bash "$INSTALL_DIR/install.sh"
