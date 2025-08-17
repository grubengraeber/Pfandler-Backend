#!/bin/bash

# Test Production Endpoints Script
# Tests the correct way to call Serverpod endpoints (POST with JSON body)

API_URL="https://api.pfandler.fabiotietz.com"

echo "🔍 Testing Pfandler Backend Production Endpoints"
echo "================================================"

# Test greeting endpoint (simple test)
echo -e "\n1️⃣ Testing Greeting Endpoint..."
curl -X POST "$API_URL/greeting/hello" \
  -H "Content-Type: application/json" \
  -d '{"name": "ProductionTest"}' \
  -s | jq '.' || echo "Failed"

# Test location/nearby endpoint - Austria-wide search
echo -e "\n2️⃣ Testing Location Nearby (Austria-wide search)..."
curl -X POST "$API_URL/location/nearby" \
  -H "Content-Type: application/json" \
  -d '{
    "lat": 48.1351,
    "lng": 11.5820
  }' \
  -s | jq '.' || echo "Failed"

# Test location/nearby endpoint - Local search with radius
echo -e "\n3️⃣ Testing Location Nearby (5km radius)..."
curl -X POST "$API_URL/location/nearby" \
  -H "Content-Type: application/json" \
  -d '{
    "lat": 48.1351,
    "lng": 11.5820,
    "filters": {
      "maxDistance": 5.0
    }
  }' \
  -s | jq '.' || echo "Failed"

# Test location/nearby endpoint - Filtered by type
echo -e "\n4️⃣ Testing Location Nearby (Supermarkets only)..."
curl -X POST "$API_URL/location/nearby" \
  -H "Content-Type: application/json" \
  -d '{
    "lat": 48.2082,
    "lng": 16.3738,
    "filters": {
      "type": "supermarket",
      "maxDistance": 10.0
    }
  }' \
  -s | jq '.' || echo "Failed"

echo -e "\n✅ Test completed!"
echo "================================================"
echo ""
echo "📝 Note: All Serverpod endpoints use POST requests with JSON bodies."
echo "   GET requests with query parameters will result in 'Internal server error'."
echo ""
echo "Correct format:"
echo "  POST /location/nearby"
echo "  Body: {\"lat\": 48.1351, \"lng\": 11.5820}"
echo ""
echo "Incorrect format:"
echo "  GET /location/nearby?lat=48.1351&lng=11.5820"