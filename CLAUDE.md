# Instrucciones para Claude

Este repo es un **instalador**: contiene el agente de outreach por LinkedIn (`skills/linkedin-outreach-agent/`), el metodo de cold outreach de Rachel Konrad (`skills/cold-outreach-rachel/`, que el agente usa para redactar los mensajes en frio) y una skill auxiliar (`skills/skill-compartible/`). Si alguien abrio este repo o te lo paso, casi seguro quiere instalar el agente. No hace falta que lo pida con esas palabras.

## Que hacer

1. **Instalar las skills** copiandolas a `~/.claude/skills/`. La forma mas simple es correr `./install.sh` desde la raiz del repo (o `bash install.sh`). Si la persona prefiere que quede solo en un proyecto, usar `CLAUDE_SKILLS_DIR=<proyecto>/.claude/skills ./install.sh`.
2. **Arrancar la instalacion del agente en esta misma conversacion**, sin esperar a que reinicie: leer `skills/linkedin-outreach-agent/SKILL.md` entero y seguir desde "DONDE VIVEN LOS DATOS" y "PASO 0". Son dos preguntas; no hacer ninguna mas.
3. Al final, decirle que en los proximos chats alcanza con escribir **"linkedin"** o **"corre linkedin"**.

## Reglas

- Los datos de la persona van a `~/linkedin-agent/`, **nunca** dentro de este repo ni de la carpeta de la skill.
- No commitear nada de `config/perfil.md`, `state/` ni `reports/` (el `.gitignore` ya los excluye).
- El agente necesita control de un navegador con la sesion de LinkedIn abierta (por ejemplo la extension Claude in Chrome). Si el entorno no lo tiene, avisarlo apenas termine la instalacion, no a mitad de la primera corrida.
