import mongoose from "mongoose";
import {product} from "./Product.js";

export const orderItem = new mongoose.Schema({
    piece: Number,
    product,
});

const OrderItem = mongoose.model('OrderItem', orderItem);

export default OrderItem;
