import AdminJS from "adminjs";
import AdminJSExpress from "@adminjs/express";
import express from "express";
import * as AdminJSMongoose from "@adminjs/mongoose";
import mongoose from "mongoose";
import { User } from "./model/user.entity.js";
import { BloodRequest } from "./model/blood_request.js";

const PORT = 3000;

AdminJS.registerAdapter({
  Resource: AdminJSMongoose.Resource,
  Database: AdminJSMongoose.Database,
});

const start = async () => {
  await mongoose.connect(
    "mongodb+srv://leulsileshi7:21191921@blood-donation.v2utun4.mongodb.net/?retryWrites=true&w=majority"
  );
  const app = express();
  const adminOptions = {
    // We pass Category to `resources`
    resources: [User, BloodRequest],
  };

  const admin = new AdminJS(adminOptions);

  const adminRouter = AdminJSExpress.buildRouter(admin);
  app.use(admin.options.rootPath, adminRouter);

  app.listen(PORT, () => {
    console.log(
      `AdminJS started on http://localhost:${PORT}${admin.options.rootPath}`
    );
  });
};

start();
