# Diagnóstico de entrada — DSY1107 Desarrollo Cloud Native I

**No lleva nota. No se entrega para ser calificado. Nadie va a saber tu puntaje salvo tú y yo.**

## Para qué sirve

Este ramo da por supuestas varias cosas de los semestres anteriores. Si algo de eso no quedó firme,
no es un problema — pero necesito saberlo **ahora**, no en la semana 9 cuando ya estemos peleando con
mensajería asíncrona.

Con tus respuestas hago dos cosas:

- **Yo** decido cuánto tiempo dedicarle a cada tema de refuerzo. Si medio curso falla en la sección D,
  esa clase se alarga y otra se acorta.
- **Tú** sabes exactamente qué repasar antes de que haga falta.

Por eso te pido algo concreto: **responde honestamente**. Si adivinas o buscas la respuesta, el
diagnóstico deja de servir para los dos. Que te vaya mal aquí no tiene ningún costo. Que me mientas
aquí te lo va a cobrar septiembre.

## Cómo lo haces

1. Reserva **40 minutos** sin interrupciones.
2. Responde cada sección **sin buscar en internet, sin IA y sin ejecutar el código**. Si no sabes,
   marca «no sé» — es una respuesta válida y me sirve más que un acierto por casualidad.
3. Al terminar cada sección, abre el bloque **Respuestas** y corrige.
4. Anota cuántas acertaste por sección.
5. Reporta tus resultados donde te indique en el aula virtual.

No necesitas instalar nada. Todo se responde leyendo.

---

## Sección A · Web y HTTP

**A1.** Acabas de crear un usuario nuevo con una petición al servidor y todo salió bien. ¿Qué código
de estado corresponde devolver?

- a) 200
- b) 201
- c) 204
- d) No sé

**A2.** Intentas entrar a una sección y el servidor responde **403**. ¿Qué significa?

- a) El servidor no sabe quién eres
- b) El servidor sabe quién eres, pero no tienes permiso
- c) La dirección no existe
- d) No sé

**A3.** ¿Cuál es la diferencia entre `POST /usuarios` y `PUT /usuarios/15`?

- a) Ninguna, son sinónimos
- b) `POST` crea un recurso nuevo; `PUT` reemplaza uno que ya existe
- c) `POST` envía datos y `PUT` los lee
- d) No sé

**A4.** ¿Qué es JSON?

- a) Un lenguaje de programación
- b) Un formato de texto para representar datos, que casi cualquier lenguaje sabe leer
- c) Una base de datos
- d) No sé

<details>
<summary><b>Respuestas — Sección A</b></summary>

**A1 → b) 201.** El 200 dice «salió bien»; el **201 Created** dice además «y creé algo nuevo».
La diferencia importa cuando alguien consume tu API y necesita saber si hubo creación.

**A2 → b) Sabe quién eres, pero no tienes permiso.** El **401** es «no sé quién eres» (falta el
token o es inválido). El **403** es «sé quién eres y aun así, no». Vas a distinguirlos mucho en la
unidad 1.

**A3 → b).** `POST` crea; `PUT` reemplaza un recurso identificado. Por eso `PUT` lleva el id en la
ruta y `POST` no.

**A4 → b) Un formato de texto para representar datos.** No es lenguaje ni base de datos. Es la forma
en que dos sistemas distintos se pasan información sin ponerse de acuerdo en nada más.

</details>

---

## Sección B · Línea de comandos

**B1.** Estás en `/home/ana` y quieres llegar a `/home/ana/proyectos/api`. ¿Qué escribes?

- a) `cd proyectos/api`
- b) `go /home/ana/proyectos/api`
- c) `open proyectos api`
- d) No sé

**B2.** ¿Para qué sirve una variable de entorno?

- a) Para guardar valores que cambian según dónde corre el programa, sin tocar el código
- b) Para declarar variables dentro de una función
- c) Para instalar programas
- d) No sé

**B3.** ¿Qué muestra `ls -la`?

