import { useSelector, useDispatch } from "react-redux";
import { logout } from "../../../features/authSlice";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import UpdateUserModal from "../dashboard/UpdateUserModal";

function InfosUser() {
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { isLogged, infos } = useSelector((state) => state.user);
  const [showModal, setShowModal] = useState(false);

  function handleLogout() {
    dispatch(logout());
    navigate("/login");
  }

  if (!isLogged) {
    return <p>Veuillez vous connecter pour accéder au dashboard.</p>;
  }

  return (
    <main>
      <h1>Bienvenue, {infos.alias} 👋</h1>
      <p>Email : {infos.email}</p>
      <p>Téléphone : {infos.phone}</p>
      <p>Rôle : {infos.role}</p>

      <button onClick={() => setShowModal(true)}>Modifier mes infos</button>

      {infos.role === "admin" && (
        <section className="admin-section">
          <h2>Zone Administrateur 🛠</h2>
          <p>Ici, vous pouvez gérer les menus, les utilisateurs, etc.</p>
        </section>
      )}

      <button onClick={handleLogout} className="btn-logout">
        Se déconnecter
      </button>

      {showModal && (
        <UpdateUserModal
          userInfos={infos}
          onClose={() => setShowModal(false)}
        />
      )}
    </main>
  );
}

export default InfosUser;
