import crypto from "crypto";

export const hashPassword = (password) => {
    const salt = crypto.randomBytes(16).toString('hex');
    const hashedPass = crypto.pbkdf2Sync(password, salt,
        1000, 64, `sha512`).toString(`hex`);
    return {
        hashedPass,
        salt,
    };
};

export const verifyPassword = (user, password) => {
    const hash = crypto.pbkdf2Sync(password,
        user.salt, 1000, 64, `sha512`).toString('hex');
    if (hash === user.password) {
        return true;
    } else { return false; }
};
