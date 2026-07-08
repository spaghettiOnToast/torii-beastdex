#!/bin/sh
set -e

export PORT="${PORT:-8080}"

envsubst < /app/torii.toml.template > /app/torii.toml

exec torii --config /app/torii.toml --db-dir /data
