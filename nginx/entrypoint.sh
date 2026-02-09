#!/bin/sh
set -e

# Substitute the STEEL_API_KEY into the auth config template
echo "🔐 Configuring Steel API authentication..."

if [ -z "$STEEL_API_KEY" ] || [ "$STEEL_API_KEY" = "change-me-to-a-strong-secret-key" ]; then
    echo "⚠️  WARNING: Using default API key! Set STEEL_API_KEY in your .env file."
fi

envsubst '${STEEL_API_KEY}' < /etc/nginx/auth.conf.template > /etc/nginx/auth.conf

echo "✅ Auth configured. API key required on all /v1/* endpoints."
echo "📡 Starting Nginx reverse proxy..."

exec nginx -g 'daemon off;'
