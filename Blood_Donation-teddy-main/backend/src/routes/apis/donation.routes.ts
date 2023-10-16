import express from "express";
import donation_routes from "../../controllers/donation.controller.js";
const donationRoutes = express.Router();

donation_routes(donationRoutes);

export default donationRoutes;