- a) La lista de programas instalados
- b) El contenido de la carpeta actual, incluidos los archivos ocultos, con sus permisos
- c) El historial de comandos
- d) No sé

<details>
<summary><b>Respuestas — Sección B</b></summary>

**B1 → a) `cd proyectos/api`.** Como ya estás en `/home/ana`, basta la ruta relativa. También sirve
la absoluta completa.

**B2 → a).** Es como le dices a un programa «esta es tu contraseña de base de datos» sin escribirla
dentro del código. Vas a usarlas en todo el semestre, y en la semana 17 hay una clase dedicada a por
qué nunca se suben al repositorio.

**B3 → b).** La `a` muestra los ocultos (los que empiezan con punto, como `.env` o `.gitignore`) y la
`l` muestra el detalle.

</details>

---

## Sección C · Git

**C1.** ¿Qué es un *commit*?

- a) Subir los archivos al servidor
- b) Un punto guardado en la historia del proyecto, con los cambios y un mensaje
- c) Una copia de seguridad automática
- d) No sé

**C2.** ¿Para qué sirve el archivo `.gitignore`?

- a) Para ocultar archivos del sistema operativo
- b) Para indicarle a Git qué archivos **no** debe versionar ni subir
- c) Para borrar archivos del repositorio
- d) No sé

**C3.** ¿Cuál de estos **nunca** debería subirse a un repositorio?

- a) El archivo `README.md`
- b) La carpeta `node_modules`
- c) El código fuente
- d) No sé

**C4.** Trabajas con un compañero en el mismo repositorio. ¿Para qué sirve una *rama*?

- a) Para trabajar en un cambio sin afectar la versión principal hasta que esté listo
- b) Para hacer una copia del proyecto en otra carpeta
- c) Para dividir el repositorio en dos
- d) No sé

<details>
<summary><b>Respuestas — Sección C</b></summary>

**C1 → b).** Un commit es una foto del proyecto en un momento, con un mensaje que explica qué
cambió. Subirlo al servidor es otra cosa (`push`).

**C2 → b).** Le dice a Git qué ignorar. Este semestre entregan por GitHub y la pauta revisa que esté
bien configurado.

**C3 → b) `node_modules`.** Son dependencias que cualquiera puede reinstalar con un comando; pesan
cientos de megas y no aportan nada. Peor todavía sería subir un archivo `.env` con contraseñas — eso
es un incidente de seguridad, no un descuido.

**C4 → a).** Permite que dos personas trabajen a la vez sin pisarse.

</details>

---

## Sección D · Programación asíncrona en JavaScript

> **Esta es la sección más importante del diagnóstico.** Todo el backend del semestre es TypeScript
> asíncrono. Si acá te va mal, es lo primero que vamos a reforzar.

**D1.** ¿En qué orden se imprimen los números?

```js
async function tarea() {
  console.log(1);
  await esperar(1000);   // espera un segundo
  console.log(2);
}

console.log(3);
tarea();
console.log(4);
```

- a) 1, 2, 3, 4
- b) 3, 1, 4, 2
- c) 3, 4, 1, 2
- d) No sé

**D2.** ¿Qué imprime este código?

```js
async function dame() {
  return 5;
}

const x = dame();
console.log(x);
```

- a) `5`
- b) Una promesa, no el número
- c) `undefined`
- d) No sé

**D3.** ¿Qué pasa acá?

```js
const ids = [1, 2, 3];

ids.forEach(async (id) => {
  await guardarEnBase(id);
});

console.log('Todo guardado');
```

- a) Imprime «Todo guardado» después de guardar los tres
- b) Imprime «Todo guardado» de inmediato, sin esperar a que se guarde ninguno
- c) Da error de sintaxis
- d) No sé

**D4.** Las dos versiones hacen lo mismo. Si cada tarea demora 1 segundo, ¿cuánto demora cada una?

