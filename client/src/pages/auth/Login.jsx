import { Link } from "react-router-dom";

function Login() {
  return (
    <main className="login">
      <form className="login-form">
        <h2 className="login-title">Connexion</h2>

        <section className="login-group">
          <label htmlFor="email">Email :</label>
          <input type="email" id="email" name="email" required />
        </section>

        <section className="login-group">
          <label htmlFor="password">Mot de passe :</label>
          <input type="password" id="password" name="password" required />
        </section>

        <button type="submit" className="login-button">
          Se connecter
        </button>

        <p className="login-register">
          Pas encore enregistré ? <Link to="/register">Cliquez ici</Link>
        </p>
      </form>
      <img src="/img-login.webp" alt="img-login" />
    </main>
  );
}

export default Login;
