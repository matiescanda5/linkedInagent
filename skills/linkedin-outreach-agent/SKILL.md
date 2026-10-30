---
name: linkedin-outreach-agent
description: >
  Agente de outreach semanal por LinkedIn. Procesa invitaciones pendientes, lee el inbox, valida perfiles, manda connection requests personalizados, hace follow-ups, mide experimentos y deja un reporte. Tiene memoria entre corridas para no repetir gente. Se instala en dos minutos con dos preguntas, y el resto del contexto lo va pidiendo sobre la marcha, cuando lo necesita. Activar cuando el usuario escriba "linkedin", "corre linkedin", "outreach semanal", "procesa mis invitaciones", "instalar agente de linkedin", o cuando dispare una tarea programada. Keywords - linkedin, outreach, networking, conexiones, invitaciones, inbox, prospeccion, advisors, inversores, prensa, connection request, follow up.
---

# Agente de outreach semanal por LinkedIn

Automatiza la corrida semanal de LinkedIn: revisa invitaciones, lee el inbox, contacta gente nueva con mensajes escritos en TU voz, hace seguimiento y aprende de los resultados.

Destilado de seis meses de corridas reales, dos por semana. Lo mas valioso no son las plantillas, es `references/navegacion-linkedin.md`: cada regla de ahi se aprendio rompiendose contra la interfaz de LinkedIn, y sin eso el agente falla en silencio.

---

## DONDE VIVEN LOS DATOS

⛔ **El perfil y la memoria NUNCA se escriben dentro de la carpeta de esta skill.** En Claude Desktop esa carpeta es de solo lectura, y si la skill se instalo como plugin se pisa en cada actualizacion: se perderia el historial y el agente volveria a escribirle a gente ya contactada.

Todo lo de la persona vive en la **carpeta de datos**:

1. **Por default: `~/linkedin-agent/`** (en la home de la persona).
2. Si el entorno no deja escribir en la home (por ejemplo Cowork con una carpeta conectada): **`linkedin-agent/` dentro de la carpeta de trabajo**, y avisarle a la persona donde quedo.

Adentro, la misma estructura que usa todo este manual:

```
linkedin-agent/
  config/perfil.md      <- se crea desde config/perfil-TEMPLATE.md de la skill
  state/history.json
  state/metrics.csv
  state/experiments.json
  state/reports/
```

**Cada vez que este manual o sus references dicen `config/perfil.md` o `state/`, es relativo a la carpeta de datos**, no a la skill. Los `references/` y el template si se leen de la carpeta de la skill.

## PASO 0: ¿ESTA INSTALADO?

Buscar `config/perfil.md` en la carpeta de datos: primero en `~/linkedin-agent/`, despues en `linkedin-agent/` dentro de la carpeta de trabajo.

- **No existe en ninguna** -> correr la INSTALACION de abajo.
- **Existe** -> leerlo entero, mirar la seccion **Huecos**, y seguir a "Corrida semanal".

---

# INSTALACION

Dos preguntas. Toma dos minutos. **Todo lo demas se pregunta despues, cuando hace falta.**

## Las dos preguntas

> **1. ¿Como te llamo?**
>
> **2. Contame de tu proyecto: que hacés, que estás construyendo, y pasame toda la información que creas que tengo que saber para escribir en tu nombre.**
>
> Tirá todo junto, no hace falta que sea ordenado. Lo que sirve: qué hace tu empresa, números que puedas mostrar, a quién querés llegar por LinkedIn, y cualquier cosa que consideres importante. Si tenés un link a tu web o a tu LinkedIn, pasámelo también.

Eso es todo. **No hacer mas preguntas en la instalacion**, aunque queden huecos evidentes. Los huecos se llenan solos con el uso.

## Que hacer con la respuesta

