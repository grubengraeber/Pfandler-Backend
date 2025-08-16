#!/bin/bash

# Remote server setup script
set -e

SERVER_IP=$1
DOMAIN="api.pfandler.fabiotietz.com"

if [ -z "$SERVER_IP" ]; then
    echo "Usage: ./setup-remote.sh <server-ip>"
    exit 1
fi

echo "🔧 Setting up remote server at $SERVER_IP..."

# Copy files to server
echo "📦 Copying application files..."
rsync -avz --exclude 'node_modules' \
    --exclude '.dart_tool' \
    --exclude 'build' \
    --exclude '.git' \
    --exclude '*.log' \
    -e "ssh -i ~/.ssh/pfandler-deploy" \
    . deploy@$SERVER_IP:/opt/pfandler/

# Create environment file
echo "🔐 Creating environment configuration..."
ssh -i ~/.ssh/pfandler-deploy deploy@$SERVER_IP << 'EOF'
cd /opt/pfandler

# Create .env file
cat > .env << EOL
# Database Configuration
DB_HOST=postgres
DB_PORT=5432
DB_NAME=pfandler
DB_USER=pfandler
DB_PASSWORD=$(openssl rand -base64 32)

# Redis Configuration
REDIS_HOST=redis
REDIS_PORT=6379

# JWT Configuration
JWT_SECRET=$(openssl rand -base64 64)

# Server Configuration
SERVER_PORT=8080
SERVER_HOST=0.0.0.0

# Environment
ENVIRONMENT=production
EOL

# Create docker-compose.yml for production
cat > docker-compose.yml << 'EOL'
version: '3.8'

services:
  postgres:
    image: pgvector/pgvector:16-alpine
    restart: always
    environment:
      POSTGRES_DB: pfandler
      POSTGRES_USER: pfandler
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./migrations:/docker-entrypoint-initdb.d
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U pfandler"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    restart: always
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  app:
    build:
      context: .
      dockerfile: Dockerfile.production
    restart: always
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    env_file:
      - .env
    ports:
      - "8080:8080"
    volumes:
      - ./config:/app/config:ro
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  nginx:
    image: nginx:alpine
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
      - certbot_data:/var/www/certbot
    depends_on:
      - app

volumes:
  postgres_data:
  redis_data:
  certbot_data:
EOL

# Create nginx configuration
cat > nginx.conf << 'EOL'
events {
    worker_connections 1024;
}

http {
    upstream backend {
        server app:8080;
    }

    server {
        listen 80;
        server_name api.pfandler.fabiotietz.com;

        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }

        location / {
            return 301 https://$server_name$request_uri;
        }
    }

    server {
        listen 443 ssl http2;
        server_name api.pfandler.fabiotietz.com;

        ssl_certificate /etc/nginx/ssl/fullchain.pem;
        ssl_certificate_key /etc/nginx/ssl/privkey.pem;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
EOL

echo "Configuration files created successfully!"
EOF

# Build and start the application
echo "🏗️ Building and starting application..."
ssh -i ~/.ssh/pfandler-deploy deploy@$SERVER_IP << 'EOF'
cd /opt/pfandler

# Build Docker image
sudo docker-compose build

# Start services (without nginx first)
sudo docker-compose up -d postgres redis app

# Wait for services to be ready
sleep 10

# Run database migrations
sudo docker-compose exec -T app dart bin/main.dart --apply-migrations

echo "Application started successfully!"
EOF

# Setup SSL certificate
echo "🔒 Setting up SSL certificate..."
ssh -i ~/.ssh/pfandler-deploy deploy@$SERVER_IP << EOF
# Get SSL certificate
sudo certbot certonly --standalone -d $DOMAIN --non-interactive --agree-tos --email admin@$DOMAIN

# Copy certificates to app directory
sudo mkdir -p /opt/pfandler/ssl
sudo cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /opt/pfandler/ssl/
sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /opt/pfandler/ssl/
sudo chown -R deploy:deploy /opt/pfandler/ssl

# Start nginx
cd /opt/pfandler
sudo docker-compose up -d nginx

# Setup auto-renewal
(crontab -l 2>/dev/null; echo "0 0 * * * certbot renew --quiet --post-hook 'docker-compose -f /opt/pfandler/docker-compose.yml restart nginx'") | crontab -

echo "SSL certificate configured successfully!"
EOF

echo "✅ Deployment complete!"
echo ""
echo "Your API is available at: https://$DOMAIN"
echo ""
echo "Next steps:"
echo "1. Test the API: curl https://$DOMAIN/health"
echo "2. Monitor logs: ssh -i ~/.ssh/pfandler-deploy deploy@$SERVER_IP 'cd /opt/pfandler && sudo docker-compose logs -f'"
echo "3. Access server: ssh -i ~/.ssh/pfandler-deploy deploy@$SERVER_IP"