```js
// Versión A
const a = await tarea1();
const b = await tarea2();

// Versión B
const [a, b] = await Promise.all([tarea1(), tarea2()]);
```

- a) A: 2 s · B: 2 s
- b) A: 2 s · B: 1 s
- c) A: 1 s · B: 2 s
- d) No sé

**D5.** ¿El `catch` captura el error si `obtenerDatos` falla?

```js
try {
  const datos = obtenerDatos();   // función async, sin await
} catch (e) {
  console.log('Error capturado');
}
```

- a) Sí, siempre
- b) No, porque falta el `await`
- c) Sí, pero solo si el error es de red
- d) No sé

**D6.** ¿Qué es una *promesa* en JavaScript?

- a) Un valor que todavía no está disponible, pero que llegará (o fallará) más adelante
- b) Una función que se ejecuta más rápido
- c) Una forma de declarar variables constantes
- d) No sé

<details>
<summary><b>Respuestas — Sección D</b></summary>

**D1 → b) 3, 1, 4, 2.** El `3` va primero porque está antes. Al llamar `tarea()` se ejecuta hasta el
`await`: imprime `1` y ahí **devuelve el control**. Por eso el `4` sale antes que el `2`. Esto es lo
que más cuesta al principio y lo que más consecuencias tiene después.

**D2 → b) Una promesa.** Una función `async` **siempre** devuelve una promesa. Para obtener el 5 hay
que escribir `await dame()`. Este es el origen del clásico «me llegó `[object Promise]`».

**D3 → b) Imprime de inmediato.** `forEach` no sabe nada de promesas: dispara las tres funciones y
sigue de largo sin esperar ninguna. Es un error muy frecuente y muy silencioso, porque no falla —
simplemente hace las cosas en desorden.

**D4 → b) A demora 2 s, B demora 1 s.** En A cada `await` espera a que termine el anterior. En B las
dos parten juntas y esperas a que terminen ambas. Es la optimización más rentable que existe en
código asíncrono.

**D5 → b) No, porque falta el `await`.** Sin `await`, la promesa se rechaza *después* de que el
bloque `try` ya terminó, y el `catch` no alcanza a verlo.

**D6 → a).** Es un compromiso: «todavía no tengo el resultado, pero te aviso cuando lo tenga o cuando
falle».

</details>

---

## Sección E · Bases de datos

**E1.** ¿Qué hace esta consulta?

```sql
SELECT nombre, precio FROM juegos WHERE precio < 10000;
```

- a) Devuelve el nombre y el precio de los juegos que cuestan menos de 10.000
- b) Cambia el precio de los juegos a 10.000
- c) Borra los juegos que cuestan menos de 10.000
- d) No sé

**E2.** ¿Para qué sirve una clave foránea?

- a) Para cifrar los datos de una tabla
- b) Para relacionar una fila de una tabla con una fila de otra
- c) Para ordenar los resultados
- d) No sé

**E3.** Tienes `usuarios` y `compras`. Un usuario puede tener muchas compras, y cada compra pertenece
a un solo usuario. ¿Dónde va la referencia?

- a) En `usuarios`, apuntando a `compras`
- b) En `compras`, apuntando a `usuarios`
- c) En una tercera tabla
- d) No sé

<details>
<summary><b>Respuestas — Sección E</b></summary>

**E1 → a).** `SELECT` lee, no modifica. `WHERE` filtra.

**E2 → b).** Es lo que conecta las tablas entre sí y garantiza que la referencia apunte a algo que
existe de verdad.

**E3 → b) En `compras`.** En una relación uno-a-muchos, la referencia va siempre **en el lado
«muchos»**. Cada compra guarda a qué usuario pertenece.

</details>

---

## Sección F · Redes y despliegue

**F1.** Tu aplicación corre en `http://localhost:3000`. ¿Qué es el `3000`?

- a) La versión del programa
- b) El puerto donde el programa está escuchando
- c) La cantidad de usuarios que soporta
- d) No sé

**F2.** ¿Qué significa que un servicio esté «en la nube»?

