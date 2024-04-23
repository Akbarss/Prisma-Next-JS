-- CreateTable
CREATE TABLE "Aviability" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "upodatedAt" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "residence" TEXT NOT NULL,
    "beds" TEXT NOT NULL,
    "baths" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "estMonthlyCommonCharges" TEXT NOT NULL,
    "description" TEXT
);
