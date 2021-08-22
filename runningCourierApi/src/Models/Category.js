import mongoose from "mongoose";
import {product} from "./Product.js";

const category = new mongoose.Schema({
    image: String,
    name: String,
    productCount: Number,
    products: [product],
});

const Category = mongoose.model('Category', category);

export default Category;
