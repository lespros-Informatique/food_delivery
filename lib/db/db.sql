-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : lun. 12 jan. 2026 à 09:46
-- Version du serveur : 8.0.44
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `db_woli`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id_categorie` int NOT NULL,
  `code_categorie` varchar(50) NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `nom_categorie` varchar(150) NOT NULL,
  `ordre` int DEFAULT '0',
  `statut` tinyint DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id_categorie`, `code_categorie`, `restaurant_code`, `nom_categorie`, `ordre`, `statut`) VALUES
(1, 'CAT-BURGER', 'RES-DEMO-001', 'Burgers', 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id_client` int NOT NULL,
  `code_client` varchar(50) NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `telephone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `statut` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id_client`, `code_client`, `restaurant_code`, `nom`, `telephone`, `email`, `statut`, `created_at`) VALUES
(1, 'CLI-DEMO-001', 'RES-DEMO-001', 'John Doe', '770000000', 'john@example.com', 1, '2025-12-20 15:29:18');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `id_commande` int NOT NULL,
  `code_commande` varchar(50) NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `client_code` varchar(50) NOT NULL,
  `total_commande` decimal(10,2) NOT NULL,
  `statut_commande` enum('en_attente','payee','en_preparation','livree','annulee') DEFAULT 'en_attente',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id_commande`, `code_commande`, `restaurant_code`, `client_code`, `total_commande`, `statut_commande`, `created_at`) VALUES
(1, 'CMD-DEMO-001', 'RES-DEMO-001', 'CLI-DEMO-001', 5000.00, 'livree', '2025-12-20 15:29:18');

-- --------------------------------------------------------

--
-- Structure de la table `commande_lignes`
--

CREATE TABLE `commande_lignes` (
  `id_commande_ligne` int NOT NULL,
  `code_commande_ligne` varchar(50) NOT NULL,
  `commande_code` varchar(50) NOT NULL,
  `produit_code` varchar(50) NOT NULL,
  `quantite` int NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `total_ligne` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commande_lignes`
--

INSERT INTO `commande_lignes` (`id_commande_ligne`, `code_commande_ligne`, `commande_code`, `produit_code`, `quantite`, `prix_unitaire`, `total_ligne`) VALUES
(1, 'LIG-001', 'CMD-DEMO-001', 'PROD-CHEESE', 1, 5000.00, 5000.00);

-- --------------------------------------------------------

--
-- Structure de la table `commissions`
--

CREATE TABLE `commissions` (
  `id_commission` int NOT NULL,
  `code_commission` varchar(50) NOT NULL,
  `commande_code` varchar(50) NOT NULL,
  `type_commission` enum('pourcentage','fixe') NOT NULL,
  `valeur_commission` decimal(10,2) NOT NULL,
  `montant_commission` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `gains`
--

CREATE TABLE `gains` (
  `id_gain` int NOT NULL,
  `code_gain` varchar(50) NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `commande_code` varchar(50) NOT NULL,
  `montant_restaurant` decimal(10,2) NOT NULL,
  `montant_woli` decimal(10,2) NOT NULL,
  `statut_gain` enum('en_attente','verse','annule') DEFAULT 'en_attente',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `livraisons`
--

CREATE TABLE `livraisons` (
  `id_livraison` int NOT NULL,
  `code_livraison` varchar(50) NOT NULL,
  `commande_code` varchar(50) NOT NULL,
  `livreur_code` varchar(50) NOT NULL,
  `statut_livraison` enum('en_attente','assignee','en_cours','livree','annulee') DEFAULT 'en_attente',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `livraison_positions`
--

CREATE TABLE `livraison_positions` (
  `id_position` int NOT NULL,
  `livraison_code` varchar(50) NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `livreurs`
--

CREATE TABLE `livreurs` (
  `id_livreur` int NOT NULL,
  `code_livreur` varchar(50) NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `telephone` varchar(30) DEFAULT NULL,
  `statut` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

CREATE TABLE `paiements` (
  `id_paiement` int NOT NULL,
  `code_paiement` varchar(50) NOT NULL,
  `commande_code` varchar(50) NOT NULL,
  `methode` varchar(50) DEFAULT NULL,
  `montant` decimal(10,2) NOT NULL,
  `reference_externe` varchar(150) DEFAULT NULL,
  `statut` enum('en_attente','valide','echoue') DEFAULT 'en_attente',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE `permissions` (
  `id_permission` int NOT NULL,
  `code_permission` varchar(100) NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id_permission`, `code_permission`, `description`, `created_at`) VALUES
