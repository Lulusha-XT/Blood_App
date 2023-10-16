import mongoose, { Model, Schema, Document } from "mongoose";

interface IUser {
  fullName: string;
  email: string;
  password: string;
  bloodType: string;
  phoneNo: string;
  dateOfBirth?: string;
  medicalCondition?: string;
  profilePicture?: string;
}

interface IUserDocument extends IUser, Document {
  userId: string;
  token: string;
  tokensValue?: { value: string; used: boolean }[];
}

const userSchema = new Schema<IUserDocument>(
  {
    fullName: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    bloodType: { type: String, required: true },
    phoneNo: { type: String, required: true },
    dateOfBirth: { type: String },
    medicalCondition: { type: String },
    token: { type: String },
    tokensValue: [
      {
        value: { type: String },
        used: { type: Boolean, default: false },
      },
    ],
    profilePicture: { type: String },
  },
  {
    timestamps: true,
    toJSON: {
      transform: (_doc, ret) => {
        ret.userId = ret._id.toString();
        delete ret._id;
        delete ret.__v;
        delete ret.password;
      },
    },
  }
);

const User: Model<IUserDocument> = mongoose.model<IUserDocument>(
  "User",
  userSchema
);

export { IUser, IUserDocument, User };
