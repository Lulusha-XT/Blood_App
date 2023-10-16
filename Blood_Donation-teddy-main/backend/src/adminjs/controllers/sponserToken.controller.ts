import * as sponserTokenService from "../services/tokenValue.service.js";
import { Request, Response, NextFunction, Router } from "express";
import { ISponser, Sponser } from "../model/sponsers.js";
import { Pagination } from "../../types/pagination.types.js";
import router from "../../routes/index.js";
import { ISponserToken } from "../model/sponserToken.model.js";
import { IRequest } from "../../interface/user.interface.js";
import mongoose from "mongoose";
import { verifyToken, verifyTokenSponser } from "../../middlewares/auth.js";
import { ISponserRequest } from "../../interface/sponser.js";

const createSponserTokenHandler = async (
  req: IRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    // Check if req.user.userId is defined before using it
    if (!req.user?.userId) {
      return res.status(400).json({ message: "User ID not provided" });
    }

    // Convert req.user.userId (string) to ObjectId
    const tokenOwnerId = new mongoose.Types.ObjectId(req.user.userId);

    const sponserToken: ISponserToken = {
      sponser: req.body.sponserId,
      tokenOwner: tokenOwnerId, // Use the converted ObjectId
      token: req.body.token,
    };

    const newSponser = await sponserTokenService.createSponserToken(
      sponserToken
    );

    return res.json({ message: "Success", data: newSponser });
  } catch (error) {
    return next(error);
  }
};

export const getSponsersTokenController = async (
  req: Request,
  res: Response,
  next: Function
) => {
  try {
    const token = req.params.userId;

    const sponserToken = await sponserTokenService.getSponsersToken(token);

    if (!sponserToken) {
      return res.status(404).json({ message: "Token not found" });
    }

    return res.json({ message: "Success", data: sponserToken });
  } catch (error) {
    return next(error);
  }
};

export const getSponsersTokenForSponser = async (
  req: ISponserRequest,
  res: Response,
  next: Function
) => {
  try {
    const sponser = req.sponser?.sponserId;

    if (sponser === undefined) {
      return res.status(400).json({ message: "Sponser not specified" });
    }

    // Now you can safely use `sponser` as a string
    const sponserToken = await sponserTokenService.getSponsersTokenForSponser(
      sponser
    );

    if (!sponserToken) {
      return res.status(404).json({ message: "Token not found" });
    }

    return res.json({ message: "Success", data: sponserToken });
  } catch (error) {
    return next(error);
  }
};

const sponserToken_routes = (router: Router) => {
  router.get("/", verifyTokenSponser, getSponsersTokenForSponser);
  router.get("/:userId", getSponsersTokenController);
  router.post("/register", verifyToken, createSponserTokenHandler);
};

export default sponserToken_routes;
