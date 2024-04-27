/*
  Warnings:

  - You are about to drop the `FilterPortfolio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Protfolio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `State` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_FilterPortfolioToProtfolio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `localName` on the `City` table. All the data in the column will be lost.
  - You are about to drop the column `stateId` on the `City` table. All the data in the column will be lost.
  - You are about to drop the column `timezone` on the `City` table. All the data in the column will be lost.
  - You are about to drop the column `zipCode` on the `City` table. All the data in the column will be lost.
  - You are about to drop the column `select` on the `Contacts` table. All the data in the column will be lost.
  - You are about to drop the column `teamName` on the `Team` table. All the data in the column will be lost.
  - Added the required column `floorPlanUrl` to the `Aviability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `content` to the `Press` table without a default value. This is not possible if the table is not empty.
  - Added the required column `date` to the `Press` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Team` table without a default value. This is not possible if the table is not empty.
  - Added the required column `surname` to the `Team` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "_FilterPortfolioToProtfolio_B_index";

-- DropIndex
DROP INDEX "_FilterPortfolioToProtfolio_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "FilterPortfolio";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Protfolio";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "State";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_FilterPortfolioToProtfolio";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Project" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "categoryId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "coverImage" TEXT NOT NULL,
    CONSTRAINT "Project_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "ProjectCategory" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ProjectCategory" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "upodatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Career" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "time" DATETIME NOT NULL,
    "count" INTEGER NOT NULL
);
INSERT INTO "new_Career" ("count", "createdAt", "description", "id", "time", "title", "updatedAt") SELECT "count", "createdAt", "description", "id", "time", "title", "updatedAt" FROM "Career";
DROP TABLE "Career";
ALTER TABLE "new_Career" RENAME TO "Career";
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
    "description" TEXT,
    "floorPlanUrl" TEXT NOT NULL
);
INSERT INTO "new_Aviability" ("area", "baths", "beds", "coverImage", "createdAt", "description", "estMonthlyCommonCharges", "id", "price", "residence", "title", "upodatedAt") SELECT "area", "baths", "beds", "coverImage", "createdAt", "description", "estMonthlyCommonCharges", "id", "price", "residence", "title", "upodatedAt" FROM "Aviability";
DROP TABLE "Aviability";
ALTER TABLE "new_Aviability" RENAME TO "Aviability";
CREATE TABLE "new_City" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL
);
INSERT INTO "new_City" ("createdAt", "id", "name") SELECT "createdAt", "id", "name" FROM "City";
DROP TABLE "City";
ALTER TABLE "new_City" RENAME TO "City";
CREATE TABLE "new_Press" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "coverImg" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "date" DATETIME NOT NULL,
    "content" TEXT NOT NULL
);
INSERT INTO "new_Press" ("coverImg", "createdAt", "description", "id", "title", "updatedAt") SELECT "coverImg", "createdAt", "description", "id", "title", "updatedAt" FROM "Press";
DROP TABLE "Press";
ALTER TABLE "new_Press" RENAME TO "Press";
CREATE TABLE "new_Contacts" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "typeOfConsultation" TEXT
);
INSERT INTO "new_Contacts" ("createdAt", "email", "id", "name", "phone", "updatedAt") SELECT "createdAt", "email", "id", "name", "phone", "updatedAt" FROM "Contacts";
DROP TABLE "Contacts";
ALTER TABLE "new_Contacts" RENAME TO "Contacts";
CREATE UNIQUE INDEX "Contacts_email_key" ON "Contacts"("email");
CREATE TABLE "new_Team" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "coverImg" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "positionInTheCompany" TEXT NOT NULL,
    "description" TEXT
);
INSERT INTO "new_Team" ("coverImg", "createdAt", "description", "id", "positionInTheCompany", "updatedAt") SELECT "coverImg", "createdAt", "description", "id", "positionInTheCompany", "updatedAt" FROM "Team";
DROP TABLE "Team";
ALTER TABLE "new_Team" RENAME TO "Team";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
