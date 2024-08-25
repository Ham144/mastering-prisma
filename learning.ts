import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

enum Provider {
	"TELKOMSEL",
	"XL",
	"AXIS",
	"SMARTFREN",
}

interface Providers {
	providerName: Provider;
	perByteCost: number;
	country?: string;
}

interface Message {
	title: string;
	towards: Contact[];
	body: string;
	sendDate: Date;
	contactReceived: Contact;
	contactReceivedID: string;
}

interface Contact {
	contact_name: string;
	number: string;
	message?: string;
	messageId: string;
	receivedMessages: Message[];
}

async function main() {
	async function AllContact() {
		const result = await prisma?.contact.findMany();
		console.log(result);
		console.log("the length total of all contact is " + result.length);
	}

	async function AddContact(newContact: Contact) {
		await prisma.contact.create({
			data: {
				contact_name: newContact.contact_name,
				number: newContact.number,
				messageId: newContact.messageId,
			},
		});
	}
}

main()
	.catch((e) => {
		console.log("something error!" + e);
		process.exit(1);
	})
	.finally(async () => {
		await prisma.$disconnect();
	});
