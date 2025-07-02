import pool from "../config/db.js";

class Product {
    static async insert({ name, description, price, categoryId, imageUrl }) {
        const INSERT_PRODUCT = `
          INSERT INTO products (name, description, price, category_id, image_url)
          VALUES (?, ?, ?, ?, ?)
        `;
        return await pool.execute(INSERT_PRODUCT, [
          name,
          description,
          price,
          categoryId,
          imageUrl,
        ]);
      }
    
      static async findAll() {
        const SELECT_ALL = `
          SELECT id, name, description, price, image_url, category_id, created_at
          FROM products
        `;
        const [rows] = await pool.execute(SELECT_ALL);
        return rows;
      }
      
    
      static async findOne(id) {
        const SELECT_ONE = `
          SELECT id, name, description, price, image_url, category_id, created_at
          FROM products
          WHERE id = ?
        `;
        return await pool.execute(SELECT_ONE, [id]);
      }
    
      static async update({ id, name, description, price, categoryId, imageUrl }) {
        const UPDATE_PRODUCT = `
          UPDATE products
          SET name = ?, description = ?, price = ?, category_id = ?, image_url = ?
          WHERE id = ?
        `;
        return await pool.execute(UPDATE_PRODUCT, [
          name,
          description,
          price,
          categoryId,
          imageUrl,
          id,
        ]);
      }
    
      static async delete(id) {
        const DELETE_PRODUCT = `DELETE FROM products WHERE id = ?`;
        return await pool.execute(DELETE_PRODUCT, [id]);
      }
}
export default Product;