-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2026 at 09:17 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vtube_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `video_id`, `user_id`, `comment`, `created_at`) VALUES
(3, 12, 5, 'bagus', '2026-06-14 04:41:06'),
(4, 7, 5, 'keren\r\n', '2026-06-14 06:32:40'),
(5, 7, 5, '1\r\n', '2026-06-14 06:32:45'),
(6, 7, 5, '2', '2026-06-14 06:32:47'),
(7, 7, 5, '3', '2026-06-14 06:32:50'),
(8, 7, 1, 'halo', '2026-06-14 06:49:54'),
(9, 14, 5, 'halo', '2026-06-14 06:51:59');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `like_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`like_id`, `user_id`, `video_id`, `created_at`) VALUES
(1, 5, 14, '2026-06-14 05:17:21'),
(2, 5, 7, '2026-06-14 05:17:48'),
(3, 5, 8, '2026-06-14 05:17:53'),
(4, 5, 9, '2026-06-14 05:17:56'),
(5, 5, 10, '2026-06-14 05:18:05'),
(6, 5, 11, '2026-06-14 05:18:08'),
(7, 5, 12, '2026-06-14 05:18:11'),
(8, 1, 14, '2026-06-14 06:39:50'),
(9, 6, 7, '2026-06-14 06:43:31'),
(10, 6, 8, '2026-06-14 06:43:31'),
(11, 6, 9, '2026-06-14 06:43:31'),
(12, 6, 11, '2026-06-14 06:43:31'),
(13, 7, 7, '2026-06-14 06:43:31'),
(14, 7, 9, '2026-06-14 06:43:31'),
(15, 7, 10, '2026-06-14 06:43:31'),
(16, 7, 12, '2026-06-14 06:43:31'),
(17, 7, 14, '2026-06-14 06:43:31'),
(18, 8, 8, '2026-06-14 06:43:31'),
(19, 8, 10, '2026-06-14 06:43:31'),
(20, 8, 11, '2026-06-14 06:43:31'),
(21, 8, 14, '2026-06-14 06:43:31'),
(22, 9, 7, '2026-06-14 06:43:31'),
(23, 9, 9, '2026-06-14 06:43:31'),
(24, 9, 12, '2026-06-14 06:43:31'),
(25, 9, 14, '2026-06-14 06:43:31');

-- --------------------------------------------------------

--
-- Table structure for table `saved_videos`
--

CREATE TABLE `saved_videos` (
  `save_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `saved_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_videos`
--

INSERT INTO `saved_videos` (`save_id`, `user_id`, `video_id`, `saved_at`) VALUES
(1, 5, 14, '2026-06-14 06:29:49'),
(2, 5, 7, '2026-06-14 06:29:53'),
(3, 1, 14, '2026-06-14 06:39:49');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` int(11) NOT NULL,
  `subscriber_id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`subscription_id`, `subscriber_id`, `creator_id`, `subscribed_at`) VALUES
(2, 1, 5, '2026-06-14 06:15:44'),
(3, 5, 1, '2026-06-14 06:29:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `profile_picture`, `bio`, `created_at`) VALUES
(1, 'Jonathan', 'jonathan@gmail.com', '123456', 'uploads/1781417894665_Screenshot 2026-06-14 131804.png', '', '2026-06-13 11:59:08'),
(2, 'Fabian', 'fabian@gmail.com', '123456', NULL, NULL, '2026-06-13 11:59:08'),
(5, 'arialz', 'arialz@gmail.com', 'arialz123', NULL, NULL, '2026-06-14 04:36:27'),
(6, 'budi', 'budi@gmail.com', 'budi123', NULL, 'Suka fotografi dan travel', '2026-06-14 06:43:31'),
(7, 'siti', 'siti@gmail.com', 'siti123', NULL, 'Content creator lifestyle', '2026-06-14 06:43:31'),
(8, 'rafi', 'rafi@gmail.com', 'rafi123', NULL, 'Pecinta alam dan petualangan', '2026-06-14 06:43:31'),
(9, 'dewi', 'dewi@gmail.com', 'dewi123', NULL, 'Vlogger kuliner Indonesia', '2026-06-14 06:43:31');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `video_path` varchar(255) NOT NULL,
  `thumbnail_path` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`video_id`, `user_id`, `title`, `description`, `video_path`, `thumbnail_path`, `views`, `upload_date`) VALUES
(7, 1, 'Beautiful Park', 'Pemandangan taman dengan pepohonan hijau.', 'video/sample-5s.mp4', 'images/park.jpg', 52, '2026-06-13 12:00:06'),
(8, 1, 'Color Test 4K', 'Video pengujian warna dan resolusi 2160p.', 'video/sample-10s-2160p.mp4', 'images/color_test.jpg', 19, '2026-06-13 12:00:06'),
(9, 2, 'Surfing Adventure', 'Video surfing dengan kualitas HD dan audio.', 'video/sample_1280x720_surfing_with_audio.mp4', 'images/surfing.jpg', 90, '2026-06-13 12:00:06'),
(10, 2, 'Ocean View', 'Pemandangan laut dengan suara ombak.', 'video/sample_960x400_ocean_with_audio.mp4', 'images/ocean.jpg', 55, '2026-06-13 12:00:06'),
(11, 1, 'Coastal Drone Shot', 'Video drone yang menampilkan garis pantai.', 'video/sample_1280x720.mp4', 'images/coast.jpg', 148, '2026-06-13 12:00:06'),
(12, 2, 'Coastal Drone Shot 2', 'Pengambilan gambar pantai dari sudut berbeda.', 'video/sample_1280x720 (1).mp4', 'images/coast2.jpg', 101, '2026-06-13 12:00:06'),
(14, 5, 'Gunung', 'Pemandangan gunung', 'uploads/1781413507999_15046073_3240_2160_60fps.mp4', 'uploads/1781413507999_gunung.jpg', 47, '2026-06-14 05:05:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `video_id` (`video_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`like_id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Indexes for table `saved_videos`
--
ALTER TABLE `saved_videos`
  ADD PRIMARY KEY (`save_id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD UNIQUE KEY `subscriber_id` (`subscriber_id`,`creator_id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `saved_videos`
--
ALTER TABLE `saved_videos`
  MODIFY `save_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`) ON DELETE CASCADE;

--
-- Constraints for table `saved_videos`
--
ALTER TABLE `saved_videos`
  ADD CONSTRAINT `saved_videos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_videos_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`subscriber_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`creator_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
