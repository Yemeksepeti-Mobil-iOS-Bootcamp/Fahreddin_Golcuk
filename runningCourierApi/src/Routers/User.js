import express from 'express';
import {createUser, getUsers, login} from '../Controllers/User.js';
import {authenticateJWT} from "../Core/Auth.js";
const router = express.Router();

router.get('/', authenticateJWT, getUsers);
router.post('/', createUser);
router.post('/login', login);

export default router;
