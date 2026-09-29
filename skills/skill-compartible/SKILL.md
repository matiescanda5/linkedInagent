---
name: skill-compartible
description: >
  Convierte cualquier agente o skill propia en un instalador portable que se le puede regalar a otra persona. Separa el conocimiento operativo (que se conserva) de los datos personales y de la empresa (que se reemplazan por una entrevista de instalacion), y lo empaqueta como archivo .skill listo para compartir. Activar cuando el usuario diga "compartir esta skill", "armame un instalador", "quiero regalarle este agente a alguien", "hacela portable", "saca mis datos de esta skill", "version para un amigo", o cualquier variacion de exportar un agente propio para otra persona. Keywords - compartir skill, instalador, portable, regalar agente, exportar skill, .skill, sacar mis datos, anonimizar skill, version para otro.
---

# Skill compartible

Convierte una skill propia en un regalo instalable.

El problema que resuelve: una skill que funciona bien esta llena de datos de quien la usa. Su empresa, sus metricas, su voz, sus contactos, sus rutas de archivo. Si se la pasas asi a alguien, no le sirve, y ademas le estas mandando informacion tuya. Si le sacas todo eso a mano, tardas una hora y te olvidas de la mitad.

Esta skill hace el corte y arma el instalador.

---

## Paso 1: Leer la skill original entera

El `SKILL.md`, todos sus `references/`, y los archivos de estado si los hay.

⚠️ **Leer tambien el estado**, no solo las instrucciones. Ahi es donde se esconden los nombres propios, los contactos y las metricas reales que nadie se acuerda de sacar.

## Paso 2: El corte

Clasificar TODO el contenido en dos columnas. Esta es la unica decision que importa.

### Se conserva: el conocimiento operativo

Lo que seria verdad para cualquiera que use la skill.

- Como funciona la herramienta o la interfaz. **Los selectores, las trampas tecnicas, lo que falla en silencio.** Esto es lo mas valioso que se transfiere, y casi siempre lo mas caro de aprender.
- El flujo de trabajo y el orden de los pasos.
- Las reglas de seguridad y los limites.
- Los criterios de decision expresados como **estructura**, no como contenido. "Definir categorias con criterio duro y verificable" se conserva; "categoria E1: advisors con exit en apps B2C" es contenido.
- La estructura de los archivos de estado y del reporte.
- Los errores conocidos y como se detectan.
- Los checklists.

### Se reemplaza por pregunta: todo lo que sea de la persona

- Nombre, rol, empresa, producto.
- Metricas, cifras, resultados.
- **La voz:** saludos, firma, muletillas, prohibiciones de estilo, textos de referencia.
- Contactos, nombres de terceros, listas de objetivos.
- Links personales: calendar, redes, documentos.
- Rutas de archivo, IDs de bases de datos, tokens, IDs de proyecto.
- Preferencias de horario, idioma y zona horaria.
- Decisiones historicas del tipo "el 5 de agosto se decidio X". Se convierten en la **regla** que dejaron, sin la anecdota.

### Test para casos dudosos

**¿Si otra persona lee esto, le sirve tal cual, o tiene que cambiarlo por lo suyo?**

- Sirve tal cual -> se conserva.
- Tiene que cambiarlo -> se vuelve pregunta.
- **Le sirve como ejemplo pero no como dato** -> se conserva **anonimizado**, contado como caso sin nombres. Los aprendizajes de errores reales son de lo mas util que se puede transferir, y no necesitan el nombre de nadie: "se descarto a un candidato con exit verificado solo por no postear hace 4 meses, y era el mejor de la lista" enseña lo mismo sin exponer a nadie.

⛔ **Ante la duda, preguntar.** Es mejor una entrevista con una pregunta de mas que un instalador que le manda a otra persona una metrica que no era para ella.

## Paso 3: Armar la instalacion

Es la parte que decide si el instalador se usa o se abandona.

### Regla principal: instalacion minima, preguntas sobre la marcha

⛔ **No hacer un cuestionario largo al instalar.** Veinte preguntas antes de que el agente haya hecho nada es la forma mas rapida de que alguien cierre el archivo y no vuelva. Ademas, mucha de esa informacion se contesta sola cuando la persona describe su proyecto.

