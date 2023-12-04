import prisma from "../../../prisma/db.js";
import { Response } from "express";
import httpStatus from "http-status";
import { AuthenticatedRequest } from "../../../middleware/authMiddleware.js";

const unFollowUser = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const user = req.user;

    const unFollowingId = parseInt(req.params.id, 10);

    const followingUser = await prisma.user.findFirst({
      where: { id: unFollowingId },
    });
    if (!followingUser) {
      return res.status(400).json({ error: "No user found for this id" });
    }

    const existingFollow = await prisma.follow.findUnique({
      where: {
        followerId_followingId: {
          followerId: user.id,
          followingId: unFollowingId,
        },
      },
    });

    if (!existingFollow) {
      return res
        .status(httpStatus.BAD_REQUEST)
        .json({ error: "You are not following this user" });
    }
    await prisma.follow.delete({
      where: {
        followerId_followingId: {
          followerId: user.id,
          followingId: unFollowingId,
        },
      },
    });

    res.json({ message: "Successfully unfollowed the user" });
  } catch (error) {
    res
      .status(httpStatus.INTERNAL_SERVER_ERROR)
      .json({ error: "An error occurred while following the user." });
  }
};

export default unFollowUser;
