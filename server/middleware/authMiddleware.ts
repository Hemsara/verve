import jwt from "jsonwebtoken";
import { User } from "@prisma/client";
import { Request, Response, NextFunction } from "express";
import prisma from "../prisma/db.js";

interface UserPayload {
  email: string;
}

async function authenticateToken(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (token == null) {
    return res.status(401).json({ message: "unauthorized" });
  }

  jwt.verify(
    token,
    process.env.ACCESS_TOKEN_KEY,
    async (err, user: UserPayload) => {
      if (err) {
        return res.status(401).json({ message: "invalid token" });
      }


      const userSnapshot = await prisma.user.findFirst({
        where: { email: user.email },
      });

      if (!userSnapshot) {
        return res
          .status(401)
          .json({ message: "No user found associated with the token" });
      }
      delete(userSnapshot.password)
      req.user = userSnapshot;
      next();
    }
  );
}
interface AuthenticatedRequest extends Request {
  user?: User;
}
export { authenticateToken, AuthenticatedRequest };
