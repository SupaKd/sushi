import pool from "../config/db.js";

class Auth {
	
	static async findUserForAuth(email) {
		const SELECT_USER =
			"SELECT id, alias, email, password, phone, role FROM users WHERE email = ?";

		return await pool.execute(SELECT_USER, [email]);
	}


	static async createUser({ alias, email, phone, password }) {
		const INSERT_USER = `
			INSERT INTO users (alias, email, phone, password)
			VALUES (?, ?, ?, ?)
		`;
		return await pool.execute(INSERT_USER, [alias, email, phone, password]);
	}
}

export default Auth;
