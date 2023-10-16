import { Request, Response, NextFunction } from "express";
import jwt, { Secret } from "jsonwebtoken";
import { IUser } from "../models/user.model.js";
import dotenv from "dotenv";
import { ISponser } from "../adminjs/model/sponsers.js";

dotenv.config();
const secret: Secret = process.env.TOKEN_SECRET as Secret;

export interface IRequest extends Request {
  user?: IUser;
  file?: Express.Multer.File; // Adjust the type based on your file object structure
}
export interface ISponserRequest extends Request {
  sponser?: ISponser;
}
const verifyToken = (req: IRequest, res: Response, next: NextFunction) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  console.log(token);

  if (!token) return res.status(403).send({ message: "No Token Provided" });

  try {
    const decodedToken = jwt.verify(token, secret) as IUser;
    console.log("Print Message", decodedToken);
    req.user = decodedToken;
    next();
  } catch (error) {
    res.status(401).send({ message: "Unauthorized" });
  }
};

const assignAccessToken = (user: IUser): string => {
  const expiresIn = "1h";
  const userObject = JSON.parse(JSON.stringify(user));
  return jwt.sign(userObject, secret, { expiresIn });
};
const assignAccessTokenSponser = (sponser: ISponser): string => {
  const expiresIn = "1h";
  const userObject = JSON.parse(JSON.stringify(sponser));
  return jwt.sign(userObject, secret, { expiresIn });
};

const verifyTokenSponser = (
  req: ISponserRequest,
  res: Response,
  next: NextFunction
) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  console.log(token);

  if (!token) return res.status(403).send({ message: "No Token Provided" });

  try {
    const decodedToken = jwt.verify(token, secret) as ISponser;
    console.log("Print Message", decodedToken);
    req.sponser = decodedToken;
    console.log("Sponser", req.sponser);
    next();
  } catch (error) {
    res.status(401).send({ message: "Unauthorized" });
  }
};

export {
  verifyToken,
  assignAccessToken,
  assignAccessTokenSponser,
  verifyTokenSponser,
};
