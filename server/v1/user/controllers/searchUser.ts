import prisma from "../../../prisma/db.js";
import { Response } from "express";
import httpStatus from "http-status";
import { AuthenticatedRequest } from "../../../middleware/authMiddleware.js";

const searchUser = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const searchQuery = req.query.username as string;
    const limit: number = parseInt(req.query.limit as string) || 10;
    if (!searchQuery) {
      return res.status(200).json({ data: [] });
    }
    const userResult: any = await prisma.user.findMany({
      where: {
        OR: [
          {
            first_name: {
              contains: searchQuery,
              mode: "insensitive",
            },
          },
          {
            last_name: {
              contains: searchQuery,
              mode: "insensitive",
            },
          },
        ],
      },
      take: limit,
      select: {
        id: true,
        profile_picture: true,
        first_name: true,
        last_name: true,
      },
    });

    res.status(httpStatus.OK).json({ data: userResult });
  } catch (error) {
    res
      .status(httpStatus.INTERNAL_SERVER_ERROR)
      .json({ error: "An error occurred while getting the users." });
  }
};

export default searchUser;
