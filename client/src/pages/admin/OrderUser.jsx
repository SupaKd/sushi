import { useState, useEffect } from "react";
import OrderDetail from "./OrderDetail";

function OrderUser() {
  const [orders, setOrders] = useState(null);
  const [orderDetail, setOrderDetail] = useState(null);

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
    <main className="admin-orders">
      <h1>Dashboard Admin</h1>

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
        <OrderDetail order={orderDetail} onClose={() => setOrderDetail(null)} />
      )}
    </main>
  );
}

export default OrderUser;
