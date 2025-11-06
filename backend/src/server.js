import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { MongoClient, ServerApiVersion } from "mongodb";

dotenv.config();
const app = express();
const PORT = 5000;

console.log("✅ Express server started successfully");

app.use(cors({origin: "*"}));
app.use(express.json());

const client = new MongoClient(process.env.DB_URI, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});
async function run() {
  try {
    await client.connect();
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
  } finally {
    await client.close();
  }
}
run().catch(console.dir);

const posts = [
  { id: 1, image: "https://picsum.photos/200/300", title: "Sunset vibes" },
  { id: 2, image: "https://picsum.photos/200/301", title: "Mountain view" },
  { id: 3, image: "https://picsum.photos/200/302", title: "City lights" }
];

app.get("/api/posts", (req, res) => {
  console.log("✅ GET /api/posts request received");
  res.json([
    { id: 1, image: "https://picsum.photos/200/300", title: "Sunset vibes" },
    { id: 2, image: "https://picsum.photos/200/301", title: "Mountain view" },
    { id: 3, image: "https://picsum.photos/200/302", title: "City lights" }
  ]);
});

app.get("/", (req, res) => {
  console.log("✅ GET / request received");
  res.send("Server is alive");
});

app.listen(PORT, "127.0.0.1", () => {
  console.log(`Server running on http://127.0.0.1:${PORT}`);
});

