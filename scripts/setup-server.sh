#!/bin/bash
set -e

# Initial server setup script - Run this on a fresh Ubuntu/Debian server
echo "🖥️  Setting up server for Pfandler Backend..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install required packages
echo "📦 Installing required packages..."
sudo apt install -y \
    docker.io \
    docker-compose \
    git \
    curl \
    ufw \
    fail2ban \
    htop \
    vim

# Setup Docker
echo "🐳 Setting up Docker..."
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Setup firewall
echo "🔥 Configuring firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

# Setup fail2ban for security
echo "🛡️  Setting up fail2ban..."
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Create serverpod user
echo "👤 Creating serverpod user..."
if ! id -u serverpod > /dev/null 2>&1; then
    sudo useradd -m -s /bin/bash serverpod
    sudo usermod -aG docker serverpod
fi

# Clone repository
echo "📥 Cloning repository..."
sudo -u serverpod bash << 'EOF'
cd /home/serverpod
if [ ! -d "pfandler-backend" ]; then
    git clone https://github.com/YOUR_GITHUB_USERNAME/pfandler-backend.git
fi
cd pfandler-backend
EOF

# Create .env.production file
echo "📝 Creating .env.production file..."
echo "Please edit /home/serverpod/pfandler-backend/.env.production with your configuration"
sudo cp /home/serverpod/pfandler-backend/.env.production.example /home/serverpod/pfandler-backend/.env.production
sudo chown serverpod:serverpod /home/serverpod/pfandler-backend/.env.production

# Make scripts executable
echo "🔧 Making scripts executable..."
sudo chmod +x /home/serverpod/pfandler-backend/scripts/*.sh

# Setup systemd service
echo "⚙️  Creating systemd service..."
sudo tee /etc/systemd/system/pfandler-backend.service > /dev/null << 'EOF'
[Unit]
Description=Pfandler Backend Service
After=docker.service
Requires=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
User=serverpod
WorkingDirectory=/home/serverpod/pfandler-backend
ExecStart=/usr/bin/docker-compose -f docker-compose.production.yml up -d
ExecStop=/usr/bin/docker-compose -f docker-compose.production.yml down
StandardOutput=journal

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable pfandler-backend

echo "✅ Server setup completed!"
echo ""
echo "📋 Next steps:"
echo "1. Edit /home/serverpod/pfandler-backend/.env.production with your configuration"
echo "2. Run: sudo -u serverpod /home/serverpod/pfandler-backend/scripts/init-ssl.sh"
echo "3. Run: sudo -u serverpod /home/serverpod/pfandler-backend/scripts/deploy.sh"
echo "4. Configure your DNS to point to this server's IP address"