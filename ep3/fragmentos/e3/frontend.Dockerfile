# Imagen del frontend para gw-azure: Caddy con el Angular compilado y su Caddyfile adentro.
# Va como Dockerfile en el repositorio del frontend, junto a Caddyfile.gw-azure (renombrado a
# Caddyfile). Se publica en GHCR con imagen.yml, como los demas servicios (si es el primer paquete,
# se pasa a Public), y gw-azure la corre con network_mode: host, los volumenes /data y /config de
# Caddy y DOMINIO=<etiqueta>.<region>.cloudapp.azure.com en su environment. Sin DOMINIO sirve HTTP
# en el 80, asi que el mismo Dockerfile sirve el compose local en el 4200.
# Probado el 29-10-2026: una ruta de Angular cualquiera devuelve index.html.

# Etapa 1: compila Angular con las dependencias de desarrollo
FROM node:24-slim AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Etapa 2: Caddy sirve lo compilado. <proyecto> es el nombre de la carpeta que deja ng build.
FROM caddy:2
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /app/dist/<proyecto>/browser/ /srv/
