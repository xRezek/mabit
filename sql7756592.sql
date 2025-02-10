-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql7.freesqldatabase.com
-- Czas generowania: 10 Lut 2025, 09:12
-- Wersja serwera: 5.5.62-0ubuntu0.14.04.1
-- Wersja PHP: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `sql7756592`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `alarmy`
--

CREATE TABLE `alarmy` (
  `alarmId` int(11) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `message` varchar(512) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `code` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `daily_data`
--

CREATE TABLE `daily_data` (
  `date` date NOT NULL,
  `quality` double NOT NULL,
  `availability` double NOT NULL,
  `effectiveness` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `events`
--

CREATE TABLE `events` (
  `eventId` int(11) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `message` varchar(512) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `code` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `machine_status`
--

CREATE TABLE `machine_status` (
  `machineId` varchar(128) NOT NULL,
  `isOn` tinyint(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `maszyny`
--

CREATE TABLE `maszyny` (
  `id` int(11) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `operatorId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id` varchar(128) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `status` int(11) NOT NULL,
  `program` varchar(128) NOT NULL COMMENT 'serial w jsonie',
  `cycleTime` int(11) NOT NULL,
  `progress` varchar(64) NOT NULL,
  `scale` varchar(64) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `alarmy`
--
ALTER TABLE `alarmy`
  ADD PRIMARY KEY (`alarmId`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`eventId`);

--
-- Indexes for table `maszyny`
--
ALTER TABLE `maszyny`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `alarmy`
--
ALTER TABLE `alarmy`
  MODIFY `alarmId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=668;
--
-- AUTO_INCREMENT dla tabeli `events`
--
ALTER TABLE `events`
  MODIFY `eventId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2697;
--
-- AUTO_INCREMENT dla tabeli `maszyny`
--
ALTER TABLE `maszyny`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
