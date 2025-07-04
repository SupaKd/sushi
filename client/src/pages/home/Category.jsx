import { useEffect, useState } from "react";

function Category({ onSelectCategory }) {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [active, setActive] = useState("all");

  useEffect(() => {
    async function fetchCategories() {
      try {
        const res = await fetch("http://localhost:9000/api/v1/category");
        if (res.ok) {
          const { datas } = await res.json();
          setCategories(datas);
        }
      } catch (error) {
        console.error("Erreur lors du chargement des catégories :", error);
      } finally {
        setLoading(false);
      }
    }

    fetchCategories();
  }, []);

  const handleClick = (categoryId) => {
    setActive(categoryId);
    onSelectCategory(categoryId);
  };

  if (loading) return <p>Chargement des catégories...</p>;

  return (
    <section className="categorie">
      <h2>Nos Produits</h2>
      <div className="categorie-buttons">
        <button
          className={active === "all" ? "active" : ""}
          onClick={() => handleClick("all")}
        >
          Tous
        </button>

        {categories.map((cat) => (
          <button
            key={cat.id}
            className={active === cat.id ? "active" : ""}
            onClick={() => handleClick(cat.id)}
          >
            {cat.name}
          </button>
        ))}
      </div>
    </section>
  );
}

export default Category;
