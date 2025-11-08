import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import userRoutes from './routes/userRoutes.js';
import pictureRoutes from './routes/picturesRoutes.js';
import mongoose from "mongoose";

dotenv.config();
const app = express();
const PORT = 5000;

app.use(cors({origin: "*"}));
app.use(express.json());

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => {
  console.log("Connected to MongoDB");
  app.listen(5000, () => console.log("Server running on port 5000"));
})
.catch((err) => console.error("MongoDB connection error:", err));


app.use("/posts", pictureRoutes);
app.use("/users", userRoutes);

app.listen(PORT, "127.0.0.1", () => {
  console.log(`Server running on http://127.0.0.1:${PORT}`);
});

