import prisma from "../../../prisma/db.js";
import bcrypt from "bcryptjs";
import { Request, Response } from "express";
import { UserRegistrationData } from "../../../schemas/auth/registerUserSchema";
import { hashPassword } from "../../../res/bcrypt_helper.js";
import httpStatus from "http-status";

const registerUser = async (req: Request, res: Response) => {
  try {
    const userData: UserRegistrationData = req.body;

    // Check if a user with the given email already exists
    const userExist = await prisma.user.findFirst({
      where: {
        email: userData.email,
      },
    });

    if (userExist) {
      res
        .status(httpStatus.BAD_REQUEST)
        .json({ error: `User with this email is already registered.` });
      return;
    }

    // Hash the password

    const hashedPassword = await hashPassword(userData.password);

    // Create the user
    const user = await prisma.user.create({
      data: {
        name: userData.name,
        email: userData.email,
        password: hashedPassword,
      },
    });

    res.status(httpStatus.OK).json({ message: `User ${user.name} created.` });
  } catch (error) {
    console.log(error)
    res
      .status(httpStatus.INTERNAL_SERVER_ERROR)
      .json({ error: "An error occurred while registering the user." });
  }
};

export default registerUser;
