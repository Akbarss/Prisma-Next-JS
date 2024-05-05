import type { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../../prisma/prismaClient";

interface UpdateUserDto {
  name?: string;
  surname?: string;
  email?: string;
  password?: string;
}

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const userId = req.query.id as string;

  if (req.method === "GET") {
    try {
      const user = await prisma.user.findUnique({
        where: { id: userId },
      });

      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }

      return res.status(200).json({ data: user });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  } else if (req.method === "PATCH") {
    try {
      const body: UpdateUserDto = JSON.parse(req.body);

      const updatedUser = await prisma.user.update({
        where: { id: userId },
        data: body,
      });

      return res.status(200).json({ data: updatedUser });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  }
}
