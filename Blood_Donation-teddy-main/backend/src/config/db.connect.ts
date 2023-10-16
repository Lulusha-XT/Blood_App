import MONGO_DB_CONFIG from "./database.js";
import mongoose from "mongoose";

const connectDB = async () => {
  try {
    mongoose.set("strictQuery", true);
    await mongoose.connect(MONGO_DB_CONFIG.DB);
    console.log("Database is connected");
  } catch (error) {
    console.log(error);
  }
};

export default connectDB;
