import mysql from "mysql2/promise";

const pool = mysql.createPool({
	host: process.env.DB_HOST,
  	port: process.env.DB_PORT, // Spécifie le port MySQL si différent (ex: MAMP, Homebrew sur Mac)
	database: process.env.DB_NAME,
	user: process.env.DB_USER,
	password: process.env.DB_PASSWORD,
});

pool.getConnection()
	.then((res) => console.log(`Connected to ${res.config.database} database`))
	.catch((err) => console.log(err));

export default pool;
