import express from 'express';
import {createNewCategory, getCategories} from '../Controllers/Category.js';
import {authenticateJWT} from "../Core/Auth.js";
const router = express.Router();

router.post('/create', authenticateJWT, createNewCategory);
router.get('/get-categories', getCategories);
export default router;
