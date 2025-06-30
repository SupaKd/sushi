// src/layout/Header.jsx
import { useState } from "react";
import { Link, NavLink } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faBarsStaggered,
  faXmark,
  faBasketShopping,
} from "@fortawesome/free-solid-svg-icons";

function Header() {
  const [isOpen, setIsOpen] = useState(false);
  const toggleMenu = () => setIsOpen((prev) => !prev);
  const closeMenu = () => setIsOpen(false);

  return (
    <header className="header">
      <Link
        className={`burger ${isOpen ? "rotate" : ""}`}
        onClick={toggleMenu}
        aria-label="Menu mobile"
        aria-expanded={isOpen}
      >
        <FontAwesomeIcon icon={isOpen ? faXmark : faBarsStaggered} />
      </Link>

      <Link to="/" onClick={closeMenu} className="logo-mobile">
        <img src="/logo/apple-touch-icon.png" alt="Logo" />
      </Link>
      <Link to="/" onClick={closeMenu} className="logo-desktop">
        <img src="/logo/apple-touch-icon.png" alt="Logo" />
      </Link>

      <div className="header-right">
        <Link to="/cart" end className="cart-link">
        <FontAwesomeIcon icon={faBasketShopping} />
        </Link>

        <nav
          className={`header-nav ${isOpen ? "show" : ""}`}
          aria-label="Navigation principale"
        >
          <NavLink to="/login" className="btn-login" onClick={closeMenu}>
            Connexion
          </NavLink>
          <NavLink to="/cart" className="btn-cart" onClick={closeMenu}>
            Panier
          </NavLink>
          <NavLink to="/story" className="btn-story" onClick={closeMenu}>
            Le restaurant
          </NavLink>
        </nav>
      </div>

    </header>
  );
}

export default Header;
