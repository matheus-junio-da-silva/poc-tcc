# poc-tcc

Pipeline de auditoria com BMad + OpenCode + Certora + Slither.

## Instalacao rapida

```bash
curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash
```

O script:
- pergunta o modo do Certora (cloud/local); se cloud, solicita a CERTORAKEY e grava no .env
- remove ANTHROPIC_API_KEY do .env (nao usamos Anthropic)
- instala dependencias do sistema, OpenCode, BMad, Certora CLI e Slither

## Uso rapido

1. Edite o .env (CERTORAKEY se modo cloud; GITHUB_TOKEN opcional)
2. Recarregue o shell: `source ~/.bashrc`
3. Abra o OpenCode no projeto: `opencode` e rode `/connect`
4. Conecte o provider (OpenCode Zen ou GitHub Copilot)
5. Inicie com `bmad-help`

## Modo cloud vs local (nao-interativo)

```bash
CERTORA_MODE=local curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash
```

```bash
CERTORA_MODE=cloud CERTORAKEY=COLOQUE_SUA_CHAVE_AQUI \
	curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash
```

## Instalacao em nova pasta (opcional)

```bash
INSTALL_DIR=~/poc-tcc-novo \
  curl -fsSL https://raw.githubusercontent.com/matheus-junio-da-silva/poc-tcc/main/scripts/install.sh | bash
```

## Estrutura (principal)

- `_bmad/` e `_bmad-output/`
- `.opencode/agents/` e `.opencode/skills/`
- `certora_venv/`
- `slither_output/`
- `specs/`
