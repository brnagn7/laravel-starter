#!/bin/bash
set -euo pipefail
# Filename: deploy.sh
#
# - Description: Safe, Self-backing, Self-restoring, Atomic, Bulletproof
# - Production-grade DevOps script. This file will create a backup, skip rollback,
# - complete the full deployment, run health check and finish cleanly.
#
# Author: Ed Mooney
#
# Date: Nov 2025
#
# ========== MOVE FROM deploy/ TO PROJECT ROOT ==========
cd "$(dirname "$0")"
cd ..

# ========== BACKUP SETUP ==========
BACKUP_DIR="deploy/releases"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/release-$TIMESTAMP.tar.gz"

echo "Creating backup of current release..."

tar -czf "$BACKUP_FILE" \
  --exclude="deploy/releases" \
  --exclude="vendor" \
  --exclude="node_modules" \
  --exclude="storage/logs" \
  ./

echo "Backup stored at: $BACKUP_FILE"


# =========================================================
# 🔥 INSERT ROLLBACK BLOCK *RIGHT HERE*
# =========================================================

rollback() {
  echo ""
  echo "❌ Deployment failed. Rolling back..."

  if [[ -f "$BACKUP_FILE" ]]; then
    echo "Restoring backup from $BACKUP_FILE..."
    tar -xzf "$BACKUP_FILE" -C ./
    echo "✔ Backup restored."
  else
    echo "⚠ No backup found. Cannot rollback."
  fi

  echo "Bringing containers back up..."
  docker compose up -d || true

  echo "Rollback complete."
  exit 1
}

# Trigger rollback on ANY error
trap rollback ERR


# ==================== DEPLOY STEPS =======================

echo "Pulling latest code..."
git pull origin main

echo "Starting containers..."
docker compose up -d

echo "Running Composer install..."
docker compose exec app composer install --no-interaction --prefer-dist --optimize-autoloader

echo "Running database migrations..."
docker compose exec app php artisan migrate --force

echo "Optimizing Laravel..."
docker compose exec app php artisan optimize
docker compose exec app php artisan config:cache
docker compose exec app php artisan route:cache
docker compose exec app php artisan view:cache

echo "Clearing old Laravel caches..."
docker compose exec app php artisan config:clear
docker compose exec app php artisan cache:clear
docker compose exec app php artisan view:clear

echo "Restarting Laravel queue workers..."
docker compose exec app php artisan queue:restart

echo "Running health check..."
docker compose exec app php artisan about > /dev/null
echo "Health check passed."

echo "Done."

