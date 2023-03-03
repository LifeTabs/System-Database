import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

(async () => {

  for(let i = 0; i < 100000; i++) {
    await new Promise((solver) => {
      setTimeout(() => solver(), 5000)
    })
    const data = await prisma.user.create({
      data: {
        name: "Ily1606"
      }
    })
    console.log(`Records: ${i}`);
    const res = await prisma.user.findUnique({
      where: {
        id: data.id
      }
    })
    console.log(res);
  }

})()