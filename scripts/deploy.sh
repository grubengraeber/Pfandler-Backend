#!/bin/bash
set -e

# Deployment script for Pfandler Backend
echo "🚀 Starting Pfandler Backend Deployment..."

# Load environment variables
if [ -f .env.production ]; then
    export $(cat .env.production | grep -v '^#' | xargs)
else
    echo "❌ Error: .env.production file not found!"
    exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check requirements
echo "📋 Checking requirements..."
if ! command_exists docker; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command_exists docker-compose; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes from git..."
git pull origin main

# Build and start services
echo "🏗️  Building Docker images..."
docker compose -f docker-compose.production.yml build

echo "🔄 Starting services..."
docker compose -f docker-compose.production.yml up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Run database migrations
echo "🗄️  Running database migrations..."
docker compose -f docker-compose.production.yml exec serverpod ./server --apply-migrations

# Health check
echo "🏥 Performing health check..."
if curl -f http://localhost:8080/health > /dev/null 2>&1; then
    echo "✅ Health check passed!"
else
    echo "❌ Health check failed!"
    echo "📋 Checking logs..."
    docker compose -f docker-compose.production.yml logs serverpod --tail=50
    exit 1
fi

# Clean up old images
echo "🧹 Cleaning up old Docker images..."
docker system prune -f

echo "✅ Deployment completed successfully!"
echo "🌐 Your API is available at: https://${DOMAIN}"
echo "📊 Insights dashboard: https://${DOMAIN}/insights"