import mongoose from "mongoose";
import {generateAccessToken, generateRefreshToken} from "../Core/Auth.js";
import {hashPassword, verifyPassword} from "../Functions/Security.js";
import User from '../Models/User.js';

export const getUsers = async (req, res) => {
    try {
        const user = await User.find();
        res.status(200).json(user);
    } catch (e) {
        res.status(400).json({message: e.message});
    }
};

export const createUser = async (req, res) => {
    const post = req.body;
    const {salt, hashedPass} = hashPassword(req.body.password);
    const newUser = new User({...post, password: hashedPass, salt});
    try {
        await newUser.save();
        const token = await pushRefreshTokenToNewUser(newUser._id);
        newUser.$set({...newUser, refreshToken: token});
        const accessToken = generateAccessToken(newUser);
        res.status(200).json({message: 'Success', status: true, accessToken, user: newUser});
    } catch (error) {
        res.status(409).json({message: error.message});
    }
};

const pushRefreshTokenToNewUser = async (userId) => {
    const userFound = await User.findById(mongoose.Types.ObjectId(`${userId}`));
    const refreshToken = generateRefreshToken(userFound);
    const user = await User.findOneAndUpdate({_id: userId}, {$set: {refreshToken}}, {new: true});
    try {
        await user.save();
        return refreshToken;
    } catch (e) {
        console.log(e);
    }
};

export const login = async (req, res) => {
    if (!req.body.email || !req.body.password) {
        return res.status(404).send({
            message: 'Email and password can not be empty!',
            status: false,
        });
    } else {
        const email = req.body.email;
        const user = await User.findOne({email});
        if (user) {
            const verify = verifyPassword(user, req.body.password);
            if (verify) {
                const accessToken = generateAccessToken(user);
                res.status(200).json({message: 'Success', user, accessToken, status: true});
            } else {
                res.status(409).json({message: 'password is invalid', status: false});
            }
        } else {
            res.status(409).json({message: 'Email not valid', status: false});
        }
    }
};
