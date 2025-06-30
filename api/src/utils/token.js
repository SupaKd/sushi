import jwt from "jsonwebtoken";

const SECRET = process.env.SECRET_TOKEN;

export default ({ id, alias, email, phone, role }) => {
	const PAYLOAD = {
		userId: id,
		alias,
		email,
    	phone,
		role,
	};
	const OPTIONS = {
		expiresIn: "1d",
	};

	return jwt.sign(PAYLOAD, SECRET, OPTIONS);
};
