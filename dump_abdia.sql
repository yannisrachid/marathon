-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 23 mars 2021 à 16:51
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 8.0.1

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `procédure_vote` (IN `vpseudo` VARCHAR(50), IN `vip` VARCHAR(50), IN `vage` VARCHAR(50), IN `vpays` VARCHAR(50), IN `vgenre` VARCHAR(50), IN `vid_event` INT, IN `vid_influenceur` INT, IN `vdate_vote` DATE)  BEGIN
declare verif_inscription, verif_ip, verif_pseudo,retour int;
declare deb, fin date;

set retour=0;
/*on verifie si l'utilisateur est inscrit =1 et 0 sinon*/
select count(*) into  verif_inscription from utilisateur 
where pseudo = vpseudo;

/*on compte le nombre de fois que cet ip a voté pour cette date, dans cette categorie, pour cet evenement**/
select count(u.ip) into verif_ip 
from voter v, utilisateur u, influenceur i 
where v.pseudo=u.pseudo and i.id_influenceur=v.id_influenceur
		and u.ip= vip
        and v.date_vote=vdate_vote 
		and v.id_event=vid_event 
        AND i.id_categorie=(select id_categorie from influenceur where 			id_influenceur=vid_influenceur);

/*on compte le nombre de fois que ce pseudo a voté dans la journée, cet évenement et cette categorie*/
select count(v.pseudo) into verif_pseudo 
from voter v, utilisateur u, influenceur i 
where v.pseudo=u.pseudo and i.id_influenceur=v.id_influenceur
	 and v.pseudo= vpseudo 
     and date_vote= vdate_vote 
     AND i.id_categorie=(select id_categorie from influenceur where 			id_influenceur=vid_influenceur);

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
select retour;

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
(1, ''),
(2, '');

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
(1, 'award', '2020-11-10', '2021-11-10'),
(2, 'egfgfd', '2020-11-10', '2021-11-10');

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
(1, '', 1),
(2, '', 2);

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
(2, 1, 2);

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

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`pseudo`, `ip`, `pays`, `age`, `genre`) VALUES
('ishsdkcndkls', '1212355', 'senegal', 15, 'homme'),
('ishsdkcndklsy', '1212355', 'senegal', 15, 'homme');

-- --------------------------------------------------------

--
-- Structure de la table `voter`
--

CREATE TABLE `voter` (
  `pseudo` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `date_vote` date NOT NULL,
  `id_event` int(11) NOT NULL,
  `id_influenceur` int(11) NOT NULL,
  `id_vote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `voter`
--

INSERT INTO `voter` (`pseudo`, `ip`, `date_vote`, `id_event`, `id_influenceur`, `id_vote`) VALUES
('ishsdkcndkls', '1212355', '2021-10-10', 1, 1, 1),
('ishsdkcndkls', '1212355', '2021-10-10', 1, 2, 2);

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
  ADD KEY `id_event` (`id_event`),
  ADD KEY `id_influenceur` (`id_influenceur`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`pseudo`);

--
-- Index pour la table `voter`
--
ALTER TABLE `voter`
  ADD PRIMARY KEY (`id_vote`),
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
  MODIFY `id_categorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `influenceur`
--
ALTER TABLE `influenceur`
  MODIFY `id_influenceur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `participer`
--
ALTER TABLE `participer`
  MODIFY `id_candidature` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `voter`
--
ALTER TABLE `voter`
  MODIFY `id_vote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
