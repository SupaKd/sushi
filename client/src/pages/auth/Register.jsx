import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";

function Register() {
	const [alias, setAlias] = useState("");
	const [email, setEmail] = useState("");
	const [phone, setPhone] = useState("");
	const [password, setPassword] = useState("");
	const [message, setMessage] = useState("");

	const [isAliasValid, setIsAliasValid] = useState(false);
	const [isEmailValid, setIsEmailValid] = useState(false);
	const [isPhoneValid, setIsPhoneValid] = useState(false);
	const [isPasswordValid, setIsPasswordValid] = useState(false);

	const navigate = useNavigate();

	const minAliaslength = 3;
	const minPasswordlength = 6;

	function handleChangeAlias(e) {
		const value = e.target.value;
		setAlias(value);
		setIsAliasValid(value.length >= minAliaslength);
	}

	function handleChangeEmail(e) {
		const value = e.target.value;
		setEmail(value);
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		setIsEmailValid(emailRegex.test(value));
	}

	function handleChangePhone(e) {
		const value = e.target.value;
		setPhone(value);
		const phoneRegex = /^[0-9]{10}$/;
		setIsPhoneValid(phoneRegex.test(value));
	}

	function handleChangePassword(e) {
		const value = e.target.value;
		setPassword(value);
		setIsPasswordValid(value.length >= minPasswordlength);
	}

	async function handleSubmit(e) {
		e.preventDefault();

		if (isEmailValid && isPasswordValid && isAliasValid && isPhoneValid) {
			try {
				const response = await fetch("http://localhost:9000/api/v1/auth/register", {
					method: "POST",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify({
						alias,
						email,
						password,
						phone,
					}),
				});

				const result = await response.json();

				if (response.ok) {
					setMessage(result.msg);
					navigate("/login");
				} else {
					setMessage(result.errors || "Erreur serveur");
				}
			} catch (error) {
				setMessage("Erreur lors de l'inscription");
			}
		} else {
			setMessage("Erreur : Certains champs sont invalides !");
		}
	}

	return (
		<main className="register">
			<form className="register-form auth" onSubmit={handleSubmit}>
				<h2 className="register-title">Inscription</h2>

				<div className="register-group">
					<label htmlFor="alias">Nom :</label>
					<input
						type="text"
						id="alias"
						name="alias"
						value={alias}
						onChange={handleChangeAlias}
						required
					/>
				</div>

				<div className="register-group">
					<label htmlFor="phone">Numéro de téléphone :</label>
					<input
						type="tel"
						id="phone"
						name="phone"
						value={phone}
						onChange={handleChangePhone}
						required
					/>
				</div>

				<div className="register-group">
					<label htmlFor="email">Adresse mail :</label>
					<input
						type="email"
						id="email"
						name="email"
						value={email}
						onChange={handleChangeEmail}
						required
					/>
				</div>

				<div className="register-group">
					<label htmlFor="password">Mot de passe :</label>
					<input
						type="password"
						id="password"
						name="password"
						value={password}
						onChange={handleChangePassword}
						required
					/>
				</div>

				{message && <p style={{ color: "red" }}>{message}</p>}

				<button type="submit" className="register-button">
					Créer un compte
				</button>

				<p className="login-register">
					Déjà un compte ? <Link to="/login">Se connecter</Link>
				</p>
			</form>
		</main>
	);
}

export default Register;
