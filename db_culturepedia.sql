-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2024 at 05:53 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_culturepedia`
--

-- --------------------------------------------------------

--
-- Table structure for table `budaya`
--

CREATE TABLE `budaya` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `konten` text NOT NULL,
  `gambar` varchar(255) NOT NULL,
  `created` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `budaya`
--

INSERT INTO `budaya` (`id`, `judul`, `konten`, `gambar`, `created`) VALUES
(1, 'Pentas Seni Tari Tradisional', 'Pentas seni tari tradisional menghadirkan tarian-tarian klasik yang menceritakan cerita-cerita legendaris.', 'gambar1.jpg', '2024-05-06'),
(2, 'Festival Wayang Kulit', 'Festival wayang kulit merupakan perayaan seni tradisional yang menghadirkan dalang terkenal dari berbagai daerah.', 'gambar2.jpg', '2024-05-06'),
(3, 'Pameran Batik Nusantara', 'Pameran batik nusantara menampilkan berbagai jenis batik dari berbagai daerah di Indonesia.', 'gambar3.jpg', '2024-05-06'),
(4, 'Pagelaran Musik Gamelan', 'Pagelaran musik gamelan memberikan pengalaman mendalam tentang musik tradisional Jawa.', 'gambar4.jpg', '2024-05-06'),
(5, 'Pentas Drama Ramayana', 'Pentas drama Ramayana mengisahkan kisah cinta dan petualangan Ramayana dan Sita.', 'gambar5.jpg', '2024-05-06'),
(6, 'Festival Kesenian Bali', 'Festival kesenian Bali menghadirkan berbagai pertunjukan seni tradisional dan modern dari Bali.', 'gambar6.jpg', '2024-05-06'),
(7, 'Pawai Budaya Jawa', 'Pawai budaya Jawa memperlihatkan kekayaan budaya dan tradisi Jawa melalui tarian dan pakaian adat.', 'gambar7.jpg', '2024-05-06'),
(8, 'Pertunjukan Reog Ponorogo', 'Pertunjukan reog Ponorogo menampilkan tarian dan kesenian khas dari Ponorogo, Jawa Timur.', 'gambar8.jpg', '2024-05-06'),
(9, 'Upacara Adat Toraja', 'Upacara adat Toraja merupakan ritual tradisional yang melibatkan berbagai kegiatan adat dan keagamaan.', 'gambar9.jpg', '2024-05-06'),
(10, 'Pesta Rakyat Jember', 'Pesta rakyat Jember merupakan acara tahunan yang menampilkan berbagai kegiatan budaya dan kesenian.', 'gambar10.jpg', '2024-05-06'),
(11, 'Festival Angklung Bandung', 'Festival angklung Bandung merupakan perayaan seni musik tradisional khas daerah Bandung.', 'gambar11.jpg', '2024-05-06'),
(12, 'Karnaval Budaya Betawi', 'Karnaval budaya Betawi merupakan pawai rakyat yang menampilkan kekayaan budaya Betawi.', 'gambar12.jpg', '2024-05-06'),
(13, 'Pentas Seni Teater Klasik', 'Pentas seni teater klasik menampilkan karya-karya klasik dari teater Indonesia.', 'gambar13.jpg', '2024-05-06'),
(14, 'Pameran Seni Lukis Kontemporer', 'Pameran seni lukis kontemporer menampilkan karya-karya seniman muda berbakat.', 'gambar14.jpg', '2024-05-06'),
(15, 'Festival Keraton Yogyakarta', 'Festival Keraton Yogyakarta merupakan perayaan budaya tradisional di Keraton Yogyakarta.', 'gambar15.jpg', '2024-05-06'),
(16, 'Pentas Wayang Golek', 'Pentas wayang golek menampilkan cerita-cerita rakyat dengan menggunakan boneka wayang.', 'gambar16.jpg', '2024-05-06'),
(17, 'Pawai Budaya Papua', 'Pawai budaya Papua menampilkan kekayaan budaya dan tradisi suku-suku di Papua.', 'gambar17.jpg', '2024-05-06'),
(18, 'Festival Kesenian Tari Betawi', 'Festival kesenian tari Betawi merupakan perayaan seni tari khas dari daerah Betawi.', 'gambar18.jpg', '2024-05-06'),
(19, 'Pentas Seni Musik Keroncong', 'Pentas seni musik keroncong menghadirkan musik keroncong yang khas dan indah.', 'gambar19.jpg', '2024-05-06'),
(20, 'Pameran Tenun Ikat Sumba', 'Pameran tenun ikat Sumba menampilkan keindahan dan keunikan tenun ikat dari Sumba.', 'gambar20.jpg', '2024-05-06');

-- --------------------------------------------------------

--
-- Table structure for table `sejarah`
--

CREATE TABLE `sejarah` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `tgl_lhr` varchar(50) NOT NULL,
  `asal` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(50) NOT NULL,
  `deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sejarah`
--

INSERT INTO `sejarah` (`id`, `nama`, `foto`, `tgl_lhr`, `asal`, `jenis_kelamin`, `deskripsi`) VALUES
(2, 'Soedjatmoko', '1000000036.jpg', '10 Januari 1922', 'Indonesia', 'Laki-laki', 'Soedjatmoko (EYD: Sujatmoko) (lahir dengan nama Soedjatmoko Mangoendiningrat; 10 Januari 1922 – 21 Desember 1989), juga dikenal dengan nama panggilan Bung Koko,[1] adalah seorang intelektual, diplomat, dan politikus Indonesia.Lahir dalam keluarga bangsawan, ia belajar kedokteran di Batavia (sekarang Jakarta). Setelah dikeluarkan dari sekolah kedokteran oleh orang-orang Jepang pada tahun 1943, ia pindah ke Surakarta dan membuka praktik pengobatan bersama ayahnya. Pada tahun 1947, setelah kemerdekaan Indonesia, Soedjatmoko bersama dua pemuda lain dikirimkan ke Lake Success, New York, Amerika Serikat untuk mewakili Indonesia di Perserikatan Bangsa-Bangsa. Setelah itu, Soedjatmoko menjalani beberapa kegiatan politik. Pada tahun 1952 ia kembali ke Indonesia dan bergabung dengan pers beraliran sosialis dan Partai Sosialis Indonesia, lalu terpilih sebagai anggota Konstituante. Namun, karena pemerintahan Presiden Soekarno semakin otoriter, Soedjatmoko mulai mengkritik pemerintah. Menghindari pencekalan, Soedjatmoko pergi ke luar negeri dan bekerja sebagai dosen di Universitas Cornell di Ithaca, New York selama dua tahun. Tiga tahun kemudian ia tidak lagi bekerja, biarpun telah kembali ke Indonesia.'),
(3, 'Prof. Dr. Raden Benedictus Slamet Muljana', '1000000034.jpg', '	21 Maret 1929', 'Indonesia', 'Laki-laki', 'Slamet Muljana memperoleh gelar B.A. dari Universitas Gadjah Mada tahun 1950, gelar M.A. dari Universitas Indonesia tahun 1952, gelar Doktor Sejarah dan Filologi dari Universitas Louvain, Belgia, tahun 1954, serta menjadi profesor pada Universitas Indonesia sejak tahun 1958.Slamet Muljana pernah mengajar di Universitas Gadjah Mada, IKIP Bandung (Universitas Pendidikan Indonesia sekarang), Akademi Penerangan, dan Akademi Jurnalistik. Selain itu ia juga pernah mengajar di luar negeri, antara lain, Wolfgang Goethe Universitat (Frankfurt, Jerman), State University of New York (Albany, Amerika Serikat), dan Nanyang University of Singapore (Singapura). Serta ia pernah pula menjabat sebagai direktur Institut untuk Bahasa dan Kebudayaan di Singapura, serta menjadi anggota dewan kurator pada Institute of Southeast Asian Studies di Singapura.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES
(1, 'tes', '098f6bcd4621d373cade4e832627b4f6', 'tes'),
(3, 'testu', 'b147b521d6a7e499b36be0a31f3331cf', 'testu'),
(5, 'tes', '147538da338b770b61e592afc92b1ee6', 'test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budaya`
--
ALTER TABLE `budaya`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sejarah`
--
ALTER TABLE `sejarah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budaya`
--
ALTER TABLE `budaya`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sejarah`
--
ALTER TABLE `sejarah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
