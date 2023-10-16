import { model, Schema, Types } from "mongoose";

export interface IUser {
  fullName: string;
  email: string;
  password: string;
  bloodType: string;
  phoneNo: string;
  dateOfBirth?: string;
  medicalCondition?: string;
  profilePicture?: string;
}

export const CategorySchema = new Schema<IUser>(
  {
    fullName: { type: "String", required: true },
    email: { type: "String", required: true, unique: true },
    password: { type: "String", required: true },
    bloodType: { type: "String", required: true },
    phoneNo: { type: "String", required: true },
    dateOfBirth: { type: "String" },
    medicalCondition: { type: "String" },
    profilePicture: { type: "String" },
  },
  { timestamps: true }
);

export const User = model<IUser>("User", CategorySchema);
