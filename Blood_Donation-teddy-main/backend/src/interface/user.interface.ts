import { Request } from "express";
import { IUserDocument } from "../models/user.model.js";

export interface IRequest extends Request {
  user?: IUserDocument;
}
