#!/bin/bash
set -e

# SSL Certificate initialization script using Let's Encrypt
echo "🔐 Initializing SSL certificates..."

# Load environment variables
if [ -f .env.production ]; then
    export $(cat .env.production | grep -v '^#' | xargs)
else
    echo "❌ Error: .env.production file not found!"
    exit 1
fi

if [ -z "$DOMAIN" ]; then
    echo "❌ Error: DOMAIN not set in .env.production"
    exit 1
fi

if [ -z "$SSL_EMAIL" ]; then
    echo "❌ Error: SSL_EMAIL not set in .env.production"
    exit 1
fi

# Check if certificates already exist
if [ -d "certbot/conf/live/$DOMAIN" ]; then
    echo "📜 Certificates already exist for $DOMAIN"
    read -p "Do you want to renew them? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Create required directories
mkdir -p certbot/www certbot/conf

# Start nginx with temporary configuration for cert generation
echo "🔧 Starting nginx for certificate generation..."
docker compose -f docker-compose.production.yml up -d nginx

# Wait for nginx to start
sleep 5

# Request certificate
echo "📝 Requesting certificate from Let's Encrypt..."
docker compose -f docker-compose.production.yml run --rm certbot certonly \
    --webroot \
    --webroot-path=/var/www/certbot \
    --email $SSL_EMAIL \
    --agree-tos \
    --no-eff-email \
    --force-renewal \
    -d $DOMAIN

# Test certificate renewal
echo "🔄 Testing automatic renewal..."
docker compose -f docker-compose.production.yml run --rm certbot renew --dry-run

echo "✅ SSL certificates initialized successfully!"
echo "🔐 Certificates are stored in: ./certbot/conf/live/$DOMAIN/"
echo "📅 Automatic renewal is configured and will run twice daily"