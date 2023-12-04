import prisma from "../../../prisma/db.js";
import { Response } from "express";
import httpStatus from "http-status";
import { AuthenticatedRequest } from "../../../middleware/authMiddleware.js";

const getUserFromId = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const user = req.user;
    const userId = parseInt(req.params.id, 10);

    const userWithPosts: any = await prisma.user.findFirst({
      where: {
        id: userId,
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

    const isFollowing = await prisma.follow.findUnique({
      where: {
        followerId_followingId: {
          followerId: user.id,
          followingId: userId,
        },
      },
    });

    delete userWithPosts.password;

    userWithPosts.isFollowing = Boolean(isFollowing);

    res.status(httpStatus.OK).json({ data: userWithPosts });
  } catch (error) {

    res
      .status(httpStatus.INTERNAL_SERVER_ERROR)
      .json({ error: "An error occurred while getting the user." });
  }
};

export default getUserFromId;
