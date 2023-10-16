import express from "express";
import bloodRequest_routes from "../../controllers/blood_request.controller.js";
const bloodRequestRoutes = express.Router();

bloodRequest_routes(bloodRequestRoutes);

export default bloodRequestRoutes;
