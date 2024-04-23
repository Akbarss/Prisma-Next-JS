/*
  Warnings:

  - Added the required column `coverImage` to the `Aviability` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Aviability" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "upodatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "coverImage" TEXT NOT NULL,
    "description" TEXT,
    "residence" TEXT NOT NULL,
    "beds" TEXT NOT NULL,
    "baths" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "estMonthlyCommonCharges" TEXT NOT NULL
);
INSERT INTO "new_Aviability" ("area", "baths", "beds", "createdAt", "description", "estMonthlyCommonCharges", "id", "price", "residence", "title", "upodatedAt") SELECT "area", "baths", "beds", "createdAt", "description", "estMonthlyCommonCharges", "id", "price", "residence", "title", "upodatedAt" FROM "Aviability";
DROP TABLE "Aviability";
ALTER TABLE "new_Aviability" RENAME TO "Aviability";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
