# skill-compartible

Convierte cualquier agente o skill propia en un **instalador portable** que le podés regalar a otra persona.

## El problema

Una skill que funciona bien está llena de datos tuyos: tu empresa, tus métricas, tu voz, tus contactos, tus rutas de archivo. Si se la pasás así a alguien, no le sirve y además le estás mandando información tuya. Si le sacás todo eso a mano, tardás una hora y te olvidás de la mitad.

## Qué hace

1. **Lee tu skill entera**, incluidos los archivos de estado, que es donde se esconden los nombres que nadie se acuerda de sacar.
2. **Hace el corte:** separa el conocimiento operativo (que se conserva) de lo que es tuyo (que se reemplaza por preguntas).
3. **Arma la instalación mínima:** dos preguntas, y una tabla de huecos con el momento exacto en que se pregunta cada cosa.
4. **Identifica los parámetros de decisión** del agente y les da calibración explícita, con casos reales para proponer y corregir.
5. **Agrega tu firma**, para que se sienta un regalo y no un archivo.
6. **Empaqueta** como `.skill` instalable.
7. **Verifica antes de entregar:** busca tu nombre, tu empresa, tus cifras, tus links y tus IDs en todos los archivos.

## Los principios que aplica

- **Instalación mínima, preguntas sobre la marcha.** Veinte preguntas antes de que el agente haya hecho nada es la forma más rápida de que alguien cierre el archivo y no vuelva.
- **Proponer, no preguntar en abstracto.** "¿Cuál es tu criterio para X?" es imposible de contestar en frío. Traer casos reales con un veredicto propuesto y pedir que corrijan produce mejores criterios en menos tiempo.
- **El conocimiento duro se conserva entero.** La tentación es resumir los detalles técnicos porque son feos y largos. Son lo más valioso que estás regalando: le ahorran a la otra persona los meses que vos ya pagaste.
- **Los errores se cuentan, sin nombres.** Un instalador que dice "esto falla en silencio, chequealo así" vale más que uno que solo dice qué hacer.

## Uso

Instalala y decile:

> armame un instalador de [tu skill] para regalársela a alguien

Keywords que la activan: compartir skill, instalador, portable, regalar agente, exportar skill, sacar mis datos, versión para un amigo.
