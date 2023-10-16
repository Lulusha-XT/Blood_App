import mongoose, { Schema, Document, model, Model } from "mongoose";
import { ISponser } from "./sponsers.js";
import { IUser } from "../../models/user.model.js";

interface ISponserToken {
  // You send sponser and tokenOwner as ObjectIds
  sponser: mongoose.Types.ObjectId;
  tokenOwner: mongoose.Types.ObjectId;
  token: string;
  status?: "Open" | "Pending" | "Completed";
}

interface ISponserTokenDocument extends ISponserToken, Document {}

const sponserTokenSchema = new Schema<ISponserTokenDocument>(
  {
    sponser: {
      type: Schema.Types.ObjectId,
      ref: "Sponser",
      required: true,
    },
    tokenOwner: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    token: {
      type: String,
      required: true,
    },
    status: {
      type: String,
      enum: ["Pending", "Completed"],
      required: true,
      default: "Open",
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

const SponserToken: Model<ISponserTokenDocument> =
  mongoose.model<ISponserTokenDocument>("SponserToken", sponserTokenSchema);

export { ISponserToken, ISponserTokenDocument, SponserToken };
