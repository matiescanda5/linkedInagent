# Experimentos

La corrida no es solo ejecucion, es un loop de aprendizaje. Sin esto, el agente manda lo mismo la semana 30 que la semana 1.

## Protocolo

1. **Un solo experimento activo por variable y por categoria.** Si corren dos sobre lo mismo, no se puede atribuir el resultado a ninguno.
2. **Cada contacto queda taggeado** en el history con `experiment` y `arm`. Sin eso no hay como medir.
3. **La asignacion alterna** para que los arms queden parejos.
4. **Cada corrida mide los arms viejos:** quien acepto, quien respondio, quien agendo. Con una ventana de medicion definida, por ejemplo 14 dias.
5. **No concluir antes del n minimo por arm.** Un arm que va 2 de 4 contra uno que va 1 de 5 no significa nada.
6. Cuando un arm gana, se cierra el experimento, **la regla ganadora se escribe en el archivo que corresponda** y se abre el siguiente de la cola.

## Estructura

```json
{
  "activos": [{
    "id": "",
    "pregunta": "",
    "hipotesis": "",
    "aplica_a": [],
    "variable": "",
    "min_n_por_arm": 8,
    "arms": {
      "A": { "descripcion": "", "enviados": 0, "aceptaron": 0, "respondieron": 0, "agendaron": 0, "contactos": [] },
      "B": { "descripcion": "", "enviados": 0, "aceptaron": 0, "respondieron": 0, "agendaron": 0, "contactos": [] }
    }
  }],
  "cola": [],
  "concluidos": []
}
```

Cada contacto dentro de un arm: nombre, URL, fecha de envio, estado, fecha de vencimiento de la ventana y resultado.

## Que vale la pena testear

Cosas con una variable clara y un resultado medible:

- **Cuando mandar el link de calendar:** en la nota del request, o despues de que acepta.
- **Que gancho abre mejor:** el logro de la otra persona, o el problema concreto que uno tiene y donde esa persona ya estuvo.
- **Idioma**, cuando la persona podria recibir cualquiera de los dos.
- **Largo del mensaje.**
- **Sourcing:** adyacencia contra lista de marcas.

## Tres errores que arruinan la medicion

**Concluir con n chico.** Es el mas comun y el mas caro. Se cambia una regla por una diferencia que era ruido.

**Contar un dato contaminado.** Si un mensaje salio distinto de lo que el arm indicaba, por ejemplo sin la nota por un fallo tecnico, ese dato **no sirve para ese arm**. Marcarlo y excluirlo, no sumarlo porque queda mejor el numero.

**Ventanas que vencen sin medirse.** Si la corrida se salta la medicion dos semanas seguidas, el experimento queda muerto sin resultado. **Medir primero, ejecutar despues.**

## Como se reporta

Siempre con el n a la vista y con la conclusion explicita de si alcanza o no:

> Arm A: 6 enviados, 1 acepto. Arm B: 6 enviados, 2 aceptaron, 1 respondio.
> **No concluyente**: el minimo es 8 por arm y ninguno llego. La tendencia favorece a B, consistente con la hipotesis, pero con n de 6 y tres ventanas abiertas no alcanza.
