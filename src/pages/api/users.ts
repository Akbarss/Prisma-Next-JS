// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";

import prisma from "../../../prisma/prismaClient";

interface CreateUserDto {
  name: string;
  surname: string;
  email: string;
  password: string;
}

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === "GET") {
    const { skip, take } = req.query;

    if (Number.isNaN(Number(take)) || Number.isNaN(Number(skip)))
      if (Number(take) > 100) {
        return res.status(400).json({ error: "Error Shit" });
      }

    if (Number(skip) < 0) {
      return res.status(400).json({ error: "Error skip" });
    }

    const users = await prisma.user.findMany({
      skip: Number(skip) || 0,
      take: Number(take) || 10,
    });
    const total = await prisma.user.count();

    return res.status(200).json({ data: users, total });
  } else if (req.method === "POST") {
    try {
      const body: CreateUserDto = JSON.parse(req.body);

      const newUser = await prisma.user.create({
        data: {
          name: body.name,
          surname: body.surname,
          email: body.email,
          password: body.password,
        },
      });

      return res.status(201).json({ data: newUser });
    } catch (e) {
      res.status(500).json({ message: "500 error" });
    }
  }
}
