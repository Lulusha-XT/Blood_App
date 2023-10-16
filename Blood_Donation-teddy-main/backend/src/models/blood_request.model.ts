import mongoose, { Model, Schema, Document, Types } from "mongoose";
import { IUserDoner } from "./donation.model.js";

interface IBloodRequest {
  bloodType: string;
  reason: string;
  unitRequired: number;
  deadLine: string;
  hospital: string;
  personInCharge: string;
  contactNumber: string;
  patientName: string;
  location: string;
  requesterId?: string | Types.ObjectId;
  pendingState?: number;
  completedState?: number;
}

interface IBloodRequestDocument extends IBloodRequest, Document {
  requestId: string;
  userDoners: IUserDoner[];
}

const bloodRequestSchema = new Schema<IBloodRequestDocument>(
  {
    bloodType: { type: String, required: true },
    reason: { type: String, required: true },
    unitRequired: { type: Number, required: true },
    deadLine: { type: String, required: true },
    hospital: { type: String, required: true },
    personInCharge: { type: String },
    contactNumber: { type: String },
    patientName: { type: String },
    location: { type: String },
    requesterId: { type: Schema.Types.ObjectId, ref: "User", required: true },
    userDoners: [{ type: Types.ObjectId, ref: "UserDoner" }],
    pendingState: { type: Number, default: 0 },
    completedState: { type: Number, default: 0 },
  },
  {
    timestamps: true,
    toJSON: {
      transform: (_doc, ret) => {
        ret.requestId = ret._id.toString();
        delete ret._id;
        delete ret.__v;
      },
    },
  }
);

const BloodRequest: Model<IBloodRequestDocument> =
  mongoose.model<IBloodRequestDocument>("BloodRequest", bloodRequestSchema);

export { IBloodRequest, IBloodRequestDocument, BloodRequest };
