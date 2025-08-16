BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "badge" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "iconUrl" text,
    "criteria" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "favorite_location" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "locationId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "favorite_location_unique_idx" ON "favorite_location" USING btree ("userId", "locationId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "location" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "lat" double precision NOT NULL,
    "lng" double precision NOT NULL,
    "acceptsJson" text,
    "openingHoursJson" text
);

-- Indexes
CREATE INDEX "location_coords_idx" ON "location" USING btree ("lat", "lng");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "location_report" (
    "id" bigserial PRIMARY KEY,
    "locationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "status" text NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product" (
    "id" bigserial PRIMARY KEY,
    "barcode" text NOT NULL,
    "name" text NOT NULL,
    "brand" text,
    "volumeML" bigint,
    "containerType" text,
    "defaultDepositCents" bigint,
    "verifiedAt" timestamp without time zone,
    "communityConfidence" double precision
);

-- Indexes
CREATE UNIQUE INDEX "product_barcode_idx" ON "product" USING btree ("barcode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "return_session" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "locationId" bigint,
    "startedAt" timestamp without time zone NOT NULL,
    "endedAt" timestamp without time zone,
    "totalDepositCents" bigint,
    "note" text
);

-- Indexes
CREATE INDEX "return_session_user_started_idx" ON "return_session" USING btree ("userId", "startedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "scan" (
    "id" bigserial PRIMARY KEY,
    "sessionId" bigint,
    "userId" bigint NOT NULL,
    "productId" bigint,
    "barcode" text NOT NULL,
    "volumeML" bigint,
    "containerType" text,
    "depositCents" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "source" text NOT NULL
);

-- Indexes
CREATE INDEX "scan_user_created_idx" ON "scan" USING btree ("userId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "settingsJson" text
);

-- Indexes
CREATE UNIQUE INDEX "user_email_idx" ON "user" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_badge" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "badgeId" bigint NOT NULL,
    "awardedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_badge_unique_idx" ON "user_badge" USING btree ("userId", "badgeId");


--
-- MIGRATION VERSION FOR pfandler_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pfandler_backend', '20250816123738605', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250816123738605', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
