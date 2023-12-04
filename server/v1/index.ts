import express, { Router } from "express";
import authRouter from "./auth/routes.js";
import userRouter from "./user/routes.js";

var router: Router = express.Router();

router.use("/auth", authRouter);
router.use("/users", userRouter);


export default router;
