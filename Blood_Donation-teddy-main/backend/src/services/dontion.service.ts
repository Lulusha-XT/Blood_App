import { Console } from "console";
import { BloodRequest, IBloodRequest } from "../models/blood_request.model.js";
import { UserDonerModel, IUserDoner } from "../models/donation.model.js";
import { User } from "../models/user.model.js";

export const donateBlood = async (
  bloodDonation: IUserDoner
): Promise<IUserDoner> => {
  try {
    const doner = bloodDonation.donor;
    const request = bloodDonation.request;
    const existingUserDoner = await UserDonerModel.findOne({
      doner,
      request,
    });
    if (existingUserDoner) {
      throw new Error("Alredy Donated");
    }
    const newBloodDonation = new UserDonerModel(bloodDonation);
    const savedBloodDonation = await newBloodDonation.save();
    const updatedRequest = await BloodRequest.findByIdAndUpdate(
      bloodDonation.request,
      {
        $addToSet: {
          userDoners: newBloodDonation,
        },
      },
      { new: true }
    );
    if (!updatedRequest) {
      throw new Error(`BloodRequest not found`);
    }
    return savedBloodDonation;
  } catch (err) {
    console.error(err);
    throw err;
  }
};

export const getAllBloodDonations = async (): Promise<IUserDoner[]> => {
  try {
    const bloodDonations = await UserDonerModel.find();
    console.log(`BloodDonations = ${bloodDonations}`);
    return bloodDonations;
  } catch (err) {
    console.error(err);
    throw err;
  }
};

export const getBloodDonationsById = async (
  requester: string
): Promise<IUserDoner[]> => {
  try {
    console.log("I come here");
    const donations = await UserDonerModel.find({ requester: requester });
    return donations;
  } catch (error) {
    throw new Error(`Request not found ${error}`);
  }
};

export const getMyApprovedDonations = async (
  requester: string
): Promise<IBloodRequest[]> => {
  try {
    console.log("I come here");
    const approvedDonations = await UserDonerModel.find({
      requester: requester,
      status: "Completed", // Select only approved donations
    }).populate("request"); // Populate the "request" field

    // Extract the fully populated "request" field from each donation
    const populatedRequests: IBloodRequest[] = approvedDonations.map(
      (donation) => donation.request
    );

    return populatedRequests;
  } catch (error) {
    throw new Error(`Request not found ${error}`);
  }
};

// Fetching users who donated blood for a specific blood request
export async function getDonatingUsers(
  requestId: string
): Promise<IUserDoner[]> {
  try {
    const usersDonatingBlood = await UserDonerModel.find({
      request: requestId,
    }).populate("donor");
    return usersDonatingBlood;
  } catch (error) {
    // Handle error
    throw error;
  }
}
export async function approveDonation(
  donationId: string,
  userId: string
): Promise<void | string> {
  try {
    // Find the blood request document
    const donation = await UserDonerModel.findById(donationId);
    if (!donation) {
      return "Blood request donation not found";
    }
    if (donation.status === "Completed") {
      return "Donation has already been approved";
    }
    // Find the user document
    const user = await User.findById(userId);
    if (!user) {
      return "User not found";
    }
    // Generate a new token for the user
    const newToken = generateUniqueToken();
    // Initialize tokensValue as an empty array if it's undefined
    if (!user.tokensValue) {
      user.tokensValue = [];
    }
    // Push the new token to the user's tokens array
    user.tokensValue.push({ value: newToken, used: false });
    // Update the blood request status
    donation.status = "Completed";
    // Save the updated blood request and user documents
    await donation.save();
    await user.save();
  } catch (error) {
    return `${error}`; // Return the error message
  }
}

function generateUniqueToken(): string {
  const tokenLength = 10;
  const possibleChars = "0123456789";
  let token = "";

  for (let i = 0; i < tokenLength; i++) {
    const randomIndex = Math.floor(Math.random() * possibleChars.length);
    const randomChar = possibleChars.charAt(randomIndex);
    token += randomChar;
  }

  return token;
}
