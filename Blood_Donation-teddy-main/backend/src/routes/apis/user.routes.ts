import express from "express";
import user_routes from "../../controllers/user.controller.js";
const userRoutes = express.Router();

user_routes(userRoutes);

export default userRoutes;
