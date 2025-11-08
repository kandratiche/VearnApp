import express from 'express';
import { getAllPosts, getPostsById, getPostsByTitle, createPost, deletePost } from '../controllers/picturesController.js';

const pictureRouter = express.Router();

pictureRouter.get('/', getAllPosts);
pictureRouter.get('/:id', getPostsById);
pictureRouter.get('/title/:title', getPostsByTitle);
pictureRouter.post('/', createPost);
pictureRouter.delete('/:id', deletePost);

export default pictureRouter;