// UI pour afficher dynamiquement le nombre de produit dans le panier
import { useDispatch } from "react-redux";
import PropTypes from "prop-types";

import { addToCart } from "../features/cartSlice";

function AddToCartBtn({ product }) {
  const dispatch = useDispatch();

  function handleProductToAdd() {
    const tmp = {
      id: product.id,
      name: product.name,
      unit_price: parseFloat(product.price),
      image_url: product.image_urls ? product.image_urls[0] : null,
    };
    dispatch(addToCart(tmp));
  }

  return (
    <button className="add" onClick={handleProductToAdd}>
      Ajouter au panier
    </button>
  );
}

AddToCartBtn.propTypes = {
  product: PropTypes.object.isRequired,
};

export default AddToCartBtn;