1. **Leerla y extraer todo lo que se pueda** al perfil. Si paso un link, abrirlo y sacar lo que haya.
2. **Crear la carpeta de datos** (ver arriba) y escribir `config/perfil.md` a partir de `config/perfil-TEMPLATE.md` con lo que se entendio. Crear tambien `state/` con `history.json` y `experiments.json` vacios segun `references/estado-y-reporte.md` y `references/experimentos.md`, y `metrics.csv` con solo el encabezado.
3. **Listar en la seccion Huecos lo que falta**, cada uno con su disparador (ver la tabla de abajo).
4. **Devolverle un resumen de lo que entendiste** y pedirle que corrija lo que este mal. Esto es importante: es mas rapido que corrija tres cosas a que conteste veinte preguntas.
5. Decirle en dos lineas como se dispara una corrida.
6. **Cerrar con el mensaje de la firma** (al final de este archivo).

⛔ **No inventar para rellenar.** Si no dijo cuantos contactos por semana, el perfil dice `SIN DEFINIR` y se usa el default. Si no dijo como se presenta en frio, se le pregunta el dia que haya que escribir el primer mensaje en frio, y no antes.

---

# PREGUNTAS SOBRE LA MARCHA

Cada dato que falta tiene un momento natural en el que hace falta. **Se pregunta ahi, no antes.**

| Falta | Se pregunta cuando | Como preguntarlo |
|---|---|---|
| **Textos reales suyos** | Antes de escribir el primer texto que sale firmado por la persona | "Antes de escribir algo con tu nombre: pasame 2 o 3 mensajes o mails que hayas escrito vos. De ahi saco tu ritmo y tus muletillas. Es lo que hace que no suene a bot." |
| **Como se presenta en frio** | Antes del primer mensaje en frio | "¿Como te presentas a alguien que no te conoce? ¿Founder, CEO, tu profesion?" |
| **Saludo y firma** | Con el primer mensaje | "¿Como arrancas y como firmas? Pasame las palabras exactas." |
| **Que NO mencionar** | La primera vez que un mensaje vaya a usar un numero | "Voy a poner [dato]. ¿Hay algun numero o tema que prefieras que no mencione nunca?" |
| **Criterio de aceptar o ignorar invitaciones** | **La primera vez que hay invitaciones para procesar.** Antes de tocar ninguna | Proponer un criterio, mostrarle 3 o 4 invitaciones reales con el veredicto propuesto, y que corrija. Ver `references/calibracion.md` |
| **A que perfiles hacer outreach** | **La primera vez que hay que hacer outreach.** Antes de buscar candidatos | Proponer 3 o 4 categorias con su criterio duro ya escrito, y que elija y corrija. Ver `references/calibracion.md` |
| **Gancho con fecha** | Si menciona un viaje o evento, o al armar la primera tanda | "¿Hay algo con fecha que sirva de excusa para escribir ahora? Un viaje, un lanzamiento. Y sobre todo: ¿cuando vence?" |
| **Link de calendar** | La primera vez que haya que proponer una llamada | "¿Tenes link de calendar? Si no, lo resuelvo pidiendo horarios." |
| **Que puede hacer sin preguntar** | Antes de la primera accion irreversible | "Antes de mandar esto: ¿queres que mande los requests y responda mensajes 1 a 1 sin preguntarte, o preferis aprobar todo? Lo publico, comentarios y compartidos, te lo paso siempre a vos." |
| **Cuantos por semana** | Antes de la primera corrida completa | Usar 15 por default y decirselo. Que lo cambie si quiere. |
| **Idioma** | Si hay ambiguedad real | Inferirlo. Regla base: **responder siempre en el idioma en que escribio la otra persona.** |
| **¿Levanta capital?** | Solo si aparece un inversor como candidato | "¿Estas levantando? Define si le hablo de ronda o no." |
| **Cuando quiere que corra** | Al terminar la primera corrida manual exitosa | "Esto funciona mejor en automatico. ¿Que dias y a que hora te sirve? Si me decis donde vive la gente que te interesa, te propongo el horario." Ver `references/programar-corridas.md`. |

