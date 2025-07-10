import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faInstagram, faFacebook, faTiktok } from "@fortawesome/free-brands-svg-icons";
import { faPhone, faEnvelope, faLocationDot } from "@fortawesome/free-solid-svg-icons";

function Footer() {
  return (
    <footer className="footer">
      <section className="footer-wrapper">
        <div className="footer-section">
          <h3>Ksushi</h3>
          <p>Le meilleur du sushi à emporter ou sur place.</p>
        </div>

        <div className="footer-section">
          <h3>Contact</h3>
          <p><FontAwesomeIcon icon={faPhone} /> 06 12 34 56 78</p>
          <p><FontAwesomeIcon icon={faEnvelope} /> contact@ksushi.fr</p>
          <p><FontAwesomeIcon icon={faLocationDot} /> 12 rue du Japon, 75000 Paris</p>
        </div>

        <div className="footer-section">
          <h3>Suivez-nous</h3>
          <div className="footer-socials">
            <a href="instagram.com"><FontAwesomeIcon icon={faInstagram} /></a>
            <a href="#"><FontAwesomeIcon icon={faFacebook} /></a>
            <a href="#"><FontAwesomeIcon icon={faTiktok} /></a>
          </div>
        </div>
      </section>
      <div className="footer-bottom">
        <p>&copy; 2025 K Sushi. Powered by Supaco. Tous droits réservés.</p>
      </div>
    </footer>
  );
}

export default Footer;
