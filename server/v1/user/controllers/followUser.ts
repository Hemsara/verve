import prisma from "../../../prisma/db.js";
import { Response } from "express";
import httpStatus from "http-status";
import { AuthenticatedRequest } from "../../../middleware/authMiddleware.js";

const followUser = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const user = req.user;
   

    const followingId = parseInt(req.params.id, 10);

    const followingUser = await prisma.user.findFirst({
      where: { id: followingId },
    });
    if (!followingUser) {
      return res.status(400).json({ error: "No user found for this id" });
    }

    const existingFollow = await prisma.follow.findUnique({
      where: {
        followerId_followingId: {
          followerId: user.id,
          followingId,
        },
      },
    });

    if (user.id == followingId) {
      return res
        .status(httpStatus.BAD_REQUEST)
        .json({ error: "You cant follow your account" });
    }
    if (existingFollow) {
      return res
        .status(httpStatus.BAD_REQUEST)
        .json({ error: "Already following this user" });
    }

    const newFollow = await prisma.follow.create({
      data: {
        followerId: user.id,
        followingId,
      },
    });

    res.json(newFollow);
  } catch (error) {
    res
      .status(httpStatus.INTERNAL_SERVER_ERROR)
      .json({ error: "An error occurred while following the user." });
  }
};

export default followUser;
