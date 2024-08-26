import { PrismaClient } from "@prisma/client";
import { accessSync } from "fs";

const prisma = new PrismaClient();

interface UserPost {
	id?: string;
	email?: string;
	isAdmin?: boolean;
	phone?: string;
	age?: number;
}

async function getCurrentUserLength() {
	const result = await prisma.userPost.count();
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

async function modifiedUser(update: UserPost) {
	await prisma.userPost.update({
		where: {
			email: update?.email,
			id: update?.id,
		},
		data: {
			age: update.age,
			email: update.email,
			isAdmin: update.isAdmin,
			phone: update.phone,
		},
	});
}

async function createUser() {
	const result = await prisma.userPost.createMany({
		data: [
			{
				age: 42,
				email: "efgh@gmail.com",
				phone: "78988888888888",
				isAdmin: false,
			},
			{
				age: 12,
				phone: "777777777777777",
				email: "23rwet@gmail.com",
				isAdmin: false,
			},
		],
	});
	console.log(result);
}
async function main() {
	//all async codes here.......
	// const result = await prisma.postMedia.update({
	// 	where: {
	// 		title: "break day",
	// 	},
	// 	data: {
	// 		content: `this content is get updated at ${new Date().getDate()}`,
	// 		favoritedBy: {
	// 			connect: {
	// 				id: "7c716911-2bed-4e88-869c-5bf10eb69c23",
	// 			},
	// 		},
	// 	},
	// });
	// const result = await prisma.category.createMany({
	// 	data: [
	// 		{ categoryName: "relationship" },
	// 		{ categoryName: "private" },
	// 		{ categoryName: "love" },
	// 		{ categoryName: "tech" },
	// 		{ categoryName: "auto" },
	// 		{ categoryName: "film" },
	// 		{ categoryName: "sport" },
	// 	],
	// });
	// const result = await prisma.userPost.update({
	// 	where: {
	// 		id: "45998b3f-bd0f-4cc9-829e-10e05e487843",
	// 	},
	// 	data: {
	// 		writtenPost: {
	// 			create: {
	// 				title: "today i fell lonely",
	// 				content:
	// 					" i dont think this is the proper space i tell you private things but.....",
	// 				categories: {
	// 					create: {
	// 						categoryName: "private",
	// 					},
	// 				},
	// 			},
	// 		},
	// 	},
	// });
	const result = await prisma.userPost.findMany({
		where: {
			id: "45998b3f-bd0f-4cc9-829e-10e05e487843",
		},
		select: {
			writtenPost: true,
		},
	});

	console.log(result);
}

main()
	.catch((error) => {
		console.log(error);
	})
	.finally(async () => {
		await getCurrentUserLength();
		process.exit(0);
	});
