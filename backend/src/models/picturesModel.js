import mongoose from 'mongoose';

const picturesSchema = new mongoose.Schema({
    authorId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
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

const Picture = mongoose.model('Picture', picturesSchema);
export default Picture;