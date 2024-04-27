/*
  Warnings:

  - You are about to drop the `Country` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FiltersCareer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Location` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_CareerToFiltersCareer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_CityToLocation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_CountryToLocation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_FiltersCareerToLocation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_LocationToState` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `location` on the `Career` table. All the data in the column will be lost.
  - Added the required column `stateId` to the `City` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "_CareerToFiltersCareer_B_index";

-- DropIndex
DROP INDEX "_CareerToFiltersCareer_AB_unique";

-- DropIndex
DROP INDEX "_CityToLocation_B_index";

-- DropIndex
DROP INDEX "_CityToLocation_AB_unique";

-- DropIndex
DROP INDEX "_CountryToLocation_B_index";

-- DropIndex
DROP INDEX "_CountryToLocation_AB_unique";

-- DropIndex
DROP INDEX "_FiltersCareerToLocation_B_index";

-- DropIndex
DROP INDEX "_FiltersCareerToLocation_AB_unique";

-- DropIndex
DROP INDEX "_LocationToState_B_index";

-- DropIndex
DROP INDEX "_LocationToState_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Country";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "FiltersCareer";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Location";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_CareerToFiltersCareer";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_CityToLocation";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_CountryToLocation";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_FiltersCareerToLocation";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_LocationToState";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "_CareerToCity" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CareerToCity_A_fkey" FOREIGN KEY ("A") REFERENCES "Career" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CareerToCity_B_fkey" FOREIGN KEY ("B") REFERENCES "City" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Career" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "time" DATETIME NOT NULL,
    "count" INTEGER NOT NULL
);
INSERT INTO "new_Career" ("count", "createdAt", "description", "id", "time", "title", "updatedAt") SELECT "count", "createdAt", "description", "id", "time", "title", "updatedAt" FROM "Career";
DROP TABLE "Career";
ALTER TABLE "new_Career" RENAME TO "Career";
CREATE TABLE "new_City" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "stateId" TEXT NOT NULL,
    "localName" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "timezone" DATETIME NOT NULL,
    "zipCode" INTEGER NOT NULL,
    CONSTRAINT "City_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "State" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_City" ("createdAt", "id", "localName", "name", "timezone", "zipCode") SELECT "createdAt", "id", "localName", "name", "timezone", "zipCode" FROM "City";
DROP TABLE "City";
ALTER TABLE "new_City" RENAME TO "City";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_CareerToCity_AB_unique" ON "_CareerToCity"("A", "B");

-- CreateIndex
CREATE INDEX "_CareerToCity_B_index" ON "_CareerToCity"("B");
