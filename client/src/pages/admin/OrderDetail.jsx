import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faXmark } from "@fortawesome/free-solid-svg-icons";

function OrderDetail({ order, onClose }) {
  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <button className="close-button" onClick={onClose}>
          <FontAwesomeIcon icon={faXmark} />
        </button>

        <h3>Détails de la commande #{order.id}</h3>
        <p>Date : {new Date(order.created_at).toLocaleString()}</p>
        <p>Statut : {order.status}</p>
        <p>Total : {order.total_price} €</p>

        <h4>Produits commandés :</h4>
        <table>
          <thead>
            <tr>
              <th>Nom</th>
              <th>Quantité</th>
              <th>Prix Unitaire</th>
            </tr>
          </thead>
          <tbody>
            {order.products.map((product) => (
              <tr key={product.id}>
                <td>{product.label || product.name}</td>
                <td>{product.quantity}</td>
                <td>{product.unit_price} €</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default OrderDetail;
