import { hash, genSalt, compare } from "bcrypt";

import createToken from "../utils/token.js";
import Auth from "../models/auth.model.js";

const register = async (req, res, next) => {
	const { alias, email, password, phone } = req.body;

	try {
		const hashedPassword = await hash(password, await genSalt());
		const response = await Auth.createUser({
			alias,
            email,
			phone,
			password: hashedPassword
		});
		res.status(201).json({
			msg: "Utilisateur créé.",
			data: response,
		});
	} catch (error) {
		next(error);
	}
};

const login = async (req, res, next) => {
	const { email, password } = req.body;

	try {
		const [[user]] = await Auth.findUserForAuth(email);

		if (user && (await compare(password, user.password))) {
			const TOKEN = createToken(user);

			res.cookie("jwt", TOKEN, {
				httpOnly: true,
				secure: process.env.NODE_ENV === "production",
				sameSite: process.env.NODE_ENV === "production" ? "none" : "lax",
				maxAge: 86400000,
			});

			res.json({
				msg: "Utilisateur connecté",
				user: {
					email: user.email,
					alias: user.alias,
					phone: user.phone,
					role: user.role, 
				}
			});
			return;
		}

		res.status(400).json({ msg: "Identifiants invalides." });
	} catch (error) {
		console.error("Erreur dans login :", error);
		next(error);
	}
};

const logout = (req, res, next) => {
	res.clearCookie("jwt", {
		httpOnly: true,
		secure: process.env.NODE_ENV === "production",
		sameSite: process.env.NODE_ENV === "production" ? "none" : "lax",
	});
	res.json({ msg: "Utilisateur bien déconnecté." });
};

const refreshLogin = async (req, res, next) => {
    res.json({success: "Autorisé à se reconnecter.", user: {alias: req.user.alias, email: req.user.email, phone: req.user.phone}});
}

export { register, login, logout, refreshLogin };
