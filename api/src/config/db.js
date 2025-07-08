import pkg from "pg";
const { Pool } = pkg;

const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT), // converti en nombre
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: { rejectUnauthorized: false }, // obligatoire pour Supabase
});

pool.connect()
  .then(() => console.log(`Connected to ${process.env.DB_NAME} database`))
  .catch((err) => console.error("Database connection error:", err));

export default pool;
