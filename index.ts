import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
interface filter {
	name?: String;
	basePrice?: number;
	discount?: number;
	remaining?: number;
	sold?: number;
	rating?: number;
	latestSoldDate?: string;
}

async function main() {
	//any async codes here
	async function register() {
		const createdUser = await prisma.user.createMany({
			data: [
				{
					name: "ham",
					email: "5Ls5y@example.com",
					phone: 1234567890,
					isAdmin: true,
					isVerified: true,
				},
				{
					name: "baba",
					email: "lily@example.com",
					phone: 1234567890,
					isAdmin: true,
					isVerified: true,
				},
			],
		});
		console.log(createdUser);
	}

	async function getAllUser(length?: number) {
		if (length) {
			return await prisma.user.findMany({ take: length });
		}
		const result = await prisma.user.findMany();
		console.log(result);
	}

	async function getLength(table?: string) {
		const result = await prisma.user.count();
		console.log(result);
	}

	async function deleteFunc(opt: string) {
		if (opt.trim() == "all" || opt.trim() == "") {
			const result = await prisma.user.deleteMany({});
			console.log(result);
		} else if (opt.trim()) {
			const result = await prisma.user.delete({
				where: { id: parseInt(opt.trim()) },
			});
			console.log(result);
		} else {
			console.log("Wrong input");
		}
	}

	async function fillingPartly() {
		await prisma.user.create({
			data: {
				name: "willie",
				email: "williehasi@example.com",
				isAdmin: true,
				phone: 29382094720,
				isVerified: true,
			},
		});
	}

	// ================================
	//functions for product
	async function addInitialProduct() {
		const result = await prisma.product.createMany({
			data: [
				{
					name: "apple",
					basePrice: 12.2,
					discount: 0.1,
					rating: 2.3,
					latestSoldDate: new Date(),
					sold: 0,
					vouchers: ["1234", "4321", "1432", "1324"],
					remaining: 3,
				},
				{
					name: "banana",
					basePrice: 16,
					discount: 0.2,
					rating: 3.5,
					latestSoldDate: new Date(),
					sold: 0,
					vouchers: ["1234", "4321", "1432", "1324"],
					remaining: 6,
				},
			],
		});
	}

	async function getProductLength() {
		const result = await prisma.product.count();
		console.log("All product added count : " + result);
	}

	async function getProductInfo(name: string) {
		const result = await prisma.product.findFirst({
			where: {
				name: name.toLowerCase(),
			},
		});
		if (!result) return console.log("we can't find such product");
		console.log(result);
	}

	async function getProductByFilter(filters: filter) {
		const result = await prisma.product.findMany({
			where: {
				name: filters.name?.toLowerCase(),
				basePrice: filters?.basePrice,
				discount: filters?.discount,
				remaining: filters?.remaining,
				sold: filters?.sold,
				rating: filters?.rating,
				latestSoldDate: filters?.latestSoldDate,
			},
		});
		const notNullFilter = Object.entries(filters).map(([key, value]) => {
			if (!value) return null;
			return `${key}: ${value}`;
		});
		if (!result.length)
			return console.log(
				"not any product match these filter : " + notNullFilter
			);
		console.log(result);
		console.log(`there are ${result.length} products matched`);
	}

	try {
		getProductByFilter({ sold: 0, basePrice: 12.2 });
	} catch (error) {
		console.log(error);
	} finally {
		getProductLength();
	}
}

main()
	.catch((e) => {
		console.log(e);
		process.exit(1);
	})
	.finally(async () => {
		await prisma.$disconnect();
	});
