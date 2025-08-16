# Pfandler Backend - Production Deployment Configuration

## Server Information
- **Domain**: api.pfandler.fabiotietz.com
- **IP Address**: 138.199.195.211
- **Provider**: Hetzner
- **Reverse DNS**: static.211.195.199.138.clients.your-server.de
- **Web Server**: nginx/1.24.0 (Ubuntu)
- **SSL Certificate**: Let's Encrypt (Valid until Nov 14, 2025)

## Current Issues and Fixes

### Problem: Internal Server Error on Database Queries
The deployed server returns "Internal server error" for endpoints that require database access.

**Root Cause**: The `config/production.yaml` file contains default placeholder values pointing to non-existent domains (examplepod.com).

### Solution Steps

1. **SSH into the server**:
```bash
ssh root@138.199.195.211
```

2. **Navigate to the application directory**:
```bash
cd /path/to/pfandler-backend
```

3. **Update production.yaml**:
```yaml
apiServer:
  port: 8080
  publicHost: api.pfandler.fabiotietz.com
  publicPort: 443
  publicScheme: https

database:
  host: localhost  # or postgres if using Docker
  port: 5432
  name: pfandler_production
  user: pfandler_user
  requireSsl: false

redis:
  enabled: true
  host: localhost  # or redis if using Docker
  port: 6379
  requireSsl: false
```

4. **Setup PostgreSQL**:
```bash
# Install PostgreSQL if not present
apt-get update && apt-get install -y postgresql postgresql-contrib

# Create database and user
sudo -u postgres psql << EOF
CREATE USER pfandler_user WITH PASSWORD 'your_secure_password';
CREATE DATABASE pfandler_production OWNER pfandler_user;
GRANT ALL PRIVILEGES ON DATABASE pfandler_production TO pfandler_user;
EOF
```

5. **Setup Redis**:
```bash
# Install Redis
apt-get install -y redis-server

# Configure password in /etc/redis/redis.conf
echo "requirepass your_redis_password" >> /etc/redis/redis.conf
systemctl restart redis-server
```

6. **Run migrations**:
```bash
dart bin/main.dart --mode production --apply-migrations
```

7. **Restart the application**:
```bash
# If using systemd
systemctl restart pfandler-backend

# If using Docker
docker-compose -f docker-compose.production.yml restart
```

## Environment Variables (.env.production)

Create this file on the server with these values:

```env
# Domain Configuration
DOMAIN=api.pfandler.fabiotietz.com
GITHUB_REPOSITORY=fabiotietz/Pfandler-Backend

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=pfandler_production
DB_USER=pfandler_user
DB_PASSWORD=<generate_secure_password>

# Redis Configuration
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=<generate_secure_password>

# Serverpod Secrets
API_SECRET=<generate_with_openssl_rand_hex_32>
SERVICE_SECRET=<generate_with_openssl_rand_hex_32>

# SSL Configuration
SSL_EMAIL=office@tietz-innovations.com
LETSENCRYPT_STAGING=false

# Server Configuration
SERVER_HOST=138.199.195.211
SERVER_USER=root
```

## Testing the Deployment

After configuration, test the endpoints:

```bash
# Test simple endpoint (no database)
curl "https://api.pfandler.fabiotietz.com/greeting/hello?name=World"

# Test database endpoint
curl "https://api.pfandler.fabiotietz.com/location/nearby?lat=48.1351&lng=11.5820"

# Test auth endpoint
curl "https://api.pfandler.fabiotietz.com/auth/loginWithEmail?email=test@example.com&password=test123"
```

## Important Notes

1. **The Hetzner API key provided appears to be invalid/expired**. You'll need a valid API key to manage the server via Hetzner Cloud API.

2. **Current server uses query parameters** instead of JSON body for API requests. This needs to be fixed in the Serverpod configuration to properly read JSON request bodies.

3. **Database is not configured** on the production server, causing all database-dependent endpoints to fail.

4. **Generate secure passwords** for production:
   - Database: `openssl rand -base64 32`
   - Redis: `openssl rand -base64 32`
   - API/Service secrets: `openssl rand -hex 32`

## GitHub Actions Deployment

Add these secrets to your GitHub repository:
- `SERVER_HOST`: 138.199.195.211
- `SERVER_USER`: root
- `SERVER_SSH_KEY`: Your SSH private key for deployment
- `SLACK_WEBHOOK`: (Optional) For notifications