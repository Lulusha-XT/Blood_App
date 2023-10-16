import MONGO_DB_CONFIG from "../config/database.js";
import {
  BloodRequest,
  IBloodRequest,
  IBloodRequestDocument,
} from "../models/blood_request.model.js";
import { IUserDoner } from "../models/donation.model.js";
import { Pagination } from "../types/pagination.types.js";

export const createBloodRequest = async (
  bloodRequest: IBloodRequest
): Promise<IBloodRequestDocument> => {
  try {
    const newBloodRequest = new BloodRequest({
      ...bloodRequest,
    });
    newBloodRequest.save();
    return newBloodRequest as IBloodRequestDocument;
  } catch (error) {
    throw new Error(`Could not create user ${error}`);
  }
};

// export async function getAllBloodRequests(
//   pagination: Pagination
// ): Promise<IBloodRequestDocument[]> {
//   try {
//     const perPage =
//       Math.abs(parseInt(pagination.pageSize!)) || MONGO_DB_CONFIG.PAGE_SIZE;
//     const page = (Math.abs(parseInt(pagination.page!)) || 1) - 1;

//     const bloodRequests = await BloodRequest.find()
//       .select(
//         "bloodType reason unitRequired deadLine hospital personInCharge contactNumber patientName location requesterId userDoners pendingState completedState createdAt updatedAt"
//       )
//       .populate("userDoners")
//       .limit(perPage)
//       .skip(page * perPage);

//     // Calculate pendingState and completedState for each blood request
//     const bloodRequestsWithStats = bloodRequests.map((bloodRequest) => {
//       const pendingState = bloodRequest.userDoners.filter(
//         (userDoner: IUserDoner) => userDoner.status === "Pending"
//       ).length;

//       const completedState = bloodRequest.userDoners.filter(
//         (userDoner: IUserDoner) => userDoner.status === "Completed"
//       ).length;

//       return {
//         ...bloodRequest.toJSON(),
//         pendingState,
//         completedState,
//       };
//     });

//     return bloodRequestsWithStats as IBloodRequestDocument[];
//   } catch (error) {
//     console.error("Error fetching blood requests:", error);
//     return [];
//   }
// }

export async function getAllBloodRequests(
  pagination: Pagination,
  currentUserRequestId: string // Pass the current user's requesterId here
): Promise<IBloodRequestDocument[]> {
  try {
    const perPage =
      Math.abs(parseInt(pagination.pageSize!)) || MONGO_DB_CONFIG.PAGE_SIZE;
    const page = (Math.abs(parseInt(pagination.page!)) || 1) - 1;

    const bloodRequests = await BloodRequest.find({
      requesterId: { $ne: currentUserRequestId }, // Exclude requests from the current user
    })
      .select(
        "bloodType reason unitRequired deadLine hospital personInCharge contactNumber patientName location requesterId userDoners pendingState completedState createdAt updatedAt"
      )
      .populate("userDoners")
      .limit(perPage)
      .skip(page * perPage);

    // Calculate pendingState and completedState for each blood request
    const bloodRequestsWithStats = bloodRequests.map((bloodRequest) => {
      const pendingState = bloodRequest.userDoners.filter(
        (userDoner: IUserDoner) => userDoner.status === "Pending"
      ).length;

      const completedState = bloodRequest.userDoners.filter(
        (userDoner: IUserDoner) => userDoner.status === "Completed"
      ).length;

      return {
        ...bloodRequest.toJSON(),
        pendingState,
        completedState,
      };
    });

    return bloodRequestsWithStats as IBloodRequestDocument[];
  } catch (error) {
    console.error("Error fetching blood requests:", error);
    return [];
  }
}

export async function getBloodRequestsByRequesterId(
  requesterId: string
): Promise<IBloodRequestDocument[]> {
  try {
    console.log(`Requester ${requesterId}`);
    const bloodRequests = await BloodRequest.find({ requesterId })
      .select(
        "bloodType reason unitRequired deadLine hospital personInCharge contactNumber patientName location requesterId userDoners pendingState completedState createdAt updatedAt"
      )
      .populate("userDoners");

    // Calculate pendingState and completedState for each blood request
    const bloodRequestsWithStats = bloodRequests.map((bloodRequest) => {
      const pendingState = bloodRequest.userDoners.filter(
        (userDoner: IUserDoner) => userDoner.status === "Pending"
      ).length;

      const completedState = bloodRequest.userDoners.filter(
        (userDoner: IUserDoner) => userDoner.status === "Completed"
      ).length;

      return {
        ...bloodRequest.toJSON(),
        pendingState,
        completedState,
      };
    });

    return bloodRequestsWithStats as IBloodRequestDocument[];
  } catch (error) {
    console.error("Error fetching blood requests:", error);
    return [];
  }
}