**El patron correcto:**

1. **Instalacion: dos preguntas.** Como se llama, y una pregunta abierta del tipo *"contame de tu proyecto y pasame toda la informacion que creas que tengo que saber"*. Si puede pasar un link, mejor.
2. **Extraer del texto libre todo lo que se pueda** y escribirlo al perfil.
3. **Devolver un resumen de lo que se entendio y pedir correcciones.** Es mas rapido que corrija tres cosas a que conteste veinte preguntas.
4. **Lo que falta va a una tabla de Huecos**, cada uno con **su disparador**: el momento en que ese dato se vuelve necesario.
5. **Cada hueco se pregunta en ese momento**, no antes.

### La tabla de huecos

Es lo que reemplaza al cuestionario. Por cada dato que falta, definir **cuando hace falta de verdad**:

| Tipo de dato | Disparador tipico |
|---|---|
| Voz y textos reales | Antes del primer texto que sale firmado por la persona |
| Como se presenta | Antes de la primera presentacion en frio |
| Que no mencionar | La primera vez que un output use una cifra |
| Criterios de decision | Antes de la primera decision de ese tipo |
| Links y credenciales | La primera vez que se necesitan |
| Nivel de autonomia | Antes de la primera accion irreversible |
| Preferencias de formato | Se usa un default y se avisa cual |

### Las tres reglas de preguntar sobre la marcha

1. **De a una.** Nunca encadenar preguntas porque "ya que estamos".
2. **Con el contexto de para que.** "Necesito X para poder hacer Y" se contesta; "¿cual es tu X?" se postergra.
3. **Guardar la respuesta al instante.** Preguntar dos veces lo mismo hace que el agente se vuelva molesto y se deje de usar.

### Las dos excepciones

**1. Los textos reales de la persona.** No se saltea ni se reemplaza por una suposicion. Pedirlo apenas haya que escribir algo firmado por esa persona. Sin eso todo suena a plantilla, y es el unico error que se nota del otro lado.

**2. Los criterios de decision del agente.** Todo agente tiene dos o tres parametros que deciden practicamente todo lo demas: a quien acepta, a quien le escribe, que aprueba, que descarta. **Esos no van como hueco suelto: van como una calibracion explicita, antes de la primera accion de ese tipo.**

Si el agente actua sin esos parametros, trabaja bien y produce basura. Y lo peor es que la persona lo descubre en la primera tanda, que es justo cuando se gana o se pierde la confianza en el agente.

**Como se calibra, y esto es lo importante: proponiendo, no preguntando en abstracto.**

⛔ "¿Cual es tu criterio para X?" es imposible de contestar en frio. Nadie tiene su criterio escrito en la cabeza: lo tiene en la forma de reaccionar ante un caso concreto.

✅ **Traer casos reales, proponer un veredicto para cada uno, y pedir que corrija.** De ahi sale el criterio de verdad, y en dos minutos.

Al armar un instalador, identificar cuales son esos dos o tres parametros de la skill original y **darles su propio procedimiento de calibracion**, con el momento exacto en que se dispara.

### El loop de correcciones

Cada correccion que la persona hace sobre una decision del agente **es un parametro nuevo**, y es lo mas valioso que produce el uso.

El instalador tiene que decir explicitamente que esas correcciones **se escriben al perfil en el momento**, y **como regla, no como anecdota**:

- ❌ "El 3 de octubre dijo que no a un consultor"
- ✅ "No contactar consultores ni agencias: no compran, venden"

Sin este loop, el agente comete el mismo error indefinidamente y la persona lo abandona.

### Que preguntar y que no

- **Preguntar por lo que el agente va a necesitar decir**, no por lo que es lindo saber. Si un dato no se usa en ningun output, sobra.
- **Preguntar por lo que NO quiere:** que no se mencione, que palabras odia. Es tan util como lo que si quiere.
- **No preguntar lo que se puede default-ear.** Rutas de archivo, formatos, frecuencias. Se pone un default, se avisa, y que lo cambie si quiere.
- **No preguntar lo que se puede inferir.** Idioma, zona horaria, rubro. Inferirlo y confirmarlo solo si hay ambiguedad real.
- **Aceptar "no se".** Se anota como `SIN DEFINIR` y se sigue.