(1, 'user.view', 'Voir les utilisateurs', '2025-12-20 15:01:15'),
(2, 'user.create', 'Créer un utilisateur', '2025-12-20 15:01:15'),
(3, 'user.update', 'Modifier un utilisateur', '2025-12-20 15:01:15'),
(4, 'user.delete', 'Supprimer un utilisateur', '2025-12-20 15:01:15'),
(5, 'role.view', 'Voir les rôles', '2025-12-20 15:01:15'),
(6, 'role.assign', 'Attribuer des rôles', '2025-12-20 15:01:15'),
(7, 'restaurant.view', 'Voir les restaurants', '2025-12-20 15:01:15'),
(8, 'restaurant.create', 'Créer un restaurant', '2025-12-20 15:01:15'),
(9, 'restaurant.update', 'Modifier un restaurant', '2025-12-20 15:01:15'),
(10, 'restaurant.delete', 'Supprimer un restaurant', '2025-12-20 15:01:15'),
(11, 'restaurant.settings', 'Gérer les paramètres du restaurant', '2025-12-20 15:01:15'),
(12, 'category.manage', 'Gérer les catégories', '2025-12-20 15:01:15'),
(13, 'product.manage', 'Gérer les produits', '2025-12-20 15:01:15'),
(14, 'order.view', 'Voir les commandes', '2025-12-20 15:01:15'),
(15, 'order.update_status', 'Changer le statut des commandes', '2025-12-20 15:01:15'),
(16, 'delivery.manage', 'Gérer les livraisons', '2025-12-20 15:01:15'),
(17, 'delivery.track', 'Suivre la livraison', '2025-12-20 15:01:15'),
(18, 'driver.manage', 'Gérer les livreurs', '2025-12-20 15:01:15'),
(19, 'payment.view', 'Voir les paiements', '2025-12-20 15:01:15'),
(20, 'commission.manage', 'Gérer les commissions', '2025-12-20 15:01:15'),
(21, 'gain.view', 'Voir les gains', '2025-12-20 15:01:15'),
(22, 'platform.settings', 'Gérer les paramètres globaux', '2025-12-20 15:01:15'),
(23, 'report.view', 'Voir les rapports globaux', '2025-12-20 15:01:15'),
(24, 'restaurant.manage', 'Gérer les restaurants', '2025-12-24 09:28:09'),
(25, 'order.manage', 'Gérer les commandes', '2025-12-24 09:28:09');

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `id_produit` int NOT NULL,
  `code_produit` varchar(50) NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `categorie_code` varchar(50) DEFAULT NULL,
  `nom_produit` varchar(150) NOT NULL,
  `description` text,
  `prix` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `disponible` tinyint DEFAULT '1',
  `statut` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id_produit`, `code_produit`, `restaurant_code`, `categorie_code`, `nom_produit`, `description`, `prix`, `image`, `disponible`, `statut`, `created_at`) VALUES
(1, 'PROD-CHEESE', 'RES-DEMO-001', 'CAT-BURGER', 'Cheeseburger', 'Delicious cheese burger', 5000.00, NULL, 1, 1, '2025-12-20 15:29:18');

-- --------------------------------------------------------

--
-- Structure de la table `restaurants`
--

CREATE TABLE `restaurants` (
  `id_restaurant` int NOT NULL,
  `code_restaurant` varchar(50) NOT NULL,
  `user_code` varchar(50) NOT NULL,
  `nom_restaurant` varchar(150) NOT NULL,
  `description` text,
  `adresse` varchar(255) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `statut` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `restaurants`
--

INSERT INTO `restaurants` (`id_restaurant`, `code_restaurant`, `user_code`, `nom_restaurant`, `description`, `adresse`, `ville`, `logo`, `statut`, `created_at`, `updated_at`, `latitude`, `longitude`) VALUES
(1, 'RES-DEMO-001', 'USR-RESTO-001', 'Woli Burger', 'Le meilleur burger de la ville', '', 'Dakar', NULL, 1, '2025-12-20 15:21:05', '2025-12-24 08:48:02', NULL, NULL),
(2, 'RES-2F407D', 'USR-RESTO-001', 'restoclarte', 'description ignorer', 's4411s', 'abidjan', NULL, 1, '2025-12-22 16:04:33', '2025-12-22 16:04:33', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `restaurant_fermetures`
--

CREATE TABLE `restaurant_fermetures` (
  `id_fermeture` int NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `motif` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `restaurant_horaires`
--

CREATE TABLE `restaurant_horaires` (
  `id_horaire` int NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `jour` enum('lundi','mardi','mercredi','jeudi','vendredi','samedi','dimanche') NOT NULL,
  `heure_ouverture` time NOT NULL,
  `heure_fermeture` time NOT NULL,
  `statut` tinyint DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `restaurant_horaires`
--

INSERT INTO `restaurant_horaires` (`id_horaire`, `restaurant_code`, `jour`, `heure_ouverture`, `heure_fermeture`, `statut`) VALUES
(1, 'RES-DEMO-001', 'lundi', '09:00:00', '22:00:00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id_role` int NOT NULL,
  `code_role` varchar(50) NOT NULL,
  `nom_role` varchar(100) NOT NULL,
  `description` text,
  `statut` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id_role`, `code_role`, `nom_role`, `description`, `statut`, `created_at`) VALUES
(1, 'admin', 'Administrateur Woli', 'Accès total à la plateforme Woli', 1, '2025-12-20 15:01:15'),
(2, 'restaurant_owner', 'Propriétaire Restaurant', 'Gestion complète de son restaurant', 1, '2025-12-20 15:01:15');

-- --------------------------------------------------------

--
-- Structure de la table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id_role_permission` int NOT NULL,
  `role_code` varchar(50) NOT NULL,
  `permission_code` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `role_permissions`
