import { Request, Response, Router } from "express";
import { IUserDoner } from "../models/donation.model.js";
import * as bloodDonations from "../services/dontion.service.js";
import { IRequest } from "../interface/user.interface.js";

async function createBloodDonation(
  req: IRequest,
  res: Response
): Promise<void> {
  try {
    const { request, donor } = req.body;
    const bloodDonation: IUserDoner = {
      donor,
      request,
    };
    const savedBloodDonation = await bloodDonations.donateBlood(bloodDonation);
    res.json({ message: "Success", data: savedBloodDonation });
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal Server Error");
  }
}
const getBloodDonations = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const listBloodDonation = await bloodDonations.getAllBloodDonations();
    res.json({ message: "Success", data: listBloodDonation });
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal Server Error");
  }
};
const getBloodDonationsById = async (
  req: Request,
  res: Response,
  next: Function
) => {
  try {
    const bloodRequests = await bloodDonations.getBloodDonationsById(
      req.params.id
    );
    res.status(200).json({ message: "Success", data: bloodRequests });
  } catch (error) {
    next(error);
  }
};

const getDonatingUsers = async (req: Request, res: Response): Promise<void> => {
  try {
    const listBloodDonation = await bloodDonations.getDonatingUsers(
      req.params.id
    );
    res.json({ message: "Success", data: listBloodDonation });
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal Server Error");
  }
};
const approveDonation = async (req: Request, res: Response): Promise<void> => {
  try {
    const { donationId, doner } = req.body;
    const result = await bloodDonations.approveDonation(donationId, doner);
    if (typeof result === "string") {
      res.status(400).json({ message: "Error", error: result });
    } else {
      res.json({ message: "Success", data: result });
    }
  } catch (err) {
    console.error(err);
    res.status(500).send(`Internal Server Error ${err}`);
  }
};

const getMyApprovedDonations = async (
  req: IRequest,
  res: Response,
  next: Function
) => {
  try {
    console.log(req.user?.userId!);
    const bloodRequests = await bloodDonations.getMyApprovedDonations(
      req.user?.userId!
    );
    res.status(200).json({ message: "Success", data: bloodRequests });
  } catch (error) {
    next(error);
  }
};

const donation_routes = (router: Router) => {
  router.get("/getApproved", getMyApprovedDonations);
  router.get("/:id", getBloodDonationsById);
  router.get("/", getBloodDonations);
  router.post("/", createBloodDonation);
  router.get("/doner/:id", getDonatingUsers);
  router.post("/doner/approved", approveDonation);
};

export default donation_routes;
