import prisma from "../../../prisma/db.js";
import bcrypt from "bcryptjs";
import { Request, Response } from "express";
import { UserRegistrationData } from "../../../schemas/auth/registerUserSchema.js";



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
      res.status(400).json({ error: `User with this email is already registered.` });
      return;
    }

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(userData.password, salt);

    // Create the user
    const user = await prisma.user.create({
      data: {
        name: userData.name,
        email: userData.email,
        password: hashedPassword,
      },
    });

    res.status(200).json({ message: `User ${user.name} created.` });
  } catch (error) {
    res.status(500).json({ error: "An error occurred while registering the user." });
  }
};

export default registerUser;
