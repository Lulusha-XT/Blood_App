// user.model.ts

import { Document, Schema, model } from "mongoose";

// Define the User schema
const userSchema = new Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  // Add more fields as needed
});

// Define the User document interface
export interface UserDocument extends Document {
  username: string;
  email: string;
  password: string;
  // Define other fields here
}

// Create and export the User model
export const UserModel = model<UserDocument>("User", userSchema);
