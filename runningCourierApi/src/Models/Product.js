import mongoose from "mongoose";

export const product = new mongoose.Schema({
    calorie: Number,
    contents: [String],
    description: String,
    image: String,
    name: String,
    price: Number,
    rating: Number,
    stockCount: Number,
});

const Product = mongoose.model('Product', product);

export default Product;
