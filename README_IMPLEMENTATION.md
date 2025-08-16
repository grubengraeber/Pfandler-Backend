# Pfandler Backend - Serverpod Implementation

## Database Tables

### User Management
- **user**: Stores user information (id, email, createdAt, settingsJson)
- **badge**: Gamification badges (id, name, description, iconUrl, criteria)
- **user_badge**: User-badge relationships (userId, badgeId, awardedAt)

### Product Catalog
- **product**: Product database (id, barcode, name, brand, volumeML, containerType, defaultDepositCents, verifiedAt, communityConfidence)

### Location Management
- **location**: Return locations (id, name, type, lat, lng, acceptsJson, openingHoursJson)
- **location_report**: User reports about locations (id, locationId, userId, status, note, createdAt)
- **favorite_location**: User's favorite locations (userId, locationId)

### Scanning & Sessions
- **return_session**: Return sessions (id, userId, locationId, startedAt, endedAt, totalDepositCents, note)
- **scan**: Individual scans (id, sessionId, userId, productId, barcode, volumeML, containerType, depositCents, createdAt, source)

## API Endpoints

### AuthEndpoint
- `registerWithEmail(email, password)`: Register new user
- `loginWithEmail(email, password)`: User login
- `getCurrentUser()`: Get authenticated user
- `linkDevice(deviceId, deviceName)`: Link device to user

### CatalogEndpoint
- `getProductByBarcode(barcode)`: Get product by barcode
- `suggestProduct(data)`: Suggest new product for moderation
- `searchProducts(query, limit, offset)`: Search products
- `verifyProduct(productId)`: Verify/upvote product

### ScanEndpoint
- `recordScan(scanInput)`: Record a new scan
- `startSession(locationId?)`: Start return session
- `endSession(sessionId)`: End return session
- `bulkUpload(scans[])`: Bulk upload scans
- `getUserScans(limit, offset)`: Get user's scan history

### LocationEndpoint
- `nearby(lat, lng, filters?)`: Find nearby locations
- `reportStatus(locationId, status, note?)`: Report location status
- `addLocation(suggestedLocation)`: Add new location
- `getFavorites()`: Get user's favorite locations
- `addFavorite(locationId)`: Add to favorites
- `removeFavorite(locationId)`: Remove from favorites

### StatsEndpoint
- `totals(startDate?, endDate?)`: Get total stats
- `breakdown(breakdownBy, startDate?, endDate?)`: Get breakdown by containerType/month/location/brand
- `exportCSV(startDate?, endDate?)`: Export data as CSV
- `getLeaderboard(period, limit)`: Get leaderboard

### SocialEndpoint (Optional)
- `getFriends()`: Get friends list
- `getUserBadges()`: Get user's badges
- `awardBadge(userId, badgeId)`: Award badge to user
- `checkAndAwardBadges(userId)`: Check and award eligible badges
- `getAllBadges()`: Get all available badges
- `createBadge(name, description, iconUrl?, criteria?)`: Create new badge
- `getLeaderboard(period, limit)`: Get social leaderboard

## Database Indexes

- `product.barcode` (unique)
- `scan.userId + createdAt`
- `return_session.userId + startedAt`
- `location.lat + lng`
- `favorite_location.userId + locationId` (unique)
- `user_badge.userId + badgeId` (unique)
- `user.email` (unique)

## Setup Instructions

1. Start the database:
```bash
docker compose up --build --detach
```

2. Apply migrations:
```bash
dart bin/main.dart --apply-migrations
```

3. Run the server:
```bash
dart bin/main.dart
```

## Client Usage

The generated client code is available in `../pfandler_backend_client` and can be used in Flutter/Dart applications to communicate with this backend.

## Notes

- Authentication is simplified - in production, implement proper password hashing and JWT tokens
- For production, consider adding rate limiting and request validation
- The location nearby search currently uses simple distance calculation - consider PostGIS for production
- Raw SQL queries have been replaced with ORM queries for better compatibility