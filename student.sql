-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Czas generowania: 08 Sty 2025, 12:49
-- Wersja serwera: 5.7.19
-- Wersja PHP: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `student`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `alarmy`
--

DROP TABLE IF EXISTS `alarmy`;
CREATE TABLE IF NOT EXISTS `alarmy` (
  `alarmId` int(11) NOT NULL AUTO_INCREMENT,
  `machineId` int(11) NOT NULL,
  `message` varchar(512) NOT NULL,
  `code` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL,
  PRIMARY KEY (`alarmId`),
  KEY `machineId` (`machineId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `eventId` int(11) NOT NULL AUTO_INCREMENT,
  `machineId` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `message` varchar(512) NOT NULL,
  `timestamp` timestamp NOT NULL,
  PRIMARY KEY (`eventId`),
  KEY `machineId` (`machineId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `maszyny`
--

DROP TABLE IF EXISTS `maszyny`;
CREATE TABLE IF NOT EXISTS `maszyny` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `machineId` varchar(128) NOT NULL,
  `operatorId` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `maszyny`
--

INSERT INTO `maszyny` (`id`, `machineId`, `operatorId`) VALUES
(1, '1103_05_UA', 'Default'),
(2, '1103_05_CAD_UA', 'Default'),
(3, '1103_05_UA', 'Default'),
(4, '1103_05_CAD_UA', 'Default'),
(5, '1103_05_UA', 'Default'),
(6, '1103_05_CAD_UA', 'Default'),
(7, '1103_05_UA', 'Default'),
(8, '1103_05_CAD_UA', 'Default'),
(9, '1103_05_UA', 'Default'),
(10, '1103_05_UA', 'Default'),
(11, '1103_05_UA', 'Default'),
(12, '1103_05_UA', 'Default');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

DROP TABLE IF EXISTS `produkty`;
CREATE TABLE IF NOT EXISTS `produkty` (
  `id` varchar(128) NOT NULL,
  `status` int(11) NOT NULL,
  `program` varchar(128) NOT NULL COMMENT 'serial w jsonie',
  `cycleTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status_maszyny`
--

DROP TABLE IF EXISTS `status_maszyny`;
CREATE TABLE IF NOT EXISTS `status_maszyny` (
  `machineId` int(11) NOT NULL,
  `mode` tinyint(1) NOT NULL,
  `isOn` tinyint(1) NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
