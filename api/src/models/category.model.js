import pool from "../config/db.js";

class Category {
	static async insert(name) {
		const INSERT_CATEGORY = "INSERT INTO categories (name) VALUES (?)";
		return await pool.execute(INSERT_CATEGORY, [name]);
	}

	static async findAll() {
		const SELECT_ALL = "SELECT id, name FROM categories";
		return await pool.query(SELECT_ALL);
	}

	static async findOne(id) {
		const SELECT_ONE = "SELECT id, name FROM categories WHERE id = ?";
		return await pool.execute(SELECT_ONE, [id]);
	}

	static async update(name, id) {
		const UPDATE_CATEGORY = "UPDATE categories SET name = ? WHERE id = ?";
		return await pool.execute(UPDATE_CATEGORY, [name, id]);
	}

	static async delete(id) {
		const DELETE_CATEGORY = "DELETE FROM categories WHERE id = ?";
		return await pool.execute(DELETE_CATEGORY, [id]);
	}
}

export default Category;
