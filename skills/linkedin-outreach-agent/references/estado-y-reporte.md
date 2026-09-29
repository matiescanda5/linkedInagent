# Estado y reporte

## Los tres archivos de estado

Viven en `state/`. **Son la diferencia entre un agente y un script que empieza de cero cada semana.**

### `history.json`

La memoria de quien se toco y como quedo. Es lo que se cruza **antes** de contactar a nadie.

```json
{
  "schema_version": 1,
  "last_run": { "fecha": "", "origen": "", "estado": "", "nota": "" },
  "entries": {
    "accepted": [],
    "declined": [],
    "pending": [],
    "contacted": [],
    "outreach_not_sent": [],
    "inbox_seen": []
  }
}
```

Cada persona en `contacted` deberia tener: nombre, URL real del perfil, headline, categoria, ubicacion, fecha de contacto, si hubo email-gate, el mensaje que se le mando **textual**, si la nota se verifico, si respondio, y el experimento y arm si participa de uno.

⚠️ **Guardar el mensaje textual, no un resumen.** Cuando la persona responda tres semanas despues, lo unico que dice que se le prometio es ese texto.

⚠️ **`outreach_not_sent` no es una cola de pendientes.** Es un basurero de descartes con motivo. Casi nada de ahi se recupera: perfiles fantasma, encaje equivocado, email-gate, ya es contacto. Lo unico recuperable es lo que cayo por la regla de 30 dias, y eso tiene fecha de liberacion.

**Al reportarlo, nunca dar el numero pelado.** Reportar solo el subconjunto con fecha. El agregado sin desglosar genera una tarea fantasma que se arrastra de reporte en reporte.

### `metrics.csv`

Una fila por corrida. Permite ver el delta.

```
fecha,origen,invitaciones_vistas,aceptadas,rechazadas,pendientes,requests_enviados,drafts_inbox,drafts_engagement,mentions,incidentes
```

### `experiments.json`

Ver `experimentos.md`.

---

## Formato del reporte

Se guarda en `state/reports/` con fecha, y se manda un resumen por donde diga el perfil.

### 1. Resumen numerico, con delta

Tabla contra la corrida anterior. Si una metrica bajo, se dice.

### 2. Decisiones de criterio que se tomaron

**Esta seccion es la que hace util el reporte.** No "que se hizo" sino **"que se decidio y por que"**:
- Si se movio la distribucion de categorias, por que
- Si se dejo un slot vacio, por que no habia nadie
- Si se descarto a alguien que parecia bueno, cual fue el motivo
- Si se ignoro una instruccion por una razon documentada, cual

### 3. Outreach enviado

Por categoria, y las prioritarias primero con mas detalle. Por cada persona: nombre con link, cargo, empresa, **por que califica con el dato concreto y verificado**, y **el mensaje textual que se le mando**.

### 4. Invitaciones

Aceptadas con su motivo, y las ignoradas en una lista breve.

### 5. Inbox

Priorizado. **Si no hubo nada relevante, decirlo en una linea** en vez de inflar el reporte listando spam.

### 6. Follow-ups

Quien califico y quien no, **con el motivo de por que no**. "Sigue en pendiente, nunca acepto" es informacion util.

### 7. Pendiente de aprobacion

Comentarios y shares. Nunca ejecutados.

### 8. Experimentos

Estado, n por arm, y **si se puede concluir o no**. Con n chico se dice que no es concluyente, sin maquillar.

### 9. Incidentes

Todo lo que fallo, con el error textual. **Incluir especialmente lo que fallo a medias**: un request que salio pero sin nota verificada es un incidente, no un exito.

### 10. Lo que le toca al usuario

Separado y explicito. Lo que el agente no puede hacer solo y necesita una persona.

---

## Dos reglas del reporte

**Separar lo que se hizo de lo que el usuario tiene que hacer.** Son dos cosas distintas y se leen distinto.

**No maquillar.** Un reporte que dice "13 requests enviados" cuando 2 salieron sin nota es un reporte que miente. La unica forma de que estos numeros sirvan para decidir es que sean ciertos, incluso cuando son feos.

---

## Higiene del estado

⚠️ **Un solo archivo de estado, en un solo lugar.**

Caso real: existian tres copias de `history.json` en carpetas distintas, congeladas en fechas distintas. Un subagente leyo la vieja, reporto el historial casi vacio, y la corrida estuvo a punto de re-contactar a decenas de personas ya contactadas.

Si aparecen copias, **quedarse con la mas reciente y borrar las demas**. Verificar la fecha de ultima modificacion cuando el contenido no coincide con lo que se espera.
