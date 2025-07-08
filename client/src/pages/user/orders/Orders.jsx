import { useEffect, useState } from "react";

function Orders() {
  const [orders, setOrders] = useState(null);
  const [error, setError] = useState("");


  useEffect(() => {
    async function fetchOrders() {
      try {
        const res = await fetch("http://localhost:9000/api/v1/order", {
          headers: { "Content-Type": "application/json" },
          credentials: "include",
        });

        if (res.ok) {
          const data = await res.json();
          setOrders(data.orders);
        } else {
          setOrders([]);
          setError("Impossible de récupérer les commandes.");
        }
      } catch (err) {
        setOrders([]);
        setError("Une erreur est survenue lors du chargement.");
      }
    }

    fetchOrders();
  }, []);

  if (orders === null) return <p>Chargement des commandes...</p>;
  if (error) return <p className="error">{error}</p>;

  return (
    <main className="orders">
      <h2>Historique des commandes</h2>
      {orders.length > 0 ? (
        <table>
          <thead>
            <tr>
              <th>Numéro</th>
              <th>Date</th>
              <th>Total</th>
              <th>Statut</th>
            </tr>
          </thead>
          <tbody>
            {orders.map((order) => (
              <tr key={order.id}>
                <td>{order.id}</td>
                <td>{new Date(order.created_at).toLocaleDateString()}</td>
                <td>{order.total_price} €</td>
                <td>{order.status}</td>
                
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>Aucune commande trouvée.</p>
      )}
    </main>
  );
}

export default Orders;
