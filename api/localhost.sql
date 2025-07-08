-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : mar. 08 juil. 2025 à 08:13
-- Version du serveur : 8.0.40
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `belli`
--
CREATE DATABASE IF NOT EXISTS `belli` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `belli`;

-- --------------------------------------------------------

--
-- Structure de la table `Categories`
--

CREATE TABLE `Categories` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Categories`
--

INSERT INTO `Categories` (`id`, `label`) VALUES
(1, 'Burger'),
(2, 'Tacos'),
(3, 'Tex-Mex'),
(5, 'Desserts');

-- --------------------------------------------------------

--
-- Structure de la table `Images`
--

CREATE TABLE `Images` (
  `id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Images`
--

INSERT INTO `Images` (`id`, `product_id`, `url`, `is_primary`) VALUES
(1, 2, '/uploads/images/qwc9tq6pbyf0sr56ut8nsz730.webp', 1);

-- --------------------------------------------------------

--
-- Structure de la table `OrderProducts`
--

CREATE TABLE `OrderProducts` (
  `id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `quantity` smallint UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `OrderProducts`
--

INSERT INTO `OrderProducts` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(2, 2, 2, 2, 50.00),
(3, 3, 2, 2, 50.00);

-- --------------------------------------------------------

--
-- Structure de la table `Orders`
--

CREATE TABLE `Orders` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `status` enum('pending','ready_for_pickup','collected','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  `total_price` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `pickup_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Orders`
--

INSERT INTO `Orders` (`id`, `user_id`, `status`, `total_price`, `created_at`, `pickup_datetime`) VALUES
(2, 2, 'pending', 99.99, '2025-05-23 13:32:55', '2025-05-25 14:30:00'),
(3, 2, 'pending', 99.99, '2025-05-23 13:35:27', '2025-05-25 14:30:00');

-- --------------------------------------------------------

--
-- Structure de la table `Products`
--

CREATE TABLE `Products` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `availability` enum('available','out_of_stock') NOT NULL DEFAULT 'available',
  `category_id` int UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Products`
--

INSERT INTO `Products` (`id`, `label`, `description`, `price`, `availability`, `category_id`, `created_at`) VALUES
(2, 'Tacos Chévre miel', 'chevre miel', 7.50, 'available', 2, '2025-05-23 11:27:52');

-- --------------------------------------------------------

--
-- Structure de la table `Users`
--

CREATE TABLE `Users` (
  `id` int UNSIGNED NOT NULL,
  `firstname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'user',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Users`
--

INSERT INTO `Users` (`id`, `firstname`, `lastname`, `phone`, `email`, `password`, `role`, `created_at`) VALUES
(2, 'kd', 'supa', '0700000000', 'supa@kd.com', '$2b$10$WiXUBshzqzaVaMdPvZopm.NMbMgkCRz4tiZYfEsZMU6HghB/DNw7.', 'admin', '2025-05-23 10:48:52'),
(3, 'leo', 'supa', '0700000000', 'supa@leo.com', '$2b$10$vIn5Ka9E12nkHvCb/ngrEOHvT9khnGLfdLUiAa99uzUAG3WI4v0Va', 'user', '2025-05-23 10:49:09'),
(6, 'supa', 'ks', '1212121212', 'leo@supa.com', '$2b$10$KcK8D1amm/bn.Jvok9O5sOQTYPJgwjl.L5TzoAj.DGSlrG78bt5Wu', 'user', '2025-05-23 20:30:52'),
(8, 'supa', 'dsfsedf', '2342343333', 'sd@ewfwe.com', '$2b$10$WDdRl7/eyR4cI9y8jXj/t.gnVavbRPw.oJlK8DpWUYIZEL8/Mt/S.', 'user', '2025-05-23 20:32:36'),
(9, 'dfgdgdg', 'fdgreg', '1212122122', 'dsf@wefwe.com', '$2b$10$CzZan1ETKU9UEStxa4WqS.OY.4vlD/YQcW.dq0aV99QgC05ukacHu', 'user', '2025-05-23 20:33:22'),
(10, 'Michel', 'Lerat', '0601020304', 'Mlerqt@gmail.com', '$2b$10$3i/2aaFT014EyD//wAxxXu6N7gwkjOVRcPyWP7cl/1J8e/Lp1wMt6', 'user', '2025-05-23 22:36:11'),
(11, 'Soso', 'soso', '3423523532', 'soso@soso.com', '$2b$10$WBgOnVqckbxssBdAfl7XOu1shCB8Cd9jJ/pOFlz4J.Y5hYQHimlPi', 'user', '2025-06-12 22:07:07');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Images`
--
ALTER TABLE `Images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `OrderProducts`
--
ALTER TABLE `OrderProducts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `Images`
--
ALTER TABLE `Images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `OrderProducts`
--
ALTER TABLE `OrderProducts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Products`
--
ALTER TABLE `Products`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Images`
--
ALTER TABLE `Images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `OrderProducts`
--
ALTER TABLE `OrderProducts`
  ADD CONSTRAINT `orderproducts_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderproducts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`) ON DELETE SET NULL;
--
-- Base de données : `bellifood`
--
CREATE DATABASE IF NOT EXISTS `bellifood` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bellifood`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'NOUVEAUTÉS'),
(10, 'NOS TACOS SIGNATURES'),
(11, 'NOS BURGERS SIGNATURES'),
(12, 'NOS TACOS À COMPOSER'),
(13, 'NOS BURGERS'),
(14, 'NOS SANDWICHS'),
(15, 'NOS TEX-MEX'),
(16, 'NOS SALADES'),
(17, 'PETITE FAIM'),
(18, 'NOS DESSERTS'),
(19, 'NOS BOISSONS');

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` enum('pending','confirmed','preparing','delivered','cancelled') DEFAULT 'pending',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`, `category_id`) VALUES
(1, 'SAVOYARD', 'TACOS SAVOYARD', 5.00, '/uploads/images/ffgu82yorcd7n8w9ob97l6ht7.webp', 10),
(2, 'TACOS CHÈVRE MIEL', 'TACOS CHÈVRE MIEL', 5.00, '/uploads/images/idfxe6j3phodj5ff2vwp0yznj.webp', 10);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `alias` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `alias`, `email`, `password`, `phone`, `role`, `created_at`) VALUES
(1, 'supa', 'supa@kd.com', '$2b$10$te5npGcRY6HBHYZP4qld2.6.w9gq78wjwdTR79bpb5O.t4u0asmga', '0600000000', 'admin', '2025-05-13 11:49:46'),
(2, 'client', 'client@gmail.com', '$2b$10$7/yRFwedHS09kwjvlQaDFOTvtaAEB88IDETP/kl/oHjfIyntEOGzy', '0600000000', 'user', '2025-05-13 12:35:24'),
(3, 'kevin', 'supa@kevin.com', '$2b$10$1eJoSFcxKRXHLkF/hClpBOhRMA80/6f3NEeWZVWxYbD6DEb2FCO/O', '0611111111', 'user', '2025-05-13 13:07:56');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
--
-- Base de données : `fsjs44_country`
--
CREATE DATABASE IF NOT EXISTS `fsjs44_country` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `fsjs44_country`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

