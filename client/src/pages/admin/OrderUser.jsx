import { useState, useEffect } from "react";
import { Link } from "react-router-dom";

function OrderUser() {
  const [orders, setOrders] = useState(null);
  const [orderDetail, setOrderDetail] = useState(null);

  // Fetch toutes les commandes
  async function fetchOrders() {
    try {
      const res = await fetch("http://localhost:9000/api/v1/admin/orders", {
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      });

      if (res.ok) {
        const data = await res.json();
        setOrders(data.orders);
      } else {
        setOrders([]);
      }
    } catch (error) {
      console.error("Erreur lors du chargement des commandes", error);
      setOrders([]);
    }
  }

  // Fetch les détails d'une commande
  async function handleGetDetail(orderId) {
    try {
      const res = await fetch(`http://localhost:9000/api/v1/admin/orders/${orderId}`, {
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      });

      if (res.ok) {
        const data = await res.json();
        setOrderDetail(data.order);
      } else {
        setOrderDetail(null);
        console.error("Erreur lors de la récupération des détails");
      }
    } catch (error) {
      console.error("Erreur réseau lors de la récupération des détails", error);
      setOrderDetail(null);
    }
  }

  // Modifier le statut d'une commande
  async function handleUpdateStatus(orderId, newStatus) {
    try {
      const res = await fetch(
        `http://localhost:9000/api/v1/admin/orders/${orderId}/status`,
        {
          method: "PUT",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ status: newStatus }),
          credentials: "include",
        }
      );

      if (res.ok) {
        setOrders((prevOrders) =>
          prevOrders.map((order) =>
            order.id === orderId ? { ...order, status: newStatus } : order
          )
        );
      } else {
        console.error("Erreur lors de la mise à jour du statut");
      }
    } catch (error) {
      console.error("Erreur réseau lors de la mise à jour", error);
    }
  }

  useEffect(() => {
    fetchOrders();
  }, []);

  if (!orders) return <p>Chargement des commandes...</p>;

  return (
    <main className="admin-dashboard">
      <h1>Dashboard Admin</h1>

      <section className="checkuser">
        <Link to={"checkuser"} className="cta">
          Consulter les utilisateurs
        </Link>
      </section>

      <section className="command-user">
        <h3>Commandes reçues</h3>

        {orders.length > 0 ? (
          <table>
            <thead>
              <tr>
                <th>Num.Com</th>
                <th>Commandé le</th>
                <th>Total</th>
                <th>Status</th>
                <th>Modifier Statut</th>
                <th>Détails</th>
              </tr>
            </thead>
            <tbody>
              {[...orders].reverse().map((order) => (
                <tr key={order.id}>
                  <td>{order.id}</td>
                  <td>{new Date(order.created_at).toLocaleDateString()}</td>
                  <td>{order.total_price} €</td>
                  <td>{order.status}</td>
                  <td>
                    <select
                      defaultValue={order.status}
                      onChange={(e) =>
                        handleUpdateStatus(order.id, e.target.value)
                      }
                    >
                      <option value="--">--</option>
                      <option value="pending">En attente</option>
                      <option value="paid">Payée</option>
                      <option value="cancelled">Annulée</option>
                    </select>
                  </td>
                  <td>
                    <button onClick={() => handleGetDetail(order.id)}>
                      Voir
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <p>Aucune commande trouvée.</p>
        )}
      </section>

      {orderDetail && (
        <section className="order-detail">
          <h3>Détails de la commande #{orderDetail.id}</h3>
          <p>Date : {new Date(orderDetail.created_at).toLocaleString()}</p>
          <p>Statut : {orderDetail.status}</p>
          <p>Total : {orderDetail.total_price} €</p>

          <h4>Produits commandés :</h4>
          <table>
            <thead>
              <tr>
                <th>ID Produit</th>
                <th>Nom</th>
                <th>Quantité</th>
                <th>Prix Unitaire</th>
              </tr>
            </thead>
            <tbody>
              {orderDetail.products.map((product) => (
                <tr key={product.id}>
                  <td>{product.id}</td>
                  <td>{product.label || product.name}</td>
                  <td>{product.quantity}</td>
                  <td>{product.unit_price} €</td>
                </tr>
              ))}
            </tbody>
          </table>

          <button onClick={() => setOrderDetail(null)}>Fermer les détails</button>
        </section>
      )}
    </main>
  );
}

export default OrderUser;

// Separer le ficher car trop long