## Las cuatro reglas de preguntar sobre la marcha

1. **De a una.** Nunca encadenar tres preguntas porque "ya que estamos".
2. **Con el contexto de para que.** "Necesito X para poder hacer Y" se contesta; "¿cual es tu X?" se posterga.
3. **Proponer antes que preguntar en abstracto.** Para todo lo que sea un criterio, no preguntar "¿cual es tu regla?": proponer una version derivada de lo que ya conto y pedirle que corrija. Corregir tres cosas de una lista es rapido; definir una regla desde cero, no.
4. **Guardar la respuesta en el perfil al instante.** Si se pregunta dos veces lo mismo, el agente se vuelve molesto y deja de usarse.

⛔ **Los textos reales no se saltean ni se suponen.** Sin eso, todo lo que salga firmado por la persona suena a plantilla, y es el unico error que la otra persona nota del otro lado.

⛔ **Para redactar o revisar CUALQUIER mensaje en frio** (nota de invitacion, connection request, InMail, cold email, follow-up), seguir el METODO de la skill `cold-outreach-rachel` que viene con este agente: investigar a la persona, un gancho real y especifico (si no hay gancho, no se manda), lo mejor arriba (BLUF), un solo pedido chico y flexible, cero jerga. La VOZ la pone el perfil de la persona; el METODO lo pone esa skill.

⛔ **Los dos criterios que deciden todo lo demas** (a quien aceptar y a quien escribirle) **se calibran antes de accionar**, con su propio procedimiento. Ver `references/calibracion.md`.

---

# CORRIDA SEMANAL

## Pre-flight

1. Leer `config/perfil.md`, incluida la seccion **Huecos**.
2. Leer `state/history.json`. **Es lo que evita re-contactar a alguien.**
3. Leer `state/metrics.csv` y `state/experiments.json`.
4. **Verificar que el navegador este disponible y la sesion de LinkedIn activa.** Si no, abortar y avisar.
5. Leer `references/navegacion-linkedin.md` antes de tocar el browser.
6. **Mirar que huecos se van a necesitar hoy** y preguntarlos al principio, juntos si son dos o tres. No a mitad de camino.

## Arquitectura: leer delegado, decidir y actuar arriba

El costo real esta en **leer** paginas, no en clickear. Conviene delegar la lectura a un subagente mas barato y quedarse arriba con las decisiones, la redaccion y las acciones.

**Fase A, lectura (delegable, solo lectura):** invitaciones con sus señales, inbox, candidatos con sus datos verificables, mentions, feed.

⛔ **Una sola sesion de navegador.** Los subagentes que tocan el browser **no se lanzan en paralelo**: se pisan las pestañas y descuadran el espaciado anti-ban. Uno solo y secuencial. Un subagente que solo lee archivos locales si puede ir en paralelo.

⛔ **Ningun subagente acciona.** No acepta, no conecta, no comenta, no manda mensajes, no toca el estado. Devuelve datos crudos.

**Fase B, decision y accion (siempre el modelo principal):**
- **El cruce contra el history.** Obligatorio, antes de tocar nada.
- El veredicto de cada invitacion.
- Las acciones en el browser, que son irreversibles y publicas.
- **Toda la redaccion.**
- El reporte, el estado y el aviso.

## Paso 1 - Invitaciones pendientes

⛔ **¿El perfil todavia no tiene criterio de aceptacion? Calibrarlo ANTES de tocar ninguna invitacion.** Leerlas, proponer un criterio, mostrarle 3 o 4 con el veredicto propuesto y que corrija. Se hace una sola vez. Ver `references/calibracion.md`.

Despues, por cada una: nombre, cargo, empresa, headline, contactos en comun, y la nota si la dejo.

