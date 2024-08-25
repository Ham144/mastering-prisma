/*
  Warnings:

  - You are about to drop the column `userPrefrenceId` on the `UserPost` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `UserSetup` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userSetupId]` on the table `UserPost` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "UserSetup" DROP CONSTRAINT "UserSetup_userId_fkey";

-- DropIndex
DROP INDEX "UserSetup_userId_key";

-- AlterTable
ALTER TABLE "UserPost" DROP COLUMN "userPrefrenceId",
ADD COLUMN     "userSetupId" TEXT;

-- AlterTable
ALTER TABLE "UserSetup" DROP COLUMN "userId";

-- CreateIndex
CREATE UNIQUE INDEX "UserPost_userSetupId_key" ON "UserPost"("userSetupId");

-- AddForeignKey
ALTER TABLE "UserPost" ADD CONSTRAINT "UserPost_userSetupId_fkey" FOREIGN KEY ("userSetupId") REFERENCES "UserSetup"("id") ON DELETE SET NULL ON UPDATE CASCADE;
