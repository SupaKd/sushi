import { useSelector, useDispatch } from "react-redux";
import { logout } from "../../../features/authSlice";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import UpdateUserModal from "../dashboard/UpdateUserModal";

function Dashboard() {
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
    <main className="dashboard">
      <section>

      <h1>Bienvenue, {infos.alias} 👋</h1>
      <p>Email : {infos.email}</p>
      <p>Téléphone : {infos.phone}</p>

      <button className="show" onClick={() => setShowModal(true)}>Modifier mes infos</button>
      <button onClick={handleLogout} className="btn-logout">
        Se déconnecter
      </button>

      {showModal && (
        <UpdateUserModal
        userInfos={infos}
        onClose={() => setShowModal(false)}
        />
      )}
      </section>
    </main>
  );
}

export default Dashboard;