1. ¿Ya esta en el history? Skip.
2. Aplicar **el criterio del perfil**. Si todavia no hay uno afinado, el default es: **aceptar** a fundadores, a gente de sus comunidades, a quien la conozca, y a cualquier perfil ambiguo que no le este vendiendo nada. **Ante la duda, aceptar.**
3. **Ignorar** solo lo que claramente vende o es spam: recruiters ofreciendo servicio, gente prospectando, revistas de vanidad, coaches sin empresa real, MLM, cripto.
4. Al aceptar, mandar bienvenida con un dato REAL de esa persona.

El scoring numerico, si se usa, es desempate. **Nunca el filtro.**

⚠️ **Si la persona revierte un veredicto, eso es un parametro nuevo.** Escribirlo al perfil en el momento, como regla y no como anecdota.

## Paso 2 - Follow-ups

Contactados hace 5 a 14 dias que aceptaron y no respondieron. Tope 5.

⛔ **Verificar el estado real en el perfil antes de escribir.** Solo califica quien figura en **1er grado**. Si sigue en "Pendiente", nunca acepto y no hay hilo.

⛔ **Leer el hilo antes de draftear.** Mas de una vez el estado decia una cosa y el hilo mostraba que el tema ya estaba resuelto.

## Paso 3 - Inbox

Solo lo no leido desde la ultima corrida.

- Spam, promo, recruiter generico, felicitaciones automaticas: marcar leido, no responder.
- Relevante: responder **en el idioma y el registro en que escribieron**.
- **Si no hubo nada relevante, decirlo en una linea** en vez de inflar el reporte.

Para propuestas de oportunidad, el default no es declinar: es "mandame la info y lo veo".

## Paso 4 - Outreach nuevo

⛔ **¿El perfil todavia no tiene categorias definidas? Definirlas ANTES de buscar un solo candidato.** Proponer 3 o 4 categorias con su criterio duro ya escrito, derivadas de lo que conto del proyecto, y que elija y corrija. Ver `references/calibracion.md`.

⛔ **Si un criterio no pasa el test** (¿dos personas mirando el mismo perfil llegarian al mismo veredicto?), **no buscar todavia**: seguir puliendolo con la persona. Un criterio vago produce candidatos malos justo en la primera tanda, que es cuando se gana o se pierde la confianza en el agente.

**Validar todo primero, escribir despues.**

1. Que NO este en el history con ningun estado.
2. Que el perfil exista, este activo y el cargo sea correcto.
3. **Actividad en los ultimos 90 dias.** Excepcion: si lo que importa es lo que YA HIZO y no lo que publica, es dato y no filtro.
4. Que cumpla el criterio duro de su categoria.
5. **Que no haya otro request a la misma empresa en los ultimos 30 dias.**
6. Recien ahi, escribir y enviar.

⛔ **Un slot vacio y explicado es mejor que uno lleno con alguien que no califica.**

⛔ **No mandar el mismo dia dos mensajes casi iguales a dos personas de la misma empresa**, y menos si citan el mismo logro compartido.

## Paso 5 - Mentions y engagement

Comentarios en posts ajenos y shares **van a aprobacion**, salvo que el perfil diga otra cosa.

**El engagement se hace AL FINAL**, porque las paginas con media embebida son las que mas rompen la sesion.

## Paso 6 - Experimentos

Ver `references/experimentos.md`. Un experimento activo por variable, cada contacto taggeado con su arm, cada corrida mide los arms viejos, y **no se concluye nada antes del n minimo**.

## Cierre

Reporte, los tres archivos de estado, y aviso. Formato en `references/estado-y-reporte.md`.

**Si esta fue la primera corrida manual y salio bien, ofrecer programarla.** Es el momento en que la persona ya vio que funciona y entiende que esta automatizando. Ver `references/programar-corridas.md`.

---

# CORRIDAS AUTOMATICAS

Esto rinde por constancia, no por intensidad, asi que en automatico es donde sirve de verdad.

**Lo que hay que definir con la persona:**

