import MONGO_DB_CONFIG from "../../config/database.js";
import { Pagination } from "../../types/pagination.types.js";

import bcrypt from "bcrypt";

import dotenv from "dotenv";

import * as auth from "../../middlewares/auth.js";
import { ISponser, ISponserDocument, Sponser } from "../model/sponsers.js";
dotenv.config();
const saltRound = process.env.SALT_ROUND as string | number;
const bcryptPassword = process.env.BCRYBT_PASSWORD;

export const createSponser = async (sponser: ISponser): Promise<ISponser> => {
  try {
    const isSponserExist = await Sponser.findOne({ email: sponser.email });

    if (isSponserExist) throw new Error("Email Already Registerd");

    const password = sponser.password;
    const hash = bcrypt.hashSync(
      password + bcryptPassword,
      MONGO_DB_CONFIG.SALT_ROUND
    );
    const newSponser = new Sponser({ ...sponser, password: hash });

    const token = auth.assignAccessToken(newSponser.toJSON());
    newSponser.token = token;
    newSponser.save();
    return newSponser as ISponser;
  } catch (error) {
    throw new Error(`Could not creat user ${error}`);
  }
};

export const getSponsers = async (
  pagination: Pagination
): Promise<ISponserDocument[]> => {
  try {
    const perPage =
      Math.abs(parseInt(pagination.pageSize!)) || MONGO_DB_CONFIG.PAGE_SIZE;
    const page = (Math.abs(parseInt(pagination.page!)) || 1) - 1;
    const sponsers = await Sponser.find();
    return sponsers as ISponserDocument[];
  } catch (error) {
    throw new Error(`User not found ${error}`);
  }
};

export const logIn = async (email: string, password: string) => {
  try {
    const sponser = await Sponser.findOne({ email });
    console.log(sponser);

    if (
      sponser &&
      (await bcrypt.compare(password + bcryptPassword, sponser.password))
    ) {
      const token = auth.assignAccessTokenSponser(sponser);
      console.log(token);

      // Update sponser token and save
      sponser.token = token;
      await sponser.save();
      console.log(sponser);

      return sponser as ISponserDocument;
    }
    return null;
  } catch (error) {
    throw new Error(`Log in failed ${error}`);
  }
};
