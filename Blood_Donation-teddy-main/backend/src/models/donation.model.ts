import mongoose, { Schema, Document, model } from "mongoose";
import { IUser } from "./user.model.js";
import { IBloodRequest } from "./blood_request.model.js";

interface IUserDoner {
  request: IBloodRequest; // Use IBloodRequest type
  donor: IUser;
  status?: "Open" | "Pending" | "Completed";
}

interface IUserDonerDocumnet extends IUserDoner, Document {
  donationId: string;
}
const bloodDonationSchema = new Schema<IUserDonerDocumnet>(
  {
    request: { type: Schema.Types.ObjectId, ref: "BloodRequest" },

    donor: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    status: {
      type: String,
      enum: ["Pending", "Completed"],
      required: true,
      default: "Pending",
    },
  },
  {
    timestamps: true,
    toJSON: {
      transform: (_doc, ret) => {
        ret.donationId = ret._id.toString();
        delete ret._id;
        delete ret.__v;
      },
    },
  }
);

const UserDonerModel = model<IUserDonerDocumnet>(
  "UserDoner",
  bloodDonationSchema
);

export { IUserDoner, UserDonerModel };
