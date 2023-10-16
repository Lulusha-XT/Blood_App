import * as sponserService from "../services/sponser.service.js";
import { Request, Response, NextFunction, Router } from "express";
import { ISponser, Sponser } from "../model/sponsers.js";
import { Pagination } from "../../types/pagination.types.js";
import router from "../../routes/index.js";
const createSponser = async (req: Request, res: Response, next: Function) => {
  try {
    console.log("HEllO");
    const sponser: ISponser = {
      sponserName: req.body.sponserName,
      phoneNo: req.body.phoneNo,
      email: req.body.email,
      password: req.body.password,
    };
    console.log(sponser);
    const newSponser = await sponserService.createSponser(sponser);
    return res.status(201).json({ message: "Success", data: newSponser });
  } catch (error) {
    return next(error);
  }
};
const getSponsers = async (req: Request, res: Response, next: Function) => {
  try {
    const pagination: Pagination = {
      page: req.query.page?.toString(),
      pageSize: req.query.pageSize?.toString(),
    };
    const allSponser = await sponserService.getSponsers(pagination);
    return res.json({ message: "Success", data: allSponser });
  } catch (error) {
    return next(error);
  }
};

const userLogin = async (req: Request, res: Response, next: Function) => {
  try {
    console.log("Login");
    const { email, password } = req.body;

    const token = await sponserService.logIn(email, password);
    console.log(token);

    if (token) {
      console.log(token);
      res.json({ message: "Success", data: token });
    } else {
      res
        .status(401)
        .json({ message: "error", error: `Invalid email or password` });
    }
  } catch (error) {
    return next(error);
  }
};

const sponser_routes = (router: Router) => {
  router.get("/", getSponsers);
  router.post("/register", createSponser);

  router.post("/login", userLogin);
};

export default sponser_routes;
