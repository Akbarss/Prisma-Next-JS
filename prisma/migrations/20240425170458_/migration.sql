/*
  Warnings:

  - You are about to alter the column `area` on the `Aviability` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `baths` on the `Aviability` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `beds` on the `Aviability` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `estMonthlyCommonCharges` on the `Aviability` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `residence` on the `Aviability` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- CreateTable
CREATE TABLE "Protfolio" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "coverImage" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "FilterPortfolio" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "upodatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Career" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "time" DATETIME NOT NULL,
    "count" INTEGER NOT NULL,
    "location" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Location" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "City" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "localName" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "timezone" DATETIME NOT NULL,
    "zipCode" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Country" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "localName" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "phoneCode" INTEGER NOT NULL,
    "timeZone" DATETIME NOT NULL,
    "zipCode" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "State" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "localName" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "timeZone" DATETIME NOT NULL,
    "zipCode" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "FiltersCareer" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_FilterPortfolioToProtfolio" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_FilterPortfolioToProtfolio_A_fkey" FOREIGN KEY ("A") REFERENCES "FilterPortfolio" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_FilterPortfolioToProtfolio_B_fkey" FOREIGN KEY ("B") REFERENCES "Protfolio" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CareerToFiltersCareer" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CareerToFiltersCareer_A_fkey" FOREIGN KEY ("A") REFERENCES "Career" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CareerToFiltersCareer_B_fkey" FOREIGN KEY ("B") REFERENCES "FiltersCareer" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_LocationToState" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_LocationToState_A_fkey" FOREIGN KEY ("A") REFERENCES "Location" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_LocationToState_B_fkey" FOREIGN KEY ("B") REFERENCES "State" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CityToLocation" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CityToLocation_A_fkey" FOREIGN KEY ("A") REFERENCES "City" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CityToLocation_B_fkey" FOREIGN KEY ("B") REFERENCES "Location" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CountryToLocation" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CountryToLocation_A_fkey" FOREIGN KEY ("A") REFERENCES "Country" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CountryToLocation_B_fkey" FOREIGN KEY ("B") REFERENCES "Location" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_FiltersCareerToLocation" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_FiltersCareerToLocation_A_fkey" FOREIGN KEY ("A") REFERENCES "FiltersCareer" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_FiltersCareerToLocation_B_fkey" FOREIGN KEY ("B") REFERENCES "Location" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Aviability" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "upodatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "coverImage" TEXT NOT NULL,
    "residence" INTEGER NOT NULL,
    "beds" INTEGER NOT NULL,
    "baths" INTEGER NOT NULL,
    "area" INTEGER NOT NULL,
    "price" TEXT NOT NULL,
    "estMonthlyCommonCharges" INTEGER NOT NULL,
    "description" TEXT
);
INSERT INTO "new_Aviability" ("area", "baths", "beds", "coverImage", "createdAt", "description", "estMonthlyCommonCharges", "id", "price", "residence", "title", "upodatedAt") SELECT "area", "baths", "beds", "coverImage", "createdAt", "description", "estMonthlyCommonCharges", "id", "price", "residence", "title", "upodatedAt" FROM "Aviability";
DROP TABLE "Aviability";
ALTER TABLE "new_Aviability" RENAME TO "Aviability";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_FilterPortfolioToProtfolio_AB_unique" ON "_FilterPortfolioToProtfolio"("A", "B");

-- CreateIndex
CREATE INDEX "_FilterPortfolioToProtfolio_B_index" ON "_FilterPortfolioToProtfolio"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CareerToFiltersCareer_AB_unique" ON "_CareerToFiltersCareer"("A", "B");

-- CreateIndex
CREATE INDEX "_CareerToFiltersCareer_B_index" ON "_CareerToFiltersCareer"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_LocationToState_AB_unique" ON "_LocationToState"("A", "B");

-- CreateIndex
CREATE INDEX "_LocationToState_B_index" ON "_LocationToState"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CityToLocation_AB_unique" ON "_CityToLocation"("A", "B");

-- CreateIndex
CREATE INDEX "_CityToLocation_B_index" ON "_CityToLocation"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CountryToLocation_AB_unique" ON "_CountryToLocation"("A", "B");

-- CreateIndex
CREATE INDEX "_CountryToLocation_B_index" ON "_CountryToLocation"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FiltersCareerToLocation_AB_unique" ON "_FiltersCareerToLocation"("A", "B");

-- CreateIndex
CREATE INDEX "_FiltersCareerToLocation_B_index" ON "_FiltersCareerToLocation"("B");
