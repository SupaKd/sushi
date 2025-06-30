import { Router } from "express";
import { register, login, logout, refreshLogin } from "../controllers/auth.controller.js";
import { registerSchema, loginSchema } from "../middlewares/validateSchemas.js";
import { validate } from "../middlewares/validate.js";
import verifyToken from "../middlewares/verifyToken.js";

const router = Router();

router.post("/register", validate(registerSchema), register);
router.post("/login", validate(loginSchema), login);
router.post("/logout", logout);
router.post("/refresh-login", verifyToken, refreshLogin);

export default router;
