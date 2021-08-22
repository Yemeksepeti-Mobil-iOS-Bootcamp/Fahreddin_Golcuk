import Order from '../Models/Order.js';

export const createOrder = async (req, res) => {
    try {
        const newOrder = new Order({...req.body,
            date: String(new Date()
                .toISOString()
                .replace(/T/, ' ')
                .replace(/\..+/, '')), userId: req.headers.userid});
        await newOrder.save();
        res.status(200).json({message: 'Success', status: true});
    } catch (e) {
        res.status(400).json({message: e.message});
    }
};

export const getOrderHistory = async (req, res) => {
    try {
        const orders = await Order.find({userId: req.headers.userid});
        res.status(200).json(orders);
    } catch (e) {
        res.status(400).json({message: e.message});
    }
};
