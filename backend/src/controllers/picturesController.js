import Picture from '../models/picturesModel.js';

export const getAllPosts = async (req, res) => {
    try {
        const pictures = await Picture.find();
        res.status(200).json(pictures);
    } catch (error) {
        res.status(500).json({ message: "Error fetching pictures", error: error.message });
    }
};

export const getPostsById = async (req, res) => {
    try {
        const picture = await Picture.findById(req.params.id);
        console.log(req.params.id);
        if (!picture) {
            return res.status(404).json({ message: "Picture not found" });
        }
        res.status(200).json(picture);
    } catch (error) {
        res.status(500).json({ message: "Error fetching picture", error: error.message });
    }
}
export const getPostsByTitle = async (req, res) => {
    try {
        const { title } = req.params;

        const words = title.split(/\s+/);
      
        const regexQueries = words.map(word => ({
            title: { $regex: word, $options: 'i' } 
        }));

        const pictures = await Picture.find({ $or: regexQueries });
        console.log(pictures)
        res.status(200).json(pictures);
    } catch (error) {
        res.status(500).json({ message: "Error fetching pictures by title", error: error.message });
    }
}


export const createPost = async (req, res) => {
    try {
        const { authorId, title, imageUrl, description } = req.body;
        const newPicture = new Picture({ authorId, title, imageUrl, description });
        await newPicture.save();
        res.status(201).json({ message: "Picture created successfully", picture: newPicture });
    } catch (error) {
        res.status(500).json({ message: "Error creating picture", error: error.message });
    }
}

export const deletePost = async (req, res) => {
    try {
        const picture = await Picture.findByIdAndDelete(req.params.id);
        if (!picture) {
            return res.status(404).json({ message: "Picture not found" });
        }
        res.status(200).json({ message: "Picture deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error deleting picture", error: error.message });
    }
}