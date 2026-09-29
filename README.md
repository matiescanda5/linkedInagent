# Agente de outreach por LinkedIn

> **Para instalarlo: pasale el link de este repo a Claude** y decile "instalalo". Claude lee las instrucciones de abajo y te guía.

---

<!--
  Esta seccion esta escrita para Claude. Si sos una persona, podes saltearla.
-->

## 🤖 Si sos Claude y alguien te pasó este repo

La persona quiere instalar este agente. **Guiala sin que tenga que leer nada.** Primero fijate en qué entorno estás:

**A. Tenés terminal (Claude Code, o la pestaña Code de Claude Desktop).** Instalalo vos:

```bash
curl -fsSL https://raw.githubusercontent.com/matiescanda5/linkedInagent/main/install.sh | bash
```

Eso copia las skills a `~/.claude/skills/`. Después **leé `~/.claude/skills/linkedin-outreach-agent/SKILL.md` entero y arrancá la instalación en esta misma conversación**, desde "DONDE VIVEN LOS DATOS" y "PASO 0": son dos preguntas y ninguna más.

**B. No tenés terminal (chat de claude.ai o de Claude Desktop).** No podés instalar archivos, así que decile exactamente esto:

1. Descargá el archivo: https://github.com/matiescanda5/linkedInagent/raw/main/dist/linkedin-outreach-agent.skill
2. Abrilo con Claude Desktop y tocá **Save skill**, o subilo en **Configuración > Capacidades > Skills**.
3. Abrí un chat nuevo y escribí **"instalar agente de linkedin"**.

En los dos casos, avisale que el agente necesita **controlar un navegador con su sesión de LinkedIn abierta** (por ejemplo con la extensión Claude in Chrome). Sin eso se instala pero no puede operar.

---

## Qué es

Un agente que hace tu networking semanal en LinkedIn: revisa las invitaciones que te llegaron, lee el inbox, busca gente que valga la pena contactar, escribe los mensajes **en tu voz**, hace el seguimiento y te deja un reporte.

Destilado de seis meses de corridas reales, dos por semana. Lo que hace que funcione no son las plantillas: es todo lo que aprendió rompiéndose contra la interfaz de LinkedIn, que está documentado adentro.

**Se instala en dos minutos con dos preguntas.** El resto del contexto te lo va pidiendo cuando lo necesita, no en un cuestionario largo antes de que hayas visto nada.

## Qué hace en una corrida

1. **Invitaciones pendientes.** Las revisa y decide cuáles aceptar con tu criterio, no con uno genérico. Al aceptar, manda un mensaje de bienvenida con un dato real de esa persona.
2. **Inbox.** Lee lo no leído, descarta el spam y responde lo relevante en el idioma y el registro en que te escribieron.
3. **Outreach.** Busca candidatos según tus categorías, **valida cada perfil antes de escribir** y manda connection requests personalizados.
4. **Follow-ups.** A quien aceptó y no respondió, verificando primero que el vínculo exista de verdad.
5. **Experimentos.** Testea variantes y mide, para mejorar solo con el uso.
6. **Reporte.** Qué hizo, qué decidió y por qué, y qué te toca a vos.

Tiene **memoria entre corridas**, así que nunca le escribe dos veces a la misma persona.

## Requisitos

Esto no es una app: es una skill para Claude. Necesitás un entorno que le dé:

- **Control de un navegador** con tu sesión de LinkedIn abierta.
- **Lectura y escritura de archivos**, para el perfil y la memoria.

Funciona en Claude Code y en Claude Desktop (modo Cowork) con la extensión de navegador conectada.

---

## Instalación manual

La forma recomendada es pasarle este repo a Claude (ver arriba). Si preferís hacerlo a mano:

### Opción A: el archivo `.skill` (Claude Desktop / claude.ai)

1. Descargá [`dist/linkedin-outreach-agent.skill`](dist/linkedin-outreach-agent.skill).
2. Abrilo con Claude Desktop, o subilo en Configuración > Capacidades > Skills.
3. Tocá **Save skill**.

### Opción B: una línea en la terminal (Claude Code)

```bash
curl -fsSL https://raw.githubusercontent.com/matiescanda5/linkedInagent/main/install.sh | bash
```

### Opción C: como plugin de Claude Code

Dentro de Claude Code:

```
/plugin marketplace add matiescanda5/linkedInagent
/plugin install linkedin-outreach-agent@linkedinagent
```

