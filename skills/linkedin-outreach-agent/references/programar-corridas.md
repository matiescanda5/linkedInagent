# Programar las corridas

El agente puede correr a mano ("corre linkedin") o automatico. **Automatico es donde rinde de verdad**, porque el outreach funciona por constancia, no por intensidad.

---

## Cuantas veces por semana

**Dos es el default probado.** Una sola alcanza para empezar, tres o mas empieza a oler a automatizado y acerca a los limites de LinkedIn.

⚠️ **Los topes son POR CORRIDA, no por semana.** Dos corridas de 15 requests son 30 por semana. Eso esta bien para una cuenta con actividad real, y es mucho para una cuenta nueva o con pocos contactos. Si la cuenta es nueva, arrancar con una corrida y la mitad de los topes durante el primer mes.

⛔ **No programar dos corridas el mismo dia.** Dejar al menos un dia entero de por medio.

---

## Que dia y a que hora

La regla es una sola: **la corrida tiene que caer cuando la gente que te interesa esta arrancando su dia**, porque es cuando miran LinkedIn. No cuando a vos te queda comodo.

Eso significa mirar **donde vive tu gente objetivo**, no donde vivis vos:

| Tus targets estan en | Te conviene correr |
|---|---|
| Tu misma ciudad o pais | Media mañana, martes a jueves |
| Estados Unidos, costa oeste, y vos en Europa o Latam | Tu tarde |
| Estados Unidos, costa este, y vos en Europa | Tu tarde temprano |
| Europa, y vos en America | Tu mañana temprano |

**Martes, miercoles y jueves** son los mejores dias. El lunes la gente esta apagando incendios y el viernes ya se fue.

Si hay targets en varios husos horarios, ese es justamente el caso para tener dos corridas con horarios distintos.

---

## El patron de dos corridas con foco distinto

Esto es lo que hace que dos corridas valgan mas que una corrida el doble de grande.

**Misma maquinaria, distinto enfasis.** Las dos usan esta skill completa y el mismo estado compartido. Lo unico que cambia es a quien priorizan.

Ejemplo de como se reparte:

- **Corrida A:** general. Distribucion normal de categorias, foco en la gente de tu propio mercado o idioma.
- **Corrida B:** sesgada. Prioriza una geografia o una categoria concreta, y el horario acompaña ese sesgo.

Por que funciona: **permite comparar.** Cada corrida se etiqueta con un identificador que va al archivo de metricas, asi que a las pocas semanas se ve cual de las dos convierte mejor y se ajusta.

⚠️ **Las dos corridas comparten el mismo `state/`.** Eso es lo que evita que la corrida del jueves le escriba a alguien que ya contacto la del martes. **Nunca darles archivos de estado separados.**

---

## Que poner en la tarea programada

**Lo mas corto posible.** La tarea programada no es el lugar donde vive la configuracion: es un disparador.

Molde:

```
Invoca la skill `linkedin-outreach-agent` con source: "<identificador de esta corrida>".

<Una o dos lineas con el enfasis de esta corrida, si tiene uno.>

Al terminar, <como avisar>.
```

Ejemplo de una corrida con sesgo:

```
Invoca la skill `linkedin-outreach-agent` con source: "jueves-tarde".

Esta corrida prioriza perfiles con base en [geografia], que a esta hora estan
arrancando su dia. Sesgar la distribucion de slots hacia [categorias].
Si el inbox tiene respuestas de [tipo de persona] recibidas durante la noche,
priorizarlas arriba del reporte.

Al terminar, mandar resumen con link al reporte completo.
```

⛔ **No duplicar el perfil ni las reglas en la tarea programada.** Si la configuracion vive en dos lugares, se desincronizan y el agente termina operando con reglas viejas sin que nadie se entere.

---

## Antes de programar nada

La tarea programada corre **sin nadie mirando**, asi que lo que en una corrida manual se resuelve preguntando, aca se resuelve mal o se traba.

**Checklist:**

- [ ] **El perfil tiene los textos reales.** Sin eso, la corrida automatica va a escribir cosas genericas firmadas con tu nombre, y nadie lo va a ver hasta que sea tarde.
- [ ] **Esta definido que puede hacer sin preguntar y que necesita OK.** En una corrida automatica no hay nadie para aprobar en el momento: lo que necesita OK queda drafteado en el reporte.
- [ ] **Los criterios duros de las categorias estan escritos.** Un criterio vago sin nadie que lo aclare produce candidatos malos.
- [ ] **Hay una corrida manual exitosa** antes de automatizar. Nunca programar algo que no funciono al menos una vez a mano.
- [ ] **Esta claro por donde avisa** cuando termina.

---

## Vigilar los primeros meses

**Revisar el reporte todas las semanas al principio.** Una corrida automatica que se rompe en silencio puede pasar semanas sin que nadie se entere, y el unico sintoma es que no pasa nada.

Señales de que hay que mirar:
- Dos corridas seguidas con cero requests enviados
- Incidentes repetidos con el mismo error
- Invitaciones que se aceptan pero nunca reciben el mensaje de bienvenida
- Ventanas de medicion de experimentos que vencen sin medirse

⚠️ **Si aparece un captcha o un warning de actividad inusual, el agente para y avisa.** Si eso pasa, no reprogramar mas seguido: bajar la frecuencia y los topes por unas semanas.
