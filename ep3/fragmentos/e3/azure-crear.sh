#!/usr/bin/env bash
# Red y maquinas de Azure de la EP3 (VidalStore). Son los comandos que uso el docente en Azure for
# Students el 29-10-2026, region northcentralus. Se copia a deploy/azure/ y se ajusta.
# Uso, en Git Bash o bash, con az login hecho y gw-azure-cloud-init.yaml al lado:
#   L=<region> ETIQUETA=<etiqueta-dns> CORREO=<correo> bash deploy/azure/crear.sh
set -euo pipefail
cd "$(dirname "$0")"

G=${G:-vidalstore}
L=${L:?falta L, la region que acepto la red de prueba de la E1}
MI_IP=$(curl -s https://checkip.amazonaws.com | tr -d "\r\n ")   # la IP de quien corre esto (SSH)
ETIQUETA=${ETIQUETA:?falta ETIQUETA, por ejemplo vidalstore-g7}
CORREO=${CORREO:?falta CORREO para el aviso del apagado automatico}
CLAVE=${CLAVE:-$HOME/.ssh/vidalstore-azure}
[ -f "$CLAVE" ] || ssh-keygen -q -t ed25519 -N "" -f "$CLAVE"

# 0. Proveedores: sin registrarlos, list-usage devuelve [] (suscripcion recien creada)
az provider register -n Microsoft.Compute --wait
az provider register -n Microsoft.Network --wait

# 1. Red: VNet, dos subredes, ambas sin salida por defecto
az group create -n $G -l $L -o none
az network vnet create -g $G -n vnet-ep3 --address-prefixes 10.1.0.0/16 \
  --subnet-name publica --subnet-prefixes 10.1.1.0/24 -o none
# 'vnet subnet create' NO deja defaultOutboundAccess=false por defecto: se pide explicito
az network vnet subnet create -g $G --vnet-name vnet-ep3 -n privada \
  --address-prefixes 10.1.2.0/24 --default-outbound false -o none

# 2. NSG
az network nsg create -g $G -n nsg-gw -o none
az network nsg rule create -g $G --nsg-name nsg-gw -n ssh-integrante --priority 100 \
  --source-address-prefixes "$MI_IP/32" --destination-port-ranges 22 --protocol Tcp -o none
az network nsg rule create -g $G --nsg-name nsg-gw -n web --priority 110 \
  --source-address-prefixes Internet --destination-port-ranges 80 443 --protocol Tcp -o none
# paso 4 del NAT: el NSG de gw-azure deja entrar lo que viene de la subred privada
az network nsg rule create -g $G --nsg-name nsg-gw -n desde-privada --priority 120 \
  --source-address-prefixes 10.1.2.0/24 --destination-port-ranges '*' --protocol '*' -o none
az network nsg create -g $G -n nsg-bff -o none
az network nsg rule create -g $G --nsg-name nsg-bff -n desde-vnet --priority 100 \
  --source-address-prefixes 10.1.0.0/16 --destination-port-ranges '*' --protocol '*' -o none
az network nsg rule create -g $G --nsg-name nsg-bff -n deny-resto --priority 4000 --access Deny \
  --source-address-prefixes '*' --destination-port-ranges '*' --protocol '*' -o none
az network vnet subnet update -g $G --vnet-name vnet-ep3 -n publica --nsg nsg-gw -o none
az network vnet subnet update -g $G --vnet-name vnet-ep3 -n privada --nsg nsg-bff -o none

# 3. gw-azure: IP publica estatica con etiqueta DNS, IP privada fija, IP forwarding (paso 1 del NAT)
az network public-ip create -g $G -n pip-gw --sku Standard --allocation-method Static \
  --dns-name "$ETIQUETA" -o none
az network nic create -g $G -n nic-gw --vnet-name vnet-ep3 --subnet publica \
  --private-ip-address 10.1.1.4 --public-ip-address pip-gw --ip-forwarding true -o none
# gw-azure-cloud-init.yaml: Docker, ip_forward (paso 2), MASQUERADE (paso 3), persistencia
az vm create -g $G -n gw-azure --image Ubuntu2404 --size Standard_B2ats_v2 --nics nic-gw \
  --admin-username azureuser --ssh-key-values "$CLAVE.pub" --custom-data gw-azure-cloud-init.yaml \
  --os-disk-size-gb 30 --storage-sku StandardSSD_LRS -o none

# 4. bff: sin IP publica, IP privada fija
az network nic create -g $G -n nic-bff --vnet-name vnet-ep3 --subnet privada \
  --private-ip-address 10.1.2.4 -o none
az vm create -g $G -n bff --image Ubuntu2404 --size Standard_B2als_v2 --nics nic-bff \
  --admin-username azureuser --ssh-key-values "$CLAVE.pub" \
  --os-disk-size-gb 30 --storage-sku StandardSSD_LRS -o none

# 5. Paso 5 del NAT: tabla de rutas 0.0.0.0/0 -> IP privada de gw-azure
az network route-table create -g $G -n rt-privada -o none
az network route-table route create -g $G --route-table-name rt-privada -n salida \
  --address-prefix 0.0.0.0/0 --next-hop-type VirtualAppliance --next-hop-ip-address 10.1.1.4 -o none
az network vnet subnet update -g $G --vnet-name vnet-ep3 -n privada --route-table rt-privada -o none

# 6. Apagado automatico (desasigna) a las 03:00 UTC, las 00:00 en Chile en horario de verano
for v in gw-azure bff; do
  az vm auto-shutdown -g $G -n $v --time 0300 --email "$CORREO" -o none
done

FQDN=$(az network public-ip show -g $G -n pip-gw --query dnsSettings.fqdn -o tsv)
IP=$(az network public-ip show -g $G -n pip-gw --query ipAddress -o tsv)
echo "gw-azure: $FQDN ($IP)"
echo "SSH: ssh -i $CLAVE azureuser@$IP   y a bff: ssh -i $CLAVE -J azureuser@$IP azureuser@10.1.2.4"
echo "Esa IP publica es la que va en la regla 443 de sg-gw en AWS."