--

INSERT INTO `role_permissions` (`id_role_permission`, `role_code`, `permission_code`) VALUES
(1, 'admin', 'category.manage'),
(2, 'admin', 'commission.manage'),
(3, 'admin', 'delivery.manage'),
(4, 'admin', 'delivery.track'),
(5, 'admin', 'driver.manage'),
(6, 'admin', 'gain.view'),
(45, 'admin', 'order.manage'),
(7, 'admin', 'order.update_status'),
(8, 'admin', 'order.view'),
(9, 'admin', 'payment.view'),
(10, 'admin', 'platform.settings'),
(11, 'admin', 'product.manage'),
(12, 'admin', 'report.view'),
(13, 'admin', 'restaurant.create'),
(14, 'admin', 'restaurant.delete'),
(44, 'admin', 'restaurant.manage'),
(15, 'admin', 'restaurant.settings'),
(16, 'admin', 'restaurant.update'),
(17, 'admin', 'restaurant.view'),
(18, 'admin', 'role.assign'),
(19, 'admin', 'role.view'),
(20, 'admin', 'user.create'),
(21, 'admin', 'user.delete'),
(22, 'admin', 'user.update'),
(23, 'admin', 'user.view'),
(35, 'restaurant_owner', 'category.manage'),
(47, 'restaurant_owner', 'commission.manage'),
(39, 'restaurant_owner', 'delivery.manage'),
(40, 'restaurant_owner', 'delivery.track'),
(41, 'restaurant_owner', 'driver.manage'),
(43, 'restaurant_owner', 'gain.view'),
(46, 'restaurant_owner', 'order.manage'),
(38, 'restaurant_owner', 'order.update_status'),
(37, 'restaurant_owner', 'order.view'),
(42, 'restaurant_owner', 'payment.view'),
(36, 'restaurant_owner', 'product.manage'),
(48, 'restaurant_owner', 'report.view'),
(34, 'restaurant_owner', 'restaurant.settings'),
(33, 'restaurant_owner', 'restaurant.update'),
(32, 'restaurant_owner', 'restaurant.view');

-- --------------------------------------------------------

--
-- Structure de la table `settings_platform`
--

