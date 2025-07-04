import { useDispatch, useSelector } from "react-redux";
import { NavLink, useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faBarsStaggered,
  faXmark,
  faBasketShopping,
} from "@fortawesome/free-solid-svg-icons";

import { toggleMenu } from "../features/menuSlice";
import { logout } from "../features/authSlice";

function Header() {
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { isLogged } = useSelector((state) => state.auth);
  const { isMenuOpen } = useSelector((state) => state.menu);
  const cart = useSelector((state) => state.cart);
  const totalItems = cart.reduce((total, item) => total + item.quantity, 0);

  async function handleLogout() {
    const res = await fetch("http://localhost:9000/api/v1/auth/logout", {
      method: "POST",
      credentials: "include",
    });

    if (res.ok) {
      dispatch(logout());
      navigate("/");
    }
  }

  function handleClick() {
    dispatch(toggleMenu());
  }

  return (
    <header className="header">
      {/* Logo mobile */}
      <div className="logo-mobile">
        <NavLink to="/" end>
          <img src="logo/apple-touch-icon.png" alt="logo mobile" />
        </NavLink>
      </div>

      {/* Logo desktop */}
      <div className="logo-desktop">
        <NavLink to="/" end>
          <img src="logo/apple-touch-icon.png" alt="logo desktop" />
        </NavLink>
      </div>

      {/* Bouton burger */}
      <button
        className={`burger ${isMenuOpen ? "rotate" : ""}`}
        onClick={handleClick}
      >
        <FontAwesomeIcon icon={isMenuOpen ? faXmark : faBarsStaggered} />
      </button>

      {/* Navigation */}
      <nav className={`header-nav ${isMenuOpen ? "show" : ""}`}>
      
        <NavLink to="/story" end onClick={handleClick}>
          Le restaurant
        </NavLink>
        {!isLogged ? (
          <NavLink to="/login" end onClick={handleClick}>
            Connexion
          </NavLink>
        ) : (
          <>
            <NavLink to="/dashboard" end onClick={handleClick}>
              Profil
            </NavLink>
            <button className="logout" onClick={handleLogout}>Déconnexion</button>
          </>
        )}
      </nav>

      {/* Panier */}
      <div className="cart-link">
        <NavLink to="/cart" end>
          <FontAwesomeIcon icon={faBasketShopping} />
          {totalItems ? <span>({totalItems})</span> : null}
        </NavLink>
      </div>
    </header>
  );
}

export default Header;
