#!/usr/bin/env bash
# Usage: IMAGE=docker.io/you/flask-ci-cd ./deploy/deploy_on_server.sh
set -euo pipefail
IMAGE="${IMAGE:-docker.io/you/flask-ci-cd}"
CONTAINER_NAME="${CONTAINER_NAME:-flask-ci-cd}"
PORT="${PORT:-80}"
echo "[deploy] pulling $IMAGE:latest"
docker pull "$IMAGE:latest"
echo "[deploy] stopping old container (if any)"
docker rm -f "$CONTAINER_NAME" || true
echo "[deploy] starting $CONTAINER_NAME on port $PORT → 5000"
docker run -d --name "$CONTAINER_NAME" --restart unless-stopped -p "$PORT:5000" "$IMAGE:latest"
echo "[deploy] done"
