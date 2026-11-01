# EP3 · Material de partida

Material del docente para la EP3 de DSY1107 (Caso VidalStore). Se copia a los repositorios del grupo;
no se entrega tal cual. Todo se probó antes de publicarlo: en local con Docker, en el Learner Lab de
AWS Academy y en una suscripción de Azure for Students.

| Carpeta | Para qué | Entrega |
|---|---|---|
| `plataforma-kafka/` | `compose.yml` de referencia (3 controllers y 3 brokers en KRaft, Kafka UI) y `kafka/topics.sh` | E1 |
| (otro repositorio) | El simulador y su dataset están en https://github.com/Umbingelelo/vidalstore-simulador, con su README para local y nube | E1 en adelante |
| `deploy/aws/verificar-permisos.sh` | Prueba lo que el Learner Lab deja hacer y deja el resultado en texto | E1 |
| `fragmentos/e1/` | `red.md.ejemplo`: el diseño de red de las dos nubes que se ensayó, para copiar como `docs/red.md` y completar. `levantar.sh.ejemplo`: esqueleto del comando que levanta todo | E1 |
| `fragmentos/e2/` | `Dockerfile`, `.dockerignore` y el workflow `imagen.yml`; el *user data* de `nat` y de las demás EC2; para las `mq`, `mq-compose.yml` (Kafka) y `rabbit-compose.yml` (RabbitMQ) con sus `.env` y `rabbitmq.conf` de ejemplo; para `datos`, `datos-compose.yml` (Postgres 18) | E2 |
| `fragmentos/e3/` | `Caddyfile.gw-aws` y `Caddyfile.gw-azure`; `frontend.Dockerfile` (Caddy con el Angular compilado); `azure-crear.sh` y `gw-azure-cloud-init.yaml` (red, VM y NAT de Azure); `versiones.env.ejemplo`, `desplegar.yml` y el esqueleto `desplegar-aws.sh` | E3 |

Los `.sh` tienen que quedar con fin de línea LF: el `.gitattributes` de esta carpeta lo asegura al
clonar. Si se copian a mano en Windows y fallan en las primeras líneas, es eso.

Los documentos de la EP3 (Guía, Entrega 1, 2 y 3, y Defensa) dicen cuándo se usa cada archivo.
