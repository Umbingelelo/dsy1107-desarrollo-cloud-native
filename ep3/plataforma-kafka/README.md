# Kafka de VidalStore en local

Referencia de la parte de Kafka del `compose.yml` de `vidalstore-plataforma` para la EP3: tres
controllers y tres brokers en modo KRaft, Kafka UI y el archivo que crea los topics. Prometheus y
Grafana no están aquí; se agregan en el mismo `compose.yml` del grupo.

| Servicio | Imagen | Puerto en el equipo | Rol |
|---|---|---|---|
| `controller-1` a `controller-3` | `apache/kafka:4.4.0` | ninguno | `process.roles=controller`, ids 1 a 3 |
| `broker-1` a `broker-3` | `apache/kafka:4.4.0` | 9092 · 9094 · 9096 | `process.roles=broker`, ids 4 a 6 |
| `kafka-ui` | `ghcr.io/kafbat/kafka-ui:v1.5.0` | 8085 | Interfaz web del clúster |

Cada nodo tiene su volumen con nombre, así que los datos sobreviven a `docker compose down` y se
borran con `docker compose down -v`. Los clientes que corren en el equipo usan
`localhost:9092,localhost:9094,localhost:9096`; los contenedores de la misma red usan
`broker-1:19092,broker-2:19092,broker-3:19092`.

## Decisiones que quedan en el archivo

- **3 controllers más 3 brokers.** Es la lectura KRaft de «ZooKeeper de 3 nodos con 3 brokers»: los
  controllers guardan los metadatos del clúster y eligen líder entre ellos; los brokers guardan los
  mensajes.
- **Topics internos con 3 réplicas.** `__consumer_offsets` y el log de transacciones usan factor 3 y
  `min.insync.replicas=2`, igual que los topics de VidalStore. El ejemplo oficial de Apache para
  este modo trae 1, y con eso un broker caído puede dejar a los consumer groups sin sus offsets.
- **Sin creación automática de topics** (`auto.create.topics.enable=false`). Un topic con un nombre
  mal escrito falla en vez de aparecer con una partición y una réplica.
- **Heap fijo.** 256 MB por controller y 512 MB por broker, para que el clúster quepa en un equipo
  de laboratorio.

## Cómo se levanta

En la carpeta de este `compose.yml`, en cualquier terminal:

```bash
docker compose up -d --wait
```

`--wait` vuelve cuando los siete contenedores pasan su healthcheck. En un MacBook con Apple Silicon
y las imágenes ya descargadas tardó 18 segundos.

## Cómo se crean los topics

Los topics se crean desde `kafka/topics.sh`, nunca a mano en Kafka UI. El script crea
`vidalstore.compras` (retención de 7 días), `vidalstore.actividad` (24 horas) y sus dos
`.dlt` (7 días), todos con 3 particiones, 3 réplicas, `min.insync.replicas=2` y
`cleanup.policy=delete`. Usa `--if-not-exists`, así que correrlo dos veces no cambia nada.

macOS, Linux o Git Bash en Windows:

```bash
sh kafka/topics.sh
```

PowerShell, usando el `sh` que trae Git for Windows:

```powershell
& "$env:ProgramFiles\Git\bin\sh.exe" kafka/topics.sh
```

Kafka avisa en cada topic que un nombre con punto puede chocar en las métricas con otro igual que
use guion bajo. VidalStore usa solo puntos, así que el aviso no aplica.

`.gitattributes` fija los `.sh` con fin de línea LF. Sin eso, un clon en Windows puede dejarlos con
CRLF y `sh` falla en la primera línea.

## Cómo se comprueba

```bash
docker compose ps
docker compose exec -T broker-1 /opt/kafka/bin/kafka-topics.sh --bootstrap-server broker-1:19092 --describe --topic vidalstore.compras
docker compose exec -T controller-1 /opt/kafka/bin/kafka-metadata-quorum.sh --bootstrap-controller controller-1:9093 describe --status
```

El primero muestra los siete contenedores `healthy`. El segundo, las 3 particiones con sus 3
réplicas y el ISR completo. El tercero, los tres controllers como `CurrentVoters` y los tres brokers
como `CurrentObservers`. En Git Bash se antepone `MSYS_NO_PATHCONV=1` a los dos últimos.

Kafka UI queda en `http://localhost:8085`, con el clúster `vidalstore-local`, tres brokers y el modo
KRaft a la vista.

## Memoria medida

Medida con `docker stats --no-stream` el 29 de octubre de 2026, en macOS con Docker 29.4.3, después de
crear los topics y reproducir el dataset de muestra una vez:

| Contenedor | Memoria |
|---|---|
| `controller-1` · `controller-2` · `controller-3` | 220 MiB · 279 MiB · 218 MiB |
| `broker-1` · `broker-2` · `broker-3` | 499 MiB · 450 MiB · 463 MiB |
| `kafka-ui` | 407 MiB |
| Total | 2 537 MiB |

Con dos nodos de RabbitMQ y Postgres al lado se suman unos 380 MiB (medido): Docker necesita al menos
4 GB asignados, y 5 o 6 GB si los servicios del grupo también corren en contenedores. Kafka UI se
puede apagar cuando no se usa (`docker compose stop kafka-ui`).

## Cómo se baja

```bash
docker compose down       # conserva los datos
docker compose down -v    # borra los volúmenes: el clúster parte vacío la próxima vez
```
