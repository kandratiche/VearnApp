import mongoose from "mongoose";
import dotenv from "dotenv";
import Picture from "./models/picturesModel.js";

dotenv.config();

const UNSPLASH_API = "https://api.unsplash.com/search/photos";

async function fetchUnsplashImages(query, count = 10) {
  const response = await fetch(
    `${UNSPLASH_API}?query=${query}&per_page=${count}&client_id=${process.env.UNSPLASH_ACCESS_KEY}`
  );

  if (!response.ok) {
    throw new Error(`Unsplash API error: ${response.statusText}`);
  }

  const data = await response.json();

  return data.results.map((img) => ({
    authorId: "690e408467671be32c2ec095", 
    title: img.alt_description || `Photo about ${query}`,
    imageUrl: img.urls.regular,
    description: img.description || `A ${query} photo by ${img.user.name}`,
  }));
}

async function seedUnsplash() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log("✅ Connected to MongoDB");

    const themes = ["nature", "city", "animals", "technology", "art"];
    let allPictures = [];

    for (const theme of themes) {
      const pictures = await fetchUnsplashImages(theme, 20);
      allPictures.push(...pictures);
      console.log(`📸 Fetched ${pictures.length} ${theme} photos`);
    }

    await Picture.insertMany(allPictures);
    console.log(`✅ Inserted ${allPictures.length} photos into MongoDB`);
  } catch (err) {
    console.error("❌ Error seeding:", err);
  } finally {
    mongoose.connection.close();
  }
}

seedUnsplash();
