import express from 'express';
import {createOrder, getOrderHistory} from '../Controllers/Order.js'
import {authenticateJWT} from "../Core/Auth.js";
const router = express.Router();

router.post('/create-order', authenticateJWT, createOrder);
router.get('/order-history', authenticateJWT, getOrderHistory);
export default router;
