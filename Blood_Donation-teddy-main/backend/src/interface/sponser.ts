import { Request } from "express";
// import { IUserDocument } from "../models/user.model.js";
import { ISponserDocument } from "../adminjs/model/sponsers.js";

export interface ISponserRequest extends Request {
  sponser?: ISponserDocument;
}