CREATE TABLE `article` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(300) NOT NULL,
  `long_content` text NOT NULL,
  `short_content` varchar(300) NOT NULL,
  `publish_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` char(5) NOT NULL DEFAULT 'admin',
  `country_id` int UNSIGNED DEFAULT NULL,
  `recipe_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`id`, `title`, `long_content`, `short_content`, `publish_date`, `author`, `country_id`, `recipe_id`) VALUES
(1, 'Présentation du site', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus. Optio, fuga eligendi aspernatur consequatur ad praesentium ea labore vitae similique earum quos enim, quaerat possimus quas beatae qui accusantium eius cum neque officia molestiae? Repudiandae libero eligendi incidunt error ut similique tempora ab? Id, corporis modi suscipit illo quod, repellat error esse, quasi incidunt tempora praesentium corrupti laudantium molestias vitae eos rerum libero asperiores quaerat atque explicabo minima iure cum unde cumque! Quaerat iste minus recusandae a dolore dolorum sapiente dolorem id, culpa, fugit veritatis consectetur molestias eveniet distinctio voluptates quas aliquid doloremque eligendi, exercitationem maiores? Excepturi maiores, autem cum nihil enim eaque perferendis quae? Ratione consequatur blanditiis modi molestias, inventore dignissimos tempore suscipit adipisci distinctio consectetur laudantium dolorem autem itaque eum! Enim nesciunt explicabo nihil expedita perferendis maiores sequi quis, mollitia minima, exercitationem vel, accusantium nemo. Debitis culpa, et hic, autem ullam iusto enim, maxime deleniti quod nemo minus ducimus optio repellat ipsum illo saepe voluptate voluptatibus dolor nam a? Porro eos excepturi natus. Similique id rerum labore fugit soluta nostrum tenetur laborum sunt aliquam ipsum provident ut sit blanditiis libero atque doloremque cupiditate nesciunt eligendi repudiandae, incidunt aperiam? Deserunt, odio, nisi consequatur a ad fugiat culpa vitae voluptas distinctio magni, animi quam facere optio? Sunt vitae dolor ratione sit, ipsa, accusantium amet illo odio architecto impedit possimus aut facere eaque ea voluptatibus et dolore, magni nihil nesciunt animi officiis! Placeat magni possimus exercitationem rerum aut dolore ducimus odit, iste quae alias dolores optio adipisci ipsa aspernatur accusantium? Quas eos pariatur repellat tempora consectetur perferendis ipsam maiores natus! Consectetur quisquam quia ipsum. Porro harum dolorem quia tempora excepturi iusto dolor reprehenderit unde facere nobis sed, corporis, exercitationem quidem, natus delectus optio animi quae. Eaque iure necessitatibus temporibus incidunt, culpa quidem tenetur eveniet, qui quibusdam optio explicabo commodi, reiciendis recusandae. Explicabo quo, odit consequuntur iusto amet saepe officia architecto nulla fugiat, aliquam laboriosam, cum perferendis quaerat repellat veniam consequatur labore? Ut, numquam. Laboriosam exercitationem cupiditate velit distinctio id nulla dolorum quis recusandae nobis at. Dignissimos quia sit sed mollitia illum praesentium cupiditate distinctio? Dolores qui cum saepe dolor. Sunt officiis deleniti, est quae nobis ratione aperiam, totam mollitia temporibus necessitatibus nostrum eligendi fuga quis eaque unde natus rem! Provident voluptate maiores neque architecto sapiente dolorum ex distinctio commodi expedita ad aliquam minima earum fugit voluptatem maxime voluptatum vitae corporis incidunt praesentium perferendis cum, a doloremque eligendi amet! Officiis, ducimus magni cumque consequuntur reiciendis est rem vitae labore minus harum distinctio repellendus tempore temporibus dolorum saepe asperiores molestias, sit perferendis porro! Numquam corrupti nobis ex soluta quam adipisci quod repellendus assumenda sequi autem, quidem nam omnis esse dicta rerum doloribus qui? Odit vero dolor eaque obcaecati iste veniam nesciunt, odio culpa ipsa repellat inventore sunt, nulla, voluptatibus non cumque placeat! Magnam saepe consectetur sunt blanditiis. Sunt distinctio, sequi aspernatur enim placeat deserunt velit. Consectetur eius quod ratione et ipsum, consequatur ad velit, minus rem rerum delectus libero vitae voluptate veritatis officiis. Illo impedit voluptatibus neque rerum et nisi! Itaque quisquam sapiente, eligendi veritatis facere harum nostrum quae, non, deleniti porro minus explicabo deserunt? At dolore error omnis quo doloribus accusamus reprehenderit qui in cumque expedita nihil illum commodi neque, ipsa dolor aut quos. Optio animi vero accusamus cumque praesentium illo sit. Accusantium odio possimus, cumque excepturi aspernatur harum quia? Itaque harum quis molestiae dignissimos quisquam minus tempora! Saepe, alias nemo. Consequatur officiis tenetur praesentium eum alias assumenda illum sed laudantium maxime itaque quidem sequi, ipsam, veritatis sapiente architecto ex, placeat non quae beatae. Consequatur, quis! Nostrum explicabo accusamus corporis mollitia quod tempore maiores eaque? Nam vitae itaque dicta autem! Dolor quam velit ipsum tempore maiores repellendus alias beatae sit! Iste et reiciendis iusto aspernatur maxime exercitationem deleniti voluptates perferendis, tempore delectus libero necessitatibus non labore sed culpa quisquam, adipisci consectetur, ad soluta voluptatum autem dolore expedita provident sit? Fugiat explicabo molestiae saepe eum reprehenderit? Culpa ratione repellat eveniet, soluta temporibus totam nisi error, exercitationem dolor porro corrupti vitae quasi est atque nam magni! Nemo odio quisquam delectus pariatur? Consectetur, aliquam inventore! Possimus optio assumenda voluptatem, voluptas sint omnis sed impedit quia quaerat doloribus quod dolores mollitia et inventore, dolore a illo voluptatibus itaque beatae. Ex perferendis dicta aliquam deleniti vero debitis voluptatum corrupti nihil hic, nesciunt porro? Ullam minus explicabo nostrum tempore. Natus eius mollitia ratione eligendi sit dolorem, quia provident similique et. Nesciunt, voluptas explicabo et maxime perspiciatis, perferendis officia repellendus est nostrum sequi possimus repellat, ducimus porro tenetur error vel reprehenderit maiores voluptates? Aspernatur mollitia, quia necessitatibus, repellendus, quos veritatis libero beatae quaerat est quidem sapiente et! Velit, earum saepe error natus excepturi quos asperiores a sint doloremque repellat eum laboriosam libero laudantium rerum iusto suscipit ipsum atque dolores, illo quas voluptatem exercitationem placeat? Quasi nostrum, iste sit nam necessitatibus cumque optio molestias, pariatur aliquam fugiat magni aperiam corporis, hic dolorem? Omnis iusto inventore tempore nulla consectetur nemo quasi asperiores unde, quod beatae amet accusantium modi eligendi dignissimos! Exercitationem quam fugiat assumenda molestiae aut illum nihil laudantium ullam incidunt debitis adipisci, quos rerum atque aspernatur totam asperiores odit tempora vitae! Rem tempore iusto, voluptates ipsa est, harum, dignissimos corporis delectus exercitationem adipisci ex nobis quidem quae ea nostrum fugit commodi animi! Facilis sit error ut deleniti et eum, officia illum eos consequuntur aspernatur sed cumque laborum officiis eaque corrupti dolor cupiditate expedita sunt porro vitae assumenda doloremque harum. Voluptas esse maxime vitae quia consequatur mollitia est! Voluptatibus aliquid soluta nulla rem eligendi! Dolorem, voluptatibus doloremque minima corporis a mollitia modi, accusamus corrupti impedit voluptatum, maiores id quaerat distinctio. Blanditiis placeat voluptates nemo magni consequatur, iure, explicabo reiciendis tempore quaerat natus perferendis earum? Corporis nemo eius officia sit non repellat dolore hic aspernatur accusantium dolor repudiandae iste doloremque magni repellendus accusamus quaerat reprehenderit esse maxime, commodi vel similique numquam. Tempora cum, sequi dignissimos quam ea rem. Voluptate eum blanditiis molestias quae ratione ipsam repellendus ducimus recusandae repudiandae.', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus.', '2024-12-28 21:26:07', 'admin', NULL, NULL),
(2, 'France et Raclette', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus. Optio, fuga eligendi aspernatur consequatur ad praesentium ea labore vitae similique earum quos enim, quaerat possimus quas beatae qui accusantium eius cum neque officia molestiae? Repudiandae libero eligendi incidunt error ut similique tempora ab? Id, corporis modi suscipit illo quod, repellat error esse, quasi incidunt tempora praesentium corrupti laudantium molestias vitae eos rerum libero asperiores quaerat atque explicabo minima iure cum unde cumque! Quaerat iste minus recusandae a dolore dolorum sapiente dolorem id, culpa, fugit veritatis consectetur molestias eveniet distinctio voluptates quas aliquid doloremque eligendi, exercitationem maiores? Excepturi maiores, autem cum nihil enim eaque perferendis quae? Ratione consequatur blanditiis modi molestias, inventore dignissimos tempore suscipit adipisci distinctio consectetur laudantium dolorem autem itaque eum! Enim nesciunt explicabo nihil expedita perferendis maiores sequi quis, mollitia minima, exercitationem vel, accusantium nemo. Debitis culpa, et hic, autem ullam iusto enim, maxime deleniti quod nemo minus ducimus optio repellat ipsum illo saepe voluptate voluptatibus dolor nam a? Porro eos excepturi natus. Similique id rerum labore fugit soluta nostrum tenetur laborum sunt aliquam ipsum provident ut sit blanditiis libero atque doloremque cupiditate nesciunt eligendi repudiandae, incidunt aperiam? Deserunt, odio, nisi consequatur a ad fugiat culpa vitae voluptas distinctio magni, animi quam facere optio? Sunt vitae dolor ratione sit, ipsa, accusantium amet illo odio architecto impedit possimus aut facere eaque ea voluptatibus et dolore, magni nihil nesciunt animi officiis! Placeat magni possimus exercitationem rerum aut dolore ducimus odit, iste quae alias dolores optio adipisci ipsa aspernatur accusantium? Quas eos pariatur repellat tempora consectetur perferendis ipsam maiores natus! Consectetur quisquam quia ipsum. Porro harum dolorem quia tempora excepturi iusto dolor reprehenderit unde facere nobis sed, corporis, exercitationem quidem, natus delectus optio animi quae. Eaque iure necessitatibus temporibus incidunt, culpa quidem tenetur eveniet, qui quibusdam optio explicabo commodi, reiciendis recusandae. Explicabo quo, odit consequuntur iusto amet saepe officia architecto nulla fugiat, aliquam laboriosam, cum perferendis quaerat repellat veniam consequatur labore? Ut, numquam. Laboriosam exercitationem cupiditate velit distinctio id nulla dolorum quis recusandae nobis at. Dignissimos quia sit sed mollitia illum praesentium cupiditate distinctio? Dolores qui cum saepe dolor. Sunt officiis deleniti, est quae nobis ratione aperiam, totam mollitia temporibus necessitatibus nostrum eligendi fuga quis eaque unde natus rem! Provident voluptate maiores neque architecto sapiente dolorum ex distinctio commodi expedita ad aliquam minima earum fugit voluptatem maxime voluptatum vitae corporis incidunt praesentium perferendis cum, a doloremque eligendi amet! Officiis, ducimus magni cumque consequuntur reiciendis est rem vitae labore minus harum distinctio repellendus tempore temporibus dolorum saepe asperiores molestias, sit perferendis porro! Numquam corrupti nobis ex soluta quam adipisci quod repellendus assumenda sequi autem, quidem nam omnis esse dicta rerum doloribus qui? Odit vero dolor eaque obcaecati iste veniam nesciunt, odio culpa ipsa repellat inventore sunt, nulla, voluptatibus non cumque placeat! Magnam saepe consectetur sunt blanditiis. Sunt distinctio, sequi aspernatur enim placeat deserunt velit. Consectetur eius quod ratione et ipsum, consequatur ad velit, minus rem rerum delectus libero vitae voluptate veritatis officiis. Illo impedit voluptatibus neque rerum et nisi! Itaque quisquam sapiente, eligendi veritatis facere harum nostrum quae, non, deleniti porro minus explicabo deserunt? At dolore error omnis quo doloribus accusamus reprehenderit qui in cumque expedita nihil illum commodi neque, ipsa dolor aut quos. Optio animi vero accusamus cumque praesentium illo sit. Accusantium odio possimus, cumque excepturi aspernatur harum quia? Itaque harum quis molestiae dignissimos quisquam minus tempora! Saepe, alias nemo. Consequatur officiis tenetur praesentium eum alias assumenda illum sed laudantium maxime itaque quidem sequi, ipsam, veritatis sapiente architecto ex, placeat non quae beatae. Consequatur, quis! Nostrum explicabo accusamus corporis mollitia quod tempore maiores eaque? Nam vitae itaque dicta autem! Dolor quam velit ipsum tempore maiores repellendus alias beatae sit! Iste et reiciendis iusto aspernatur maxime exercitationem deleniti voluptates perferendis, tempore delectus libero necessitatibus non labore sed culpa quisquam, adipisci consectetur, ad soluta voluptatum autem dolore expedita provident sit? Fugiat explicabo molestiae saepe eum reprehenderit? Culpa ratione repellat eveniet, soluta temporibus totam nisi error, exercitationem dolor porro corrupti vitae quasi est atque nam magni! Nemo odio quisquam delectus pariatur? Consectetur, aliquam inventore! Possimus optio assumenda voluptatem, voluptas sint omnis sed impedit quia quaerat doloribus quod dolores mollitia et inventore, dolore a illo voluptatibus itaque beatae. Ex perferendis dicta aliquam deleniti vero debitis voluptatum corrupti nihil hic, nesciunt porro? Ullam minus explicabo nostrum tempore. Natus eius mollitia ratione eligendi sit dolorem, quia provident similique et. Nesciunt, voluptas explicabo et maxime perspiciatis, perferendis officia repellendus est nostrum sequi possimus repellat, ducimus porro tenetur error vel reprehenderit maiores voluptates? Aspernatur mollitia, quia necessitatibus, repellendus, quos veritatis libero beatae quaerat est quidem sapiente et! Velit, earum saepe error natus excepturi quos asperiores a sint doloremque repellat eum laboriosam libero laudantium rerum iusto suscipit ipsum atque dolores, illo quas voluptatem exercitationem placeat? Quasi nostrum, iste sit nam necessitatibus cumque optio molestias, pariatur aliquam fugiat magni aperiam corporis, hic dolorem? Omnis iusto inventore tempore nulla consectetur nemo quasi asperiores unde, quod beatae amet accusantium modi eligendi dignissimos! Exercitationem quam fugiat assumenda molestiae aut illum nihil laudantium ullam incidunt debitis adipisci, quos rerum atque aspernatur totam asperiores odit tempora vitae! Rem tempore iusto, voluptates ipsa est, harum, dignissimos corporis delectus exercitationem adipisci ex nobis quidem quae ea nostrum fugit commodi animi! Facilis sit error ut deleniti et eum, officia illum eos consequuntur aspernatur sed cumque laborum officiis eaque corrupti dolor cupiditate expedita sunt porro vitae assumenda doloremque harum. Voluptas esse maxime vitae quia consequatur mollitia est! Voluptatibus aliquid soluta nulla rem eligendi! Dolorem, voluptatibus doloremque minima corporis a mollitia modi, accusamus corrupti impedit voluptatum, maiores id quaerat distinctio. Blanditiis placeat voluptates nemo magni consequatur, iure, explicabo reiciendis tempore quaerat natus perferendis earum? Corporis nemo eius officia sit non repellat dolore hic aspernatur accusantium dolor repudiandae iste doloremque magni repellendus accusamus quaerat reprehenderit esse maxime, commodi vel similique numquam. Tempora cum, sequi dignissimos quam ea rem. Voluptate eum blanditiis molestias quae ratione ipsam repellendus ducimus recusandae repudiandae.', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus.', '2024-12-29 21:26:07', 'admin', 4, NULL),
(3, 'title test 3', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus. Optio, fuga eligendi aspernatur consequatur ad praesentium ea labore vitae similique earum quos enim, quaerat possimus quas beatae qui accusantium eius cum neque officia molestiae? Repudiandae libero eligendi incidunt error ut similique tempora ab? Id, corporis modi suscipit illo quod, repellat error esse, quasi incidunt tempora praesentium corrupti laudantium molestias vitae eos rerum libero asperiores quaerat atque explicabo minima iure cum unde cumque! Quaerat iste minus recusandae a dolore dolorum sapiente dolorem id, culpa, fugit veritatis consectetur molestias eveniet distinctio voluptates quas aliquid doloremque eligendi, exercitationem maiores? Excepturi maiores, autem cum nihil enim eaque perferendis quae? Ratione consequatur blanditiis modi molestias, inventore dignissimos tempore suscipit adipisci distinctio consectetur laudantium dolorem autem itaque eum! Enim nesciunt explicabo nihil expedita perferendis maiores sequi quis, mollitia minima, exercitationem vel, accusantium nemo. Debitis culpa, et hic, autem ullam iusto enim, maxime deleniti quod nemo minus ducimus optio repellat ipsum illo saepe voluptate voluptatibus dolor nam a? Porro eos excepturi natus. Similique id rerum labore fugit soluta nostrum tenetur laborum sunt aliquam ipsum provident ut sit blanditiis libero atque doloremque cupiditate nesciunt eligendi repudiandae, incidunt aperiam? Deserunt, odio, nisi consequatur a ad fugiat culpa vitae voluptas distinctio magni, animi quam facere optio? Sunt vitae dolor ratione sit, ipsa, accusantium amet illo odio architecto impedit possimus aut facere eaque ea voluptatibus et dolore, magni nihil nesciunt animi officiis! Placeat magni possimus exercitationem rerum aut dolore ducimus odit, iste quae alias dolores optio adipisci ipsa aspernatur accusantium? Quas eos pariatur repellat tempora consectetur perferendis ipsam maiores natus! Consectetur quisquam quia ipsum. Porro harum dolorem quia tempora excepturi iusto dolor reprehenderit unde facere nobis sed, corporis, exercitationem quidem, natus delectus optio animi quae. Eaque iure necessitatibus temporibus incidunt, culpa quidem tenetur eveniet, qui quibusdam optio explicabo commodi, reiciendis recusandae. Explicabo quo, odit consequuntur iusto amet saepe officia architecto nulla fugiat, aliquam laboriosam, cum perferendis quaerat repellat veniam consequatur labore? Ut, numquam. Laboriosam exercitationem cupiditate velit distinctio id nulla dolorum quis recusandae nobis at. Dignissimos quia sit sed mollitia illum praesentium cupiditate distinctio? Dolores qui cum saepe dolor. Sunt officiis deleniti, est quae nobis ratione aperiam, totam mollitia temporibus necessitatibus nostrum eligendi fuga quis eaque unde natus rem! Provident voluptate maiores neque architecto sapiente dolorum ex distinctio commodi expedita ad aliquam minima earum fugit voluptatem maxime voluptatum vitae corporis incidunt praesentium perferendis cum, a doloremque eligendi amet! Officiis, ducimus magni cumque consequuntur reiciendis est rem vitae labore minus harum distinctio repellendus tempore temporibus dolorum saepe asperiores molestias, sit perferendis porro! Numquam corrupti nobis ex soluta quam adipisci quod repellendus assumenda sequi autem, quidem nam omnis esse dicta rerum doloribus qui? Odit vero dolor eaque obcaecati iste veniam nesciunt, odio culpa ipsa repellat inventore sunt, nulla, voluptatibus non cumque placeat! Magnam saepe consectetur sunt blanditiis. Sunt distinctio, sequi aspernatur enim placeat deserunt velit. Consectetur eius quod ratione et ipsum, consequatur ad velit, minus rem rerum delectus libero vitae voluptate veritatis officiis. Illo impedit voluptatibus neque rerum et nisi! Itaque quisquam sapiente, eligendi veritatis facere harum nostrum quae, non, deleniti porro minus explicabo deserunt? At dolore error omnis quo doloribus accusamus reprehenderit qui in cumque expedita nihil illum commodi neque, ipsa dolor aut quos. Optio animi vero accusamus cumque praesentium illo sit. Accusantium odio possimus, cumque excepturi aspernatur harum quia? Itaque harum quis molestiae dignissimos quisquam minus tempora! Saepe, alias nemo. Consequatur officiis tenetur praesentium eum alias assumenda illum sed laudantium maxime itaque quidem sequi, ipsam, veritatis sapiente architecto ex, placeat non quae beatae. Consequatur, quis! Nostrum explicabo accusamus corporis mollitia quod tempore maiores eaque? Nam vitae itaque dicta autem! Dolor quam velit ipsum tempore maiores repellendus alias beatae sit! Iste et reiciendis iusto aspernatur maxime exercitationem deleniti voluptates perferendis, tempore delectus libero necessitatibus non labore sed culpa quisquam, adipisci consectetur, ad soluta voluptatum autem dolore expedita provident sit? Fugiat explicabo molestiae saepe eum reprehenderit? Culpa ratione repellat eveniet, soluta temporibus totam nisi error, exercitationem dolor porro corrupti vitae quasi est atque nam magni! Nemo odio quisquam delectus pariatur? Consectetur, aliquam inventore! Possimus optio assumenda voluptatem, voluptas sint omnis sed impedit quia quaerat doloribus quod dolores mollitia et inventore, dolore a illo voluptatibus itaque beatae. Ex perferendis dicta aliquam deleniti vero debitis voluptatum corrupti nihil hic, nesciunt porro? Ullam minus explicabo nostrum tempore. Natus eius mollitia ratione eligendi sit dolorem, quia provident similique et. Nesciunt, voluptas explicabo et maxime perspiciatis, perferendis officia repellendus est nostrum sequi possimus repellat, ducimus porro tenetur error vel reprehenderit maiores voluptates? Aspernatur mollitia, quia necessitatibus, repellendus, quos veritatis libero beatae quaerat est quidem sapiente et! Velit, earum saepe error natus excepturi quos asperiores a sint doloremque repellat eum laboriosam libero laudantium rerum iusto suscipit ipsum atque dolores, illo quas voluptatem exercitationem placeat? Quasi nostrum, iste sit nam necessitatibus cumque optio molestias, pariatur aliquam fugiat magni aperiam corporis, hic dolorem? Omnis iusto inventore tempore nulla consectetur nemo quasi asperiores unde, quod beatae amet accusantium modi eligendi dignissimos! Exercitationem quam fugiat assumenda molestiae aut illum nihil laudantium ullam incidunt debitis adipisci, quos rerum atque aspernatur totam asperiores odit tempora vitae! Rem tempore iusto, voluptates ipsa est, harum, dignissimos corporis delectus exercitationem adipisci ex nobis quidem quae ea nostrum fugit commodi animi! Facilis sit error ut deleniti et eum, officia illum eos consequuntur aspernatur sed cumque laborum officiis eaque corrupti dolor cupiditate expedita sunt porro vitae assumenda doloremque harum. Voluptas esse maxime vitae quia consequatur mollitia est! Voluptatibus aliquid soluta nulla rem eligendi! Dolorem, voluptatibus doloremque minima corporis a mollitia modi, accusamus corrupti impedit voluptatum, maiores id quaerat distinctio. Blanditiis placeat voluptates nemo magni consequatur, iure, explicabo reiciendis tempore quaerat natus perferendis earum? Corporis nemo eius officia sit non repellat dolore hic aspernatur accusantium dolor repudiandae iste doloremque magni repellendus accusamus quaerat reprehenderit esse maxime, commodi vel similique numquam. Tempora cum, sequi dignissimos quam ea rem. Voluptate eum blanditiis molestias quae ratione ipsam repellendus ducimus recusandae repudiandae.', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus.', '2024-12-29 11:26:07', 'admin', NULL, NULL),
(4, 'title test 4', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus. Optio, fuga eligendi aspernatur consequatur ad praesentium ea labore vitae similique earum quos enim, quaerat possimus quas beatae qui accusantium eius cum neque officia molestiae? Repudiandae libero eligendi incidunt error ut similique tempora ab? Id, corporis modi suscipit illo quod, repellat error esse, quasi incidunt tempora praesentium corrupti laudantium molestias vitae eos rerum libero asperiores quaerat atque explicabo minima iure cum unde cumque! Quaerat iste minus recusandae a dolore dolorum sapiente dolorem id, culpa, fugit veritatis consectetur molestias eveniet distinctio voluptates quas aliquid doloremque eligendi, exercitationem maiores? Excepturi maiores, autem cum nihil enim eaque perferendis quae? Ratione consequatur blanditiis modi molestias, inventore dignissimos tempore suscipit adipisci distinctio consectetur laudantium dolorem autem itaque eum! Enim nesciunt explicabo nihil expedita perferendis maiores sequi quis, mollitia minima, exercitationem vel, accusantium nemo. Debitis culpa, et hic, autem ullam iusto enim, maxime deleniti quod nemo minus ducimus optio repellat ipsum illo saepe voluptate voluptatibus dolor nam a? Porro eos excepturi natus. Similique id rerum labore fugit soluta nostrum tenetur laborum sunt aliquam ipsum provident ut sit blanditiis libero atque doloremque cupiditate nesciunt eligendi repudiandae, incidunt aperiam? Deserunt, odio, nisi consequatur a ad fugiat culpa vitae voluptas distinctio magni, animi quam facere optio? Sunt vitae dolor ratione sit, ipsa, accusantium amet illo odio architecto impedit possimus aut facere eaque ea voluptatibus et dolore, magni nihil nesciunt animi officiis! Placeat magni possimus exercitationem rerum aut dolore ducimus odit, iste quae alias dolores optio adipisci ipsa aspernatur accusantium? Quas eos pariatur repellat tempora consectetur perferendis ipsam maiores natus! Consectetur quisquam quia ipsum. Porro harum dolorem quia tempora excepturi iusto dolor reprehenderit unde facere nobis sed, corporis, exercitationem quidem, natus delectus optio animi quae. Eaque iure necessitatibus temporibus incidunt, culpa quidem tenetur eveniet, qui quibusdam optio explicabo commodi, reiciendis recusandae. Explicabo quo, odit consequuntur iusto amet saepe officia architecto nulla fugiat, aliquam laboriosam, cum perferendis quaerat repellat veniam consequatur labore? Ut, numquam. Laboriosam exercitationem cupiditate velit distinctio id nulla dolorum quis recusandae nobis at. Dignissimos quia sit sed mollitia illum praesentium cupiditate distinctio? Dolores qui cum saepe dolor. Sunt officiis deleniti, est quae nobis ratione aperiam, totam mollitia temporibus necessitatibus nostrum eligendi fuga quis eaque unde natus rem! Provident voluptate maiores neque architecto sapiente dolorum ex distinctio commodi expedita ad aliquam minima earum fugit voluptatem maxime voluptatum vitae corporis incidunt praesentium perferendis cum, a doloremque eligendi amet! Officiis, ducimus magni cumque consequuntur reiciendis est rem vitae labore minus harum distinctio repellendus tempore temporibus dolorum saepe asperiores molestias, sit perferendis porro! Numquam corrupti nobis ex soluta quam adipisci quod repellendus assumenda sequi autem, quidem nam omnis esse dicta rerum doloribus qui? Odit vero dolor eaque obcaecati iste veniam nesciunt, odio culpa ipsa repellat inventore sunt, nulla, voluptatibus non cumque placeat! Magnam saepe consectetur sunt blanditiis. Sunt distinctio, sequi aspernatur enim placeat deserunt velit. Consectetur eius quod ratione et ipsum, consequatur ad velit, minus rem rerum delectus libero vitae voluptate veritatis officiis. Illo impedit voluptatibus neque rerum et nisi! Itaque quisquam sapiente, eligendi veritatis facere harum nostrum quae, non, deleniti porro minus explicabo deserunt? At dolore error omnis quo doloribus accusamus reprehenderit qui in cumque expedita nihil illum commodi neque, ipsa dolor aut quos. Optio animi vero accusamus cumque praesentium illo sit. Accusantium odio possimus, cumque excepturi aspernatur harum quia? Itaque harum quis molestiae dignissimos quisquam minus tempora! Saepe, alias nemo. Consequatur officiis tenetur praesentium eum alias assumenda illum sed laudantium maxime itaque quidem sequi, ipsam, veritatis sapiente architecto ex, placeat non quae beatae. Consequatur, quis! Nostrum explicabo accusamus corporis mollitia quod tempore maiores eaque? Nam vitae itaque dicta autem! Dolor quam velit ipsum tempore maiores repellendus alias beatae sit! Iste et reiciendis iusto aspernatur maxime exercitationem deleniti voluptates perferendis, tempore delectus libero necessitatibus non labore sed culpa quisquam, adipisci consectetur, ad soluta voluptatum autem dolore expedita provident sit? Fugiat explicabo molestiae saepe eum reprehenderit? Culpa ratione repellat eveniet, soluta temporibus totam nisi error, exercitationem dolor porro corrupti vitae quasi est atque nam magni! Nemo odio quisquam delectus pariatur? Consectetur, aliquam inventore! Possimus optio assumenda voluptatem, voluptas sint omnis sed impedit quia quaerat doloribus quod dolores mollitia et inventore, dolore a illo voluptatibus itaque beatae. Ex perferendis dicta aliquam deleniti vero debitis voluptatum corrupti nihil hic, nesciunt porro? Ullam minus explicabo nostrum tempore. Natus eius mollitia ratione eligendi sit dolorem, quia provident similique et. Nesciunt, voluptas explicabo et maxime perspiciatis, perferendis officia repellendus est nostrum sequi possimus repellat, ducimus porro tenetur error vel reprehenderit maiores voluptates? Aspernatur mollitia, quia necessitatibus, repellendus, quos veritatis libero beatae quaerat est quidem sapiente et! Velit, earum saepe error natus excepturi quos asperiores a sint doloremque repellat eum laboriosam libero laudantium rerum iusto suscipit ipsum atque dolores, illo quas voluptatem exercitationem placeat? Quasi nostrum, iste sit nam necessitatibus cumque optio molestias, pariatur aliquam fugiat magni aperiam corporis, hic dolorem? Omnis iusto inventore tempore nulla consectetur nemo quasi asperiores unde, quod beatae amet accusantium modi eligendi dignissimos! Exercitationem quam fugiat assumenda molestiae aut illum nihil laudantium ullam incidunt debitis adipisci, quos rerum atque aspernatur totam asperiores odit tempora vitae! Rem tempore iusto, voluptates ipsa est, harum, dignissimos corporis delectus exercitationem adipisci ex nobis quidem quae ea nostrum fugit commodi animi! Facilis sit error ut deleniti et eum, officia illum eos consequuntur aspernatur sed cumque laborum officiis eaque corrupti dolor cupiditate expedita sunt porro vitae assumenda doloremque harum. Voluptas esse maxime vitae quia consequatur mollitia est! Voluptatibus aliquid soluta nulla rem eligendi! Dolorem, voluptatibus doloremque minima corporis a mollitia modi, accusamus corrupti impedit voluptatum, maiores id quaerat distinctio. Blanditiis placeat voluptates nemo magni consequatur, iure, explicabo reiciendis tempore quaerat natus perferendis earum? Corporis nemo eius officia sit non repellat dolore hic aspernatur accusantium dolor repudiandae iste doloremque magni repellendus accusamus quaerat reprehenderit esse maxime, commodi vel similique numquam. Tempora cum, sequi dignissimos quam ea rem. Voluptate eum blanditiis molestias quae ratione ipsam repellendus ducimus recusandae repudiandae.', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum voluptatibus mollitia earum blanditiis cum at autem! Enim eligendi sit, ab ipsam laboriosam nam facere dolorem accusamus eaque blanditiis, quia, quae nesciunt voluptatibus.', '2024-11-29 11:26:07', 'admin', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

CREATE TABLE `comment` (
  `user_id` int UNSIGNED NOT NULL,
  `article_id` int UNSIGNED NOT NULL,
  `publish_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `country`
