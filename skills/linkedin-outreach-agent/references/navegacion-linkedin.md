# Como operar LinkedIn sin romperse

Cada regla de este archivo se aprendio fallando en una corrida real. **Leerlo antes de tocar el navegador.** La mayoria de los fallos de este agente no son errores ruidosos: son cosas que parecen haber funcionado y no hicieron nada.

---

## Las cuatro reglas que mas tiempo ahorran

### 1. El boton de envio del modal de invitacion vive en un shadow root

No aparece con `querySelector` plano ni en el arbol de accesibilidad. Buscarlo por su texto **falla**, porque su `innerText` es `Enviar` pero su `aria-label` es `Enviar invitación`. Ademas hay otro boton `Enviar` oculto y siempre deshabilitado (del reproductor de video) que hace creer que la nota no habilito el envio.

Lo que funciona siempre:

```js
document.getElementById('interop-outlet').shadowRoot
  .querySelector('button[aria-label="Enviar invitación"]')
```

Dentro de ese mismo shadow root viven tambien `textarea#custom-message`, `button[aria-label="Añadir una nota"]` y `button[aria-label="Enviar sin nota"]`.

### 2. Comprimir abrir + escribir + verificar + enviar en UNA sola llamada

Partirlo en tres llamadas abre tres ventanas en las que la conexion de la extension se puede caer con el modal abierto. Cuando eso pasa, **el request sale igual pero sin la nota**, y no queda registro de que paso.

Medido en una misma corrida: con el patron de tres llamadas, 4 de 6 requests salieron con la nota verificada. Con el patron de una sola llamada, 7 de 7.

```js
const TXT = "...";              // el mensaje
const NOMBRE = /Nombre/;        // para verificar que es la persona correcta
const sr = document.getElementById('interop-outlet').shadowRoot;
const dlg = sr.querySelector('div[role="dialog"]');
if (!dlg) throw 'NO MODAL';
if (!NOMBRE.test(dlg.innerText)) throw 'NOMBRE NO COINCIDE: ' + dlg.innerText.slice(0,120);
const gate = sr.querySelector('button[aria-label="Enviar sin nota"]');
if (!gate || gate.disabled) throw 'EMAIL GATE';
sr.querySelector('button[aria-label="Añadir una nota"]').click();
await new Promise(r => setTimeout(r, 5000));
const ta = sr.querySelector('textarea#custom-message');
if (!ta) throw 'NO TEXTAREA';
const setter = Object.getOwnPropertyDescriptor(window.HTMLTextAreaElement.prototype, 'value').set;
ta.focus(); setter.call(ta, TXT);
ta.dispatchEvent(new Event('input', { bubbles: true, composed: true }));
await new Promise(r => setTimeout(r, 2000));
if (ta.value.length < 200) throw 'NOTA VACIA len=' + ta.value.length;
const s = sr.querySelector('button[aria-label="Enviar invitación"]');
if (!s || s.disabled) throw 'SEND DISABLED';
s.click();
await new Promise(r => setTimeout(r, 3000));
'ENVIADO len=' + TXT.length;
```

### 3. `composed: true` es lo que hace que React registre la nota

Escribir el `value` del textarea por JS **no habilita** el boton de envio si el evento `input` no cruza el shadow boundary. Sin `composed: true`, el texto queda escrito, el boton queda deshabilitado, y parece un problema de la nota cuando es del evento.

Tampoco sirve `type` por teclado: el foco queda bien pero `value` queda en cero **y no avisa**.

### 4. Verificar el nombre dentro del modal antes de escribir

El sidebar de "Mas perfiles para ti" tiene links de invitacion de **otras personas**. Un `querySelectorAll(...)` que agarre el primero o el ultimo puede abrir el modal de alguien equivocado. Paso: se abrio el modal de otra persona y solo se detecto porque el modal dice el nombre.

El modal siempre dice **"Personaliza tu invitación para [Nombre]"**. Chequearlo es una linea y evita mandarle a la persona equivocada un mensaje personalizado para otra.

---

## Abrir el modal de invitacion

1. Buscar el link por **href que contenga `custom-invite` y el slug de la persona**. Nunca por el texto "Conectar", nunca por la estructura de ancestros.

```js
const S = 'slug-de-la-persona';
[...document.querySelectorAll('a')]
  .find(a => (a.href||'').includes('custom-invite') && (a.href||'').includes(S))
```

2. Si no aparece, el item esta en el menu **"Más"**. Abrirlo **por JS** (`.click()`), no con el mouse virtual, **esperar 4 a 5 segundos** y recien ahi buscar el link.

⚠️ El menu tarda en terminar de renderizar. Mirar el DOM antes de tiempo hizo concluir tres veces que un perfil estaba "bloqueado" cuando no lo estaba. **No declarar un perfil bloqueado sin haber esperado y reintentado.**

3. Si a los 5 segundos no hay link `custom-invite` **y tampoco figura "Pendiente"**, ahi si es un bloqueo real.

4. El modal puede tardar **mas de 5 segundos** en abrir. Una lectura a los 4,5 s devolvio "no modal" para un modal que abrio a los 8. No concluir que el click fallo sin re-chequear.

---

## Email-gate

Algunos perfiles abren un modal que pide el email de la persona, con los botones de envio deshabilitados. **Es configuracion por persona, no del sistema.**

El chequeo mas barato, sin accionar nada: si `button[aria-label="Enviar sin nota"]` existe y **no** esta `disabled`, no hay gate.

Si hay gate: saltear a esa persona y seguir. **No frenar la corrida.** Anotarlo en el history para no volver a intentar.

---

## Mensajeria: el mapa de rutas

La mensajeria es la parte mas inestable. Lo importante es que **el problema es por RUTA**, no por corrida ni por perfil:

