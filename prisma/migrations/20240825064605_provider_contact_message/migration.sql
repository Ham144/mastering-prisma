/*
  Warnings:

  - You are about to drop the column `discount` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `vouchers` on the `Product` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "Providers" AS ENUM ('TELOMSEL', 'TRI', 'SMARTFREN', 'AXIS', 'XL');

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "discount",
DROP COLUMN "vouchers";

-- CreateTable
CREATE TABLE "Voucher" (
    "id" INTEGER NOT NULL,
    "productId" INTEGER,
    "discount" DECIMAL(65,30) NOT NULL,
    "expired" BOOLEAN NOT NULL,
    "expiredDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Voucher_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Post" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "postdate" TIMESTAMP(3) NOT NULL,
    "likes" INTEGER NOT NULL,
    "updatedate" TIMESTAMP(3) NOT NULL,
    "userID" INTEGER NOT NULL,

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Buyer" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER,
    "buyerName" TEXT NOT NULL,
    "money" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "Buyer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "sendDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "contactReceivedID" TEXT,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact" (
    "id" TEXT NOT NULL,
    "messageId" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "contact_name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Provider" (
    "id" TEXT NOT NULL,
    "providerName" "Providers" NOT NULL DEFAULT 'TELOMSEL',
    "perByteCost" DOUBLE PRECISION NOT NULL,
    "country" TEXT NOT NULL DEFAULT 'indonesia',

    CONSTRAINT "Provider_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Message_title_key" ON "Message"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Contact_number_key" ON "Contact"("number");

-- CreateIndex
CREATE UNIQUE INDEX "Contact_contact_name_key" ON "Contact"("contact_name");

-- CreateIndex
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");

-- AddForeignKey
ALTER TABLE "Voucher" ADD CONSTRAINT "Voucher_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Buyer" ADD CONSTRAINT "Buyer_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Buyer" ADD CONSTRAINT "Buyer_buyerName_fkey" FOREIGN KEY ("buyerName") REFERENCES "User"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_contactReceivedID_fkey" FOREIGN KEY ("contactReceivedID") REFERENCES "Contact"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "Message"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
