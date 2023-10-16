import { IUser, IUserDocument, User } from "../models/user.model.js";
import bcrypt from "bcrypt";
import * as auth from "../middlewares/auth.js";
import dotenv from "dotenv";
import MONGO_DB_CONFIG from "../config/database.js";
import { Pagination } from "../types/pagination.types.js";
import * as sponserTokenService from "../adminjs/services/tokenValue.service.js";

// Environment variables
dotenv.config();
const saltRound = process.env.SALT_ROUND as string | number;
const bcryptPassword = process.env.BCRYBT_PASSWORD;

// Signup
export const createUser = async (user: IUser): Promise<IUserDocument> => {
  try {
    const isUserExist = await User.findOne({ email: user.email });
    if (isUserExist) throw new Error("Email Already Registerd");

    const password = user.password;
    const hash = bcrypt.hashSync(
      password + bcryptPassword,
      MONGO_DB_CONFIG.SALT_ROUND
    );

    const newUser = new User({
      ...user,
      password: hash,
    });

    const token = auth.assignAccessToken(newUser.toJSON());
    newUser.token = token;
    await newUser.save();

    return newUser as IUserDocument;
  } catch (error) {
    throw new Error(`Could not create user ${error}`);
  }
};

export const logIn = async (email: string, password: string) => {
  try {
    const user = await User.findOne({ email });

    if (
      user &&
      (await bcrypt.compare(password + bcryptPassword, user.password))
    ) {
      const token = auth.assignAccessToken(user);
      console.log(token);

      // Update user token and save
      user.token = token;
      await user.save();

      return user as IUserDocument;
    }
    return null;
  } catch (error) {
    throw new Error(`Log in failed ${error}`);
  }
};

// Get all users
export const getAllUser = async (
  pagination: Pagination
): Promise<IUserDocument[]> => {
  try {
    const perPage =
      Math.abs(parseInt(pagination.pageSize!)) || MONGO_DB_CONFIG.PAGE_SIZE;
    const page = (Math.abs(parseInt(pagination.page!)) || 1) - 1;

    const user = await User.find()
      .limit(perPage)
      .skip(page * perPage);
    return user as IUserDocument[];
  } catch (error) {
    throw new Error(`User not found ${error}`);
  }
};

// Get user by id

export const getUserById = async (id: string): Promise<IUserDocument> => {
  try {
    const user = await User.findById(id); // Find the user by ID
    if (!user) throw new Error("User not found"); // Throw an error if the user is not found
    return user; // Return the user if it exists
  } catch (error) {
    throw new Error(`Retrieving user failed: ${error}`);
  }
};

export const updateUserById = async (
  id: string,
  user: IUser
): Promise<IUser | null> => {
  try {
    console.log("Updated Excuted");
    const updatedUser = await User.findByIdAndUpdate(id, user, {
      new: true,
    });
    return updatedUser;
  } catch (err) {
    throw new Error(`Updating user failed: ${err}`);
  }
};
// Dellete user
export const deleteUser = async (id: string) => {
  try {
    const user = await User.findById(id).lean();
    return user;
  } catch (error) {
    throw new Error(`Delete failed ${error}`);
  }
};

export async function useAndRomeveToken(
  userId: string,
  tokenValue: string,
  sponserId: string
): Promise<void | string> {
  try {
    // Find the user document
    const user = await User.findById(userId);
    if (!user) {
      return "User not found";
    }
    if (!user.tokensValue) {
      user.tokensValue = [];
    }
    // Filter out the token from the user's tokens array
    user.tokensValue = user.tokensValue.filter(
      (token) => token.value.toString() !== tokenValue
    );
    await user.save();
    await sponserTokenService.useAndRomeveToken(sponserId, tokenValue);
    // Save the updated user document
  } catch (error) {
    return `${error}`; // Return the error message
  }
}

// Function to find a user by token and count occurrences
export async function getUserByToken(
  token: string
): Promise<{ user: IUserDocument | null; totalToken: number }> {
  try {
    console.log(token);
    const user = await User.findOne({
      "tokensValue.value": { $in: [token] },
    }).exec();

    const totalToken = user?.tokensValue!.length ?? 0;

    return { user, totalToken };
  } catch (error) {
    console.error(error);
    throw new Error("Failed to find user by token");
  }
}

export async function getTokenValue(id: string) {
  try {
    const user = await User.findById(id);

    if (!user) {
      throw new Error("User not found");
    }

    const tokensValue = user.tokensValue;

    return tokensValue;
  } catch (error) {
    console.error(error);
    throw new Error("Failed to find user by token");
  }
}
