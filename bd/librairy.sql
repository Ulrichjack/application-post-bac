-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:4306
-- Généré le : ven. 27 déc. 2024 à 21:28
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `librairy`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_etudiant_id` ()   BEGIN
    DECLARE next_val INT;

    -- Verifier et obtenir le prochain numéro dans la séquence
    SELECT next_value INTO next_val FROM sequence WHERE seq_name = 'etudiant_id_seq' FOR UPDATE;

    -- Formater l'identifiant
    SET @new_id = CONCAT('BCF', LPAD(next_val, 4, '0'));

    -- Mettre à jour le numéro suivant dans la séquence
    UPDATE sequence SET next_value = next_value + 1 WHERE seq_name = 'etudiant_id_seq';

    -- Retourner l'identifiant généré
    SELECT @new_id AS new_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `concours`
--

CREATE TABLE `concours` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `ecole` varchar(255) DEFAULT NULL,
  `domaine` varchar(255) DEFAULT NULL,
  `places` int(11) DEFAULT NULL,
  `lien` varchar(255) DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `diplome_requis` varchar(255) DEFAULT NULL,
  `conditions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `concours`
--

INSERT INTO `concours` (`id`, `nom`, `ecole`, `domaine`, `places`, `lien`, `date_debut`, `date_fin`, `diplome_requis`, `conditions`) VALUES
(1, 'Concours de recrutement à la Cameron Railways (Camrail)', 'Cameron Railways', 'Transports', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-07-01', '2024-08-15', 'BAC Technique', 'Expérience professionnelle de 2 ans dans le secteur ferroviaire'),
(2, 'Concours IDE-TMS-SAGES-FEMMES-AIDES-SOIGNANTS MINSANTE 2024', 'Ministère de la Santé', 'Santé', 200, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-15', '2024-07-30', 'BAC en Sciences', 'Diplôme d’État en soins infirmiers, ou équivalent'),
(3, 'Concours d\'entrée en Classes Scientifiques Spéciales ENS de l\'Université de Yaoundé I 2024/2025', 'Université de Yaoundé I', 'Éducation', 50, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-01', '2024-06-15', 'BAC Scientifique', 'Note moyenne de 12/20 en mathématiques et physique'),
(4, 'Concours pour le recrutement de ressortissants des États membres de la CEEAC 2024', 'CEEAC', 'Économie', 1100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-01', '2024-07-31', 'BAC', 'Citoyen de l’un des États membres de la CEEAC'),
(5, 'Concours de l\'Ecole Nationale des Eaux et Forêts de Mbalmayo (ENEF) 2024', 'ENEF Mbalmayo', 'Environnement', 120, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-10', '2024-06-20', 'BAC D', 'Avoir moins de 30 ans au 1er janvier 2024'),
(6, 'Concours d\'entrée à l\'École Nationale Supérieure Polytechnique de Douala (ENSPD) 2024-2025', 'Université de Douala', 'Ingénierie', 80, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-15', '2024-06-10', 'BAC C', 'Note moyenne de 14/20 en mathématiques et physique'),
(7, 'Concours d\'entrée à l\'École Nationale Supérieure Polytechnique de Bamenda (ENSPB) 2024', 'Université de Bamenda', 'Ingénierie', 90, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-20', '2024-07-05', 'BAC C ou D', 'Être âgé de moins de 25 ans'),
(8, 'Concours d\'entrée à l\'École Supérieure de Transformation des Mines et des Ressources Énergétiques (ESTM) de l\'Université de Bertoua 2024/2025', 'Université de Bertoua', 'Ressources naturelles', 75, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-01', '2024-08-01', 'BAC Technique', 'Expérience de 1 an dans le domaine minier ou énergétique'),
(9, 'Concours d\'entrée à l\'Institut des Beaux-Arts et de l\'Innovation (IBAI) de l\'Université de Garoua 2024/2025', 'Université de Garoua', 'Arts', 50, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-25', '2024-06-30', 'BAC', 'Portfolio artistique requis'),
(10, 'Concours d\'entrée à l\'École Supérieure de Transport, de Logistique et de Commerce (ESTLC) de l\'Université d\'Ebolowa 2024', 'Université d\'Ebolowa', 'Logistique', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-15', '2024-07-20', 'BAC G2', 'Compétences en logistique et gestion des stocks'),
(11, 'Concours des personnels de traduction et d\'interprétation MINFOPRA 2024', 'MINFOPRA', 'Traduction', 60, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-10', '2024-06-05', 'BAC + Licence en langues', 'Excellente maîtrise de deux langues au moins'),
(12, 'Concours d\'entrée à l\'Institut de Formation et de Recherche Démographiques (I.F.O.R.D.) 2024', 'I.F.O.R.D.', 'Démographie', 45, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-01', '2024-07-15', 'BAC + Licence en sciences sociales', 'Expérience de 1 an en recherche démographique'),
(13, 'Concours d\'entrée au Centre d\'Appui aux Ecoles de Statistique Africaines (CAPESA/ISSEA) 2024', 'CAPESA/ISSEA', 'Statistiques', 30, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-10', '2024-06-30', 'BAC + Licence en mathématiques', 'Compétences en analyse statistique requises'),
(14, 'Concours d\'entrée à l\'Institut Universitaire de Technologie de l\'Université de Ngaoundéré 2024/2025', 'Université de Ngaoundéré', 'Technologie', 150, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-20', '2024-06-15', 'BAC Technique', 'Avoir moins de 25 ans au 1er janvier 2024'),
(15, 'Concours d\'entrée à l\'École Supérieure de Traducteurs et Interprètes (ASTI) de l\'Université de Buéa 2024/2025', 'Université de Buéa', 'Traduction', 80, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-05', '2024-06-30', 'BAC + Licence en langues', 'Compétences en traduction et interprétation'),
(16, 'Concours d\'entrée à l\'École de Technologie (COT) de l\'Université de Buéa 2024/2025', 'Université de Buéa', 'Technologie', 90, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-15', '2024-07-10', 'BAC Technique', 'Note moyenne de 13/20 en matières techniques'),
(17, 'Concours d\'entrée en première année du cycle de licence de la Faculté des sciences de l\'Université d\'Ebolowa 2024', 'Université d\'Ebolowa', 'Sciences', 120, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-30', '2024-06-20', 'BAC C ou D', 'Excellents résultats en sciences'),
(18, 'Concours international d\'entrée au cycle de diplôme master professionnel en assurance (MPA) promotion 2024-2026', 'Université de Yaoundé II', 'Assurance', 60, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-01', '2024-08-01', 'BAC + Licence', 'Expérience professionnelle dans le secteur des assurances'),
(19, 'Concours d\'entrée à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Douala 2024/2025', 'Université de Douala', 'Sciences Halieutiques', 50, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-15', '2024-06-10', 'BAC D', 'Compétences en biologie marine ou halieutique'),
(20, 'Concours d\'entrée en première année à l\'École des Sciences et de Médecine Vétérinaire (ESMV) de l\'Université de Ngaoundéré 2024/2025', 'Université de Ngaoundéré', 'Médecine Vétérinaire', 60, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-10', '2024-07-15', 'BAC C ou D', 'Bonne condition physique, passion pour les animaux'),
(21, 'Concours d\'entrée à l\'Institut Universitaire de Technologie (IUT) de l\'Université de Dschang 2024/2025', 'Université de Dschang', 'Technologie', 70, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-01', '2024-07-10', 'BAC Technique ou G', 'Compétences en gestion technologique requises'),
(22, 'Concours d\'entrée en première année à l\'École Supérieure des Travaux Publics (ESTP) de l\'Université de Yaoundé I 2024', 'Université de Yaoundé I', 'Travaux Publics', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-20', '2024-06-30', 'BAC Technique', 'Compétences en construction et génie civil'),
(23, 'Concours d\'entrée en première année à l\'Institut Universitaire de Technologie (IUT) de l\'Université de Buéa 2024/2025', 'Université de Buéa', 'Technologie', 90, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-10', '2024-07-10', 'BAC Technique ou G', 'Compétences en technologie de l’information'),
(24, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Douala 2024', 'Université de Douala', 'Sciences Halieutiques', 40, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-25', '2024-06-20', 'BAC D', 'Compétences en sciences halieutiques requises'),
(25, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Maroua 2024', 'Université de Maroua', 'Sciences Halieutiques', 50, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-15', '2024-07-10', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(26, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Ngaoundéré 2024', 'Université de Ngaoundéré', 'Sciences Halieutiques', 60, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-30', '2024-06-25', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(27, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Garoua 2024', 'Université de Garoua', 'Sciences Halieutiques', 70, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-05', '2024-07-05', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(28, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Bertoua 2024', 'Université de Bertoua', 'Sciences Halieutiques', 80, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-15', '2024-06-30', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(29, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Dschang 2024', 'Université de Dschang', 'Sciences Halieutiques', 90, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-01', '2024-06-25', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(30, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Buéa 2024', 'Université de Buéa', 'Sciences Halieutiques', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-20', '2024-06-30', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(31, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Yaoundé I 2024', 'Université de Yaoundé I', 'Sciences Halieutiques', 110, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-10', '2024-07-10', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(32, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Maroua 2024', 'Université de Maroua', 'Sciences Halieutiques', 120, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-25', '2024-06-25', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(33, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Bertoua 2024', 'Université de Bertoua', 'Sciences Halieutiques', 130, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-01', '2024-07-05', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(34, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Douala 2024', 'Université de Douala', 'Sciences Halieutiques', 140, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-30', '2024-06-30', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(35, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Garoua 2024', 'Université de Garoua', 'Sciences Halieutiques', 150, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-15', '2024-07-10', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(36, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Buéa 2024', 'Université de Buéa', 'Sciences Halieutiques', 160, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-04-20', '2024-06-30', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(37, 'Concours d\'entrée en première année à l\'Institut des Sciences Halieutiques (ISH) de l\'Université de Yaoundé I 2024', 'Université de Yaoundé I', 'Sciences Halieutiques', 170, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-10', '2024-07-10', 'BAC D ou C', 'Compétences en biologie marine ou halieutique'),
(38, 'Concours d\'entrée à l\'Institut Supérieur de Commerce et de Gestion (ISCG) de l\'Université de Ngaoundéré 2024/2025', 'Université de Ngaoundéré', 'Commerce et Gestion', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-15', '2024-07-15', 'BAC C, D ou G', 'Compétences en mathématiques et en économie'),
(39, 'Concours d\'entrée en première année à l\'École Nationale Supérieure des Postes et Télécommunications (ENSPT) de Yaoundé 2024/2025', 'Université de Yaoundé I', 'Postes et Télécommunications', 80, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-01', '2024-08-01', 'BAC C ou D', 'Excellentes compétences en sciences et technologies'),
(40, 'Concours d\'entrée en première année à l\'Institut Supérieur des Techniques Appliquées (ISTA) de l\'Université de Douala 2024/2025', 'Université de Douala', 'Techniques Appliquées', 120, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-20', '2024-07-10', 'BAC Technique ou F', 'Compétences en ingénierie et technologies appliquées'),
(41, 'Concours d\'entrée en première année à l\'École Normale Supérieure (ENS) de l\'Université de Maroua 2024/2025', 'Université de Maroua', 'Éducation', 150, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-10', '2024-08-10', 'BAC toutes séries', 'Passion pour l\'enseignement et l\'éducation'),
(42, 'Concours d\'entrée en première année à l\'École Supérieure d\'Ingénierie de l\'Université de Buéa 2024/2025', 'Université de Buéa', 'Ingénierie', 90, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-05', '2024-07-05', 'BAC C, D ou E', 'Compétences en mathématiques et en sciences physiques'),
(43, 'Concours d\'entrée en première année à l\'Institut des Beaux-Arts (IBA) de l\'Université de Nkongsamba 2024/2025', 'Université de Nkongsamba', 'Arts', 50, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-15', '2024-08-15', 'BAC toutes séries', 'Talent artistique démontré par un portfolio'),
(44, 'Concours d\'entrée en première année à l\'Institut Supérieur des Sciences de la Santé (ISSS) de l\'Université de Bertoua 2024/2025', 'Université de Bertoua', 'Sciences de la Santé', 70, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-25', '2024-07-25', 'BAC C ou D', 'Connaissances en biologie et sciences de la santé'),
(45, 'Concours d\'entrée en première année à l\'Institut des Sciences et Techniques de l\'Information et de la Communication (ISTIC) de l\'Université de Yaoundé II 2024/2025', 'Université de Yaoundé II', 'Information et Communication', 80, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-05', '2024-08-05', 'BAC toutes séries', 'Excellentes compétences en communication et technologies de l\'information'),
(46, 'Concours d\'entrée en première année à l\'Institut National de Jeunesse et Sports (INJS) de Yaoundé 2024/2025', 'Université de Yaoundé I', 'Sports et Jeunesse', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-07-01', '2024-09-01', 'BAC toutes séries', 'Aptitude physique et passion pour les sports'),
(47, 'Concours d\'entrée en première année à l\'Institut Universitaire des Sciences de l\'Environnement et de la Développement Durable (IUSED) de l\'Université de Douala 2024/2025', 'Université de Douala', 'Environnement et Développement Durable', 60, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-10', '2024-08-10', 'BAC D ou C', 'Intérêt pour les questions environnementales et le développement durable'),
(48, 'Concours d\'entrée en première année à l\'Institut National Supérieur de l\'Agriculture et de l\'Elevage (INSAE) de l\'Université de Ngaoundéré 2024/2025', 'Université de Ngaoundéré', 'Agriculture et Élevage', 110, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-05-20', '2024-07-20', 'BAC C, D ou E', 'Connaissances en agriculture, élevage et sciences de la nature'),
(49, 'Concours d\'entrée en première année à l\'École Nationale d\'Administration et de Magistrature (ENAM) de Yaoundé 2024/2025', 'Université de Yaoundé II', 'Administration et Magistrature', 120, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-01', '2024-08-01', 'BAC toutes séries', 'Compétences en droit, sciences politiques ou administration'),
(50, 'Concours d\'entrée en première année à l\'École Supérieure des Sciences et Techniques de l\'Information (ESSTI) de l\'Université de Buéa 2024/2025', 'Université de Buéa', 'Sciences de l\'Information', 100, 'https://infosconcourseducation.com/liste-des-concours-2024-2025-lances-au-cameroun/', '2024-06-15', '2024-08-15', 'BAC toutes séries', 'Compétences en technologies de l\'information et en communication');

-- --------------------------------------------------------

--
-- Structure de la table `ecole`
--

CREATE TABLE `ecole` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `domaine` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `diploma` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `modality` varchar(255) DEFAULT NULL,
  `conditions` varchar(255) DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `etablissement` varchar(255) DEFAULT NULL,
  `Serie_Bac_requis` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ecole`
--

INSERT INTO `ecole` (`id`, `nom`, `domaine`, `description`, `location`, `diploma`, `duration`, `modality`, `conditions`, `dateDebut`, `etablissement`, `Serie_Bac_requis`) VALUES
(1, 'Université de Yaoundé I', 'Sciences', 'Institution de premier plan offrant des programmes en sciences et en technologie.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(2, 'Université de Yaoundé II', 'Droit', 'Spécialisée en sciences sociales et droit, avec une forte tradition académique.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Yaoundé II', 'Séri'),
(3, 'Université de Yaoundé I', 'Informatique', 'Formation avancée en informatique et technologie de l\'information.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(4, 'Université de Yaoundé I', 'Médecine', 'Offre des programmes complets en médecine et sciences de la santé.', 'Yaoundé', 'Doctorat', 7, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(5, 'Université de Yaoundé II', 'Sciences Politiques', 'Université renommée pour ses programmes en sciences politiques et administration publique.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Yaoundé II', 'Séri'),
(6, 'Université de Yaoundé I', 'Arts', 'Institution offrant des formations en beaux-arts, musique et théâtre.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(7, 'Université de Yaoundé I', 'Sciences Sociales', 'Spécialisée en sociologie, psychologie et anthropologie.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(8, 'Université de Yaoundé I', 'Génie Civil', 'Formation en ingénierie civile et infrastructure.', 'Yaoundé', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(9, 'Université de Yaoundé I', 'Éducation', 'Offre des programmes en sciences de l\'éducation et formation des enseignants.', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(10, 'Université de Yaoundé I', 'Génie Électrique', 'Formation en génie électrique et électronique.', 'Yaoundé', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(11, 'Université de Douala', 'Gestion', 'Spécialisée en gestion et économie, avec des programmes de formation de qualité.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(12, 'Université de Douala', 'Informatique', 'Formation de pointe en informatique et nouvelles technologies.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(13, 'Université de Douala', 'Commerce', 'Offre des programmes de commerce international et de gestion des entreprises.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(14, 'Université de Douala', 'Économie', 'Université renommée pour ses programmes en sciences économiques et commerciales.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(15, 'Université de Douala', 'Médecine', 'Institution offrant des programmes complets en médecine et santé.', 'Douala', 'Doctorat', 7, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Douala', 'Séri'),
(16, 'Université de Douala', 'Sciences Sociales', 'Université privée offrant une éducation de qualité en sciences sociales.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(17, 'Université de Douala', 'Technologie', 'Spécialisée en technologie et ingénierie.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(18, 'Université de Douala', 'Sciences', 'Formation en sciences appliquées et technologies.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(19, 'Université de Douala', 'Communication', 'Formation aux métiers de la communication et des médias.', 'Douala', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Douala', 'Séri'),
(20, 'Université de Douala', 'Génie Mécanique', 'Offre des formations en génie mécanique et industriel.', 'Douala', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Douala', 'Séri'),
(21, 'Université de Buea', 'Informatique', 'Université offrant des programmes de formation avancés en informatique.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(22, 'Université de Buea', 'Médecine', 'Spécialisée en médecine avec des programmes complets.', 'Buea', 'Doctorat', 7, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(23, 'Université de Buea', 'Sciences Appliquées', 'Institut proposant des formations en sciences appliquées.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(24, 'Université de Buea', 'Gestion', 'Formation en gestion des affaires et administration.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(25, 'Université de Buea', 'Éducation', 'Offre des programmes en sciences de l’éducation et pédagogie.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(26, 'Université de Buea', 'Génie Civil', 'Formation en génie civil et infrastructure.', 'Buea', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Buea', 'Séri'),
(27, 'Université de Buea', 'Sciences Politiques', 'Programmes spécialisés en sciences politiques et relations internationales.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(28, 'Université de Buea', 'Droit', 'Institution offrant des programmes complets en droit et sciences juridiques.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Buea', 'Séri'),
(29, 'Université de Buea', 'Génie Électrique', 'Formation en génie électrique et technologies de l’énergie.', 'Buea', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Buea', 'Séri'),
(30, 'Université de Buea', 'Biotechnologie', 'Offre des programmes en biotechnologie et sciences de la vie.', 'Buea', 'Licence', 3, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Buea', 'Séri'),
(31, 'Université de Bamenda', 'Sciences de l\'Éducation', 'Institution de premier plan pour la formation des enseignants et les sciences de l\'éducation.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Bamenda', 'Séri'),
(32, 'Université de Bamenda', 'Sciences et Technologie', 'Spécialisée en sciences et technologie avec des programmes de recherche.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Bamenda', 'Séri'),
(33, 'Université de Bamenda', 'Informatique', 'Formation en informatique avec des programmes de pointe.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Bamenda', 'Séri'),
(34, 'Université de Bamenda', 'Gestion', 'Offre des programmes en gestion des entreprises et administration publique.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Bamenda', 'Séri'),
(35, 'Université de Bamenda', 'Médecine', 'Institution offrant des programmes complets en médecine.', 'Bamenda', 'Doctorat', 7, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Bamenda', 'Séri'),
(36, 'Université de Bamenda', 'Sciences Sociales', 'Formation en sciences sociales avec une approche interdisciplinaire.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Bamenda', 'Séri'),
(37, 'Université de Bamenda', 'Génie Mécanique', 'Spécialisée en génie mécanique et ingénierie industrielle.', 'Bamenda', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Bamenda', 'Séri'),
(38, 'Université de Bamenda', 'Génie Civil', 'Offre des programmes en ingénierie civile et construction.', 'Bamenda', 'Ingénieur', 5, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Bamenda', 'Séri'),
(39, 'Université de Bamenda', 'Sciences de la Santé', 'Université avec des programmes en sciences de la santé et médecine.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac scientifique', '2024-09-01', 'Université de Bamenda', 'Séri'),
(40, 'Université de Bamenda', 'Communication', 'Formation aux métiers de la communication et des médias.', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac général', '2024-09-01', 'Université de Bamenda', 'Séri'),
(41, 'Université de Yaoundé I', 'Médecine', 'Formation en médecine générale avec des stages cliniques approfondis et des spécialisations en chirurgie, pédiatrie, et médecine interne.', 'Yaoundé', 'Doctorat en Médecine', 7, 'Présentiel', 'Baccalauréat Scientifique requis', '2024-10-01', 'Université de Yaoundé I', 'Séri'),
(42, 'Université de Yaoundé I', 'Soins Infirmiers', 'Programme de soins infirmiers avec une formation pratique en clinique et des modules de soins communautaires et d\'urgence.', 'Yaoundé', 'Bachelor en Sciences Infirmières', 3, 'Présentiel', 'Baccalauréat Scientifique ou équivalent requis', '2024-09-01', 'Université de Yaoundé I', 'Séri'),
(43, 'Université de Yaoundé I', 'Médecine', 'Programme en pharmacie avec des stages en pharmacologie clinique, gestion des médicaments et conseil en pharmacie.', 'Yaoundé', 'Doctorat en Pharmacie', 6, 'Présentiel', 'Baccalauréat Scientifique requis', '2024-09-01', 'Université de Yaoundé I', 'Séri');

-- --------------------------------------------------------

--
-- Structure de la table `emploie`
--

CREATE TABLE `emploie` (
  `id_emploie` int(11) NOT NULL,
  `domaine` varchar(255) NOT NULL,
  `poste` varchar(255) NOT NULL,
  `salaire` decimal(10,2) NOT NULL,
  `annees_experience` int(11) NOT NULL,
  `type_formation` varchar(255) NOT NULL,
  `institution` varchar(255) NOT NULL,
  `niveau_etude_requis` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emploie`
--

INSERT INTO `emploie` (`id_emploie`, `domaine`, `poste`, `salaire`, `annees_experience`, `type_formation`, `institution`, `niveau_etude_requis`) VALUES
(1, 'Informatique', 'Développeur de logiciels', 500000.00, 2, 'Licence', 'IAI Cameroun', 'Bac+3'),
(2, 'Informatique', 'Analyste en cybersécurité', 700000.00, 3, 'Licence', 'IAI Cameroun', 'Bac+3'),
(3, 'Informatique', 'Administrateur réseau', 600000.00, 2, 'Licence', 'IAI Cameroun', 'Bac+3'),
(4, 'Réseaux et Télécommunications', 'Spécialiste en réseaux', 650000.00, 3, 'Licence', 'IAI Cameroun', 'Bac+3'),
(5, 'Réseaux et Télécommunications', 'Ingénieur télécom', 750000.00, 4, 'Licence', 'IAI Cameroun', 'Bac+3'),
(6, 'Génie Informatique', 'Ingénieur logiciel', 800000.00, 4, 'DUT', 'Université de Yaoundé I', 'Bac+2'),
(7, 'Génie Informatique', 'Administrateur de systèmes', 600000.00, 3, 'DUT', 'Université de Yaoundé I', 'Bac+2'),
(8, 'Génie Civil', 'Ingénieur civil', 900000.00, 5, 'DUT', 'Université de Yaoundé I', 'Bac+2'),
(9, 'Génie Civil', 'Gestionnaire de projets de construction', 850000.00, 5, 'DUT', 'Université de Yaoundé I', 'Bac+2'),
(10, 'Génie Électrique', 'Ingénieur électricien', 700000.00, 3, 'DUT', 'Université de Yaoundé I', 'Bac+2'),
(11, 'Génie Électrique', 'Spécialiste en systèmes d\'énergie', 750000.00, 4, 'DUT', 'Université de Yaoundé I', 'Bac+2'),
(12, 'Informatique', 'Développeur', 550000.00, 2, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(13, 'Informatique', 'Analyste en systèmes d\'information', 600000.00, 3, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(14, 'Génie Électrique', 'Ingénieur en énergies renouvelables', 750000.00, 4, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(15, 'Génie Électrique', 'Gestionnaire de projets électriques', 700000.00, 4, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(16, 'Gestion des Ressources Humaines', 'Responsable RH', 650000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(17, 'Gestion des Ressources Humaines', 'Conseiller en relations industrielles', 600000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(18, 'Comptabilité et Finance', 'Comptable', 500000.00, 2, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(19, 'Comptabilité et Finance', 'Analyste financier', 700000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(20, 'Marketing', 'Spécialiste en marketing', 550000.00, 2, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(21, 'Marketing', 'Gestionnaire de la communication', 600000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(22, 'Génie Civil', 'Ingénieur civil', 900000.00, 5, 'DUT', 'Université de Douala', 'Bac+2'),
(23, 'Génie Civil', 'Chef de projets en construction', 850000.00, 5, 'DUT', 'Université de Douala', 'Bac+2'),
(24, 'Technologie de l\'Information', 'Développeur de logiciels', 500000.00, 2, 'DUT', 'Université de Douala', 'Bac+2'),
(25, 'Technologie de l\'Information', 'Administrateur de systèmes informatiques', 600000.00, 3, 'DUT', 'Université de Douala', 'Bac+2'),
(26, 'Réseaux et Télécommunications', 'Ingénieur en réseaux', 650000.00, 3, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(27, 'Réseaux et Télécommunications', 'Spécialiste en télécommunications', 750000.00, 4, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(28, 'Génie Électrique', 'Ingénieur en génie électrique', 700000.00, 3, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(29, 'Génie Électrique', 'Spécialiste en systèmes d\'énergie', 750000.00, 4, 'Licence', 'Institut Universitaire de la Côte', 'Bac+3'),
(30, 'Gestion des Entreprises', 'Gestionnaire', 600000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(31, 'Gestion des Entreprises', 'Administrateur d\'entreprise', 700000.00, 4, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(32, 'Comptabilité et Gestion Financière', 'Comptable', 500000.00, 2, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(33, 'Comptabilité et Gestion Financière', 'Gestionnaire financier', 700000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(34, 'Marketing', 'Responsable marketing', 550000.00, 2, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(35, 'Marketing', 'Expert en stratégie commerciale', 600000.00, 3, 'Licence', 'Institut Universitaire de Gestion', 'Bac+3'),
(36, 'Génie Mécanique', 'Ingénieur mécanicien', 750000.00, 4, 'DUT', 'Université de Douala', 'Bac+2'),
(37, 'Génie Mécanique', 'Gestionnaire de projets industriels', 800000.00, 5, 'DUT', 'Université de Douala', 'Bac+2'),
(38, 'Gestion Logistique et Transport', 'Responsable logistique', 600000.00, 3, 'DUT', 'Université de Douala', 'Bac+2'),
(39, 'Gestion Logistique et Transport', 'Spécialiste en gestion des transports', 650000.00, 3, 'DUT', 'Université de Douala', 'Bac+2'),
(40, 'Technologie Alimentaire', 'Technologue alimentaire', 550000.00, 2, 'DUT', 'Université de Douala', 'Bac+2'),
(41, 'Technologie Alimentaire', 'Spécialiste en sécurité alimentaire', 600000.00, 3, 'DUT', 'Université de Douala', 'Bac+2'),
(42, 'Génie Civil', 'Ingénieur civil', 900000.00, 5, 'DUT', 'Université de Buea', 'Bac+2'),
(43, 'Informatique', 'Développeur de logiciels', 500000.00, 2, 'DUT', 'Université de Buea', 'Bac+2'),
(44, 'Informatique', 'Administrateur de systèmes informatiques', 600000.00, 3, 'DUT', 'Université de Buea', 'Bac+2'),
(45, 'Génie Informatique', 'Ingénieur en génie informatique', 800000.00, 4, 'DUT', 'Institut Universitaire des Technologies et des Sciences', 'Bac+2'),
(46, 'Génie Informatique', 'Développeur', 550000.00, 2, 'DUT', 'Institut Universitaire des Technologies et des Sciences', 'Bac+2'),
(47, 'Génie Civil', 'Ingénieur en génie civil', 900000.00, 5, 'DUT', 'Institut Universitaire des Technologies et des Sciences', 'Bac+2'),
(48, 'Génie Civil', 'Gestionnaire de projets', 850000.00, 5, 'DUT', 'Institut Universitaire des Technologies et des Sciences', 'Bac+2'),
(49, 'Technologie Alimentaire', 'Technologue alimentaire', 550000.00, 2, 'DUT', 'Institut Universitaire des Technologies et des Sciences', 'Bac+2'),
(50, 'Technologie Alimentaire', 'Spécialiste en qualité des produits alimentaires', 600000.00, 3, 'DUT', 'Institut Universitaire des Technologies et des Sciences', 'Bac+2'),
(51, 'Marketing', 'Assistant marketing', 450000.00, 0, 'BTS', 'Institut Universitaire de Gestion', 'Bac+2'),
(52, 'Marketing', 'Chargé de marketing digital', 600000.00, 1, 'BTS', 'Institut Universitaire de Gestion', 'Bac+2'),
(53, 'Comptabilité et Finance', 'Assistant comptable', 400000.00, 0, 'BTS', 'Institut Universitaire de Gestion', 'Bac+2'),
(54, 'Comptabilité et Finance', 'Contrôleur financier', 650000.00, 2, 'BTS', 'Institut Universitaire de Gestion', 'Bac+2'),
(55, 'Technologie de l\'Information', 'Technicien support informatique', 450000.00, 1, 'BTS', 'Université de Douala', 'Bac+2'),
(56, 'Technologie de l\'Information', 'Analyste système', 550000.00, 2, 'BTS', 'Université de Douala', 'Bac+2'),
(57, 'Génie Civil', 'Technicien en génie civil', 500000.00, 1, 'BTS', 'Université de Douala', 'Bac+2'),
(58, 'Génie Civil', 'Technicien de chantier', 600000.00, 2, 'BTS', 'Université de Douala', 'Bac+2'),
(59, 'Génie Électrique', 'Technicien en électricité', 480000.00, 1, 'BTS', 'Université de Buea', 'Bac+2'),
(60, 'Génie Électrique', 'Technicien en énergie renouvelable', 580000.00, 2, 'BTS', 'Université de Buea', 'Bac+2'),
(61, 'Gestion des Ressources Humaines', 'Assistant RH', 450000.00, 1, 'BTS', 'Institut Universitaire de Gestion', 'Bac+2'),
(62, 'Gestion des Ressources Humaines', 'Chargé de formation', 550000.00, 2, 'BTS', 'Institut Universitaire de Gestion', 'Bac+2'),
(63, 'Marketing', 'Responsable marketing', 700000.00, 3, 'MASTER', 'Institut Universitaire de Gestion', 'Bac+5'),
(64, 'Marketing', 'Chef de produit', 800000.00, 4, 'MASTER', 'Institut Universitaire de Gestion', 'Bac+5'),
(65, 'Comptabilité et Finance', 'Contrôleur de gestion', 750000.00, 3, 'MASTER', 'Institut Universitaire de Gestion', 'Bac+5'),
(66, 'Comptabilité et Finance', 'Auditeur financier', 850000.00, 4, 'MASTER', 'Institut Universitaire de Gestion', 'Bac+5'),
(67, 'Technologie de l\'Information', 'Architecte système', 700000.00, 3, 'MASTER', 'Université de Douala', 'Bac+5'),
(68, 'Technologie de l\'Information', 'Chef de projet IT', 800000.00, 4, 'MASTER', 'Université de Douala', 'Bac+5'),
(69, 'Génie Civil', 'Ingénieur de projet', 900000.00, 5, 'MASTER', 'Université de Douala', 'Bac+5'),
(70, 'Génie Civil', 'Directeur de travaux', 950000.00, 6, 'MASTER', 'Université de Douala', 'Bac+5'),
(71, 'Génie Électrique', 'Ingénieur en automatismes', 850000.00, 5, 'MASTER', 'Université de Buea', 'Bac+5'),
(72, 'Génie Électrique', 'Ingénieur de maintenance', 900000.00, 6, 'MASTER', 'Université de Buea', 'Bac+5'),
(73, 'Gestion des Ressources Humaines', 'Responsable des ressources humaines', 800000.00, 4, 'MASTER', 'Institut Universitaire de Gestion', 'Bac+5'),
(74, 'Gestion des Ressources Humaines', 'Consultant RH', 900000.00, 5, 'MASTER', 'Institut Universitaire de Gestion', 'Bac+5'),
(75, 'Marketing', 'Directeur marketing', 1000000.00, 6, 'BACHELOR', 'Institut Universitaire de Gestion', 'Bac+4'),
(76, 'Marketing', 'Directeur commercial', 1100000.00, 7, 'BACHELOR', 'Institut Universitaire de Gestion', 'Bac+4'),
(77, 'Comptabilité et Finance', 'Directeur financier', 1200000.00, 8, 'BACHELOR', 'Institut Universitaire de Gestion', 'Bac+4'),
(78, 'Comptabilité et Finance', 'Directeur comptable', 1100000.00, 7, 'BACHELOR', 'Institut Universitaire de Gestion', 'Bac+4'),
(79, 'Technologie de l\'Information', 'Directeur des systèmes d\'information', 1300000.00, 9, 'BACHELOR', 'Université de Douala', 'Bac+4'),
(80, 'Technologie de l\'Information', 'Directeur technique IT', 1200000.00, 8, 'BACHELOR', 'Université de Douala', 'Bac+4'),
(81, 'Génie Civil', 'Chef de projet BTP', 1400000.00, 10, 'BACHELOR', 'Université de Douala', 'Bac+4'),
(82, 'Génie Civil', 'Directeur de construction', 1500000.00, 11, 'BACHELOR', 'Université de Douala', 'Bac+4'),
(83, 'Génie Électrique', 'Directeur technique en énergie', 1300000.00, 9, 'BACHELOR', 'Université de Buea', 'Bac+4'),
(84, 'Génie Électrique', 'Chef de département énergie', 1400000.00, 10, 'BACHELOR', 'Université de Buea', 'Bac+4'),
(85, 'Gestion des Ressources Humaines', 'Directeur des ressources humaines', 1200000.00, 8, 'BACHELOR', 'Institut Universitaire de Gestion', 'Bac+4'),
(86, 'Droit', 'Avocat', 800000.00, 4, 'Master', 'Université de Douala', 'Bac+5'),
(87, 'Droit', 'Juriste d\'entreprise', 700000.00, 3, 'Master', 'Université de Douala', 'Bac+5'),
(88, 'Médecine', 'Médecin généraliste', 1000000.00, 5, 'Doctorat', 'Université de Yaoundé I', 'Bac+8'),
(89, 'Médecine', 'Spécialiste en chirurgie', 1500000.00, 7, 'Doctorat', 'Université de Yaoundé I', 'Bac+8'),
(90, 'Ingénierie', 'Ingénieur en génie civil', 900000.00, 5, 'Bachelor', 'Institut Universitaire des Technologies et des Sciences', 'Bac+3'),
(91, 'Ingénierie', 'Ingénieur en informatique industrielle', 850000.00, 5, 'Bachelor', 'Institut Universitaire des Technologies et des Sciences', 'Bac+3'),
(92, 'Arts', 'Artiste peintre', 600000.00, 3, 'Bachelor', 'École des Beaux-Arts de Yaoundé', 'Bac+3'),
(93, 'Arts', 'Designer graphique', 650000.00, 3, 'Bachelor', 'École des Beaux-Arts de Yaoundé', 'Bac+3'),
(94, 'Génie Mécanique', 'Ingénieur mécanicien', 750000.00, 4, 'Master', 'Université de Douala', 'Bac+5'),
(95, 'Génie Mécanique', 'Technicien en maintenance industrielle', 600000.00, 3, 'BTS', 'Université de Douala', 'Bac+2'),
(96, 'Éducation', 'Enseignant', 500000.00, 2, 'BTS', 'École Normale Supérieure de Yaoundé', 'Bac+2'),
(97, 'Éducation', 'Conseiller pédagogique', 600000.00, 3, 'Master', 'École Normale Supérieure de Yaoundé', 'Bac+5'),
(98, 'Droit', 'Avocat', 1000000.00, 5, 'Doctorat', 'Université de Yaoundé II', 'Bac+8'),
(99, 'Médecine', 'Médecin généraliste', 800000.00, 3, 'Doctorat', 'Université de Douala', 'Bac+8'),
(100, 'Génie', 'Ingénieur de recherche', 900000.00, 4, 'Doctorat', 'Université de Buea', 'Bac+8'),
(107, 'Informatique', 'Technicien support informatique', 400000.00, 0, 'BTS', 'IUT de Douala', 'Bac+2'),
(108, 'Réseaux et Télécommunications', 'Technicien réseaux', 450000.00, 0, 'BTS', 'Lycée technique de Yaoundé', 'Bac+2'),
(109, 'Génie Informatique', 'Développeur web junior', 500000.00, 0, 'BTS', 'Institut Universitaire de Gestion de Buea', 'Bac+2'),
(110, 'Informatique', 'Ingénieur logiciel', 750000.00, 2, 'Master', 'Université de Yaoundé I', 'Bac+4'),
(111, 'Réseaux et Télécommunications', 'Administrateur réseau', 800000.00, 3, 'Master', 'Université de Douala', 'Bac+4'),
(112, 'Génie Informatique', 'Ingénieur système', 900000.00, 4, 'Master', 'Université de Buea', 'Bac+4');

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `etudiant_id` int(11) NOT NULL,
  `etudiant_name` varchar(100) NOT NULL,
  `etablissement` varchar(100) NOT NULL,
  `année` varchar(9) NOT NULL,
  `type_bac` varchar(50) NOT NULL,
  `serie_bac` varchar(50) NOT NULL,
  `date_naissance` date DEFAULT NULL,
  `sexe` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`etudiant_id`, `etudiant_name`, `etablissement`, `année`, `type_bac`, `serie_bac`, `date_naissance`, `sexe`) VALUES
(1, 'Alice Ndem', 'Lycée Classique de Douala', '2024', 'Bac Général', 'Série A', '2004-05-12', 'F'),
(2, 'Blaise Tchana', 'Lycée Technique de Yaoundé', '2024', 'Bac Technique', 'Série F2', '2003-03-25', 'M'),
(3, 'Céline Fotsing', 'Collège Polyvalent de Buea', '2023-2024', 'Bac General', 'General Education', '2004-08-14', 'F'),
(4, 'Daniel Mbongo', 'Lycée Bilingue de Dschang', '2024', 'Bac Général', 'Série C', '2003-11-30', 'M'),
(5, 'Esther Ebogo', 'Lycée de Maroua', '2024', 'Bac Général', 'Série B', '2004-02-18', 'F'),
(6, 'Francis Ngong', 'Government Bilingual High School Ngaoundéré', '2024', 'Bac Anglophone', 'Technical Education', '2004-06-21', 'M'),
(7, 'Gloria Nkem', 'Lycée Technique de Bamenda', '2024', 'Bac Technique', 'Série F4', '2003-10-07', 'F'),
(8, 'Henry Enow', 'Lycée de Yaoundé II', '2024', 'Bac Général', 'Série D', '2004-01-15', 'M'),
(9, 'Isabelle Abega', 'Lycée Technique de Douala', '2024', 'Bac Technique', 'Série F3', '2003-03-11', 'F'),
(10, 'Jules Mbaku', 'Bilingual High School Buea', '2024', 'Bac Anglophone', 'General Education', '2004-12-19', 'M'),
(11, 'Koffi Amou', 'Lycée Bilingue de Bafoussam', '2024', 'Bac Général', 'Série C', '2004-07-15', 'M'),
(12, 'Linda Nje', 'Lycée de Yaoundé I', '2024', 'Bac Technique', 'Série F1', '2004-09-23', 'F'),
(13, 'Marcel Ewondo', 'Lycée Technique de Garoua', '2024', 'Bac Technique', 'Série F5', '2004-04-02', 'M'),
(14, 'Nadine Nkeng', 'Lycée de Limbé', '2024', 'Bac Anglophone', 'General Education', '2004-06-13', 'F'),
(15, 'Olivier Talla', 'Lycée Classique de Bamenda', '2024', 'Bac Général', 'Série B', '2004-08-20', 'M'),
(16, 'Pauline Abanda', 'Lycée de Yaoundé III', '2024', 'Bac Général', 'Série D', '2004-05-27', 'F'),
(17, 'Quentin Ngongang', 'Collège Polyvalent de Douala', '2024', 'Bac Technique', 'Série F4', '2004-11-30', 'M'),
(18, 'Rita Ngo', 'Lycée de Buea', '2024', 'Bac Anglophone', 'Technical Education', '2004-03-16', 'F'),
(19, 'Steve Kamga', 'Lycée Classique de Yaoundé', '2024', 'Bac Général', 'Série A', '2004-12-14', 'M'),
(20, 'Therese Ndom', 'Lycée de Garoua', '2024', 'Bac Général', 'Série C', '2004-10-05', 'F'),
(21, 'Ulrich Ekong', 'Government High School Bamenda', '2024', 'Bac Anglophone', 'General Education', '2004-01-09', 'M'),
(22, 'Victoria Yebga', 'Lycée Bilingue de Maroua', '2024', 'Bac Général', 'Série B', '2004-07-22', 'F'),
(23, 'William Ndeng', 'Lycée Technique de Douala', '2024', 'Bac Technique', 'Série F3', '2004-02-28', 'M'),
(24, 'Xavier Oben', 'Lycée de Bafoussam', '2024', 'Bac Anglophone', 'Technical Education', '2004-04-19', 'M'),
(25, 'Yvonne Tata', 'Lycée de Yaoundé IV', '2024', 'Bac Général', 'Série A', '2004-11-04', 'F'),
(66, 'Zacharie Mbale', 'Lycée Bilingue de Buea', '2024', 'Bac Anglophone', 'General Education', '2004-05-06', 'M'),
(67, 'Adele Nkeng', 'Lycée Technique de Ngaoundéré', '2024', 'Bac Technique', 'Série F5', '2004-09-17', 'F'),
(68, 'Bertrand Essomba', 'Lycée de Yaoundé V', '2024', 'Bac Général', 'Série D', '2004-03-21', 'M'),
(69, 'Camille Ngatchou', 'Collège Polyvalent de Bamenda', '2024', 'Bac Technique', 'Série F1', '2004-10-28', 'F'),
(70, 'David Mbonjo', 'Lycée de Douala', '2024', 'Bac Général', 'Série B', '2004-12-11', 'M');

--
-- Déclencheurs `etudiant`
--
DELIMITER $$
CREATE TRIGGER `before_insert_etudiant` BEFORE INSERT ON `etudiant` FOR EACH ROW BEGIN
    DECLARE next_val INT;

    -- Sélectionner et incrémenter la séquence
    UPDATE sequence_table SET seq_value = LAST_INSERT_ID(seq_value + 1) WHERE sequence_name = 'etudiant_id_seq';
    SET next_val = LAST_INSERT_ID();

    -- Formater l'identifiant avec 'BCF' et le padding
    SET NEW.etudiant_id = CONCAT('BCF', LPAD(next_val, 6, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

CREATE TABLE `formations` (
  `id` int(11) UNSIGNED NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `domaine` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `diploma` varchar(50) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `modality` varchar(100) DEFAULT NULL,
  `conditions` text DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `etablissement` varchar(50) DEFAULT NULL,
  `Serie_Bac_requis` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `formations`
--

INSERT INTO `formations` (`id`, `nom`, `description`, `domaine`, `location`, `diploma`, `duration`, `modality`, `conditions`, `dateDebut`, `etablissement`, `Serie_Bac_requis`) VALUES
(163, 'IAI Cameroun', 'Formation en développement de logiciels, réseaux et télécommunications.', 'Informatique', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IAI Cameroun', 'Série C'),
(164, 'IAI Cameroun', 'Formation spécialisée en gestion des réseaux informatiques et télécommunications.', 'Réseaux et Télécommunications', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IAI Cameroun', 'Série C'),
(165, 'IUT de l\'Université de Yaoundé I', 'Programme en ingénierie informatique avec une focalisation sur le développement logiciel et les systèmes d\'information.', 'Génie Informatique', 'Yaoundé', 'DUT', 2, 'Présentiel', 'Bac Scientifique ou Technique', '2024-09-01', 'Université de Yaoundé I', 'Série C'),
(166, 'IUT de l\'Université de Yaoundé I', 'Formation en génie civil, incluant la construction et la gestion des infrastructures.', 'Génie Civil', 'Yaoundé', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'Université de Yaoundé I', 'Série E'),
(167, 'IUT de l\'Université de Yaoundé I', 'Formation en génie électrique et électronique, couvrant les systèmes d\'énergie et les circuits électroniques.', 'Génie Électrique', 'Yaoundé', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'Université de Yaoundé I', 'Série E'),
(168, 'Institut Universitaire de la Côte (IUC)', 'Programme en développement informatique, gestion des systèmes d\'information et cybersécurité.', 'Informatique', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IUC', 'Série C'),
(169, 'Institut Universitaire de la Côte (IUC)', 'Programme en génie électrique et technologie des énergies renouvelables.', 'Génie Électrique', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUC', 'Série E'),
(170, 'Institut Universitaire de Gestion (IUG)', 'Programme spécialisé en gestion des ressources humaines et relations industrielles.', 'Gestion des Ressources Humaines', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Littéraire', '2024-09-01', 'IUG', 'Série A'),
(171, 'Institut Universitaire de Gestion (IUG)', 'Formation en comptabilité, finance d\'entreprise et audit.', 'Comptabilité et Finance', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Littéraire ou Scientifique', '2024-09-01', 'IUG', 'Série A ou'),
(172, 'Institut Universitaire de Gestion (IUG)', 'Programme en marketing, communication et gestion commerciale.', 'Marketing', 'Yaoundé', 'Licence', 3, 'Présentiel', 'Bac Littéraire', '2024-09-01', 'IUG', 'Série A'),
(173, 'IUT de Douala', 'Programme en ingénierie civile et gestion des projets de construction.', 'Génie Civil', 'Douala', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'Université de Douala', 'Série E'),
(174, 'IUT de Douala', 'Formation en technologies de l\'information et développement de logiciels.', 'Technologie de l\'Information', 'Douala', 'DUT', 2, 'Présentiel', 'Bac Scientifique ou Technique', '2024-09-01', 'Université de Douala', 'Série C ou'),
(175, 'Institut Universitaire de la Côte (IUC)', 'Programme axé sur les réseaux, les télécommunications et la cybersécurité.', 'Réseaux et Télécommunications', 'Douala', 'Licence', 3, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IUC', 'Série C'),
(176, 'Institut Universitaire de la Côte (IUC)', 'Formation en génie électrique et électronique, avec une spécialisation en énergie.', 'Génie Électrique', 'Douala', 'Licence', 3, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUC', 'Série E'),
(177, 'Institut Universitaire de Gestion (IUG)', 'Programme en administration et gestion des entreprises, incluant la stratégie et la gestion opérationnelle.', 'Gestion des Entreprises', 'Douala', 'Licence', 3, 'Présentiel', 'Bac Littéraire ou Scientifique', '2024-09-01', 'IUG', 'Série A ou'),
(178, 'Institut Universitaire de Gestion (IUG)', 'Formation en comptabilité, gestion financière et audit.', 'Comptabilité et Gestion Financière', 'Douala', 'Licence', 3, 'Présentiel', 'Bac Littéraire ou Scientifique', '2024-09-01', 'IUG', 'Série A ou'),
(179, 'Institut Universitaire de Gestion (IUG)', 'Programme en marketing, communication et stratégie commerciale.', 'Marketing', 'Douala', 'Licence', 3, 'Présentiel', 'Bac Littéraire', '2024-09-01', 'IUG', 'Série A'),
(180, 'IUT de Douala', 'Programme en ingénierie mécanique, avec une spécialisation en systèmes et équipements industriels.', 'Génie Mécanique', 'Douala', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'Université de Douala', 'Série E'),
(181, 'IUT de Douala', 'Formation en gestion de la logistique, des transports et des chaînes d\'approvisionnement.', 'Gestion Logistique et Transport', 'Douala', 'DUT', 2, 'Présentiel', 'Bac Littéraire ou Technique', '2024-09-01', 'Université de Douala', 'Série A ou'),
(182, 'IUT de Douala', 'Programme en technologie alimentaire, sécurité et qualité des produits alimentaires.', 'Technologie Alimentaire', 'Douala', 'DUT', 2, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'Université de Douala', 'Série C'),
(183, 'IUT de Buea', 'Formation en ingénierie civile et gestion de projets de construction.', 'Génie Civil', 'Buea', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'Université de Buea', 'Série E'),
(184, 'IUT de Buea', 'Programme en technologies de l\'information et développement de logiciels.', 'Informatique', 'Buea', 'DUT', 2, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'Université de Buea', 'Série C'),
(185, 'Institut Universitaire des Technologies et des Sciences (IUTS)', 'Programme en ingénierie informatique et développement de logiciels.', 'Génie Informatique', 'Buea', 'DUT', 2, 'Présentiel', 'Bac Scientifique ou Technique', '2024-09-01', 'IUTS', 'Série C ou'),
(186, 'Institut Universitaire des Technologies et des Sciences (IUTS)', 'Formation en génie civil, incluant la construction et la gestion des infrastructures.', 'Génie Civil', 'Buea', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUTS', 'Série E'),
(187, 'Institut Universitaire des Technologies et des Sciences (IUTS)', 'Programme en technologie alimentaire et sécurité alimentaire.', 'Technologie Alimentaire', 'Buea', 'DUT', 2, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IUTS', 'Série C'),
(188, 'IUT de Bamenda', 'Formation en génie informatique et développement de logiciels.', 'Génie Informatique', 'Bamenda', 'DUT', 2, 'Présentiel', 'Bac Scientifique ou Technique', '2024-09-01', 'Université de Bamenda', 'Série C ou'),
(189, 'IUT de Bamenda', 'Programme en génie mécanique et maintenance industrielle.', 'Génie Mécanique', 'Bamenda', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'Université de Bamenda', 'Série E'),
(190, 'Institut Universitaire de Technologie (IUT)', 'Formation en génie civil et gestion des infrastructures urbaines.', 'Génie Civil', 'Bamenda', 'DUT', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUT Bamenda', 'Série E'),
(191, 'Institut Universitaire de Technologie (IUT)', 'Programme en technologies de l\'information et gestion des systèmes informatiques.', 'Technologie de l\'Information', 'Bamenda', 'DUT', 2, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IUT Bamenda', 'Série C'),
(192, 'Institut Universitaire des Sciences et Technologies (IUST)', 'Programme en génie électrique, avec une spécialisation en énergies renouvelables.', 'Génie Électrique', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUST Bamenda', 'Série E'),
(193, 'Institut Universitaire des Sciences et Technologies (IUST)', 'Formation en marketing, communication et stratégies commerciales.', 'Marketing et Communication', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac Littéraire', '2024-09-01', 'IUST Bamenda', 'Série A'),
(194, 'Université Catholique Saint Jérôme (UCSJ)', 'Programme en soins infirmiers et santé communautaire.', 'Sciences Infirmières', 'Bamenda', 'Bachelor', 4, 'Présentiel', 'Bac Scientifique ou Technique', '2024-09-01', 'UCSJ', 'Série C ou'),
(195, 'Université Catholique Saint Jérôme (UCSJ)', 'Formation en administration des affaires et gestion d\'entreprise.', 'Gestion des Entreprises', 'Bamenda', 'Bachelor', 4, 'Présentiel', 'Bac Littéraire ou Scientifique', '2024-09-01', 'UCSJ', 'Série A ou'),
(197, 'Université des Montagnes', 'Programme en biologie, écologie et conservation de la biodiversité.', 'Biologie et Sciences de la Vie', 'Bamenda', 'Licence', 3, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'Université des Montagnes', 'Série C'),
(198, 'Institut Universitaire de Technologie (IUT)', 'Formation en génie civil et gestion des infrastructures urbaines.', 'Génie Civil', 'Yaoundé', 'BTS', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUT Yaoundé', 'Série E'),
(199, 'École Supérieure de Gestion (ESG)', 'Programme en marketing stratégique, communication d\'entreprise et relations publiques.', 'Marketing et Communication', 'Yaoundé', 'BTS', 2, 'Présentiel', 'Bac Littéraire ou Scientifique', '2024-09-01', 'ESG Yaoundé', 'Série A ou'),
(200, 'Institut Universitaire de Technologie (IUT)', 'Programme en génie électrique, avec une spécialisation en énergies renouvelables.', 'Génie Électrique', 'Douala', 'BTS', 2, 'Présentiel', 'Bac Technique', '2024-09-01', 'IUT Douala', 'Série E'),
(201, 'École Supérieure de Commerce et de Management (ESCM)', 'Formation en gestion des affaires, entrepreneuriat et développement commercial.', 'Gestion des Entreprises', 'Douala', 'BTS', 2, 'Présentiel', 'Bac Scientifique ou Technique', '2024-09-01', 'ESCM Douala', 'Série C ou'),
(202, 'Institut Universitaire de Technologie (IUT)', 'Formation en technologie alimentaire, sécurité et qualité des produits alimentaires.', 'Technologie Alimentaire', 'Buea', 'BTS', 2, 'Présentiel', 'Bac Scientifique', '2024-09-01', 'IUT Buea', 'Série C'),
(203, 'Université de Yaoundé I', 'Programme avancé en sciences politiques avec spécialisations en gouvernance et politique publique.', 'Sciences Politiques', 'Yaoundé', 'Master', 2, 'Présentiel', 'Licence en Sciences Politiques ou équivalent', '2024-09-01', 'Université de Yaoundé I', 'Série A'),
(204, 'Institut Supérieur du Sahel (ISS)', 'Formation approfondie en économie du développement et politiques économiques.', 'Économie et Développement', 'Yaoundé', 'Master', 2, 'Présentiel', 'Licence en Sciences Économiques ou équivalent', '2024-09-01', 'ISS Yaoundé', 'Série A'),
(205, 'École Normale Supérieure (ENS)', 'Programme de formation pour l\'enseignement secondaire avec spécialisations en mathématiques et sciences.', 'Enseignement Secondaire', 'Yaoundé', 'Master', 2, 'Présentiel', 'Licence en Éducation ou équivalent', '2024-09-01', 'ENS Yaoundé', 'Série C'),
(206, 'Université de Douala', 'Programme avancé en gestion des ressources humaines avec spécialisations en relations de travail et gestion du personnel.', 'Gestion des Ressources Humaines', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Sciences Sociales ou équivalent', '2024-09-01', 'Université de Douala', 'Série A'),
(207, 'École Supérieure des Sciences Économiques et Commerciales (ESSEC)', 'Formation en finance d\'entreprise, comptabilité et audit financier.', 'Finance et Comptabilité', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Finance ou équivalent', '2024-09-01', 'ESSEC Douala', 'Série A'),
(208, 'Institut Universitaire de Technologie (IUT)', 'Formation en technologies avancées de l\'information et de la communication.', 'Technologies de l\'Information et de la Communicati', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'IUT Douala', 'Série C ou'),
(209, 'Université de Buea', 'Programme de Master en sciences de l\'environnement, conservation et gestion durable des ressources naturelles.', 'Études Environnementales', 'Buea', 'Master', 2, 'Présentiel', 'Licence en Sciences Naturelles ou équivalent', '2024-09-01', 'Université de Buea', 'Série C'),
(210, 'École Supérieure des Sciences et Techniques de l\'Ingénieur (ESSTI)', 'Formation avancée en génie logiciel avec spécialisations en développement web et applications mobiles.', 'Génie Logiciel', 'Buea', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'ESSTI Buea', 'Série C'),
(211, 'École Normale Supérieure de l\'Enseignement Technique (ENSET)', 'Formation pour l\'enseignement technique avec spécialisations en génie mécanique et électrique.', 'Éducation Technique', 'Buea', 'Master', 2, 'Présentiel', 'Licence en Éducation ou équivalent', '2024-09-01', 'ENSET Buea', 'Série E'),
(212, 'Institut Universitaire de Technologie (IUT)', 'Formation en génie informatique avec spécialisations en développement logiciel et réseaux informatiques.', 'Génie Informatique', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'IUT Douala', 'Série C ou'),
(213, 'École Supérieure des Sciences et Techniques de l\'Ingénieur (ESSTI)', 'Programme avancé en génie informatique avec spécialisations en sécurité des systèmes et intelligence artificielle.', 'Génie Informatique', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'ESSTI Douala', 'Série C'),
(214, 'École Supérieure des Sciences Économiques et Commerciales (ESSEC)', 'Formation en informatique appliquée au commerce électronique et gestion des systèmes d\'information.', 'Informatique', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'ESSEC Douala', 'Série C'),
(215, 'Institut Universitaire de Technologie (IUT)', 'Programme de Master en informatique avec spécialisations en bases de données et développement web.', 'Informatique', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'IUT Douala', 'Série C ou'),
(216, 'Institut Universitaire de la Côte (IUC)', 'Programme de Master en gestion des entreprises avec spécialisations en stratégie d\'entreprise et entrepreneuriat.', 'Gestion des Entreprises', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Sciences Économiques ou équivalent', '2024-09-01', 'IUC Douala', 'Série C'),
(217, 'Institut Universitaire de la Côte (IUC)', 'Programme de Master en marketing et communication avec spécialisations en stratégies digitales et relations publiques.', 'Marketing et Communication', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Marketing ou équivalent', '2024-09-01', 'IUC Douala', 'Série A ou'),
(218, 'Institut Universitaire de la Côte (IUC)', 'Programme de Master en finance d\'entreprise et comptabilité avancée.', 'Finance et Comptabilité', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Finance ou équivalent', '2024-09-01', 'IUC Douala', 'Série A'),
(219, 'Institut Universitaire de la Côte (IUC)', 'Programme de Master en gestion des ressources humaines avec spécialisations en développement organisationnel et gestion du personnel.', 'Gestion des Ressources Humaines', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Sciences Humaines ou équivalent', '2024-09-01', 'IUC Douala', 'Série A'),
(220, 'Institut Universitaire de la Côte (IUC)', 'Programme de Master en technologies de l\'information et de la communication avec spécialisations en sécurité des systèmes et gestion des réseaux.', 'Technologies de l\'Information et de la Communicati', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Informatique ou équivalent', '2024-09-01', 'IUC Douala', 'Série C'),
(221, 'Institut Universitaire de la Côte (IUC)', 'Programme de Master en droit des affaires avec spécialisations en droit commercial international et propriété intellectuelle.', 'Droit des Affaires', 'Douala', 'Master', 2, 'Présentiel', 'Licence en Droit ou équivalent', '2024-09-01', 'IUC Douala', 'Série A');

-- --------------------------------------------------------

--
-- Structure de la table `sequence`
--

CREATE TABLE `sequence` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sequence_table`
--

CREATE TABLE `sequence_table` (
  `sequence_name` varchar(50) NOT NULL,
  `seq_value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sequence_table`
--

INSERT INTO `sequence_table` (`sequence_name`, `seq_value`) VALUES
('etudiant_id_seq', 109);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `contact`) VALUES
(1, 'ksd', 'sdvg', 'vsd', 'sdvv'),
(2, 'sfg', '465', 'sxdf', 'cxx'),
(3, 'jack', '123', 'a@gamil.com', '55'),
(4, 'jack', '123', 'a@gamil.com', '99'),
(5, 'dfdg', '254545', 'd@fsfd.com', '566'),
(6, 'fdb', '123', 'sfd@gmail.com', '354412');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `concours`
--
ALTER TABLE `concours`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ecole`
--
ALTER TABLE `ecole`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `emploie`
--
ALTER TABLE `emploie`
  ADD PRIMARY KEY (`id_emploie`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`etudiant_id`);

--
-- Index pour la table `formations`
--
ALTER TABLE `formations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sequence`
--
ALTER TABLE `sequence`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sequence_table`
--
ALTER TABLE `sequence_table`
  ADD PRIMARY KEY (`sequence_name`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ecole`
--
ALTER TABLE `ecole`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT pour la table `emploie`
--
ALTER TABLE `emploie`
  MODIFY `id_emploie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `etudiant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT pour la table `formations`
--
ALTER TABLE `formations`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT pour la table `sequence`
--
ALTER TABLE `sequence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
