function OrderDetailModal({ order, onClose }) {
    if (!order) return null;
  
    return (
      <div className="modal-overlay">
        <div className="modal">
          <h3>Détails de la commande #{order.id}</h3>
          <p><strong>Date :</strong> {new Date(order.created_at).toLocaleDateString()}</p>
          <p><strong>Total :</strong> {order.total_price} €</p>
          <p><strong>Statut :</strong> {order.status}</p>
  
          <h4>Articles :</h4>
          <ul>
            {order.items?.map((item, index) => (
              <li key={index}>
                {item.name} × {item.quantity} – {item.price} €
              </li>
            ))}
          </ul>
  
          <button onClick={onClose}>Fermer</button>
        </div>
      </div>
    );
  }
  
  export default OrderDetailModal;
  