import { useEffect, useState } from "react";
import AddToCartBtn from "../../UI/AddtoCartBtn";
import ProductModal from "../../UI/ProductModal";

function Product({ selectedCategory }) {
  const [products, setProducts] = useState(null);
  const [selectedProduct, setSelectedProduct] = useState(null); 

  useEffect(() => {
    async function fetchProducts() {
      try {
        const res = await fetch("https://ksushi.onrender.com/api/v1/product");
        if (res.ok) {
          const { datas } = await res.json();
          setProducts(datas);
        }
      } catch (error) {
        console.error("Erreur lors du chargement des produits :", error);
      }
    }

    fetchProducts();
  }, []);

  function handleImage(product) {
    if (product.image_url) {
      return `http://localhost:9000/${product.image_url.replace(/^\/?/, '')}`;
    }
    return null;
  }

  const filteredProducts =
    selectedCategory === "all"
      ? products
      : products?.filter((product) => product.category_id === selectedCategory);

  if (!filteredProducts) return <p>Chargement des produits...</p>;
  if (filteredProducts.length === 0) return <p>Aucun produit trouvé.</p>;

  return (
    <>
      <section className="product">
        {filteredProducts.map((product) => (
          <article
            key={product.id}
            className="product-card"
          >
            {handleImage(product) ? (
              <img
                src={handleImage(product)}
                alt={product.name}
                className="product-image"
                onClick={() => setSelectedProduct(product)} 
              />
            ) : (
              <div className="no-image">Aucune image</div>
            )}

            <h3 className="product-name">{product.name}</h3>
            <p className="product-description">{product.description}</p>
            <p className="product-price">{product.price} €</p>
            <AddToCartBtn product={product} />
          </article>
        ))}
      </section>

      {/* Modal */}
      {selectedProduct && (
        <ProductModal
          product={selectedProduct}
          onClose={() => setSelectedProduct(null)}
        />
      )}
    </>
  );
}

export default Product;
