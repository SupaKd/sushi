import { useState } from "react";
import { useDispatch } from "react-redux";
import { login } from "../../../features/authSlice";
import { useNavigate } from "react-router-dom";

function UpdateUserModal({ userInfos, onClose }) {
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    alias: userInfos.alias || "",
    email: userInfos.email || "",
    phone: userInfos.phone || "",
  });

  const [message, setMessage] = useState("");

  function handleChange(e) {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  }

  async function handleSubmit(e) {
    e.preventDefault();

    try {
      const res = await fetch("http://localhost:9000/api/v1/user", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify(formData),
      });

      if (res.ok) {
        const refreshRes = await fetch(
          "http://localhost:9000/api/v1/auth/refresh-login",
          {
            method: "POST",
            credentials: "include",
          }
        );

        if (refreshRes.ok) {
          const { user } = await refreshRes.json();
          dispatch(login(user));
        }

        onClose(); // Ferme la modale
        navigate("/"); // Redirige si souhaité
      } else {
        setMessage("Échec de la mise à jour.");
      }
    } catch (err) {
      setMessage("Une erreur est survenue.");
    }
  }

  return (
    <div className="modal-overlay">
      <div className="modal">
        <h2>Modifier mes informations</h2>
        {message && <p className="error">{message}</p>}

        <form onSubmit={handleSubmit}>
          <label>
            Prénom
            <input
              type="text"
              name="alias"
              value={formData.alias}
              onChange={handleChange}
            />
          </label>

          <label>
            Email
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
            />
          </label>

          <label>
            Téléphone
            <input
              type="tel"
              name="phone"
              value={formData.phone}
              onChange={handleChange}
            />
          </label>

          <div className="modal-buttons">
            <button type="submit">Enregistrer</button>
            <button type="button" onClick={onClose}>Annuler</button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default UpdateUserModal;
