import React from "react";

function Story() {
  return (
    <section className="story">
      <div className="story-container">
        <h2 className="story-title">Notre Histoire</h2>
        <p className="story-text">
          Depuis notre ouverture, nous nous engageons à offrir une expérience culinaire unique, mêlant tradition japonaise et fraîcheur des produits. Chaque plat est préparé avec soin par notre chef passionné.
        </p>
        <img
          className="story-image"
          src="/img-login.webp"
          alt="Chef en train de préparer des sushis"
        />
      </div>
    </section>
  );
}

export default Story;
