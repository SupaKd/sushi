import { useRef, useState } from "react";
import { useDispatch } from "react-redux";
import { Link, useNavigate } from "react-router-dom";

import { login } from "../../features/authSlice";

function Login() {
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const emailRef = useRef();
  const passRef = useRef();

  const [message, setMessage] = useState("");

  async function handleSubmit(e) {
    e.preventDefault();
    const email = emailRef.current.value;
    const password = passRef.current.value;

    if (email.length && password.length) {
      const res = await fetch("http://localhost:9000/api/v1/auth/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify({ email, password }),
      });

      const resJSON = await res.json();

      if (!res.ok) {
        setMessage(resJSON.msg || "Erreur de connexion");
        return;
      }

      setMessage("");
      dispatch(login(resJSON.user));
      navigate("/");
    } else {
      setMessage("Identifiants requis");
    }
  }

  return (
    <main className="login">
      <form onSubmit={handleSubmit} className="login-form auth">
        <h1 className="login-title">Connexion</h1>

        <div className="login-group">
          <label htmlFor="email">Email</label>
          <input
            type="email"
            id="email"
            ref={emailRef}
            placeholder="Entrer votre email"
          />
        </div>

        <div className="login-group">
          <label htmlFor="password">Mot de passe</label>
          <input
            type="password"
            id="password"
            ref={passRef}
            placeholder="Entrer votre mot de passe"
          />
        </div>

        {message && <p style={{ color: "red" }}>{message}</p>}

        <button type="submit" className="login-button">
          Se connecter
        </button>
        <p className="login-register">
          Pas de compte ? <Link to="/register">Créer un compte</Link>
        </p>
      </form>

      <img src="img-login.webp" alt="login" />
    </main>
  );
}

export default Login;
