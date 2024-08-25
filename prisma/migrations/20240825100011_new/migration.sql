-- CreateTable
CREATE TABLE "UserPost" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "isAdmin" BOOLEAN NOT NULL,
    "userPrefrenceId" TEXT,

    CONSTRAINT "UserPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostMedia" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,
    "favoritedById" TEXT,

    CONSTRAINT "PostMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" TEXT NOT NULL,
    "categoryName" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSetup" (
    "id" TEXT NOT NULL,
    "emailupdates" BOOLEAN NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "UserSetup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CategoryToPostMedia" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "UserPost_email_key" ON "UserPost"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserPost_phone_key" ON "UserPost"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "PostMedia_title_key" ON "PostMedia"("title");

-- CreateIndex
CREATE UNIQUE INDEX "UserSetup_userId_key" ON "UserSetup"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToPostMedia_AB_unique" ON "_CategoryToPostMedia"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToPostMedia_B_index" ON "_CategoryToPostMedia"("B");

-- AddForeignKey
ALTER TABLE "PostMedia" ADD CONSTRAINT "PostMedia_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostMedia" ADD CONSTRAINT "PostMedia_favoritedById_fkey" FOREIGN KEY ("favoritedById") REFERENCES "UserPost"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSetup" ADD CONSTRAINT "UserSetup_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToPostMedia" ADD CONSTRAINT "_CategoryToPostMedia_A_fkey" FOREIGN KEY ("A") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToPostMedia" ADD CONSTRAINT "_CategoryToPostMedia_B_fkey" FOREIGN KEY ("B") REFERENCES "PostMedia"("id") ON DELETE CASCADE ON UPDATE CASCADE;
