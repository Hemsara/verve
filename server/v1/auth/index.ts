import express from "express";
import * as AuthController from "./controllers/index.js";
import {userRegisterSchema} from "../../schemas/auth/registerUserSchema.js";
import validateSchema from "../../schemas/validator.js";


var router = express.Router();

/* POST => register user */
router.post(
  "/register",
  validateSchema(userRegisterSchema),
  AuthController.registerUser
);

export default router;
