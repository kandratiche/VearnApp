import mongoose from 'mongoose';

const picturesSchema = new mongoose.Schema({
    authorId: {
        type: String, 
        required: true,
    },
    title: { 
        type: String, 
        required: true },
    imageUrl: { 
        type: String, 
        required: true },
    description: { 
        type: String },
    createdAt: { 
        type: Date, 
        default: Date.now }
});

module.exports = mongoose.model('Picture', picturesSchema);