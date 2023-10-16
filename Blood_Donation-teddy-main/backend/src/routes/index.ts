import express from "express";
import userRoutes from "./apis/user.routes.js";
import bloodRequestRoutes from "./apis/blood_request.routes.js";
import donationRoutes from "./apis/donation.routes.js";
import sponserRoutes from "./apis/sponser.route.js";
import sponserTokenRoutes from "./apis/sponserToken.route.js";

const router: express.Router = express.Router();

router.use("/user", userRoutes);
router.use("/bloodRequest", bloodRequestRoutes);
router.use("/donate", donationRoutes);
router.use("/sponser", sponserRoutes);
router.use("/sponserToken", sponserTokenRoutes);

export default router;
