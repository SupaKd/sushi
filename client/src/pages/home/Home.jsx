import { useState } from "react";
import Hero from "../home/Hero";
import Product from "../home/Product";
import Category from "./Category";

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
