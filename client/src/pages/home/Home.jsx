import { useState } from "react";
import Hero from "../home/Hero";
import Product from "../home/Product";
import Category from "./Category";

useEffect(() => {
  fetch("https://ksushiv1.onrender.com/ping")
    .then(res => res.text())
    .then(console.log)
    .catch(console.error);
}, []);


function Home() {
  const [selectedCategory, setSelectedCategory] = useState("all");

  return (
    <main className="home">
      <Hero />

      <section>
        <Category onSelectCategory={setSelectedCategory} />
      </section>

      <section>
        <Product selectedCategory={selectedCategory} />
      </section>
    </main>
  );
}

export default Home;
