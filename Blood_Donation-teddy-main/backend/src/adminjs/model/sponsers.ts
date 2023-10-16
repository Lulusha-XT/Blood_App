import mongoose, { Model, model, Schema } from "mongoose";

interface ISponser {
  sponserName: string;
  email: string;
  phoneNo: string;
  password: string;
}

interface ISponserDocument extends ISponser, Document {
  sponserId: string;
  token: string;
}

const SponserSchema = new Schema<ISponserDocument>({
  sponserName: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  phoneNo: { type: String, required: true },

  password: { type: String, required: true },

  token: { type: String },
});

SponserSchema.set("toJSON", {
  transform: (doc, ret) => {
    ret.sponserId = ret._id.toString();
    delete ret._id;
    delete ret.__v;

    // delete ret.password;
  },
});

const Sponser: Model<ISponserDocument> = mongoose.model<ISponserDocument>(
  "Sponser",
  SponserSchema
);

export { ISponser, ISponserDocument, Sponser };
