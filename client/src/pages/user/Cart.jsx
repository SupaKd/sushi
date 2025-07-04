import { useDispatch, useSelector } from "react-redux";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  removeFromCart,
  clearCart,
  addToCart,
  decrementQuantity,
} from "../../features/cartSlice.js";
import { faXmark, faPlus, faMinus } from "@fortawesome/free-solid-svg-icons";
import AddOrderBtn from "../../UI/AddOrderBtn.jsx";

function Cart() {
  const dispatch = useDispatch();
  const { isLogged } = useSelector((state) => state.auth);
  const cart = useSelector((state) => state.cart);
  const totalItems = cart.reduce(
    (total, product) => total + product.unit_price * product.quantity,
    0
  );

  function handleClearCart() {
    dispatch(clearCart());
  }

  return (
    <main className="cart">
      {cart.length ? (
        <>
          <section>
            <button className="remove" onClick={handleClearCart}>
              <FontAwesomeIcon icon={faXmark} />
            </button>
            {cart.map((product) => (
              <article key={product.id}>
                <h3>{product.name}</h3>
                <div>
                  <p> Prix unitaire : {product.unit_price}€</p>
                  <button
                    onClick={() => dispatch(decrementQuantity(product.id))}
                  >
                    <FontAwesomeIcon icon={faMinus} />
                  </button>
                  <span>{product.quantity}</span>
                  <button onClick={() => dispatch(addToCart(product))}>
                    <FontAwesomeIcon icon={faPlus} />
                  </button>
                </div>
                <p>Total : {product.unit_price * product.quantity}€</p>
                <button onClick={() => dispatch(removeFromCart(product.id))}>
                  Retirer du panier
                </button>
              </article>
            ))}
            <AddOrderBtn cart={cart} isLogged={isLogged} />

            <p>Montant de la commande : {totalItems}€</p>
          </section>
        </>
      ) : (
        <p>Votre panier est vide</p>
      )}
    </main>
  );
}

export default Cart;
