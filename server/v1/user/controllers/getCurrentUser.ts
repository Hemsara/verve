import prisma from "../../../prisma/db.js";
import { Response } from "express";
import httpStatus from "http-status";
import { AuthenticatedRequest } from "../../../middleware/authMiddleware.js";

const getCurrentUser = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const user = req.user;

    const userWithPosts = await prisma.user.findFirst({
      where: {
        id: user.id,
      },
      include: {
        posts: true,
        _count: {
          select: {
            followers: true,
            following: true,
          },
        },
      },
    });

    delete userWithPosts.password;

    res.status(httpStatus.OK).json({ data: userWithPosts });
  } catch (error) {
    console.log(error);
    res
      .status(httpStatus.INTERNAL_SERVER_ERROR)
      .json({ error: "An error occurred while registering the user." });
  }
};

export default getCurrentUser;
