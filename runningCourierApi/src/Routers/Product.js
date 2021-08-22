import express from 'express';
import {createNewProduct, getFavoriteProducts} from "../Controllers/Product.js";
const router = express.Router();

router.post('/create', createNewProduct);
router.get('/favorites', getFavoriteProducts);
export default router;
