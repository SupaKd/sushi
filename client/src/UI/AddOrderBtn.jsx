import { useNavigate } from "react-router-dom";
import { useDispatch } from "react-redux";
import { clearCart } from "../features/cartSlice.js";

function AddOrderBtn({ cart, isLogged }) {
  const navigate = useNavigate();
  const dispatch = useDispatch();

  const total_price = cart.reduce(
    (total, product) => total + product.unit_price * product.quantity,
    0
  );

  async function handlePlaceOrder() {
    try {
      if (!isLogged) {
        navigate("/login");
        return;
      }

      const order = {
        total_price,
        products: cart,
      };

      const response = await fetch("http://localhost:9000/api/v1/order", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify(order),
      });

      if (response.ok) {
        dispatch(clearCart());
        navigate("/");
      } else {
        console.error("La commande a échoué.");
      }
    } catch (error) {
      console.error("Erreur lors de la commande :", error);
    }
  }

  return (
    <button onClick={handlePlaceOrder} className="btn-order">
      Commander
    </button>
  );
}

export default AddOrderBtn;