## Paso 4: Escribir el instalador

Estructura del `SKILL.md` portable:

1. **Paso 0: chequear si existe el perfil.** Si no existe, correr la instalacion.
2. **La instalacion: las dos preguntas**, y que hacer con la respuesta.
3. **La tabla de preguntas sobre la marcha**, con el disparador de cada una.
4. **El manual de operacion**, que es la skill original con los datos personales sacados y reemplazados por referencias al perfil.
5. **Las reglas duras**, las que no dependen de quien la use.
6. **El indice de archivos.**
7. **El mensaje de cierre con la firma.**

⛔ **El perfil arranca incompleto a proposito, y esta bien.** Lo que no se puede es inventar: lo que la persona no dijo se marca como hueco y se pregunta en su momento, nunca se rellena a ojo.

## Paso 5: La firma

Al terminar la instalacion, el agente cierra con un mensaje de quien lo regalo. Es lo que convierte un archivo en un regalo.

Tiene que ser **corto, calido y de una sola vez**. No se repite en cada corrida: aparece solo al final de la instalacion.

Molde:

> Listo, el agente ya quedo instalado.
>
> Una cosa mas. Este agente te lo comparte **[nombre]**, y me pidio que te diga que te desea un lindo dia y lo mejor en este proceso.

Preguntarle al usuario si quiere ese texto o uno propio.

## Paso 6: Empaquetar

Armar la estructura:

```
nombre-de-la-skill/
  SKILL.md
  config/perfil-TEMPLATE.md
  references/
  (state/ vacio, si aplica)
```

⛔ **Los datos de la persona (perfil, estado, reportes) no se escriben dentro de la carpeta de la skill.** En Claude Desktop es de solo lectura, y si se instala como plugin se pisa en cada actualizacion. El instalador tiene que definir una carpeta de datos fuera de la skill (por ejemplo `~/<nombre-del-agente>/`) y decir que todas las rutas de estado son relativas a ella.

Comprimir en un zip **con extension `.skill`**, con la carpeta raiz adentro del zip. Ese archivo se instala con un boton.

⚠️ Si el entorno no deja escribir el zip directo sobre la carpeta de salida, armarlo en una carpeta temporal y copiarlo despues.

## Paso 7: Verificar antes de entregar

Este paso no se saltea. **El costo de un error aca es mandarle datos propios a otra persona.**

- [ ] **Buscar en todos los archivos el nombre del usuario, de su empresa y de sus productos.** Cero resultados, salvo en la firma de cierre.
- [ ] Buscar cifras y metricas sueltas.
- [ ] Buscar links personales: calendar, redes, documentos.
- [ ] Buscar rutas de archivo, IDs y tokens.
- [ ] Buscar nombres de terceros.
- [ ] Confirmar que el conocimiento operativo **si** quedo.
- [ ] **Cada cosa que se saco tiene su hueco con disparador.** Si se elimino un dato y nadie lo va a pedir nunca, el agente va a operar con un agujero silencioso.
- [ ] **Los parametros de decision tienen calibracion explicita**, con casos reales para proponer y corregir, y no quedaron como una pregunta abstracta.
- [ ] **Esta el loop de correcciones**: las correcciones se guardan al perfil, en el momento, como regla.
- [ ] Confirmar que la instalacion son dos preguntas y no un cuestionario.
- [ ] Abrir el zip y verificar que estan todos los archivos.

Al entregar, decirle al usuario **que se conservo, que se reemplazo por pregunta, y que quedo afuera**.

---

## Lo que hace bueno a un instalador

**La entrevista cubre exactamente lo que se saco.** Si se saco la voz pero no se pregunta por la voz, el agente va a escribir generico y nadie va a entender por que.

**El conocimiento duro se conserva entero.** La tentacion es resumir los detalles tecnicos porque son feos y largos. Son lo mas valioso que estas regalando: es lo que le ahorra a la otra persona los meses que vos ya pagaste.

**Los errores se cuentan, sin nombres.** Un instalador que dice "esto falla en silencio, chequealo asi" vale mas que uno que solo dice que hacer.

**La firma esta.** Es lo que hace que se sienta un regalo y no un archivo.
