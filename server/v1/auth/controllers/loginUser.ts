import prisma from "../../../prisma/db.js";
import { Request, Response } from "express";
import { UserLoginData } from "../../../schemas/auth/loginUserSchema.js";
import  httpStatus from "http-status";
import { verifyPassword } from "../../../res/bcrypt_helper.js";
import jwt from "jsonwebtoken";
import "dotenv/config";

const loginUser = async (req: Request, res: Response) => {
  try {
    const loginData: UserLoginData = req.body;
    const user = await prisma.user.findFirst({
      where: { email: loginData.email },
    });

    // If the user doesn't exist..
    if (!user) {
      return res.status(httpStatus.UNAUTHORIZED).json({
        error: "User under given credentials are not found",
      });
    }

    const passwordMatch = await verifyPassword(
      loginData.password,
      user.password
    );

    if (!passwordMatch) {
      return res.status(httpStatus.UNAUTHORIZED).json({
        error: "Password is incorrect",
      });
    }
    const email = loginData.email;
    const token = jwt.sign({ email }, process.env.ACCESS_TOKEN_KEY);
    res.status(httpStatus.OK).json({
      token,
    });

  } catch (error) {
    console.log(error)
    res
      .status(400)
      .json({ error: "An error occurred while login in the user" });
  }
};

export default loginUser;
