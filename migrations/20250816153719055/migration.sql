BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "location" ADD COLUMN "address" text;
ALTER TABLE "location" ADD COLUMN "googleMapsUrl" text;

--
-- MIGRATION VERSION FOR pfandler_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pfandler_backend', '20250816153719055', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250816153719055', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
