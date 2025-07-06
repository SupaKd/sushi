import formidable from "formidable";
import path from "path";
import Product from "../models/product.model.js";
import sendResponse from "../utils/sendResponse.js";

const add = async (req, res, next) => {
	const form = formidable({
		uploadDir: path.join(process.cwd(), "public", "uploads", "images"),
		keepExtensions: true,
		multiples: false, 
	});

	form.parse(req, async (err, fields, files) => {
		if (err) {
			console.error("Erreur formidable :", err);
			return res.status(500).json({ message: "Erreur lors de l'envoi du formulaire." });
		}

		const image = files.image?.[0] || files.image;

		const product = {
			name: fields.name?.[0] || fields.name,
			description: fields.description?.[0] || fields.description,
			price: parseFloat(fields.price?.[0] || fields.price),
			categoryId: parseInt(fields.categoryId?.[0] || fields.categoryId, 10),
			imageUrl: image
				? path.join("/uploads/images", image.newFilename).replace(/\\/g, "/")
				: null,
		};

		try {
			console.log("Produit à insérer :", product);
			const [response] = await Product.insert(product);
			if (response.insertId) {
				return res.status(201).json({ message: "Produit ajouté avec succès." });
			}
			return res.status(400).json({ message: "Échec de l'ajout du produit." });
		} catch (error) {
			console.error("Erreur lors de l'ajout :", error);
			res.status(500).json({ message: "Erreur interne lors de l'ajout du produit." });
		}
	});
};

const getAll = async (req, res, next) => {
	try {
		const response = await Product.findAll();
		if (response.length) {
			return sendResponse(res, "Produits récupérés.", 200, response);
		}
		return sendResponse(res, "Aucun produit trouvé.", 400);
	} catch (error) {
		next(error);
	}
};

const getOne = async (req, res, next) => {
	try {
		const [response] = await Product.findOne(req.params.id);
		if (response.length) {
			return sendResponse(res, "Produit récupéré.", 200, response);
		}
		return sendResponse(res, "Produit introuvable.", 400);
	} catch (error) {
		next(error);
	}
};

const update = async (req, res, next) => {
    const { name, description, price, categoryId, imageUrl } = req.body;
	const product = {
        name,
        description,
        price,
        categoryId,
        imageUrl,
        id: parseInt(req.params.id, 10),
      };
	try {
		const [response] = await Product.update(product);
		if (response.affectedRows) {
			res.status(201).json({ message: "Produit modifié." });
			return;
		}
		res.status(400).json({
			message: "Un problème est survenue, veuillez recommencer.",
		});
		return;
	} catch (error) {
		next(error);
	}
};

const remove = async (req, res, next) => {
	try {
		const [response] = await Product.delete(req.params.id);
		if (response.affectedRows) {
			return res.json({ message: "Produit supprimé." });
		}
		return res.status(400).json({ message: "Produit introuvable." });
	} catch (error) {
		next(error);
	}
};

export { add, getAll, getOne, update, remove };
