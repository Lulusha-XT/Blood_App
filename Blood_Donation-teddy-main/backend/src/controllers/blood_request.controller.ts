import { Request, Response, Router } from "express";
import mongoose from "mongoose";
import { IBloodRequest } from "../models/blood_request.model.js";
import * as BloodRequestServie from "../services/blood_request.service.js";
import { Pagination } from "../types/pagination.types.js";
import { verifyToken } from "../middlewares/auth.js";
import { IRequest } from "../interface/user.interface.js";

const createBloodRequest = async (
  req: IRequest,
  res: Response,
  next: Function
) => {
  try {
    const bloodRequest: IBloodRequest = {
      bloodType: req.body.bloodType,
      reason: req.body.reason,
      unitRequired: req.body.unitRequired,
      deadLine: req.body.deadLine,
      hospital: req.body.hospital,
      personInCharge: req.body.personInCharge,
      contactNumber: req.body.contactNumber,
      patientName: req.body.patientName,
      location: req.body.location,
      requesterId: req.user?.userId,
    };
    console.log(`User Id ${new mongoose.Types.ObjectId(req.user?.id)}`);
    const newBloodRequest = await BloodRequestServie.createBloodRequest(
      bloodRequest
    );
    return res.json({ message: "Success", data: newBloodRequest });
  } catch (error) {
    return next(error);
  }
};
// const getAllBloodReques = async (
//   req: Request,
//   res: Response,
//   next: Function
// ) => {

//   try {
//     const pagination: Pagination = {
//       page: req.query.page?.toString(),
//       pageSize: req.query.pageSize?.toString(),
//     };

//     const allBloodRequest = await BloodRequestServie.getAllBloodRequests(
//       pagination,

//     );
//     return res.json({ message: "Success", data: allBloodRequest });
//   } catch (error) {
//     return next(error);
//   }
// };
const getAllBloodReques = async (
  req: IRequest,
  res: Response,
  next: Function
) => {
  try {
    console.log(
      `get all blood request is excuted: userID:  ${req.user!.userId}`
    );
    const pagination: Pagination = {
      page: req.query.page?.toString(),
      pageSize: req.query.pageSize?.toString(),
    };

    const currentUserRequestId = req.user!.userId; // Assuming you store the requesterId of the current user in req.user

    const allBloodRequest = await BloodRequestServie.getAllBloodRequests(
      pagination,
      currentUserRequestId
    );

    return res.json({ message: "Success", data: allBloodRequest });
  } catch (error) {
    return next(error);
  }
};

const getBloodRequestById = async (
  req: Request,
  res: Response,
  next: Function
) => {
  try {
    const bloodRequests =
      await BloodRequestServie.getBloodRequestsByRequesterId(req.params.id);
    res.status(200).json({ message: "Success", data: bloodRequests });
  } catch (error) {
    next(error);
  }
};

const bloodRequest_routes = (router: Router) => {
  router.get("/", verifyToken, getAllBloodReques);
  router.get("/:id", getBloodRequestById);
  router.post("/", verifyToken, createBloodRequest);
};

export default bloodRequest_routes;
