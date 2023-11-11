import express, { Router } from "express";
import authRouter from "./auth/routes.js";

var router: Router = express.Router();

router.use("/auth", authRouter);

export default router;
