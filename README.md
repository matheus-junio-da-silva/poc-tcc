# poc-tcc

Pipeline de auditoria com BMad + OpenCode + Certora + Slither.

## Instalacao rapida

```bash
curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash
```

O script:
- pergunta se deseja fazer backup e reinstalar (_bmad, _bmad-output, .opencode, certora_venv, slither_output)
- pergunta o modo do Certora (cloud/local); se cloud, solicita a CERTORAKEY e grava no .env
- remove ANTHROPIC_API_KEY do .env (nao usamos Anthropic)
- instala dependencias do sistema, OpenCode, BMad, Certora CLI e Slither

## Uso rapido

1. Edite o .env (CERTORAKEY se modo cloud; GITHUB_TOKEN opcional)
2. Recarregue o shell: `source ~/.bashrc`
3. Abra o OpenCode no projeto: `opencode` e rode `/connect`
4. Conecte o provider (OpenCode Zen ou GitHub Copilot)
5. Inicie com `bmad-help`

## Reinstalar com backup

Responda `y` quando o script perguntar ou rode:

```bash
env REINSTALL=y bash -c 'curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash'
```

Backups ficam em `_backups/install-YYYYMMDD-HHMMSS/`.

## Modo cloud vs local (nao-interativo)

```bash
env CERTORA_MODE=local bash -c 'curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash'
```

```bash
env CERTORA_MODE=cloud CERTORAKEY=COLOQUE_SUA_CHAVE_AQUI \
  bash -c 'curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash'
```

## Estrutura (principal)

- `_bmad/` e `_bmad-output/`
- `.opencode/agents/` e `.opencode/skills/`
- `certora_venv/`
- `slither_output/`
- `specs/`
