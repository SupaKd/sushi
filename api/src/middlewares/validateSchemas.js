import Joi from "joi";

const registerSchema = Joi.object({
	alias: Joi.string().alphanum().min(2).max(50).required().messages({
		"string.empty": "Alias est requis.",
		"string.alphanum":
			"Alias doit contenir uniquement des caractères alphanumérique.",
		"string.min": "Alias doit contenir au moins 2 caractères.",
		"string.max":
			"Alias ne doit pas contenir plus de 50 caractères.",
	}),
  email: Joi.string().email().required().messages({
		"string.empty": "Email est requis.",
		"string.email": "Email doit être valide.",
	}),
  phone: Joi.string()
		.pattern(/^[0-9\s()+-]{7,20}$/)
		.required()
		.messages({
			"string.empty": "Numéro de téléphone requis.",
			"string.pattern.base":
				"Numéro de téléphone invalide (7 à 20 chiffres, espaces, +, - ou parenthèses autorisés).",
		}),
	password: Joi.string().min(8).required().messages({
		"string.empty": "Mot de passe requis.",
		"string.min": "Mot de passe doit contenir au moins 8 caractères.",
	}),
});

const loginSchema = Joi.object({
    email: Joi.string().required().messages({
		    "string.empty": "Email est requis.",
	  }),
    password: Joi.string().required().messages({
        "string.empty": "Mot de passe requis."
    })
})

export { registerSchema, loginSchema };
