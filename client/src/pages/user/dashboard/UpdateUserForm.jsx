import { useState } from "react";
import { useSelector, useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import { login } from "../../../features/authSlice";

function UpdateUserForm() {
  const { infos } = useSelector((state) => state.auth);
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    alias: infos.alias || "",
    email: infos.email || "",
    phone: infos.phone || "",
  });

  const [message, setMessage] = useState("");

  function handleChange(e) {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  }

  async function handleSubmit(e) {
    e.preventDefault();
    const newFormData = {
      alias: formData.alias || null,
      email: formData.email || null,
      phone: formData.phone || null,
    };

    try {
      const res = await fetch("http://localhost:9000/api/v1/user", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        credentials: "include",
        body: JSON.stringify(newFormData),
      });

      if (res.ok) {
        const resRefreshToken = await fetch(
          "http://localhost:9000/api/v1/auth/refresh-login",
          {
            method: "POST",
            credentials: "include",
          }
        );

        if (resRefreshToken.ok) {
          const resJSON = await resRefreshToken.json();

          dispatch(login(resJSON.user));
        }

        navigate("/");
      } else {
        setMessage("Échec de la mise à jour. Veuillez réessayer.");
      }
    } catch (error) {
      setMessage("Une erreur s'est produite. Veuillez réessayer.");
    }
  };

  return (
    <main className="update">
      <h1>Modifier vos informations</h1>

      {message && <p>{message}</p>}

      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="alias">Prénom</label>
          <input
            type="text"
            id="alias"
            name="alias"
            value={formData.alias}
            onChange={handleChange}
          />
        </div>

        <div>
          <label htmlFor="phone">Téléphone</label>
          <input
            type="tel"
            id="phone"
            name="phone"
            value={formData.phone}
            onChange={handleChange}
          />
        </div>
        <button type="submit">Enregistrer les modifications</button>
      </form>
    </main>
  );
}

export default UpdateUserForm;
