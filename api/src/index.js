// Chargement des variables d'environnement
import "dotenv/config";

// Modules nécessaires
import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import path from "path";

// Routes principales
import router from "./router/index.routes.js";

// Configuration
const app = express();
const PORT = process.env.PORT || 9000;
const base_url = "/api/v1";

// Middleware CORS : autorise les requêtes depuis le frontend
app.use(
	cors({
		origin: process.env.CLIENT,
		credentials: true,
		methods: ["GET", "POST", "PATCH","PUT", "DELETE", "OPTIONS"],
		allowedHeaders: ["Content-Type", "Accept"],
	})
);

app.get('/ping', async (req, res) => {
	try {
	  const [rows] = await pool.query('SELECT 1 + 1 AS result');
	  res.json({ success: true, result: rows[0].result });
	} catch (error) {
	  res.status(500).json({ success: false, error: error.message });
	}
  });
  

// Middleware pour lire les cookies et le JSON
app.use(cookieParser());
app.use(express.json());

// Servir les images statiques depuis /public/uploads/images
app.use("/uploads/images", express.static(path.resolve("public/uploads/images")));

// Route test pour vérifier que l'API fonctionne
app.get("/", (req, res) => {
	res.json({ msg: "API is running" });
});

// Utilisation des routes définies dans /router
app.use(base_url, router);

// Gestion des erreurs simples (ex: doublon SQL)
app.use((err, req, res, next) => {
	if (err.code === "ER_DUP_ENTRY") {
		return res.status(409).json({ message: "Donnée déjà existante." });
	}
	res.status(500).json({ msg: "Erreur serveur. Veuillez réessayer." });
});

// Lancement du serveur
app.listen(PORT, () => {
	console.log(`Serveur en ligne : http://localhost:${PORT}`);
});
