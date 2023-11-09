import express, { Router } from "express";
import authRouter from "./auth/index.js";

var router: Router = express.Router();

router.use("/auth", authRouter);

export default router;