CREATE TABLE `settings_platform` (
  `id_setting` int NOT NULL,
  `code_setting` varchar(100) NOT NULL,
  `valeur` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `settings_restaurants`
--

CREATE TABLE `settings_restaurants` (
  `id_setting` int NOT NULL,
  `restaurant_code` varchar(50) NOT NULL,
  `code_setting` varchar(100) NOT NULL,
  `valeur` enum('0','1') NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `code_user` varchar(50) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `telephone` varchar(30) DEFAULT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `statut` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `code_user`, `nom`, `email`, `telephone`, `mot_de_passe`, `statut`, `created_at`, `updated_at`) VALUES
(1, 'USR-ADMIN-001', 'Super Admin', 'admin@woli.com', NULL, '$2b$10$2jMog/eqWYzrn2iQ/s.EW.QszKfDHkCmhC7OoHH/BZ54LByJSgNFW', 1, '2025-12-20 15:18:05', '2025-12-20 15:18:05'),
(2, 'USR-RESTO-001', 'Resto Demo Owner', 'resto@woli.com', NULL, '$2b$10$o.JzLsj314joUCYg80n1rOWMGbtg58QBM2MccDl5Sey72oXF7U9s.', 1, '2025-12-20 15:21:05', '2025-12-20 15:21:05');

-- --------------------------------------------------------

--
-- Structure de la table `user_roles`
--

CREATE TABLE `user_roles` (
  `id_user_role` int NOT NULL,
  `user_code` varchar(50) NOT NULL,
  `role_code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user_roles`
--

INSERT INTO `user_roles` (`id_user_role`, `user_code`, `role_code`) VALUES
(1, 'USR-ADMIN-001', 'admin'),
(2, 'USR-RESTO-001', 'restaurant_owner');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_categorie`),
  ADD UNIQUE KEY `code_categorie` (`code_categorie`),
  ADD KEY `restaurant_code` (`restaurant_code`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id_client`),
  ADD UNIQUE KEY `code_client` (`code_client`),
  ADD KEY `restaurant_code` (`restaurant_code`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`id_commande`),
  ADD UNIQUE KEY `code_commande` (`code_commande`),
  ADD KEY `restaurant_code` (`restaurant_code`),
  ADD KEY `client_code` (`client_code`);

--
-- Index pour la table `commande_lignes`
--
ALTER TABLE `commande_lignes`
  ADD PRIMARY KEY (`id_commande_ligne`),
  ADD UNIQUE KEY `code_commande_ligne` (`code_commande_ligne`),
  ADD KEY `commande_code` (`commande_code`),
  ADD KEY `produit_code` (`produit_code`);

--
-- Index pour la table `commissions`
--
ALTER TABLE `commissions`
  ADD PRIMARY KEY (`id_commission`),
  ADD UNIQUE KEY `code_commission` (`code_commission`),
  ADD KEY `commande_code` (`commande_code`);

--
-- Index pour la table `gains`
--
ALTER TABLE `gains`
  ADD PRIMARY KEY (`id_gain`),
  ADD UNIQUE KEY `code_gain` (`code_gain`),
  ADD KEY `restaurant_code` (`restaurant_code`),
  ADD KEY `commande_code` (`commande_code`);

--
-- Index pour la table `livraisons`
--
ALTER TABLE `livraisons`
  ADD PRIMARY KEY (`id_livraison`),
  ADD UNIQUE KEY `code_livraison` (`code_livraison`),
  ADD KEY `commande_code` (`commande_code`),
  ADD KEY `livreur_code` (`livreur_code`);

--
-- Index pour la table `livraison_positions`
--
ALTER TABLE `livraison_positions`
  ADD PRIMARY KEY (`id_position`),
  ADD KEY `livraison_code` (`livraison_code`);

--
-- Index pour la table `livreurs`
--
ALTER TABLE `livreurs`
  ADD PRIMARY KEY (`id_livreur`),
  ADD UNIQUE KEY `code_livreur` (`code_livreur`),
  ADD KEY `restaurant_code` (`restaurant_code`);

--
-- Index pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD PRIMARY KEY (`id_paiement`),
  ADD UNIQUE KEY `code_paiement` (`code_paiement`),
  ADD KEY `commande_code` (`commande_code`);

--
-- Index pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id_permission`),
  ADD UNIQUE KEY `code_permission` (`code_permission`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id_produit`),
  ADD UNIQUE KEY `code_produit` (`code_produit`),
  ADD KEY `restaurant_code` (`restaurant_code`),
  ADD KEY `categorie_code` (`categorie_code`);

--
-- Index pour la table `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`id_restaurant`),
  ADD UNIQUE KEY `code_restaurant` (`code_restaurant`),
  ADD KEY `user_code` (`user_code`);

--
-- Index pour la table `restaurant_fermetures`
--
ALTER TABLE `restaurant_fermetures`
  ADD PRIMARY KEY (`id_fermeture`),
  ADD KEY `restaurant_code` (`restaurant_code`);

--
-- Index pour la table `restaurant_horaires`
--
ALTER TABLE `restaurant_horaires`
  ADD PRIMARY KEY (`id_horaire`),
  ADD UNIQUE KEY `restaurant_code` (`restaurant_code`,`jour`),
  ADD KEY `restaurant_code_2` (`restaurant_code`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`),
  ADD UNIQUE KEY `code_role` (`code_role`);