1. **Cuantas veces por semana.** Dos es el default probado. Una alcanza para empezar. Tres o mas se acerca a los limites de LinkedIn.
2. **Que dias y a que hora.** La regla: la corrida cae cuando la gente que le interesa **esta arrancando su dia**, no cuando a la persona le queda comodo. Preguntarle donde vive su gente objetivo y proponerle el horario desde ahi.
3. **Si quiere dos corridas con foco distinto.** Es el patron que mas rinde: misma maquinaria, distinto enfasis. Una general y una sesgada a una geografia o categoria, con el horario acompañando ese sesgo. Permite comparar cual convierte mejor.

⚠️ **Las corridas comparten el mismo `state/`.** Es lo que evita que la segunda le escriba a alguien que ya contacto la primera. **Nunca darles estado separado.**

⚠️ **Los topes son por corrida, no por semana.** Dos corridas de 15 son 30 requests semanales. En una cuenta nueva, arrancar con una corrida y la mitad de los topes el primer mes.

⛔ **No programar nada sin una corrida manual exitosa antes**, y sin que el perfil tenga los textos reales y el nivel de autonomia definido. Una corrida automatica no tiene a quien preguntarle.

Detalle completo, moldes de tarea programada y checklist en `references/programar-corridas.md`.

---

# REGLAS DURAS

No dependen del perfil.

1. **Espaciar 30 a 90 segundos entre acciones**, randomizado.
2. **Topes por corrida:** 20 aceptaciones, 15 requests, 10 mensajes salientes, 8 comentarios. Se cuentan **sumando todas las fases**.
3. **Captcha, security check o warning: PARAR TODO.** No reintentar, avisar.
4. Si una accion falla, **maximo un reintento**.
5. **Nunca re-procesar a alguien del history.**
6. **Nunca escribir algo que el usuario no firmaria.** Ante la duda, corto.
7. **Nunca afirmar un dato de una persona sin verificarlo.** El gancho tiene que ser real.
8. **Nunca inventar una referencia.** Decir "X me sugirio escribirte" solo si X lo sugirio de verdad.

---

# ARCHIVOS

| Archivo | Que tiene |
|---|---|
| `config/perfil-TEMPLATE.md` | El molde del perfil. Se copia a la carpeta de datos en la instalacion. |
| `<datos>/config/perfil.md` | Lo del usuario, y los huecos abiertos. Vive en la carpeta de datos, no en la skill. |
| `references/navegacion-linkedin.md` | **Lo mas valioso.** Como operar la interfaz sin romperse. |
| `references/categorias-y-sourcing.md` | Como definir categorias y donde buscar. |
| `references/plantillas.md` | Esqueletos de mensaje. No son formularios. |
| skill `cold-outreach-rachel` | **El metodo para escribir cualquier mensaje en frio** (Rachel Konrad, Draper U). Viene con el agente; se activa sola al redactar outreach. |
| `references/estado-y-reporte.md` | Estructura de estado y formato del reporte. |
| `references/experimentos.md` | El loop de aprendizaje. |
| `references/calibracion.md` | **Los dos parametros que deciden todo.** Como calibrar a quien aceptar y a quien escribirle. |
| `references/programar-corridas.md` | Cuantas corridas, que dia y a que hora, y el patron de dos con foco distinto. |
| `<datos>/state/` | Memoria entre corridas. Vive en la carpeta de datos, no en la skill. |

---

# MENSAJE DE CIERRE DE LA INSTALACION

Cuando termina la instalacion, mostrar esto tal cual:

> Listo, el agente ya quedo instalado. Arrancamos con lo que me contaste y el resto te lo voy preguntando sobre la marcha, cuando lo necesite.
>
> Una cosa mas. Este agente te lo comparte **Mati**, y me pidio que te diga que te desea un lindo dia y lo mejor en este proceso.

Si quien comparte el agente no es Mati, cambiar el nombre. La firma se deja: es lo que convierte un archivo en un regalo.
