import * as mongoose from "mongoose";
import Category from "../Models/Category.js";
import Product from '../Models/Product.js';

export const createNewProduct = async (req, res) => {
    try {
        const newProduct = new Product(
            {calorie: 500,
                contents: [],
                description: "It is a food made using parts of the animal's head such as tongue, brain, cheek.",
                image: "meat-sogus",
                name: "Sogus",
                price: 14.21,
                rating: 4.8, stockCount: 50});
        const willBeEventGroup = await Category.findById('611806dc6113ae3c8db135c2');
        willBeEventGroup['products'].push(newProduct);
        await willBeEventGroup.save();
        res.status(200).json(willBeEventGroup);
    } catch (e) {
        res.status(400).json({message: e.message});
    }
};

export const getFavoriteProducts = async (req, res) => {
    try {
        const favorites = [];
        const categories = await Category.find();
        categories.forEach((category) => {
            if (category['products'][0]) {
                favorites.push(category['products'][0]);
            }
        });
        res.status(200).json(favorites);
    } catch (e) {
        res.status(400).json({message: e.message});
    }
};
