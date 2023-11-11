import express from "express";
import * as AuthController from "./controllers/index.js";
import * as AuthSchemas from "../../schemas/auth/index.js"
import validateSchema from "../../schemas/validator.js";



var router = express.Router();

/* POST => register user */
router.post(
  "/register",
  validateSchema(AuthSchemas.userRegisterSchema),
  AuthController.registerUser
);

/* POST => register user */
router.post(
  "/login",
  validateSchema(AuthSchemas.userLoginSchema),
  AuthController.loginUser
);

export default router;
