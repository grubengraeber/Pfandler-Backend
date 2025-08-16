# 🚀 Pfandler Backend Deployment Guide

Complete guide for deploying the Pfandler Backend to production on your company domain.

## 📋 Prerequisites

- A Linux server (Ubuntu 22.04 or Debian 12 recommended)
- A domain name pointing to your server's IP
- GitHub account for CI/CD
- Basic knowledge of Docker and Linux

## 🏗️ Architecture

```
Internet → CloudFlare/DNS → Your Domain
                ↓
        Nginx (SSL/HTTPS)
                ↓
        Serverpod Backend
            ↓        ↓
      PostgreSQL   Redis
```

## 🔧 Quick Start

### 1. Server Setup

SSH into your server and run:

```bash
# Download and run the setup script
wget https://raw.githubusercontent.com/YOUR_REPO/main/scripts/setup-server.sh
chmod +x setup-server.sh
./setup-server.sh
```

### 2. Configure Environment

Edit the production environment file:

```bash
sudo nano /home/serverpod/pfandler-backend/.env.production
```

Required variables:
```env
# Your company domain
DOMAIN=api.yourcompany.com
GITHUB_REPOSITORY=yourcompany/pfandler-backend

# Database (use strong passwords!)
DB_NAME=pfandler_production
DB_USER=pfandler_user
DB_PASSWORD=GenerateSecurePassword123!

# Redis
REDIS_PASSWORD=AnotherSecurePassword456!

# Serverpod secrets (generate random strings)
API_SECRET=RandomString789ForAPI
SERVICE_SECRET=RandomString012ForService

# SSL email
SSL_EMAIL=admin@yourcompany.com
```

### 3. DNS Configuration

Point your domain to the server:

| Type | Host | Value | TTL |
|------|------|-------|-----|
| A | api | YOUR_SERVER_IP | 3600 |
| A | @ | YOUR_SERVER_IP | 3600 |

### 4. Initialize SSL Certificates

```bash
cd /home/serverpod/pfandler-backend
sudo -u serverpod ./scripts/init-ssl.sh
```

### 5. Deploy

```bash
sudo -u serverpod ./scripts/deploy.sh
```

## 🔄 CI/CD Setup

### GitHub Secrets

Add these secrets to your GitHub repository (Settings → Secrets):

- `SERVER_HOST`: Your server's IP address
- `SERVER_USER`: serverpod
- `SERVER_SSH_KEY`: Your SSH private key (for deployment)
- `SLACK_WEBHOOK`: (Optional) For deployment notifications

### Deployment Workflow

Push to `main` branch → Tests run → Docker image builds → Auto-deploys to server

## 🛡️ Security Checklist

- [ ] Strong passwords in `.env.production`
- [ ] Firewall configured (only 80, 443, SSH open)
- [ ] SSL certificates installed
- [ ] fail2ban configured
- [ ] Regular backups enabled
- [ ] Monitoring setup

## 📱 Mobile App Configuration

Update your Flutter app to use the production API:

```dart
// lib/config/api_config.dart
class ApiConfig {
  static const String baseUrl = 'https://api.yourcompany.com';
  static const String wsUrl = 'wss://api.yourcompany.com/ws';
}
```

## 🔍 Monitoring

### Check Service Status
```bash
docker compose -f docker-compose.production.yml ps
```

### View Logs
```bash
# All services
docker compose -f docker-compose.production.yml logs -f

# Specific service
docker compose -f docker-compose.production.yml logs serverpod -f --tail=100
```

### Health Check
```bash
curl https://api.yourcompany.com/health
```

### Insights Dashboard
Visit: `https://api.yourcompany.com/insights`

## 🔧 Maintenance

### Update Application
```bash
cd /home/serverpod/pfandler-backend
git pull origin main
./scripts/deploy.sh
```

### Backup Database
```bash
docker compose -f docker-compose.production.yml exec backup /backup.sh
```

### Restore Database
```bash
gunzip < backups/pfandler_backup_TIMESTAMP.sql.gz | \
  docker compose -f docker-compose.production.yml exec -T postgres \
  psql -U pfandler_user -d pfandler_production
```

### Renew SSL Certificate
Automatic renewal runs twice daily. Manual renewal:
```bash
docker compose -f docker-compose.production.yml run --rm certbot renew
```

## 🚨 Troubleshooting

### Service Won't Start
```bash
# Check logs
docker compose -f docker-compose.production.yml logs serverpod

# Check port availability
sudo netstat -tulpn | grep -E ':(80|443|8080)'
```

### Database Connection Issues
```bash
# Test connection
docker compose -f docker-compose.production.yml exec postgres \
  psql -U pfandler_user -d pfandler_production -c "SELECT 1"
```

### SSL Certificate Issues
```bash
# Check certificate
openssl s_client -connect api.yourcompany.com:443 -servername api.yourcompany.com
```

## 📊 Performance Tuning

### PostgreSQL Optimization
Edit `docker-compose.production.yml` to add:
```yaml
postgres:
  command: |
    -c max_connections=200
    -c shared_buffers=256MB
    -c effective_cache_size=1GB
    -c maintenance_work_mem=64MB
```

### Nginx Optimization
Already configured for:
- Gzip compression
- Rate limiting
- Connection limits
- HTTP/2

## 🔄 Scaling

For high traffic, consider:

1. **Load Balancer**: Add HAProxy or use cloud load balancer
2. **Multiple Serverpod Instances**: Run multiple containers
3. **Database Replication**: Setup PostgreSQL replication
4. **Redis Cluster**: For session management at scale
5. **CDN**: CloudFlare for static assets

## 📞 Support

- GitHub Issues: [Your Repository Issues]
- Documentation: [Serverpod Docs](https://docs.serverpod.dev)
- Monitoring: Check `/insights` endpoint

## 🎯 Quick Commands Reference

```bash
# Deploy
./scripts/deploy.sh

# View logs
docker compose -f docker-compose.production.yml logs -f

# Restart services
docker compose -f docker-compose.production.yml restart

# Stop services
docker compose -f docker-compose.production.yml down

# Database shell
docker compose -f docker-compose.production.yml exec postgres psql -U pfandler_user -d pfandler_production

# Redis shell  
docker compose -f docker-compose.production.yml exec redis redis-cli
```

---

## ✅ Deployment Checklist

- [ ] Server provisioned
- [ ] Domain configured
- [ ] Environment variables set
- [ ] SSL certificates installed
- [ ] Database migrated
- [ ] Health check passing
- [ ] Mobile app updated with production URL
- [ ] Backups configured
- [ ] Monitoring setup
- [ ] Documentation updated

Once all items are checked, your Pfandler Backend is ready for production! 🎉