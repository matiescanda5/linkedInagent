#!/usr/bin/env bash
# Instala el agente de outreach por LinkedIn como skill de Claude Code.
#
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/matiescanda5/linkedInagent/main/install.sh | bash
# o, desde un clon del repo:
#   ./install.sh
#
# Por default instala en ~/.claude/skills. Para otro lugar:
#   CLAUDE_SKILLS_DIR=.claude/skills ./install.sh
#
# Tus datos (perfil, historial, reportes) viven en ~/linkedin-agent/ y este
# script no los toca nunca, asi que se puede volver a correr para actualizar.

set -euo pipefail

REPO="https://github.com/matiescanda5/linkedInagent"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
SKILLS="linkedin-outreach-agent skill-compartible"

SRC=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -z "$SRC" ] || [ ! -d "$SRC/skills/linkedin-outreach-agent" ]; then
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  echo "Descargando el agente..."
  curl -fsSL "$REPO/archive/refs/heads/main.tar.gz" | tar -xz -C "$TMP"
  SRC="$(find "$TMP" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
fi

mkdir -p "$DEST"
for s in $SKILLS; do
  rm -rf "${DEST:?}/$s"
  cp -R "$SRC/skills/$s" "$DEST/$s"
  echo "OK  $DEST/$s"
done

cat <<'MSG'

Listo. El agente quedo instalado.

Para arrancar, abri Claude Code y escribi:  instalar agente de linkedin
(si Claude Code ya estaba abierto, empeza un chat nuevo para que tome la skill)

Te va a hacer dos preguntas y el resto lo pregunta sobre la marcha.
MSG
