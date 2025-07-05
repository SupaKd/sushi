import { useState, useEffect } from "react";

function InfoUser() {
  const [users, setUsers] = useState(null);
  const [message, setMessage] = useState("");

  // Charger les utilisateurs
  async function fetchUsers() {
    try {
      const res = await fetch("http://localhost:9000/api/v1/admin/user", {
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      });

      if (res.ok) {
        const data = await res.json();
        setUsers(data.users || data.datas); // selon ta réponse backend
        setMessage("");
      } else {
        const err = await res.json();
        setMessage(err.error || "Erreur lors du chargement des utilisateurs");
        setUsers([]);
      }
    } catch (error) {
      console.error("Erreur réseau", error);
      setMessage("Impossible de charger les utilisateurs.");
      setUsers([]);
    }
  }

  useEffect(() => {
    fetchUsers();
  }, []);

  if (!users) return <p>Chargement des utilisateurs...</p>;

  return (
    <main className="admin-users">
      <h1>Utilisateurs enregistrés</h1>

      {message && <p style={{ color: "red" }}>{message}</p>}

      {users.length > 0 ? (
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nom</th>
              <th>Email</th>
              <th>Téléphone</th>
              <th>Inscription</th>
            </tr>
          </thead>
          <tbody>
            {[...users].reverse().map((user) => (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.alias}</td>
                <td>{user.email}</td>
                <td>{user.phone}</td>
                <td>{new Date(user.created_at).toLocaleDateString()}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>Aucun utilisateur trouvé.</p>
      )}
    </main>
  );
}

export default InfoUser;
