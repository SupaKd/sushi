import React from "react";

function Story() {
  return (
    <main className="story">
      <div className="story-container">
        <h2 className="story-title">Notre Histoire</h2>

        <div className="story-block">
          <img
            className="story-image"
            src="/img-login.webp"
            alt="Chef en train de préparer des sushis"
          />
          <p className="story-text">
            Depuis notre ouverture à Oyonnax, notre objectif est de faire découvrir la richesse et la finesse de la cuisine japonaise à travers des plats authentiques, réalisés chaque jour avec des produits frais, locaux et de saison.
          </p>
        </div>

        <div className="story-block reverse">
          <img
            className="story-image"
            src="/img-login.webp"
            alt="L'équipe du restaurant"
          />
          <div>
            <h3 className="story-subtitle">Une équipe passionnée</h3>
            <p className="story-text">
              Notre équipe est composée de passionnés de la gastronomie nippone. Chaque membre apporte sa touche personnelle, tout en respectant les techniques traditionnelles japonaises.
            </p>
          </div>
        </div>

        <div className="story-block">
        <img
            className="story-image"
            src="/img-login.webp"
            alt="Table garnie de sushis"
          />
          <div>
            <h3 className="story-subtitle">Notre mission</h3>
            <p className="story-text">
              Offrir une expérience culinaire unique, chaleureuse et authentique, à emporter ou sur place, dans un cadre moderne et accueillant. Nous croyons que bien manger, c’est aussi bien partager.
            </p>
          </div>
          
        </div>

        <div className="story-values">
          <h3 className="story-subtitle">Nos valeurs</h3>
          <ul>
            <li>🍣 Qualité et fraîcheur des produits</li>
            <li>👨‍🍳 Savoir-faire artisanal et rigueur</li>
            <li>💛 Accueil chaleureux et service attentif</li>
            <li>🌱 Engagement envers une cuisine responsable</li>
          </ul>
        </div>
      </div>
    </main>
  );
}

export default Story;
