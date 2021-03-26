-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 23 mars 2021 à 18:10
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

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alpha` (IN `aa` INT)  NO SQL
BEGIN

declare retour int;
set retour=0;

select count(*) into retour from influenceur;

if retour>aa then 
select retour;
ELSE
select 'blabla';
end if;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procédure_vote` (IN `vpseudo` VARCHAR(50), IN `vip` VARCHAR(50), IN `vage` VARCHAR(50), IN `vpays` VARCHAR(50), IN `vgenre` VARCHAR(50), IN `vid_event` INT, IN `vid_influenceur` INT, IN `vdate_vote` DATE)  BEGIN
declare verif_inscription, verif_ip, verif_pseudo,retour int;
declare deb, fin date;

set retour=0;
/*on verifie si l'utilisateur est inscrit =1 et 0 sinon*/
select count(*) into  verif_inscription from utilisateur 
where pseudo = vpseudo;

/*on compte le nombre de fois que cet ip a voté dans la journée**/
select count(u.ip) into verif_ip from voter v, utilisateur u where v.pseudo=u.pseudo and v.date_vote=vdate_vote and u.ip= vip;

/*on compte le nombre de fois que ce pseudo a voté dans la journée*/
select count(pseudo) into verif_pseudo from voter where pseudo= vpseudo and date_vote= vdate_vote;

/*on sélectionne la date début de l'évènement*/
select date_debut into deb from evenement where id_event= vid_event;

/*on sélectionne la date fin de l'évènement*/
select date_fin into fin from evenement where id_event= vid_event;

/*Vérifications*/

/*on inscrit le votant si ce n'est pas encore le cas*/
if (verif_inscription = 0) then 
insert into utilisateur(pseudo,ip,  pays, age, genre) values (vpseudo,vip,  vpays, vage, vgenre );
end if;

/*on vérifie que le pseudo n'a pas déjà voté dans la journée, si oui retour=-1*/
if verif_pseudo > 0 then 
set retour= -1;

/*on vérifie que le ip n'a pas voté plus de 5 fois dans la journée, si oui retour=-2*/
ELSEIF verif_ip >5 THEN 
set retour= -2 ;


/*on vérifie si le vote est toujours ouvert, si oui retour=-3*/
ELSEIF deb> vdate_vote or fin< vdate_vote then 
set retour= -3;

/*si tout s'est bien passé retour=0*/
else
set retour=0;
end if;

/*si tout s'est bien passé on insère le vote*/
if retour=0 THEN
insert into voter(date_vote,ip, id_event, id_influenceur, pseudo) values(vdate_vote, vip, vid_event, vid_influenceur, vpseudo);
end if;

/*on retourne la variable retour*/
select deb, fin,vdate_vote, retour;

END$$

DELIMITER ;

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

--
-- Déchargement des données de la table `evenement`
--

INSERT INTO `evenement` (`id_event`, `nom_event`, `date_debut`, `date_fin`) VALUES
(1, 'Abdia', '2021-03-22', '2021-03-27');

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
(63, 'JENY BSG', 10),
(64, 'TOUS EN WAX', 7),
(65, 'SCHEENA DONIA', 13),
(66, 'KERY JAMES', 13),
(67, 'JOJO LE COMEDIEN', 6),
(68, 'TATA OSCA', 6),
(69, 'JERRY PURPDRANK', 6),
(70, 'AKIMOTO', 11),
(71, 'MR BORIS BECKER', 11),
(72, 'OMAR SY', 13),
(73, 'JACKIE AINA', 13),
(74, 'KOBBY WILLS OFFICIAL', 13),
(75, 'OBSERVATEUR EBENE', 6),
(76, 'KIITANA', 11),
(77, 'FARIDA SAIDOU', 11),
(78, 'AMINA MAGAZINE', 7);

-- --------------------------------------------------------

--
-- Structure de la table `participer`
--

CREATE TABLE `participer` (
  `id_candidature` int(11) NOT NULL,
  `id_event` int(11) NOT NULL,
  `id_influenceur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `participer`
--

INSERT INTO `participer` (`id_candidature`, `id_event`, `id_influenceur`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 15),
(16, 1, 16),
(17, 1, 17),
(18, 1, 18),
(19, 1, 19),
(20, 1, 20),
(21, 1, 21),
(22, 1, 22),
(23, 1, 23),
(24, 1, 24),
(25, 1, 25),
(26, 1, 26),
(27, 1, 27),
(28, 1, 28),
(29, 1, 29),
(30, 1, 30),
(31, 1, 31),
(32, 1, 32),
(33, 1, 33),
(34, 1, 34),
(35, 1, 35),
(36, 1, 36),
(37, 1, 37),
(38, 1, 38),
(39, 1, 39),
(40, 1, 40),
(41, 1, 41),
(42, 1, 42),
(43, 1, 43),
(44, 1, 44),
(45, 1, 45),
(46, 1, 46),
(47, 1, 47),
(48, 1, 48),
(49, 1, 49),
(50, 1, 50),
(51, 1, 51),
(52, 1, 52),
(53, 1, 53),
(54, 1, 54),
(55, 1, 55),
(56, 1, 56),
(57, 1, 57),
(58, 1, 58),
(59, 1, 59),
(60, 1, 60),
(61, 1, 61),
(62, 1, 62),
(63, 1, 63),
(64, 1, 64),
(65, 1, 65),
(66, 1, 66),
(67, 1, 67),
(68, 1, 68),
(69, 1, 69),
(70, 1, 70),
(71, 1, 71),
(72, 1, 72),
(73, 1, 73),
(74, 1, 74),
(75, 1, 75),
(76, 1, 76),
(77, 1, 77),
(78, 1, 78);

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
-- Index pour la table `participer`
--
ALTER TABLE `participer`
  ADD PRIMARY KEY (`id_candidature`),
  ADD KEY `participer_ibfk_1` (`id_event`),
  ADD KEY `participer_ibfk_2` (`id_influenceur`);

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
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `influenceur`
--
ALTER TABLE `influenceur`
  MODIFY `id_influenceur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT pour la table `participer`
--
ALTER TABLE `participer`
  MODIFY `id_candidature` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `influenceur`
--
ALTER TABLE `influenceur`
  ADD CONSTRAINT `fk_id_categorie` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`);

--
-- Contraintes pour la table `participer`
--
ALTER TABLE `participer`
  ADD CONSTRAINT `participer_ibfk_1` FOREIGN KEY (`id_event`) REFERENCES `evenement` (`id_event`),
  ADD CONSTRAINT `participer_ibfk_2` FOREIGN KEY (`id_influenceur`) REFERENCES `influenceur` (`id_influenceur`);

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
