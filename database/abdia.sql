-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 22 mars 2021 à 21:56
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `abdia`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id_categorie` int(11) NOT NULL,
  `nom_categorie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id_categorie`, `nom_categorie`) VALUES
(1, 'Travel'),
(2, 'Lifestyle'),
(3, 'Fashion Homme'),
(4, 'Fashion Femme'),
(5, 'Food'),
(6, 'Humour'),
(7, 'Media d\'influence'),
(8, 'Chanteurs'),
(9, 'Chanteuses'),
(10, 'Danseurs'),
(11, 'Influenceur espoir'),
(12, 'Figure Entrepreneur'),
(13, 'Award d\'honneur');

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE `evenement` (
  `id_event` int(11) NOT NULL,
  `nom_event` varchar(50) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `influenceur`
--

CREATE TABLE `influenceur` (
  `id_influenceur` int(11) NOT NULL,
  `nom_influenceur` varchar(50) NOT NULL,
  `id_categorie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `influenceur`
--

INSERT INTO `influenceur` (`id_influenceur`, `nom_influenceur`, `id_categorie`) VALUES
(1, 'DUDE THAT COOKZ', 5),
(2, 'PAPA SCRIPT', 10),
(3, 'MICHAEL BLACKSON', 6),
(4, 'INVESTIR AU PAYS', 7),
(5, 'WENDY SHAY', 9),
(6, 'UGO MOZIE', 12),
(7, 'AMARACHI EKEKWE', 1),
(8, 'ANERLISA MUIGAI', 4),
(9, 'AFUA RIDA', 4),
(10, 'IMMACULATESBITES', 5),
(11, 'ERICK PRINCE', 1),
(12, 'FATOU N\'DIAYE', 13),
(13, 'FANTA KONE', 2),
(14, 'TAYC', 8),
(15, 'TREVOR STRUURMAN', 3),
(16, 'BLACK FOODIE', 5),
(17, 'ROTIMI', 8),
(18, 'ARONE CROSS', 3),
(19, 'TWIN 225 OFFICIEL', 10),
(20, 'BOZOMA SAINT JOHN', 12),
(21, 'ABEER SINDER', 2),
(22, 'SILVIA NJOKI', 1),
(23, 'ERNEST DINKU JR', 3),
(24, 'AAMITO LAGUM', 2),
(25, 'SOBEKWA TWINS', 2),
(26, 'KWESI ARTHUR', 8),
(27, 'KARELL VIGNON VULLIERME', 5),
(28, 'MILLY MIRA', 1),
(29, 'LOURENS GEBHARTD', 3),
(30, 'LAMIC KIRABO', 4),
(31, 'ONYI MOSS', 4),
(32, 'BENGINE ELISCAR', 4),
(33, 'KAYVON STEEZIE', 6),
(34, 'IGEE OKAFOR', 3),
(35, 'WINNIE RIOBA', 1),
(36, 'DIAMOND PLATNUMZ', 8),
(37, 'AYA NAKAMURA', 9),
(38, 'SHARON MUNDIA', 2),
(39, 'ESSIESPIECE', 5),
(40, 'CRAZY SALLY', 11),
(41, 'TIWA SAVAGE', 9),
(42, 'MELODY MOLALE', 4),
(43, 'BAD GYAL CASSIE', 10),
(44, 'THABISO MALAPE', 12),
(45, 'SHAN’L', 9),
(46, 'HADIZA LAWAL', 5),
(47, 'LA PETITE ZOTA', 10),
(48, 'DOKOLOSS', 11),
(49, 'STEVEN ONOJA', 3),
(50, 'NATACHASAMA', 2),
(51, 'BURNA BOY', 8),
(52, 'THIONE NIANG', 12),
(53, 'OBINNA OKWODU', 12),
(54, 'NWE', 7),
(55, 'YEMI ALADE', 9),
(56, 'ELTON ANDERSON JR', 1),
(57, 'ROOTS MAGAZINE', 7),
(58, 'DADJU', 8),
(59, 'SHO MADJOZI', 9),
(60, 'LES TWINS', 10),
(61, 'HAPSATOU SY', 12),
(62, 'AFRIQUETTE', 7),
(63, 'JENY BSG', 10);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `pseudo` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `pays` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `genre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `voter`
--

CREATE TABLE `voter` (
  `pseudo` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `date_vote` date NOT NULL,
  `id_event` int(11) NOT NULL,
  `id_influenceur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id_categorie`);

--
-- Index pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`id_event`);

--
-- Index pour la table `influenceur`
--
ALTER TABLE `influenceur`
  ADD PRIMARY KEY (`id_influenceur`),
  ADD KEY `fk_id_categorie` (`id_categorie`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`pseudo`);

--
-- Index pour la table `voter`
--
ALTER TABLE `voter`
  ADD KEY `fk_pseudo` (`pseudo`),
  ADD KEY `fk_id_event` (`id_event`),
  ADD KEY `fk_id_influenceur` (`id_influenceur`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id_categorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `influenceur`
--
ALTER TABLE `influenceur`
  MODIFY `id_influenceur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `influenceur`
--
ALTER TABLE `influenceur`
  ADD CONSTRAINT `fk_id_categorie` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`);

--
-- Contraintes pour la table `voter`
--
ALTER TABLE `voter`
  ADD CONSTRAINT `fk_id_event` FOREIGN KEY (`id_event`) REFERENCES `evenement` (`id_event`),
  ADD CONSTRAINT `fk_id_influenceur` FOREIGN KEY (`id_influenceur`) REFERENCES `influenceur` (`id_influenceur`),
  ADD CONSTRAINT `fk_pseudo` FOREIGN KEY (`pseudo`) REFERENCES `utilisateur` (`pseudo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
