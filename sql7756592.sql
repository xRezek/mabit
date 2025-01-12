-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql7.freesqldatabase.com
-- Czas generowania: 12 Sty 2025, 21:15
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
  `message` varchar(512) NOT NULL,
  `code` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `alarmy`
--

INSERT INTO `alarmy` (`alarmId`, `machineId`, `message`, `code`, `timestamp`) VALUES
(116, '1103_05_UA', ' X axis error / Servo alarm', 8, '2025-01-09 21:14:11'),
(117, '1103_05_UA', ' Y axis error / Servo alarm', 9, '2025-01-09 21:14:12'),
(118, '1103_05_UA', ' C axis error / Servo alarm', 10, '2025-01-09 21:14:12'),
(119, '1103_05_UA', ' Y2 axis error / Servo alarm', 12, '2025-01-09 21:14:14'),
(120, '1103_05_UA', ' C2 axis error / Servo alarm', 13, '2025-01-09 21:14:14');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `events`
--

CREATE TABLE `events` (
  `eventId` int(11) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `code` int(11) NOT NULL,
  `message` varchar(512) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `events`
--

INSERT INTO `events` (`eventId`, `machineId`, `code`, `message`, `timestamp`) VALUES
(21, '1103_04', 100, 'Klikni?to: Nowy projekt', '2025-01-09 21:13:31'),
(23, '1103_04', 100, 'Import pliku SMC: pierzol4.smc', '2025-01-09 21:13:45'),
(26, '1103_04', 100, 'Klikni?to: X/Y = 0', '2025-01-09 21:13:50'),
(27, '1103_04', 100, 'Klikni?to: Auto', '2025-01-09 21:13:50'),
(28, '1103_04', 100, 'Klikni?to: START PROGRAMU (HMI)', '2025-01-09 21:13:51'),
(29, '1103_04', 105, 'Start pracy automatycznej', '2025-01-09 21:13:51'),
(42, '1103_05_UA', 100, 'Klikni?to: Ustawiono nowe warto?ci marginesów i rozmiaru bloka', '2025-01-09 21:14:35'),
(43, '1103_05_UA', 100, 'Klikni?to: Ustawiono nowe warto?ci marginesów i rozmiaru bloka', '2025-01-09 21:14:36'),
(44, '1103_05_UA', 100, 'Klikni?to: Ustawiono nowe warto?ci marginesów i rozmiaru bloka', '2025-01-09 21:14:36'),
(45, '1103_05_UA', 100, 'Klikni?to: Ustawiono nowe warto?ci marginesów i rozmiaru bloka', '2025-01-09 21:14:37'),
(46, '1103_05_UA', 100, 'Klikni?to: Ustawiono nowe warto?ci marginesów i rozmiaru bloka', '2025-01-09 21:14:37'),
(48, '1103_05_UA', 100, 'Klikni?to: Auto', '2025-01-09 21:14:46'),
(68, '1103_05_UA', 100, 'Klikni?to: Man', '2025-01-09 21:39:55'),
(82, '1103_05_CAD_UA', 100, 'Import pliku DXF: 649C000054.dxf', '2025-01-10 21:04:35'),
(85, '1103_05_CAD_UA', 100, 'Import pliku DXF: 649C000054.dxf', '2025-01-10 21:05:17');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `machine_status`
--

CREATE TABLE `machine_status` (
  `machineId` varchar(128) NOT NULL,
  `mode` tinyint(1) NOT NULL,
  `isOn` tinyint(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `machine_status`
--

INSERT INTO `machine_status` (`machineId`, `mode`, `isOn`, `timestamp`) VALUES
('1103', 0, 0, '2025-01-09 22:13:06'),
('1103_05_UA', 1, 1, '2025-01-10 21:03:16'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:03:20'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:04:35'),
('1103_05_UA', 1, 1, '2025-01-10 21:04:36'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:05:17'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:05:18'),
('1103_05_UA', 1, 1, '2025-01-10 21:05:19'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:05:20'),
('1103_05_UA', 1, 1, '2025-01-10 21:05:21'),
('1103_05_UA', 1, 1, '2025-01-10 21:22:37'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:22:41'),
('1103_05_UA', 1, 1, '2025-01-10 21:22:57'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:23:00'),
('1103_05_UA', 1, 1, '2025-01-10 21:23:17'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:23:21'),
('1103_05_UA', 1, 1, '2025-01-10 21:23:36'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:23:41'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:24:01'),
('1103_05_UA', 1, 1, '2025-01-10 21:24:16'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:24:23'),
('1103_05_UA', 1, 1, '2025-01-10 21:24:36'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:24:41'),
('1103_05_UA', 1, 1, '2025-01-10 21:24:56'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:25:00'),
('1103_05_UA', 1, 1, '2025-01-10 21:25:17'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:25:21'),
('1103_05_UA', 1, 1, '2025-01-10 21:25:36'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:25:41'),
('1103_05_UA', 1, 1, '2025-01-10 21:25:57'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:26:00'),
('1103_05_UA', 1, 1, '2025-01-10 21:26:16'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:26:21'),
('1103_05_UA', 1, 1, '2025-01-10 21:26:36'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:26:40'),
('1103_05_UA', 1, 1, '2025-01-10 21:26:57'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:27:00'),
('1103_05_UA', 1, 1, '2025-01-10 21:27:16'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:27:23'),
('1103_05_UA', 1, 1, '2025-01-10 21:27:37'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:27:41'),
('1103_05_UA', 1, 1, '2025-01-10 21:27:57'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:28:00'),
('1103_05_UA', 1, 1, '2025-01-10 21:28:19'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:28:20'),
('1103_05_UA', 1, 1, '2025-01-10 21:28:54'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:28:54'),
('1103_05_UA', 1, 1, '2025-01-10 21:28:56'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:29:00'),
('1103_05_UA', 1, 1, '2025-01-10 21:29:18'),
('1103_05_CAD_UA', 1, 0, '2025-01-10 21:29:21');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `maszyny`
--

CREATE TABLE `maszyny` (
  `id` int(11) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `operatorId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `maszyny`
--

INSERT INTO `maszyny` (`id`, `machineId`, `operatorId`) VALUES
(1, '1103_05_UA', 'Default'),
(2, '1103_05_CAD_UA', 'Default'),
(3, '1103_04', 'Default');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id` varchar(128) NOT NULL,
  `machineId` varchar(128) NOT NULL,
  `status` int(11) NOT NULL,
  `program` varchar(128) NOT NULL COMMENT 'serial w jsonie',
  `cycleTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `produkty`
--

INSERT INTO `produkty` (`id`, `machineId`, `status`, `program`, `cycleTime`) VALUES
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_05_CAD_UA', 0, '607C001136.dxf', 0),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_05_CAD_UA', 0, '607C001136.dxf', 0),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_05_CAD_UA', 0, '607C001136.dxf', 0),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_05_CAD_UA', 0, '607C001136.dxf', 0),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_05_CAD_UA', 0, '607C001136.dxf', 0),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 0, '09.01.20253111211.isep', 1290),
('CUT', '1103_05_CAD_UA', 0, '607C001136.dxf', 0),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_04', 0, 'asap.smc', 480),
('CUT', '1103_05_UA', 4, '10.01.250.isep', 220),
('CUT', '1103_05_CAD_UA', 0, '649C000060.dxf', 0),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.250.isep', 300),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.250.isep', 320),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.250.isep', 340),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 106),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 1, '10.01.2501.isep', 126),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 146),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 166),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 206),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 226),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 246),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 266),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 286),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 306),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 326),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 346),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 366),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 386),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 406),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 426),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 446),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 466),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 486),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0),
('CUT', '1103_05_UA', 4, '10.01.2501.isep', 506),
('CUT', '1103_05_CAD_UA', 0, '649C000054.dxf', 0);

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
  MODIFY `alarmId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;
--
-- AUTO_INCREMENT dla tabeli `events`
--
ALTER TABLE `events`
  MODIFY `eventId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT dla tabeli `maszyny`
--
ALTER TABLE `maszyny`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
