# DSY1107 · Desarrollo Cloud Native I

**Duoc UC · Escuela de Informática y Telecomunicaciones · Segundo semestre 2026**

Acá vas a encontrar el material del curso: guías, laboratorios y documentos de apoyo.
Este repositorio es público y no requiere que tengas cuenta para leerlo.

## Empieza por aquí

### ➤ [Pulso, la plataforma del curso](https://pulso-umbingelelos-projects.vercel.app/registro)

Regístrate con tu correo institucional y elige tu sección. Ahí llevas tu avance, rindes las
actividades y acumulas puntos. Solo por crear la cuenta partes con 100.

**El diagnóstico de entrada se rinde dentro de Pulso**: 40 preguntas, alrededor de una hora, sin
nota y **por una sola vez**. Se corrige solo y te dice qué repasar antes de que haga falta. Suma 50
puntos.

## De qué se trata el ramo

Vas a construir una **plataforma de videojuegos** distribuida en la nube: catálogo, compras,
biblioteca del jugador, notificaciones y un ranking en vivo alimentado por las partidas.

Para llegar ahí pasamos por tres etapas:

| Unidad | Semanas | Qué le agregas al sistema |
|---|---|---|
| **1 · Identidad y APIs** | 1 a 7 | Login corporativo, roles y una puerta única que protege todos los servicios |
| **2 · Mensajería** | 8 a 11 | Los servicios dejan de esperarse: se comunican por mensajes |
| **3 · Streaming** | 12 a 16 | Miles de eventos por minuto, analítica y ranking en tiempo real |

**Stack:** Angular 22 · NestJS 12 con TypeScript · Node 24 · AWS Cognito · RabbitMQ 4 ·
Apache Kafka 4 en modo KRaft · Docker · AWS (Learner Lab) y Azure for Students.

## Material de la EP3

La carpeta [`ep3/`](ep3/) trae el material de partida del Parcial 3: el `compose.yml` de Kafka
(3 controllers y 3 brokers), `kafka/topics.sh`, el script que prueba los permisos del Learner Lab y
los fragmentos de cada entrega. Su [`README.md`](ep3/README.md) dice qué se usa en cada entrega.
El simulador de la noche de la venta está en
[vidalstore-simulador](https://github.com/Umbingelelo/vidalstore-simulador).

## El proyecto guía de los laboratorios

Desde el Laboratorio 9 la biblioteca son **ocho repositorios**, uno por pieza, igual que los de tu
grupo. Haz Fork de los ocho y clónalos **sin el sufijo** `-l9`, uno al lado del otro en la misma
carpeta.

| Pieza | Repositorio de partida | Equivale en VidalStore a |
|---|---|---|
| Frontend | [biblioteca-web-l9](https://github.com/Umbingelelo/biblioteca-web-l9) | el frontend Angular |
| Gateway | [biblioteca-gateway-l9](https://github.com/Umbingelelo/biblioteca-gateway-l9) | el gateway |
| BFF | [biblioteca-bff-l9](https://github.com/Umbingelelo/biblioteca-bff-l9) | el BFF |
| Libros | [biblioteca-libros-l9](https://github.com/Umbingelelo/biblioteca-libros-l9) | catálogo |
| Préstamos | [biblioteca-prestamos-l9](https://github.com/Umbingelelo/biblioteca-prestamos-l9) | licencias |
| Worker | [biblioteca-eventos-l9](https://github.com/Umbingelelo/biblioteca-eventos-l9) | `vidalstore-eventos` |
| Administrador | [biblioteca-admin-l9](https://github.com/Umbingelelo/biblioteca-admin-l9) | `vidalstore-admin` |
| Plataforma | [biblioteca-plataforma-l9](https://github.com/Umbingelelo/biblioteca-plataforma-l9) | `vidalstore-plataforma` |

El simulador de la biblioteca, [biblioteca-simulador](https://github.com/Umbingelelo/biblioteca-simulador),
es una herramienta aparte: se clona al lado de los ocho, igual que `vidalstore-simulador`.

## Cómo trabajamos

Cada semana tiene dos sesiones y **en las dos se programa**. No hay clase de solo escuchar.

- **Sesión de concepto** — explicación corta y enseguida código, en ejercicios de diez minutos que
  escribes y ejecutas en la misma clase.
- **Sesión de laboratorio** — una guía paso a paso, completa: cada comando, la salida que deberías
  ver y qué hacer si algo falla.

Los laboratorios están hechos para que puedas seguirlos **por tu cuenta**. Si faltaste a una sesión,
puedes recuperarla sola con la guía.

## Evaluaciones

| Evaluación | Cuándo | Peso |
|---|---|---|
| Parcial 1 — Arquitectura base | 21 al 26 de septiembre | 40% del 60% |
| Parcial 2 — Mensajería con colas | 19 al 24 de octubre | 30% del 60% |
| Parcial 3 — Streaming y analítica | 23 al 28 de noviembre | 30% del 60% |
| Evaluación Final Transversal | 7 al 12 de diciembre | 40% |

Cada parcial se compone de un **encargo** (40%, el código, en parejas) y una **defensa individual**
(60%). La defensa se califica por separado: dos personas del mismo grupo pueden obtener notas
distintas.

Hay además tres evaluaciones formativas sin nota, en las semanas 5, 10 y 15.

## Contacto

**Cristian Calderón** — [cr.calderons@profesor.duoc.cl](mailto:cr.calderons@profesor.duoc.cl)

Pregunta el mismo día que te surge la duda. La duda de hoy es barata; la de dentro de tres semanas
ya bloqueó otras cinco cosas.
