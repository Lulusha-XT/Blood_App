import express from "express";
import sponserToken_routes from "../../adminjs/controllers/sponserToken.controller.js";

const sponserTokenRoutes = express.Router();

sponserToken_routes(sponserTokenRoutes);

export default sponserTokenRoutes;
