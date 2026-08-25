k#!/bin/bash
set -e

# Variables
VAULT_ADDR='http://127.0.0.1:8200'          # Vault runs on the same server, so localhost
# VAULT_TOKEN is NOT hardcoded here - it's injected as an env var (see step below),
# either from a GitHub Actions secret or a local .vault_token file that's gitignored.
if [ -z "$VAULT_TOKEN" ]; then
  echo "VAULT_TOKEN is not set in the environment. Aborting."
  exit 1
fi
SECRET_PATH='kv/skills-utilization'         # Path where you stored the app secrets in Vault
ENV_FILE='/home/actions-runner-user/Skill_Utilization/.env'   # Where docker-compose.yaml expects .env

# Export Vault address and token
export VAULT_ADDR
export VAULT_TOKEN

# Retrieve secrets from Vault
echo "Retrieving secrets from Vault..."
SECRETS=$(vault kv get -format=json "$SECRET_PATH")

# Check if retrieval was successful
if [ $? -ne 0 ]; then
  echo "Failed to retrieve secrets from Vault."
  exit 1
fi

# Extract data and save to .env file
echo "Saving secrets to $ENV_FILE..."
echo "$SECRETS" | jq -r '.data.data | to_entries[] | .key + "=" + .value' > "$ENV_FILE"

# Check if .env file was created successfully
if [ $? -ne 0 ]; then
  echo "Failed to save secrets to $ENV_FILE."
  exit 1
fi

# Run Docker with .env file
echo "Running Docker container..."
cd "$(dirname "$ENV_FILE")"

# Log in to GHCR so the image can be pulled (skip if the package is public)
# echo "$GHCR_TOKEN" | docker login ghcr.io -u 3ZZAM217 --password-stdin

docker compose pull
docker compose --env-file "$ENV_FILE" up -d

echo "Deployment complete."
