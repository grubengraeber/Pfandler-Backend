#!/bin/bash

# Helper script for managing the deployed Pfandler backend

SERVER_IP="138.199.195.211"
SSH_KEY="~/.ssh/pfandler-deploy"

case "$1" in
  ssh)
    echo "🔐 Connecting to server..."
    ssh -i $SSH_KEY root@$SERVER_IP
    ;;
    
  logs)
    echo "📋 Showing application logs..."
    ssh -i $SSH_KEY root@$SERVER_IP "cd /opt/pfandler && docker-compose logs -f app"
    ;;
    
  logs-all)
    echo "📋 Showing all logs..."
    ssh -i $SSH_KEY root@$SERVER_IP "cd /opt/pfandler && docker-compose logs -f"
    ;;
    
  status)
    echo "🔍 Checking container status..."
    ssh -i $SSH_KEY root@$SERVER_IP "cd /opt/pfandler && docker-compose ps"
    ;;
    
  restart)
    echo "🔄 Restarting application..."
    ssh -i $SSH_KEY root@$SERVER_IP "cd /opt/pfandler && docker-compose restart app"
    ;;
    
  rebuild)
    echo "🏗️ Rebuilding and restarting application..."
    ssh -i $SSH_KEY root@$SERVER_IP "cd /opt/pfandler && docker-compose build app && docker-compose up -d app"
    ;;
    
  nginx-logs)
    echo "📋 Showing Nginx logs..."
    ssh -i $SSH_KEY root@$SERVER_IP "tail -f /var/log/nginx/error.log /var/log/nginx/access.log"
    ;;
    
  test)
    echo "🧪 Testing API endpoints..."
    echo "Health check:"
    curl -s https://api.pfandler.fabiotietz.com/health | jq . || echo "API not responding"
    ;;
    
  *)
    echo "Pfandler Backend Server Management"
    echo "Usage: ./server-commands.sh [command]"
    echo ""
    echo "Commands:"
    echo "  ssh         - Connect to the server via SSH"
    echo "  logs        - Show application logs (follow mode)"
    echo "  logs-all    - Show all container logs (follow mode)"
    echo "  status      - Check container status"
    echo "  restart     - Restart the application"
    echo "  rebuild     - Rebuild and restart the application"
    echo "  nginx-logs  - Show Nginx access and error logs"
    echo "  test        - Test if the API is responding"
    echo ""
    echo "Server: $SERVER_IP"
    echo "Domain: https://api.pfandler.fabiotietz.com"
    ;;
esac