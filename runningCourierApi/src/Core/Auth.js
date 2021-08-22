import jwt from "jsonwebtoken";

export const authenticateJWT = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(" ")[1];
        const decodedToken = jwt.verify(token, process.env.ACCESS_JWT_SECRET_KEY);
        console.log(decodedToken.jwtuid);
        req.userData = decodedToken;
        next();
    } catch (error) {
        return res.status(401).send({
            message: 'Auth failed',
        });
    }
};

export const generateAccessToken = (user) => {
    const token =
        jwt.sign({jwtUid: user._id, jwtEmail: user.email}, process.env.ACCESS_JWT_SECRET_KEY, {expiresIn: "90d"});
    return token;
};

export const generateRefreshToken = (user) => {
    const token =
        jwt.sign({jwtUid: user._id, jwtEmail: user.email}, process.env.REFRESH_JWT_SECRET_KEY, {expiresIn: "365d"});
    return token;
};
