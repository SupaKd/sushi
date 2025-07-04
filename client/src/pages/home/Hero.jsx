import { Link } from "react-router-dom";

function Hero() {
  return (
    <section className="hero">
      <div className="hero-overlay">
        <div className="hero-content">
          <h1 className="hero-title">Bienvenue chez Ksushi</h1>
          <p className="hero-subtitle">Fraîcheur. Qualité. Tradition japonaise.</p>
          <Link to="/cart" className="hero-button">Commander</Link>
        </div>
      </div>
    </section>
  );
}

export default Hero;