--

CREATE TABLE `country` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(100) NOT NULL,
  `url_wiki` varchar(300) NOT NULL,
  `flag` varchar(30) NOT NULL,
  `countryimage_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `country`
--

INSERT INTO `country` (`id`, `label`, `url_wiki`, `flag`, `countryimage_id`) VALUES
(4, 'france', 'https://fr.wikipedia.org/wiki/France', 'france.png', 1),
(5, 'japon', 'https://fr.wikipedia.org/wiki/Japon', 'japon.png', 2),
(7, 'Inde', 'https://fr.wikipedia.org/wiki/Inde', 'inde.png', 7);

-- --------------------------------------------------------

--
-- Structure de la table `countryimage`
--

CREATE TABLE `countryimage` (
  `id` int UNSIGNED NOT NULL,
  `url` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `countryimage`
--

INSERT INTO `countryimage` (`id`, `url`) VALUES
(1, 'france.webp'),
(2, 'japon.webp'),
(7, 'inde.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `country_recipe`
--

CREATE TABLE `country_recipe` (
  `recipe_id` int UNSIGNED NOT NULL,
  `country_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `newsletter`
--

CREATE TABLE `newsletter` (
  `id` int UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `recipe`
--

CREATE TABLE `recipe` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(150) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `recipe`
--

INSERT INTO `recipe` (`id`, `label`, `content`) VALUES
(1, 'Raclette', '<header>\r\n        <h1>Recette de la Raclette Traditionnelle</h1>\r\n        <p><em>Un plat réconfortant venu des montagnes suisses et françaises, parfait pour les soirées hivernales !</em></p>\r\n    </header>\r\n    \r\n    <section>\r\n        <h2>Ingrédients</h2>\r\n        <ul>\r\n            <li>200 g de fromage à raclette par personne</li>\r\n            <li>150 g de pommes de terre par personne (de préférence des variétés fermes comme la Charlotte ou l\'Amandine)</li>\r\n            <li>Charcuterie variée (jambon cru, salami, rosette, viande des Grisons)</li>\r\n            <li>Condiments : cornichons, oignons au vinaigre</li>\r\n            <li>Poivre, paprika, ou autres épices au choix (facultatif)</li>\r\n        </ul>\r\n    </section>\r\n    \r\n    <section>\r\n        <h2>Matériel nécessaire</h2>\r\n        <ul>\r\n            <li>Appareil à raclette (avec poêlons)</li>\r\n            <li>Assiettes et couverts adaptés</li>\r\n        </ul>\r\n    </section>\r\n    \r\n    <section>\r\n        <h2>Préparation</h2>\r\n        <ol>\r\n            <li>Épluchez et lavez les pommes de terre. Faites-les cuire dans de l\'eau salée jusqu\'à ce qu\'elles soient tendres (environ 20 minutes).</li>\r\n            <li>Disposez les charcuteries et les condiments sur des plateaux ou dans des bols.</li>\r\n            <li>Coupez le fromage à raclette en tranches si ce n\'est pas déjà fait.</li>\r\n            <li>Placez les pommes de terre dans un grand plat ou un panier pour garder au chaud.</li>\r\n        </ol>\r\n    </section>\r\n    \r\n    <section>\r\n        <h2>Mode de dégustation</h2>\r\n        <p>\r\n            Faites chauffer l\'appareil à raclette. Placez une tranche de fromage dans un poêlon et laissez fondre sous la résistance.\r\n            Pendant ce temps, pelez une pomme de terre, ajoutez-y un peu de fromage fondu, et accompagnez de charcuterie et de condiments.\r\n        </p>\r\n        <p>\r\n            Personnalisez votre raclette avec des épices ou des légumes grillés pour plus de saveurs !\r\n        </p>\r\n    </section>\r\n    \r\n    <footer>\r\n        <p><strong>Bon appétit !</strong> Ce plat convivial ravira vos invités et réchauffera vos soirées d\'hiver.</p>\r\n    </footer>'),
(2, 'raclette 2', 'dadazdzda');

-- --------------------------------------------------------

--
-- Structure de la table `recipeimage`
--

CREATE TABLE `recipeimage` (
  `id` int UNSIGNED NOT NULL,
  `url` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `recipeimage`
--

INSERT INTO `recipeimage` (`id`, `url`) VALUES
(1, 'raclette1.webp'),
(2, 'raclette2.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `recipe_image`
--

CREATE TABLE `recipe_image` (
  `recipe_id` int UNSIGNED NOT NULL,
  `recipeimage_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `recipe_image`
--

INSERT INTO `recipe_image` (`recipe_id`, `recipeimage_id`) VALUES
(1, 1),
(1, 2),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int UNSIGNED NOT NULL,
  `alias` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` char(60) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isAdmin` tinyint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `alias`, `password`, `creation_date`, `isAdmin`) VALUES
(1, 'jako', '$2b$10$92dqznbtMO31nnooHj8tGO7D3MtcGWZP/OcmGYnMlXczvMODJvqXG', '2024-12-30 09:46:37', 0),
(2, 'aaa', '$2b$10$DRHWIBeXHuQ8xcvugeusZeHF3dQ4IboAwQtjAXUU9MgpneVwvsr.S', '2024-12-30 09:53:01', 0),
(3, 'Khyn', '$2b$10$mQuzu7Q/O/goUUpTuJ1vSeCOUzCPdn8/FOQZiTjN2Ds8awS4E9Lzy', '2024-12-30 10:54:20', 0),
(4, 'kevin', '$2b$10$degqSMuby7MFO80iY.DIeusIiNQRTVerFgkuxMbho7dV8vF7xpXSa', '2025-01-02 11:06:04', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Index pour la table `comment`
--
ALTER TABLE `comment`
  ADD KEY `article_id` (`article_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countryimage_id` (`countryimage_id`);

--
-- Index pour la table `countryimage`
--
ALTER TABLE `countryimage`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `country_recipe`
--
ALTER TABLE `country_recipe`
  ADD KEY `country_id` (`country_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Index pour la table `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `recipeimage`
--
ALTER TABLE `recipeimage`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `recipe_image`
--
ALTER TABLE `recipe_image`
  ADD KEY `recipeimage_id` (`recipeimage_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `article`
--
ALTER TABLE `article`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `country`
--
ALTER TABLE `country`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `countryimage`
--
ALTER TABLE `countryimage`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `recipe`
--
ALTER TABLE `recipe`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `recipeimage`
--
ALTER TABLE `recipeimage`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `article_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `country`
--
ALTER TABLE `country`
  ADD CONSTRAINT `country_ibfk_1` FOREIGN KEY (`countryimage_id`) REFERENCES `countryimage` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `country_recipe`
--
ALTER TABLE `country_recipe`
  ADD CONSTRAINT `country_recipe_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `country_recipe_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `recipe_image`
--
ALTER TABLE `recipe_image`
  ADD CONSTRAINT `recipe_image_ibfk_1` FOREIGN KEY (`recipeimage_id`) REFERENCES `recipeimage` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `recipe_image_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
--
-- Base de données : `ksushi`
--
CREATE DATABASE IF NOT EXISTS `ksushi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `ksushi`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Sushi'),
(2, 'Maki'),
(3, 'California'),
(4, 'Ramen');

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` enum('pending','paid','cancelled') DEFAULT 'pending',
  `total_price` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `total_price`, `created_at`) VALUES
(1, 2, 'paid', 25.50, '2025-07-02 15:21:11'),
(2, 2, 'cancelled', 28.00, '2025-07-04 09:58:42'),
(3, 3, 'paid', 7.00, '2025-07-04 10:58:21'),
(4, 2, 'paid', 14.00, '2025-07-06 23:53:15');

-- --------------------------------------------------------

--
-- Structure de la table `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 4, 2, 10.00),
(2, 1, 5, 1, 5.50),
(3, 2, 4, 4, 7.00),
(4, 3, 4, 1, 7.00),
(5, 4, 5, 1, 7.00),
(6, 4, 6, 1, 7.00);

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`, `category_id`, `created_at`) VALUES
(4, 'Maki Legume', 'Plateau de 8', 7.00, 'uploads/images/fznql873wm7ddzhlaxliw0nd5.webp', 2, '2025-07-02 15:07:32'),
(5, 'California Saumon', 'Plateau de 8', 7.00, 'uploads/images/ekcr9bpbs1lo2baxadjl7565q.webp', 3, '2025-07-02 15:08:56'),
(6, 'Ramen porc', 'Plateau de 8', 7.00, 'uploads/images/eic1aprhijq6szknp5jluo1qr.webp', 4, '2025-07-02 15:09:52'),
(7, 'Sushi Thon', 'Plateau de 4', 7.00, 'uploads/images/galy1euuf8rmkmjxm0bsbjwdy.webp', 1, '2025-07-02 15:11:10');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `alias` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `alias`, `email`, `phone`, `password`, `role`, `created_at`) VALUES
(2, 'kevin', 'kevin.khek@gmail.com', '0783052412', '$2b$10$Ie9xL8cYp1QNrRUw2PpJdueviJmulTVQIQYZlwH17AZ3LYS8s/LI.', 'admin', '2025-07-01 00:07:02'),
(3, 'supakd', 'supakd@gmail.com', '0783052412', '$2b$10$PbbN4bkFYikg4el4.E7cNu7jV5xE9mbvK4Ulr5B5Rks9IrK/lQszC', 'user', '2025-07-02 16:45:25'),
(4, 'Supa', 'supa@gmail.com', '0303030303', '$2b$10$kxBqnHNe7.SGOPhqM2WOXuJ5SN38s4vLx9WAR40AIALUqaQCilmtW', 'user', '2025-07-02 16:46:09'),
(5, 'kenzo', 'ken@gmail.com', '0505050505', '$2b$10$RMUXWXLIxV5Lq7GxDTZJBO2ZRvuCVHQsxCvcrVRRt0s/OsbIGl2Eu', 'user', '2025-07-02 16:47:06');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
--
-- Base de données : `supasushiv2`
--
CREATE DATABASE IF NOT EXISTS `supasushiv2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `supasushiv2`;

-- --------------------------------------------------------

--
-- Structure de la table `Categories`
--

CREATE TABLE `Categories` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Categories`
--

INSERT INTO `Categories` (`id`, `label`) VALUES
(1, 'Sushi'),
(2, 'Maki'),
(3, 'Bento'),
(4, 'Ramen');

-- --------------------------------------------------------

--
-- Structure de la table `Images`
--

CREATE TABLE `Images` (
  `id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_primary` tinyint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Images`
--

INSERT INTO `Images` (`id`, `product_id`, `url`, `is_primary`) VALUES
(1, 1, '/uploads/images/731dfb1d3fac880d9a0f1b800.jpg', 1),
(2, 2, '/uploads/images/19ab51611f9d6d06ef17ed400.jpg', 1),
(3, 3, '/uploads/images/19ab51611f9d6d06ef17ed401.jpg', 1),
(4, 4, '/uploads/images/19ab51611f9d6d06ef17ed402.jpg', 1),
(5, 5, '/uploads/images/19ab51611f9d6d06ef17ed403.jpg', 1),
(6, 6, '/uploads/images/19ab51611f9d6d06ef17ed404.jpg', 1),
(7, 7, '/uploads/images/b17451bf8fe0a478cc48b5000.jpg', 1),
(8, 8, '/uploads/images/ecde1dd8b5f54e48f17aad400.jpg', 1),
(9, 9, '/uploads/images/ecde1dd8b5f54e48f17aad401.jpg', 1),
(10, 10, '/uploads/images/7fb5062ab9877c16429a44600.jpeg', 1),
(11, 11, '/uploads/images/7fb5062ab9877c16429a44601.jpeg', 1),
(12, 12, '/uploads/images/7fb5062ab9877c16429a44602.jpeg', 1);

-- --------------------------------------------------------

--
-- Structure de la table `OrderProducts`
--

CREATE TABLE `OrderProducts` (
  `id` int UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `quantity` smallint NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `OrderProducts`
--

INSERT INTO `OrderProducts` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(16, 9, 1, 1, 6.00),
(17, 9, 2, 1, 5.00),
(18, 9, 3, 1, 4.00),
(19, 10, 1, 1, 6.00),
(20, 11, 1, 1, 6.00),
(21, 11, 2, 1, 5.00),
(22, 12, 2, 1, 5.00),
(23, 12, 3, 1, 4.00),
(24, 13, 1, 1, 6.00),
(25, 14, 1, 1, 6.00),
(26, 14, 2, 1, 5.00),
(27, 15, 1, 1, 6.00),
(28, 16, 2, 1, 5.00),
(29, 17, 1, 1, 6.00),
(30, 18, 1, 1, 6.00),
(31, 19, 1, 1, 6.00),
(32, 19, 2, 1, 5.00),
(33, 19, 3, 1, 4.00),
(34, 20, 1, 1, 6.00),
(35, 20, 2, 1, 5.00),
(36, 21, 1, 1, 6.00),
(37, 21, 5, 1, 8.00),
(40, 23, 1, 1, 6.00),
(41, 23, 2, 1, 5.00),
(42, 24, 1, 1, 6.00),
(43, 24, 2, 1, 5.00),
(44, 25, 2, 2, 5.00),
(45, 26, 1, 1, 6.00),
(46, 26, 2, 1, 5.00),
(47, 27, 1, 1, 6.00),
(48, 27, 2, 1, 5.00),
(49, 27, 3, 1, 4.00),
(50, 28, 1, 2, 6.00);

-- --------------------------------------------------------

--
-- Structure de la table `Orders`
--

CREATE TABLE `Orders` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('En attente','En préparation','Prête','Annulé') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'En attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Orders`
--

INSERT INTO `Orders` (`id`, `user_id`, `total_price`, `created_at`, `status`) VALUES
(9, 5, 15.00, '2025-04-23 09:35:07', 'Prête'),
(10, 5, 6.00, '2025-04-23 14:52:25', 'En attente'),
(11, 5, 11.00, '2025-04-23 15:13:56', 'En attente'),
(12, 4, 9.00, '2025-04-23 18:07:57', 'Prête'),
(13, 5, 6.00, '2025-04-23 19:44:12', 'En attente'),
(14, 5, 11.00, '2025-04-23 23:47:03', 'En attente'),
(15, 5, 6.00, '2025-04-23 23:47:25', 'En attente'),
(16, 5, 5.00, '2025-04-23 23:48:39', 'En attente'),
(17, 5, 6.00, '2025-04-23 23:49:23', 'En attente'),
(18, 5, 6.00, '2025-04-23 23:57:39', 'En attente'),
(19, 5, 15.00, '2025-04-24 14:08:54', 'En attente'),
(20, 5, 11.00, '2025-04-24 14:44:22', 'En attente'),
(21, 5, 14.00, '2025-04-25 01:04:15', 'Prête'),
(23, 5, 11.00, '2025-04-25 15:46:21', 'Annulé'),
(24, 11, 11.00, '2025-04-26 10:46:15', 'En attente'),
(25, 10, 10.00, '2025-04-26 13:09:10', 'En attente'),
(26, 4, 11.00, '2025-04-26 13:38:47', 'Prête'),
(27, 10, 15.00, '2025-04-27 23:03:40', 'En attente'),
(28, 4, 12.00, '2025-04-28 23:06:49', 'En attente');

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `category_id` int UNSIGNED DEFAULT NULL,
  `is_available` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `stock` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `label`, `description`, `price`, `category_id`, `is_available`, `created_at`, `stock`) VALUES
(1, 'Sushi Saumon', 'Plateau de 3, riz avec du saumon.', 6.00, 1, 1, '2025-04-16 14:18:55', 1000),
(2, 'Sushi Thon', 'Plateau de 3, riz avec du thon.', 5.00, 1, 1, '2025-04-16 14:21:44', 1000),
(3, 'Maki Saumon', 'Plateau de 6, algue, riz et saumon.', 4.00, 2, 1, '2025-04-16 14:25:54', 1000),
(4, 'Maki thon', 'Plateau de 6, algue, riz et thon.', 4.00, 2, 1, '2025-04-16 14:26:19', 1000),
(5, 'Bento poulet', 'Plateau, assortiment de riz, légumes et poulet.', 8.00, 3, 1, '2025-04-16 14:35:59', 1000),
(6, 'Bento poisson', 'Plateau, assortiment de riz, légumes et poisson.', 7.00, 3, 1, '2025-04-16 14:36:27', 1000),
(7, 'Sushi Crevette', 'Plateau de 3,riz et crevettes.', 6.00, 1, 1, '2025-04-24 14:14:00', 100),
(8, 'Maki Saumon Avocat', 'Plateau de 6, algue, riz et saumon avocat.', 5.00, 2, 1, '2025-04-24 14:20:44', 100),
(9, 'Bento Porc', 'Plateau, assortiment de riz, légumes et porc.', 8.00, 3, 1, '2025-04-24 14:23:33', 100),
(10, 'Sushi Saumon oeufs poisson', 'Plateau de 3, riz avec du saumon et des oeufs de poisson.', 7.00, 1, 1, '2025-04-26 13:30:22', 100),
(11, 'Maki avocat poulet', 'Plateau de 6, riz avec du poulet panée et des avocats.', 6.00, 2, 1, '2025-04-26 13:33:13', 100),
(12, 'Bento canard', 'Plateau, assortiment de riz, légumes et canard.', 9.00, 3, 1, '2025-04-26 13:35:39', 100);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` char(60) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password`, `created_at`, `role`) VALUES
(3, 'Kevin', 'Khek', 'kevin@example.com', '0600000000', '$2b$10$67ZJlDvaLqO.QyDpxCeIi.qtqMxebpQ5flANcOBh1ffmeH4NoEOpO', '2025-04-16 14:57:38', 'user'),
(4, 'supa', 'kenzo', 'supa@kenzo.com', '0700000000', '$2b$10$ZGs2N12vbBEwGx1IjHDUJesR7O5OKZ80yko7dhzUrXDPaJtmdFWJ6', '2025-04-17 21:33:01', 'user'),
(5, 'supaLeo000', 'Leo', 'supa@leo.com', '061111100', '$2b$10$GykGSSUriBCgmYRw4vWLCeFjqvO7Tfoze6Aug9Cntb6vPK.AqKEzi', '2025-04-17 21:37:06', 'user'),
(7, 'supa', 'be', 'supa@bea.com', '0707070707', '$2b$10$/VqUSkfBZYfcQUOR1Wy2V.H5MhvvowpXRWAef9wnkz/KaB4JEgwm.', '2025-04-23 18:15:58', 'user'),
(8, 'ddcc', 'xdx', 'kedkde@gmail.com', '0635464785', '$2b$10$h8FWIeEGHtpTUBHg744a4.Ls12sE7I/fWX/cuW1DqK9ejs6b7M1bS', '2025-04-25 01:03:24', 'user'),
(9, 'kev', 'kdk', 'kev@kdk.com', '0303030303', '$2b$10$/OdZeuE0xck7mxwNeI2ElO8jWAUm3njpEboehMCtfJfCdU58DIF0.', '2025-04-25 23:15:18', 'user'),
(10, 'admin', 'admin', 'admin@login.com', '0707070707', '$2b$10$DqYuyUFGl4yjDyfy8D/.2u3.WpioGXVDVg9WJ3JTTpfcC69mHGt/C', '2025-04-26 00:44:13', 'admin'),
(11, 'kevin', 'khek', 'kevin.khek@gmail.com', '1234567890', '$2b$10$c9Cqoh50n1zqjZE.gk7MpeMRgcwnVrSNDEGzAvf9avHlLKZk85Fh2', '2025-04-26 10:00:08', 'user');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Images`
--
ALTER TABLE `Images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `OrderProducts`
--
ALTER TABLE `OrderProducts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `Images`
--
ALTER TABLE `Images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `OrderProducts`
--
ALTER TABLE `OrderProducts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Images`
--
ALTER TABLE `Images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `OrderProducts`
--
ALTER TABLE `OrderProducts`
  ADD CONSTRAINT `orderproducts_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderproducts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`) ON DELETE SET NULL;
--
-- Base de données : `supasushiv3`
--
CREATE DATABASE IF NOT EXISTS `supasushiv3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `supasushiv3`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Bento'),
(3, 'Maki'),
(2, 'Sushi');

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `status` enum('en_attente','en_preparation','pret','recuperer','annule') DEFAULT 'en_attente',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`, `category_id`, `created_at`) VALUES
(3, 'Sushi saumon', 'Riz vinaigré + saumon frais', 7.00, 'uploads/images/evugs5xo4h1f4mpm83bwfhzlz.webp', 2, '2025-05-04 20:08:11'),
(10, 'Sushi crevette', 'Riz vinaigré + crevette frais', 6.00, '/uploads/images/n1hb542lpi2sme8msfy5e6gxj.webp', 2, '2025-05-05 15:21:21'),
(11, 'Sushi thon', 'Riz vinaigré + thon frais', 7.00, '/uploads/images/pnlqldpi15610nnnglq90lkan.webp', 2, '2025-05-05 15:24:08'),
(12, 'Sushi saumon oeufs poisson', 'Riz vinaigré + saumon frais + oeufs poisson', 8.00, '/uploads/images/jr5l6s28lwvqxajwmystm9dxn.webp', 2, '2025-05-05 15:28:15'),
(13, 'Bento poulet', 'Riz vinaigré + poulet + crudités', 13.00, '/uploads/images/nempi7hkvcpkddh86rfvsxh3h.webp', 1, '2025-05-05 15:36:13'),
(14, 'Bento porc', 'Riz vinaigré + porc + crudités', 13.00, '/uploads/images/e6anami4p5busc108winjiywx.webp', 1, '2025-05-05 15:36:53'),
(15, 'Bento canard', 'Riz vinaigré + canard + crudités', 15.00, '/uploads/images/egj5u55skkrv64xs9e97951f0.webp', 1, '2025-05-05 15:37:28'),
(16, 'Bento vegan', 'Riz vinaigré + crudités', 11.00, '/uploads/images/dp42je9305czl8yslfd6zqdc0.webp', 1, '2025-05-05 15:38:29'),
(17, 'Maki saumon', 'Riz vinaigré + saumon par 6', 8.00, '/uploads/images/o1yrg7eg77kzczx3noy927ioq.webp', 3, '2025-05-05 15:41:29'),
(18, 'Maki thon', 'Riz vinaigré + thon par 6', 7.00, '/uploads/images/tlmewmahl7wzkfij5enq3g0r2.webp', 3, '2025-05-05 15:42:12'),
(19, 'Maki saumon avocat', 'Riz vinaigré + saumon avocat par 6', 8.00, '/uploads/images/hyg9oeptg8hwjbypaqze9zx46.webp', 3, '2025-05-05 15:43:07');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('client','admin') DEFAULT 'client',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `alias`, `email`, `phone`, `password`, `role`, `created_at`) VALUES
(1, 'Supa', 'supa@kd.com', '0600000000', '$2b$10$oBgnG4PNDDWimYT0XOdFMuRzJRJSsmguXs.4nCbK5hb57Tj4UIHj.', 'admin', '2025-05-04 15:57:13'),
(4, 'sasuke', 'sasuke@gmail.com', '0700000000', '$2b$10$2LbN1YJMT3n6Vlp1YzO6wu198MhW7Rw/twuLyfq7QNcg7.gpNlbPy', 'client', '2025-05-05 08:43:55');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
--
-- Base de données : `users`
--
CREATE DATABASE IF NOT EXISTS `users` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `users`;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `label` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
