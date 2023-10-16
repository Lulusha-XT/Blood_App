import MONGO_DB_CONFIG from "../../config/database.js";
import { Pagination } from "../../types/pagination.types.js";
import { ISponserToken, SponserToken } from "../model/sponserToken.model.js";

import * as userServices from "../../services/users.service.js";
import { User } from "../../models/user.model.js";
export const createSponserToken = async (
  sponser: ISponserToken
): Promise<ISponserToken> => {
  try {
    const newSponser = new SponserToken({
      sponser: sponser.sponser,
      tokenOwner: sponser.tokenOwner,
      token: sponser.token,
      status: "Pending",
    });

    await newSponser.save();

    if (newSponser) {
      const user = await userServices.getUserByToken(sponser.token);

      // Check if the user and tokensValue array exist
      if (user.user && user.user.tokensValue) {
        // Iterate through tokensValue to find the specific token
        for (const tokenValue of user.user.tokensValue) {
          if (tokenValue.value === sponser.token) {
            // Update the used property to true
            tokenValue.used = true;
            break; // Exit the loop once the token is found
          }
        }

        // Update the user in the database with the modified tokensValue array
        await User.findByIdAndUpdate(user.user._id, {
          tokensValue: user.user.tokensValue,
        });
      }
    }

    return newSponser as ISponserToken;
  } catch (error) {
    throw new Error(`Could not create user ${error}`);
  }
};

export const getSponsersTokenForSponser = async (sponser: string) => {
  try {
    // Use Mongoose to find the token by token string
    const sponserToken = await SponserToken.find({ sponser: sponser })

      .populate({
        path: "tokenOwner",
        select: "fullName email phoneNo",
      })
      .select("  token "); // Include the status field

    return sponserToken;
  } catch (error) {
    throw error;
  }
};

export const getSponsersToken = async (token: string) => {
  try {
    // Use Mongoose to find the token by token string
    const sponserToken = await SponserToken.findOne({ token: token })
      .populate({
        path: "sponser",
        select: "sponserName email phoneNo",
      })
      .populate({
        path: "tokenOwner",
        select: "fullName email phoneNo",
      })
      .select("sponser tokenOwner token status"); // Include the status field

    return sponserToken;
  } catch (error) {
    throw error;
  }
};

// export const getSponsersToken = async (token: string) => {
//   try {
//     // Use Mongoose to find the token by token string
//     const sponserToken = await SponserToken.findOne({ token: token })
//       .populate({
//         path: "tokenOwner",
//         select: "fullName", // Select only the fullName field
//       })
//       .select("token"); // Include only the token field

//     return sponserToken;
//   } catch (error) {
//     throw error;
//   }
// };

export async function useAndRomeveToken(
  sponserId: string,
  tokenValue: string
): Promise<ISponserToken | string> {
  try {
    // Find the SponserToken document and remove it
    console.log(`sponserId ${sponserId}`);

    const sponserToken = await SponserToken.findOneAndRemove({
      sponser: sponserId,
      token: tokenValue,
    });

    console.log(`hello ${sponserToken}`);
    if (!sponserToken) {
      return "SponserToken not found";
    }
    // console.log(sponserToken);
    return sponserToken;
  } catch (error) {
    return `${error}`; // Return the error message
  }
}
