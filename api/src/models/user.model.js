import pool from "../config/db.js";

class User {
	static async findAll() {
		const SELECT_ALL = "SELECT id, alias, email, phone, role, created_at FROM users";
		return await pool.query(SELECT_ALL);
	}

	static async findOne(id) {
		const SELECT_ONE =
			"SELECT id, alias, email, phone, created_at FROM users WHERE id = ?";
		return await pool.execute(SELECT_ONE, [id]);
	}

	static async update(userInfos) {
		const UPDATE_USER =
			"UPDATE users SET alias = ?, email = ?, phone = ? WHERE id = ?";
		return await pool.execute(UPDATE_USER, [...Object.values(userInfos)]);
	}

	static async delete(id) {
		const DELETE_USER = "DELETE FROM users WHERE id = ?";
		return await pool.execute(DELETE_USER, [id]);
	}
}

export default User;
