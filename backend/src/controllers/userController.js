import User from '../models/User.js';

export const getAllUsers = async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ message: "Error fetching users", error: error.message });
    }
}

export const getUserById = async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(user);
    } catch (error) {
        res.status(500).json({ message: "Error fetching user", error: error.message });
    }
}

export const createUser = async (req, res) => {
    try {
        const {username, email, password} = req.body;
        const existingUser = await User.findOne({ $or: [ { username }, { email } ] });
        if (existingUser) {
            return res.status(400).json({ message: "Username or email already exists" });
        }
        const newUser = new User({ username, email, password });
        await newUser.save();
        res.status(201).json({message : "User created successfully", user: newUser});
    } catch (error) {
        res.status(500).json({ message: "Error creating user", error: error.message });
    }
}

export const deleteUser = async (req, res) => {
    try {
        const user = await User.findByIdAndDelete(req.params.id);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json({ message: "User deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error deleting user", error: error.message });
    }
}