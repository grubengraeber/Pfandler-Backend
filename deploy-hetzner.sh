#!/bin/bash

# Hetzner Cloud Deployment Script for Pfandler Backend
set -e

# Configuration
export HCLOUD_TOKEN="${HCLOUD_TOKEN:-oCW3owbWIe5Fy9UWiyCpxteLNU7bPLIIs5i98bTKMYOPhzSLb8gYjWbHVGPKFJqv}"
SERVER_NAME="pfandler-api"
SERVER_TYPE="cx22"  # 2 vCPU, 4GB RAM, 40GB SSD
IMAGE="ubuntu-24.04"
LOCATION="nbg1"  # Nuremberg, Germany
DOMAIN="api.pfandler.fabiotietz.com"

echo "🚀 Starting Hetzner deployment for Pfandler Backend..."

# Check if server already exists
if hcloud server describe $SERVER_NAME &>/dev/null; then
    echo "Server $SERVER_NAME already exists. Getting IP..."
    SERVER_IP=$(hcloud server describe $SERVER_NAME -o format='{{.PublicNet.IPv4.IP}}')
else
    # Create SSH key if it doesn't exist
    if ! hcloud ssh-key describe pfandler-deploy &>/dev/null; then
        echo "Creating SSH key..."
        ssh-keygen -t ed25519 -f ~/.ssh/pfandler-deploy -N "" -C "pfandler-deploy"
        hcloud ssh-key create --name pfandler-deploy --public-key-from-file ~/.ssh/pfandler-deploy.pub
    fi

    # Create server
    echo "Creating server $SERVER_NAME..."
    hcloud server create \
        --name $SERVER_NAME \
        --type $SERVER_TYPE \
        --image $IMAGE \
        --location $LOCATION \
        --ssh-key pfandler-deploy \
        --user-data-from-file cloud-init.yaml

    # Wait for server to be ready
    echo "Waiting for server to be ready..."
    sleep 30

    # Get server IP
    SERVER_IP=$(hcloud server describe $SERVER_NAME -o format='{{.PublicNet.IPv4.IP}}')
fi

echo "✅ Server created with IP: $SERVER_IP"
echo ""
echo "📝 DNS Configuration Required:"
echo "Please add the following DNS A record to your domain:"
echo ""
echo "Type: A"
echo "Name: api"
echo "Value: $SERVER_IP"
echo "TTL: 300"
echo ""
echo "The full domain will be: $DOMAIN"
echo ""
echo "After DNS is configured, run the setup script:"
echo "./setup-remote.sh $SERVER_IP"