### Opción D: clonar el repo

```bash
git clone https://github.com/matiescanda5/linkedInagent.git
```

Y copiá `skills/linkedin-outreach-agent/` a `~/.claude/skills/` (o a `.claude/skills/` dentro de un proyecto). Reiniciá el chat para que la tome.

---

## Primer uso

Escribí **"instalar agente de linkedin"** o simplemente **"linkedin"**.

Te va a hacer dos preguntas:

1. ¿Cómo te llamo?
2. Contame de tu proyecto y pasame toda la información que creas que tengo que saber para escribir en tu nombre.

Contestá la segunda a lo bruto, todo junto, sin ordenar. El agente extrae lo que puede, te devuelve un resumen de lo que entendió y le corregís lo que esté mal.

### Después, en el momento

Lo que falta te lo pregunta cuando hace falta, de a una cosa por vez y explicándote para qué la necesita. Hay dos momentos que sí o sí frena a calibrar con vos, porque son los parámetros que deciden todo lo demás:

- **Antes de tocar tu primera invitación**, define con vos a quién aceptar y a quién no. No te pregunta en abstracto: te muestra las invitaciones que tenés ahora con un veredicto propuesto y vos corregís.
- **Antes de buscar el primer candidato**, define a qué perfiles escribirle. Te propone 3 o 4 categorías con el criterio ya escrito y elegís.

Y hay un dato que no se saltea: **te va a pedir 2 o 3 textos que hayas escrito vos**, antes de escribir el primer mensaje con tu nombre. De ahí saca tu ritmo y tus muletillas. Sin eso suena a bot, y es lo único que se nota del otro lado.

### Cada corrección cuenta

Cuando le revertís una decisión o reescribís un mensaje, lo guarda **como regla** en tu perfil. No vuelve a cometer el mismo error.

---

## Qué hay adentro

| Archivo | Qué tiene |
|---|---|
| `skills/linkedin-outreach-agent/SKILL.md` | El flujo completo y las reglas duras |
| `.../references/navegacion-linkedin.md` | **Lo más valioso.** Cómo operar LinkedIn sin romperse: los selectores que funcionan, las trampas, los fallos silenciosos |
| `.../references/calibracion.md` | Cómo se definen los dos parámetros que deciden todo |
| `.../references/categorias-y-sourcing.md` | Cómo definir a quién buscar y dónde encontrarlo |
| `.../references/plantillas.md` | Esqueletos de mensaje, que no son formularios |
| `.../references/estado-y-reporte.md` | La memoria y el formato del reporte |
| `.../references/experimentos.md` | El loop de aprendizaje |
| `.../references/programar-corridas.md` | Cuántas corridas, qué día y a qué hora |
| `.../config/perfil-TEMPLATE.md` | El perfil que se completa solo con el uso |
| `skills/skill-compartible/` | La skill para convertir tus propios agentes en instaladores (ver abajo) |
| `dist/*.skill` | Las dos skills empaquetadas para instalar con un botón |
| `install.sh` | El instalador de una línea para Claude Code |

---

## Seguridad y privacidad

**Tus datos se quedan en tu máquina.** El perfil, el historial y los reportes son archivos locales en `~/linkedin-agent/`, fuera de la skill, así que actualizar el agente no los borra. Este repo no tiene datos de nadie.

⚠️ **Si forkeás este repo, no commitees tu `config/perfil.md` ni tu carpeta `state/`.** El `.gitignore` ya los excluye, pero conviene saberlo: ahí viven tu voz, tus métricas y los nombres de toda la gente que contactaste.

El agente respeta límites pensados para no exponer tu cuenta: espacia las acciones, tiene topes por corrida, y **frena y avisa** si LinkedIn muestra un captcha o un aviso de actividad inusual. Aun así, usalo con criterio: automatizar LinkedIn tiene riesgo y la cuenta es tuya.

Lo público e irreversible (comentar en posts ajenos, compartir) **nunca se ejecuta solo**: queda esperando tu OK.

---

## Cómo compartirlo

Este repo incluye también **`skill-compartible`**, la skill que convierte cualquier agente propio en un instalador portable como este: separa el conocimiento operativo de los datos personales, arma la entrevista de instalación y lo empaqueta.

Si armaste un agente que te sirve y se lo querés regalar a alguien, es la que te evita hacerlo a mano.

---

Hecho con cariño, y compartido para que a otra persona le ahorre los meses que a mí me costó.
