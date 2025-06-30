import { Link } from "react-router-dom";

function Register() {
  return (
    <div className="register">
      <form className="register-form">
        <h2 className="register-title">Inscription</h2>

        <section className="register-group">
          <label htmlFor="name">Nom :</label>
          <input type="text" id="name" name="name" required />
        </section>

        <section className="register-group">
          <label htmlFor="phone">Numéro de téléphone :</label>
          <input type="tel" id="phone" name="phone" required />
        </section>

        <section className="register-group">
          <label htmlFor="email">Adresse mail :</label>
          <input type="email" id="email" name="email" required />
        </section>

        <section className="register-group">
          <label htmlFor="password">Mot de passe :</label>
          <input type="password" id="password" name="password" required />
        </section>

        <button type="submit" className="register-button">
          Créer un compte
        </button>

        <p className="login-register">
          Déjà un compte ? <Link to="/login">Se connecter</Link>
        </p>
      </form>
    </div>
  );
}

export default Register;
