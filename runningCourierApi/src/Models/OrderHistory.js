import mongoose from "mongoose";
import Order from "./Order.js";

const orderHistory = new mongoose.Schema({
    orders: [Order],
    userId: String,
});

const OrderHistory = mongoose.model('OrderHistory', orderHistory);

export default orderHistory;
