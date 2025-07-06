import AddToCartBtn from "./AddtoCartBtn";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faXmark } from "@fortawesome/free-solid-svg-icons";

function ProductModal({ product, onClose }) {
  if (!product) return null;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <button className="modal-close" onClick={onClose}>
          <FontAwesomeIcon icon={faXmark} />
        </button>
        <img
          src={`http://localhost:9000/${product.image_url}`}
          alt={product.name}
          className="modal-image"
        />
        <h2>{product.name}</h2>
        <p>{product.description}</p>
        <p>{product.price} €</p>
      </div>
    </div>
  );
}

export default ProductModal;