| Ruta | Estado |
|---|---|
| `/messaging/?filter=unread` **en pestaña nueva** | ✅ Funciona. Es la forma de leer el inbox. |
| `/messaging/` pelada | ❌ Dispara `Cannot access a chrome-extension:// URL of different extension` |
| `/messaging/thread/new/` | ❌ Carga pero renderiza vacio (`document.body.innerText` devuelve ~16 caracteres) |
| Overlay de compose desde el perfil | ⚠️ Intermitente **por perfil** |

**Para leer el inbox:** abrir pestaña nueva y entrar directo a `/messaging/?filter=unread`. Durante meses se dio el inbox por ilegible hasta que se probo esta ruta.

**Para mandar un mensaje:** abrir el perfil de la persona y clickear "Enviar mensaje" **por JS**, no con el mouse virtual:

```js
[...document.querySelectorAll('a,button')].filter(x => {
  const r = x.getBoundingClientRect();
  return r.width > 0 && (x.innerText||'').trim() === 'Enviar mensaje' && r.top > 150;
})[0].click()
```

El filtro `top > 150` saca el boton del header pegajoso, que figura visible pero esta tapado por la barra y no responde.

**Despues del click, chequear `location.pathname`.** Si empieza con `/messaging`, ese perfil navego en vez de abrir el overlay: draftear el mensaje en el reporte y seguir. **No insistir.** Dos perfiles identicos en apariencia se comportan distinto y no se puede predecir cual.

Si el overlay si abrio, el contenteditable vive en shadow root. Escribir con:

```js
ed.focus();
const sel = ed.getRootNode().getSelection ? ed.getRootNode().getSelection() : window.getSelection();
const rg = document.createRange(); rg.selectNodeContents(ed); rg.collapse(false);
sel.removeAllRanges(); sel.addRange(rg);
document.execCommand('insertText', false, TXT);
```

Escribe 600 caracteres de una y habilita el boton. No hace falta partirlo en pedazos.

---

## Paginas de busqueda

**No llegan a `document_idle`.** Sacar screenshot o leer el arbol de accesibilidad da timeout.

Usar extraccion de texto o JS directo:

```js
document.querySelectorAll('a[href*="/in/"]')
```

El headline y la empresa salen en la tarjeta de resultado, asi que **el primer filtro no necesita abrir cada perfil**. Eso es la diferencia entre una corrida barata y una cara.

⛔ **Nunca adivinar la URL `/in/slug`.** Sacarla siempre del `href` real. Una URL inferida da 404 y se descubre tarde.

---

## Trampas de coordenadas y screenshots

⛔ **Las coordenadas del mouse virtual no son pixeles del screenshot.** El screenshot es un recorte escalado del viewport, con un factor que cambia segun el tamaño de la ventana. Leer una coordenada mirando la imagen manda el click a cualquier lado: paso que abriera una pestaña de busqueda por error.

**Regla:** sacar la coordenada de `getBoundingClientRect()`, o directamente clickear por JS. Para todo lo que sea abrir modales o compose, **click por JS siempre**.

⛔ **Nunca llamar a la funcion de redimensionar ventana.** Es la causa sospechada de que se caiga la capa de input.

---

## Fallos silenciosos y como detectarlos

**Capa de input caida.** En medio de una corrida los clicks pueden dejar de dar foco y el teclado deja de escribir, en cualquier campo y tambien en pestaña nueva. Hipotesis: la ventana perdio el foco del sistema operativo.

Chequeo barato antes de una tanda de escritura: clickear el buscador global y escribir dos letras. Si el campo queda vacio, la capa de input esta caida. **No gastar intentos**: draftear todo en el reporte y seguir con lo que no necesita teclado.

**Conexion de la extension caida.** Distinto del crash. La herramienta devuelve que el navegador no esta conectado. Suele ser transitorio y vuelve sola. **El riesgo es que se caiga con un modal abierto**: el request sale sin nota y no queda registro. Por eso el patron de una sola llamada.

**Crash de extension.** `Cannot access a chrome-extension:// URL of different extension`, disparado por media embebida renderizando. **Es por pestaña:** cerrar esa pestaña, abrir otra y seguir. Si se reproduce en pestaña nueva para la misma ruta, es la ruta y no la pestaña.

⚠️ Si aparece un host de shadow DOM que no es de LinkedIn ni del navegador, es la extension en conflicto. Vale la pena revisar las extensiones instaladas.

---

## Limites de las herramientas

- **Una evaluacion de JS tiene que correr en menos de ~40 segundos** o falla por timeout. El espaciado anti-ban de 30 a 90 segundos hay que partirlo en varias llamadas.
- **En perfiles con mucha audiencia, no recorrer todo el DOM.** Un walker que atraviesa todos los shadow roots colgo el renderer 45 segundos. Usar `querySelector` directo.
- **En perfiles pesados, subir la espera interna a 5 o 6 segundos** despues de abrir el campo de nota. Con 2,5 s fallo por textarea no renderizado.
- **Cerrar pestañas al final, nunca en medio de un lote de acciones.** Cerrar una pestaña invalida los identificadores de las demas y hace fallar todo lo que venga despues.

---

## Checklist antes de dar por enviado un request

- [ ] El modal decia el nombre correcto
- [ ] Los dos botones estaban habilitados (no habia email-gate)
- [ ] La nota quedo escrita: verificar el largo, no asumirlo
- [ ] El boton de envio estaba habilitado antes de clickear
- [ ] El modal se cerro despues del click
- [ ] Quedo registrado en el history

Si alguno no se pudo verificar, **anotarlo como no verificado en vez de darlo por hecho**. Un request que salio sin nota es recuperable si se sabe; si se registra como exitoso, nadie se entera nunca.
