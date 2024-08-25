import { PrismaClient } from "@prisma/client";
import { accessSync } from "fs";

const prisma = new PrismaClient();

interface UserPost {
	email?: string;
	isAdmin?: boolean;
	phone?: string;
	age?: number;
}

async function getCurrentUserLength() {
	const result = await prisma.user.count();
	console.log("there are about " + result + " user registered");
}

async function getAllUser() {
	const result = await prisma.userPost.findMany({});
	if (!result) console.log("none user exist..");
	console.log(result);
}

async function getUser(user: UserPost) {
	const result = await prisma.userPost.findFirst({
		where: {
			OR: [
				{ email: user.email },
				{ phone: user.phone },
				{ age: user.age },
				{ isAdmin: user.isAdmin },
			],
		},
	});

	if (!result) {
		console.log("nothing found..");
	} else {
		console.log(result);
	}
}

async function createUser() {
	await prisma.user.deleteMany();
	const result = await prisma.userPost.create({
		data: {
			age: 21,
			email: "oiuaoiya@gmail.com",
			phone: "00000000000283",
			userSetup: {
				create: {
					emailupdates: true,
				},
			},
		},
	});
	console.log(result);
}
async function main() {
	//all async codes here.......
	await createUser();
}

main()
	.catch((error) => {
		console.log(error);
	})
	.finally(async () => {
		await getCurrentUserLength();
		process.exit(0);
	});