--
-- Index pour la table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id_role_permission`),
  ADD UNIQUE KEY `role_code` (`role_code`,`permission_code`),
  ADD KEY `role_code_2` (`role_code`),
  ADD KEY `permission_code` (`permission_code`);

--
-- Index pour la table `settings_platform`
--
ALTER TABLE `settings_platform`
  ADD PRIMARY KEY (`id_setting`),
  ADD UNIQUE KEY `code_setting` (`code_setting`);

--
-- Index pour la table `settings_restaurants`
--
ALTER TABLE `settings_restaurants`
  ADD PRIMARY KEY (`id_setting`),
  ADD UNIQUE KEY `restaurant_code` (`restaurant_code`,`code_setting`),
  ADD KEY `restaurant_code_2` (`restaurant_code`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `code_user` (`code_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id_user_role`),
  ADD UNIQUE KEY `user_code` (`user_code`,`role_code`),
  ADD KEY `user_code_2` (`user_code`),
  ADD KEY `role_code` (`role_code`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_categorie` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id_client` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `id_commande` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `commande_lignes`
--
ALTER TABLE `commande_lignes`
  MODIFY `id_commande_ligne` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `commissions`
--
ALTER TABLE `commissions`
  MODIFY `id_commission` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gains`
--
ALTER TABLE `gains`
  MODIFY `id_gain` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `livraisons`
--
ALTER TABLE `livraisons`
  MODIFY `id_livraison` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `livraison_positions`
--
ALTER TABLE `livraison_positions`
  MODIFY `id_position` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `livreurs`
--
ALTER TABLE `livreurs`
  MODIFY `id_livreur` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paiements`
--
ALTER TABLE `paiements`
  MODIFY `id_paiement` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id_permission` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `id_produit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `restaurants`
--
ALTER TABLE `restaurants`
  MODIFY `id_restaurant` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `restaurant_fermetures`
--
ALTER TABLE `restaurant_fermetures`
  MODIFY `id_fermeture` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `restaurant_horaires`
--
ALTER TABLE `restaurant_horaires`
  MODIFY `id_horaire` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id_role_permission` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pour la table `settings_platform`
--
ALTER TABLE `settings_platform`
  MODIFY `id_setting` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `settings_restaurants`
--
ALTER TABLE `settings_restaurants`
  MODIFY `id_setting` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id_user_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `fk_clients_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `fk_commandes_client` FOREIGN KEY (`client_code`) REFERENCES `clients` (`code_client`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_commandes_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commande_lignes`
--
ALTER TABLE `commande_lignes`
  ADD CONSTRAINT `fk_lignes_commande` FOREIGN KEY (`commande_code`) REFERENCES `commandes` (`code_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lignes_produit` FOREIGN KEY (`produit_code`) REFERENCES `produits` (`code_produit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commissions`
--
ALTER TABLE `commissions`
  ADD CONSTRAINT `fk_commissions_commande` FOREIGN KEY (`commande_code`) REFERENCES `commandes` (`code_commande`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `gains`
--
ALTER TABLE `gains`
  ADD CONSTRAINT `fk_gains_commande` FOREIGN KEY (`commande_code`) REFERENCES `commandes` (`code_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_gains_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `livraisons`
--
ALTER TABLE `livraisons`
  ADD CONSTRAINT `fk_livraisons_commande` FOREIGN KEY (`commande_code`) REFERENCES `commandes` (`code_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_livraisons_livreur` FOREIGN KEY (`livreur_code`) REFERENCES `livreurs` (`code_livreur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `livraison_positions`
--
ALTER TABLE `livraison_positions`
  ADD CONSTRAINT `fk_positions_livraison` FOREIGN KEY (`livraison_code`) REFERENCES `livraisons` (`code_livraison`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `livreurs`
--
ALTER TABLE `livreurs`
  ADD CONSTRAINT `fk_livreurs_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `fk_paiements_commande` FOREIGN KEY (`commande_code`) REFERENCES `commandes` (`code_commande`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `fk_produits_categorie` FOREIGN KEY (`categorie_code`) REFERENCES `categories` (`code_categorie`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_produits_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `restaurants`
--
ALTER TABLE `restaurants`
  ADD CONSTRAINT `fk_restaurants_user` FOREIGN KEY (`user_code`) REFERENCES `users` (`code_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `restaurant_fermetures`
--
ALTER TABLE `restaurant_fermetures`
  ADD CONSTRAINT `fk_fermetures_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `restaurant_horaires`
--
ALTER TABLE `restaurant_horaires`
  ADD CONSTRAINT `fk_horaires_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_code`) REFERENCES `permissions` (`code_permission`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_code`) REFERENCES `roles` (`code_role`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `settings_restaurants`
--
ALTER TABLE `settings_restaurants`
  ADD CONSTRAINT `fk_settings_restaurant` FOREIGN KEY (`restaurant_code`) REFERENCES `restaurants` (`code_restaurant`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_code`) REFERENCES `roles` (`code_role`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_code`) REFERENCES `users` (`code_user`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
