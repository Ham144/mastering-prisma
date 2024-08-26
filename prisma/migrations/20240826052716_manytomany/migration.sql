/*
  Warnings:

  - You are about to drop the `_CategoryToPostMedia` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CategoryToPostMedia" DROP CONSTRAINT "_CategoryToPostMedia_A_fkey";

-- DropForeignKey
ALTER TABLE "_CategoryToPostMedia" DROP CONSTRAINT "_CategoryToPostMedia_B_fkey";

-- AlterTable
ALTER TABLE "Category" ADD COLUMN     "postMediaId" TEXT[];

-- AlterTable
ALTER TABLE "PostMedia" ADD COLUMN     "categoryId" TEXT[];

-- DropTable
DROP TABLE "_CategoryToPostMedia";

-- AddForeignKey
ALTER TABLE "PostMedia" ADD CONSTRAINT "PostMedia_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_postMediaId_fkey" FOREIGN KEY ("postMediaId") REFERENCES "PostMedia"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
