import express from "express";
import * as UserController from "./controllers/index.js";
import { authenticateToken } from "../../middleware/authMiddleware.js";

var router = express.Router();

/* GET => get current user data with posts */
router.get("/me", authenticateToken, UserController.getCurrentUser);

/* POST => follow and unfollow a user */
router.post("/follow/:id", authenticateToken, UserController.followUser);
router.post("/unfollow/:id", authenticateToken, UserController.unFollowUser);

/* GET => get user with id */
router.get("/user/:id", authenticateToken, UserController.getUserFromId);

/* GET => search user with params */
router.get("/search", authenticateToken, UserController.searchUser);

export default router;
