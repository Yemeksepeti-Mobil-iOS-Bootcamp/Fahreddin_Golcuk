import mongoose from "mongoose";

const user = new mongoose.Schema({
    email: String,
    name: String,
    password: String,
    refreshToken: String,
    salt: String,
});

const User = mongoose.model('User', user);

export default User;