- a) Que corre en computadores de un proveedor, a los que accedes por internet
- b) Que no necesita servidores
- c) Que los datos se guardan en el navegador
- d) No sé

**F3.** ¿Has usado Docker antes?

- a) Sí, sé crear imágenes y levantar contenedores
- b) Lo he usado siguiendo instrucciones, pero no sabría explicarlo
- c) Sé qué es, pero nunca lo he usado
- d) Nunca lo he escuchado

<details>
<summary><b>Respuestas — Sección F</b></summary>

**F1 → b) El puerto.** Una misma máquina puede tener muchos programas escuchando a la vez; el puerto
es el número que distingue a cuál le hablas.

**F2 → a).** «La nube» es el computador de otra persona, alquilado y accesible por internet.

**F3 — no tiene respuesta correcta.** Es la pregunta que más me sirve del diagnóstico: si la mayoría
responde c) o d), la clase de Docker de la semana 8 se alarga. No pasa nada si nunca lo has tocado.

</details>

---

## Sección G · Seguridad

**G1.** ¿Cuál es la diferencia entre *hashear* y *cifrar* una contraseña?

- a) Ninguna, son sinónimos
- b) El cifrado se puede revertir con la clave; el hash está diseñado para no poder revertirse
- c) El hash es más seguro porque usa más caracteres
- d) No sé

**G2.** Recibes este texto: `eyJub21icmUiOiJhbmEifQ==`. ¿Está seguro su contenido?

- a) Sí, está cifrado
- b) No, está codificado en Base64 y cualquiera lo puede leer
- c) Depende de la longitud de la clave
- d) No sé

<details>
<summary><b>Respuestas — Sección G</b></summary>

**G1 → b).** Cifrar es reversible si tienes la clave. Hashear es de una sola vía: por eso los
sistemas serios guardan el hash de tu contraseña y no la contraseña.

**G2 → b) No está seguro.** Base64 **no es seguridad**, es una forma de representar datos como texto.
Ese ejemplo dice `{"nombre":"ana"}`. Lo vas a comprobar tú mismo en la semana 2, y es clave para
entender por qué un token va firmado y no solo codificado.

</details>

---

## Qué hacer con tu resultado

Anota tus aciertos por sección y ubícate en la tabla.

| Sección | Preguntas | Si acertaste menos de… | Repasa esto antes de la semana |
|---|---|---|---|
| A · Web y HTTP | 4 | 3 | Métodos HTTP y códigos de estado — **semana 1** |
| B · Línea de comandos | 3 | 2 | Navegación básica en terminal — **semana 1** |
| C · Git | 4 | 3 | Commits, ramas y `.gitignore` — **semana 7** |
| **D · Asincronía** | 6 | **4** | **Promesas y `async/await` — semana 4** |
| E · Bases de datos | 3 | 2 | `SELECT`, relaciones y claves foráneas — **semana 5** |
| F · Redes | 3 | 2 | Puertos y servicios — **semana 8** |
| G · Seguridad | 2 | 2 | Hash, cifrado y codificación — **semana 2** |

**Si hay una sola sección que atender, que sea la D.** Es la que sostiene el resto del semestre: los
consumidores de mensajería de la semana 8 y los de streaming de la semana 13 son código asíncrono de
principio a fin. Todas las demás se pueden recuperar sobre la marcha; esa no.

Si quedaste bajo el umbral en D, avísame en la primera clase. Vamos a reforzarlo igual para todos,
pero prefiero saber con cuánta gente estoy trabajando.

## Cómo me entregas el resultado

Reporta **solo tus aciertos por sección** —no las respuestas— en el formulario del aula virtual,
antes de la próxima sesión.

Es anónimo para el resto del curso. Lo uso para ajustar las clases, no para calificar a nadie.

---

**Cristian Calderón** · cr.calderons@profesor.duoc.cl
Escuela de Informática y Telecomunicaciones · Duoc UC
