import express from "express";
import sponser_routes from "../../adminjs/controllers/sponser.contoller.js";

const sponserRoutes = express.Router();

sponser_routes(sponserRoutes);

export default sponserRoutes;
