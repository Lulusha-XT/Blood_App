import express, { Request, Response } from "express";
import connectDB from "./config/db.connect.js";
import morgan from "morgan";
import http from "http";
import cors from "cors";
import { Server, Socket } from "socket.io";
import path from "path";
import errorHandler from "./middlewares/errors.js";
import indexRoutes from "./routes/index.js";
import { adminRouter } from "./adminjs/index.js";

// Create Express app
const app: express.Application = express();
const port: string | number = process.env.PORT || 8080;

// Configure middlewares
app.use(morgan("dev"));
app.use(express.json());
app.use(cors());

// Routes
app.use("/api", indexRoutes);
app.use("/admin", adminRouter);

// Serve static files
app.use("/uploads", express.static(path.resolve("uploads")));
// Error handler middleware
app.use(errorHandler);

// Default route
app.get("/", (req: Request, res: Response) => {
  res.send("API WORKING!!");
});

// Create HTTP server
const server = http.createServer(app);

// Socket.io setup
const io = new Server(server);

// Handle new socket connections
io.on("connection", (socket: Socket) => {
  console.log("New user connected");

  // Handle user connections
  socket.on("userConnected", async (userId: string) => {
    socket.join(userId);
    console.log(`User ${userId} connected`);

    // You can perform any necessary actions here, such as fetching user data from the database
    // or sending initial chat history to the connected user.
  });

  // Handle chat messages
  socket.on(
    "sendMessage",
    async (data: { senderId: string; receiverId: string; message: string }) => {
      const { senderId, receiverId, message } = data;

      try {
        // Save the message to the database or perform any other necessary actions
        // using the Mongoose model
        // For simplicity, we're assuming the senderId and receiverId are valid user IDs.
        // You may need to handle cases where the IDs don't exist or have errors.
        const chatMessage = {
          senderId,
          receiverId,
          message,
        };

        // Save the message to the database
        // For example, if you have a ChatMessage model:
        // const chatMessageModel = new ChatMessage(chatMessage);
        // await chatMessageModel.save();

        // Emit the message to the receiver's room
        console.log(chatMessage);
        socket.to(receiverId).emit("messageReceived", chatMessage);
      } catch (error) {
        console.error("Error saving chat message:", error);
      }
    }
  );

  // Handle disconnections
  socket.on("disconnect", () => {
    console.log("User disconnected");
    // Perform any necessary cleanup or actions when a user disconnects
    // Perform any necessary cleanup or actions when a user disconnects
    // For example, you might want to update the user's status or remove them from any active chats.

    // Leave all rooms the user joined
    const rooms = Object.keys(socket.rooms);
    rooms.forEach((room) => {
      if (room !== socket.id) {
        socket.leave(room);
      }
    });
  });
});

// Start the server
const startServer = async () => {
  try {
    await connectDB();
    server.listen(port, () => {
      console.log(`Server is running on port http://localhost:${port}`);
    });
  } catch (error) {
    console.log(error);
  }
};

startServer();
