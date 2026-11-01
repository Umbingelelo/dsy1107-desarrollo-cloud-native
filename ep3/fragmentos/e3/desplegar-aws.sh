#!/usr/bin/env bash
# Se copia como deploy/aws/desplegar.sh. Lo corre el runner aws, que vive en gestion, con el rol de la
# instancia (LabInstanceProfile): sin llaves ni credenciales en GitHub.
#
# Estructura en cada maquina (la misma que en la E2):
#   /opt/vidalstore/deploy/      copia de deploy/ del repositorio, que llega por S3
#   /opt/vidalstore/secretos/    el .env real de la maquina, que llega de Parameter Store
# El .env de cada maquina se guarda una vez, entero, como SecureString en /vidalstore/<maquina>/env:
#   MSYS_NO_PATHCONV=1 aws ssm put-parameter --type SecureString --overwrite \
#     --name /vidalstore/servicios/env --value file://servicios.env
#
# Cada pieza se probo en el Learner Lab el 29-10-2026: s3 sync y get-parameter desde una instancia con
# su rol, y send-command de gestion a otra maquina por su etiqueta Name (menos de 2 s). El conjunto es
# un esqueleto: el grupo ajusta la lista de maquinas y lo que corre en cada una.
set -euo pipefail
export AWS_DEFAULT_REGION=us-east-1 AWS_PAGER=""
BUCKET="${BUCKET:?falta BUCKET: en desplegar.yml sale de la variable del repositorio vars.BUCKET}"

aws s3 sync deploy/ "s3://$BUCKET/deploy/" --delete

for maquina in servicios gestion gw-aws; do
  id=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$maquina" "Name=instance-state-name,Values=running" \
    --query 'Reservations[0].Instances[0].InstanceId' --output text)
  c1="aws s3 sync s3://$BUCKET/deploy/ /opt/vidalstore/deploy/ --delete --region us-east-1"
  c2="mkdir -p /opt/vidalstore/secretos && aws ssm get-parameter --region us-east-1 --name /vidalstore/$maquina/env --with-decryption --query Parameter.Value --output text > /opt/vidalstore/secretos/$maquina.env"
  c3="cd /opt/vidalstore/deploy/aws/$maquina && docker compose --env-file ../../versiones.env --env-file /opt/vidalstore/secretos/$maquina.env pull"
  c4="cd /opt/vidalstore/deploy/aws/$maquina && docker compose --env-file ../../versiones.env --env-file /opt/vidalstore/secretos/$maquina.env up -d"
  cmd=$(aws ssm send-command --instance-ids "$id" --document-name AWS-RunShellScript \
    --parameters "commands=[\"$c1\",\"$c2\",\"$c3\",\"$c4\"]" \
    --query Command.CommandId --output text)
  aws ssm wait command-executed --command-id "$cmd" --instance-id "$id" || true
  estado=$(aws ssm get-command-invocation --command-id "$cmd" --instance-id "$id" --query Status --output text)
  echo "$maquina: $estado"
  [ "$estado" = "Success" ] || exit 1
done
