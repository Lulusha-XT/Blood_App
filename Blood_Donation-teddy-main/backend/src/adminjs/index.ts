import AdminJS from "adminjs";
import AdminJSExpress from "@adminjs/express";
import express from "express";
import * as AdminJSMongoose from "@adminjs/mongoose";
import mongoose from "mongoose";
import session from "express-session";
import dotenv from "dotenv";
import { User } from "../models/user.model.js";
import { BloodRequest } from "../models/blood_request.model.js";
import { Sponser } from "./model/sponsers.js";

dotenv.config();

AdminJS.registerAdapter({
  Resource: AdminJSMongoose.Resource,
  Database: AdminJSMongoose.Database,
});

const { MONGO_URI, ADMIN_EMAIL, ADMIN_PASSWORD, SESSION_SECRET } = process.env;

const authenticate = async (email: string, password: string) => {
  // Replace this with your actual authentication logic
  if (email === "leul@gmail.com" && password === "1234") {
    return Promise.resolve({ email }); // Replace with your user object
  }
  return null;
};

const ConnectSession = session({
  secret: SESSION_SECRET || "your-secret-here",
  resave: false,
  saveUninitialized: true,
});

mongoose.connect(MONGO_URI || "mongodb://127.0.0.1:27017/blood-donation");

const adminOptions = {
  resources: [User, BloodRequest, Sponser],
  rootPath: "/admin",
  loginPath: "/admin/login", // Define the login page path
  logoutPath: "/admin/logout", // Define the logout page path
  // Customize the dashboard as needed
};

const admin = new AdminJS(adminOptions);

const adminRouter = AdminJSExpress.buildAuthenticatedRouter(admin, {
  authenticate,
  cookieName: "adminjs",
  cookiePassword: "sessionsecret",
});

export { adminRouter };
