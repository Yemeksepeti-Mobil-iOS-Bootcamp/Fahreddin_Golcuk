import bodyParser from "body-parser";
import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import mongoose from "mongoose";
import CategoryRoutes from './src/Routers/Category.js';
import OrderRoutes from './src/Routers/Order.js';
import ProductRoutes from './src/Routers/Product.js';
import UserRoutes from './src/Routers/User.js';

dotenv.config();

const app = express();

app.use(bodyParser.json({ limit: "30mb"}));
app.use(bodyParser.urlencoded({ limit: "30mb", extended: true}));
app.use(cors());

app.use('/user', UserRoutes);
app.use('/category', CategoryRoutes);
app.use('/product', ProductRoutes);
app.use('/order', OrderRoutes);

const CONNECTION_URL = `${process.env.CONNECTION_URL}`;
const port = process.env.PORT || 8080;

// @ts-ignore
mongoose.connect(CONNECTION_URL, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => app.listen(port, () => console.log("Server is running " + port)))
    .catch((error) => console.log(error));

mongoose.set("useFindAndModify", false);
