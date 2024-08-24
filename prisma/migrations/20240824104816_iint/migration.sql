-- AlterTable
ALTER TABLE "User" ALTER COLUMN "phone" DROP NOT NULL;

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "basePrice" DECIMAL(65,30) NOT NULL,
    "discount" DOUBLE PRECISION NOT NULL,
    "vouchers" TEXT[],
    "remaining" INTEGER NOT NULL,
    "sold" INTEGER NOT NULL,
    "rating" DECIMAL(65,30) NOT NULL,
    "latestSoldDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);
