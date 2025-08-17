# 🔧 Fix Production Server Database Error

The server at `api.pfandler.fabiotietz.com` is returning "Internal server error" because the database is not properly configured.

## Quick Fix via SSH

### Option 1: Automated Script
```bash
# SSH into the server
ssh root@138.199.195.211

# Download and run the fix script
wget https://raw.githubusercontent.com/grubengraeber/Pfandler-Backend/main/scripts/fix-production-server.sh
chmod +x fix-production-server.sh
sudo ./fix-production-server.sh
```

### Option 2: Manual Steps

1. **SSH into the server:**
```bash
ssh root@138.199.195.211
```

2. **Install PostgreSQL:**
```bash
apt update
apt install -y postgresql postgresql-contrib
systemctl start postgresql
systemctl enable postgresql
```

3. **Create database and user:**
```bash
sudo -u postgres psql << EOF
CREATE USER pfandler_user WITH PASSWORD 'ChangeThisPassword123';
CREATE DATABASE pfandler_production OWNER pfandler_user;
GRANT ALL PRIVILEGES ON DATABASE pfandler_production TO pfandler_user;
EOF
```

4. **Fix the configuration file:**
```bash
# Navigate to where the app is deployed
cd /opt/pfandler-backend  # or wherever it's deployed

# Create correct production.yaml
cat > config/production.yaml << 'EOF'
apiServer:
  port: 8080
  publicHost: api.pfandler.fabiotietz.com
  publicPort: 443
  publicScheme: https

database:
  host: localhost
  port: 5432
  name: pfandler_production
  user: pfandler_user
  requireSsl: false

redis:
  enabled: false
  host: localhost
  port: 6379

maxRequestSize: 524288
sessionLogs:
  consoleEnabled: true
  persistentEnabled: true
EOF
```

5. **Update passwords.yaml:**
```bash
cat > config/passwords.yaml << 'EOF'
production:
  database: 'ChangeThisPassword123'
  serviceSecret: 'GenerateRandomSecret123'
EOF
chmod 600 config/passwords.yaml
```

6. **Restart the application:**
```bash
# If using systemd
systemctl restart pfandler-backend

# If using Docker
docker restart pfandler-backend

# If running directly
pkill -f "dart.*main.dart"
nohup dart bin/main.dart --mode production --port 8080 > /var/log/pfandler.log 2>&1 &
```

## Testing the Fix

After applying the fix, test the endpoints:

```bash
# Test from the server
curl "http://localhost:8080/greeting/hello?name=LocalTest"
curl "http://localhost:8080/location/nearby?lat=48.1351&lng=11.5820"

# Test from outside
curl "https://api.pfandler.fabiotietz.com/greeting/hello?name=Test"
curl "https://api.pfandler.fabiotietz.com/location/nearby?lat=48.1351&lng=11.5820"
```

## Expected Results

✅ The greeting endpoint should return:
```json
{"message":"Hello Test","author":"Serverpod","timestamp":"2025-08-16T..."}
```

✅ The location endpoint should return location data instead of "Internal server error"

## Troubleshooting

If still getting errors:

1. **Check logs:**
```bash
# Application logs
tail -f /var/log/pfandler.log

# PostgreSQL logs
tail -f /var/log/postgresql/postgresql-*.log

# Nginx logs
tail -f /var/log/nginx/error.log
```

2. **Verify database connection:**
```bash
psql -h localhost -U pfandler_user -d pfandler_production -c "SELECT version();"
```

3. **Check if migrations ran:**
```bash
dart bin/main.dart --mode production --apply-migrations
```

## Root Cause

The server's `config/production.yaml` file has default values pointing to non-existent database hosts like `database.private-production.examplepod.com`. This needs to be changed to `localhost` with proper PostgreSQL setup.