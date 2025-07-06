import mysql from "mysql2/promise";

// Crée un pool de connexions avec la chaîne complète depuis la variable d'environnement
const pool = mysql.createPool(process.env.DATABASE_URL);

pool.getConnection()
  .then((conn) => {
    console.log(`Connecté à la base de données : ${conn.config.database}`);
    conn.release(); // Relâche la connexion après test
  })
  .catch((err) => {
    console.error("Erreur de connexion MySQL :", err);
  });

export default pool;
