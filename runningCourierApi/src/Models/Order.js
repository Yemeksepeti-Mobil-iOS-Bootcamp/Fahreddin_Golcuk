import mongoose from "mongoose";
import {orderItem} from "./OrderItem.js";

const order = new mongoose.Schema({
    date: String,
    products: [orderItem],
    totalPrice: Number,
    userId: String,
});

const Order = mongoose.model('Order', order);

export default Order;
