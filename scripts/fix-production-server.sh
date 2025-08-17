#!/bin/bash

# Fix production server database configuration
# Run this script on the production server at 138.199.195.211

set -e

echo "🔧 Fixing Pfandler Backend Production Server"
echo "============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to generate secure password
generate_password() {
    openssl rand -base64 32 | tr -d "=+/" | cut -c1-25
}

echo -e "${YELLOW}Step 1: Check current directory${NC}"
DEPLOY_DIR="/opt/pfandler-backend"
if [ ! -d "$DEPLOY_DIR" ]; then
    DEPLOY_DIR="/home/pfandler-backend"
fi
if [ ! -d "$DEPLOY_DIR" ]; then
    DEPLOY_DIR="/var/www/pfandler-backend"
fi
if [ ! -d "$DEPLOY_DIR" ]; then
    echo -e "${YELLOW}Creating deployment directory${NC}"
    DEPLOY_DIR="/opt/pfandler-backend"
    mkdir -p $DEPLOY_DIR
fi

cd $DEPLOY_DIR
echo "Working directory: $DEPLOY_DIR"

echo -e "${YELLOW}Step 2: Clone or update repository${NC}"
if [ ! -d ".git" ]; then
    git clone https://github.com/grubengraeber/Pfandler-Backend.git .
else
    git pull origin main
fi

echo -e "${YELLOW}Step 3: Create production configuration${NC}"
cat > config/production.yaml << 'EOF'
# Production configuration for api.pfandler.fabiotietz.com
apiServer:
  port: 8080
  publicHost: api.pfandler.fabiotietz.com
  publicPort: 443
  publicScheme: https

insightsServer:
  port: 8081
  publicHost: api.pfandler.fabiotietz.com
  publicPort: 443
  publicScheme: https

webServer:
  port: 8082
  publicHost: api.pfandler.fabiotietz.com
  publicPort: 443
  publicScheme: https

database:
  host: postgres
  port: 5432
  name: pfandler_production
  user: pfandler_user
  requireSsl: false

redis:
  enabled: true
  host: redis
  port: 6379
  requireSsl: false

maxRequestSize: 524288
sessionLogs:
  consoleEnabled: true
  persistentEnabled: true
  consoleLogFormat: json
futureCallExecutionEnabled: true
EOF

echo -e "${YELLOW}Step 4: Generate passwords if not exists${NC}"
if [ ! -f config/passwords.yaml ]; then
    DB_PASS=$(generate_password)
    REDIS_PASS=$(generate_password)
    API_SECRET=$(openssl rand -hex 32)
    SERVICE_SECRET=$(openssl rand -hex 32)
    
    cat > config/passwords.yaml << EOF
shared:
  serviceSecret: '$SERVICE_SECRET'

production:
  database: '$DB_PASS'
  redis: '$REDIS_PASS'
  serviceSecret: '$SERVICE_SECRET'
EOF
    chmod 600 config/passwords.yaml
    echo -e "${GREEN}Generated new passwords${NC}"
else
    echo "Using existing passwords.yaml"
    DB_PASS=$(grep -A1 "production:" config/passwords.yaml | grep "database:" | cut -d"'" -f2)
fi

echo -e "${YELLOW}Step 5: Create docker-compose.production.yml${NC}"
cat > docker-compose.production.yml << EOF
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    restart: always
    environment:
      POSTGRES_USER: pfandler_user
      POSTGRES_PASSWORD: $DB_PASS
      POSTGRES_DB: pfandler_production
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - pfandler_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U pfandler_user -d pfandler_production"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    restart: always
    command: redis-server --requirepass $REDIS_PASS
    networks:
      - pfandler_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  serverpod:
    image: dart:3.6.1
    restart: always
    working_dir: /app
    command: dart bin/main.dart --mode production --port 8080
    environment:
      - SERVERPOD_MODE=production
      - DB_HOST=postgres
      - DB_NAME=pfandler_production
      - DB_USER=pfandler_user
      - DB_PASSWORD=$DB_PASS
      - REDIS_HOST=redis
      - REDIS_PASSWORD=$REDIS_PASS
    ports:
      - "8080:8080"
      - "8081:8081"
      - "8082:8082"
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - pfandler_network
    volumes:
      - .:/app
      - /app/.dart_tool
      - /app/build

networks:
  pfandler_network:
    driver: bridge

volumes:
  postgres_data:
EOF

echo -e "${YELLOW}Step 6: Install dependencies${NC}"
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    systemctl start docker
    systemctl enable docker
fi

echo -e "${YELLOW}Step 7: Stop existing services${NC}"
docker compose down 2>/dev/null || true

echo -e "${YELLOW}Step 8: Start services${NC}"
docker compose -f docker-compose.production.yml up -d

echo -e "${YELLOW}Step 9: Wait for services to be ready${NC}"
sleep 10

echo -e "${YELLOW}Step 10: Run database migrations${NC}"
docker compose -f docker-compose.production.yml exec serverpod dart bin/main.dart --mode production --apply-migrations || echo "Migrations may already be applied"

echo -e "${YELLOW}Step 11: Configure Nginx${NC}"
cat > /etc/nginx/sites-available/pfandler-backend << 'EOF'
server {
    listen 80;
    server_name api.pfandler.fabiotietz.com;
    return 301 https://\$server_name\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name api.pfandler.fabiotietz.com;

    ssl_certificate /etc/letsencrypt/live/api.pfandler.fabiotietz.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.pfandler.fabiotietz.com/privkey.pem;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enable the site if not already enabled
if [ ! -L /etc/nginx/sites-enabled/pfandler-backend ]; then
    ln -s /etc/nginx/sites-available/pfandler-backend /etc/nginx/sites-enabled/
fi

# Test and reload nginx
nginx -t && systemctl reload nginx

echo -e "${YELLOW}Step 12: Test the deployment${NC}"
sleep 5
echo "Testing local connection..."
curl -f http://localhost:8080/greeting/hello?name=Production || echo "Local test failed"

echo "Testing HTTPS endpoint..."
curl -f https://api.pfandler.fabiotietz.com/greeting/hello?name=Production || echo "HTTPS test failed"

echo ""
echo -e "${GREEN}✅ Production server configuration complete!${NC}"
echo ""
echo "Test the API:"
echo "  curl 'https://api.pfandler.fabiotietz.com/greeting/hello?name=Test'"
echo "  curl 'https://api.pfandler.fabiotietz.com/location/nearby?lat=48.1351&lng=11.5820'"
echo ""
echo "View logs:"
echo "  docker compose -f docker-compose.production.yml logs -f"
echo ""
echo "Database password stored in: $DEPLOY_DIR/config/passwords.yaml"