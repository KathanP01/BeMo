-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 29, 2025 at 09:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_ticket_triage`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_01_01_000000_create_tickets_table', 2),
(6, '2025_08_29_175750_create_jobs_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` char(26) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `status` enum('open','pending','resolved') NOT NULL DEFAULT 'open',
  `category` varchar(255) DEFAULT NULL,
  `explanation` text DEFAULT NULL,
  `confidence` double(3,2) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `subject`, `body`, `status`, `category`, `explanation`, `confidence`, `note`, `created_at`, `updated_at`) VALUES
('01K3VF1SH2TNYY7MR2NSMGNACX', 'Eum assumenda nesciunt impedit recusandae quis.', 'Repellendus omnis adipisci nemo numquam optio iure voluptates sed. Quia autem voluptatibus sunt sit nihil. Harum quibusdam odit itaque autem. Consectetur qui incidunt et accusantium deserunt itaque atque.\n\nFacere est enim aut est voluptatem molestiae. Numquam dolores provident similique temporibus harum.\n\nEarum ut sit eos quasi. Quisquam tempore et nulla. Aut nobis repellat et aut sit eaque sint.', 'pending', 'Technical', 'Rerum voluptas nihil facilis dolorem id ratione.', 0.65, NULL, '2025-08-15 08:15:01', '2025-08-29 12:17:19'),
('01K3VF1SHGB2HZKXAGHQFJ7Z1H', 'Id dignissimos nesciunt quae qui omnis tempora distinctio.', 'Repudiandae quam optio expedita vero aut expedita assumenda vel. Nisi ut consequatur autem amet omnis sunt temporibus. Ex voluptas assumenda ut dolorem itaque.\n\nQui et pariatur consequatur consequuntur doloribus. Minus fugit reprehenderit repellendus nulla sed fugiat. Voluptates autem perferendis sed eius deserunt quibusdam voluptatem. Sapiente aliquid ut quis debitis.\n\nCumque animi blanditiis reprehenderit consequuntur. Officiis cumque dolorem id recusandae. Sit voluptas adipisci vero et in.', 'pending', 'General Inquiry', 'Quo ut nostrum sit.', 0.81, 'Sit aliquam perferendis sunt harum eaque ipsam mollitia.', '2025-08-14 06:45:39', '2025-08-29 12:17:19'),
('01K3VF1SHHVKFJXNY30D9PRYX9', 'Aut hic ut omnis recusandae et quisquam minima.', 'Eligendi temporibus facilis et amet. Optio et voluptas consequatur est ea eveniet nobis. Dolore impedit reprehenderit aliquam necessitatibus neque id voluptas. Rerum fuga ipsa et sapiente corporis voluptas.\n\nFuga quas totam quia explicabo vitae voluptatem. Unde odit excepturi sed ut et dignissimos. Eos vero doloremque soluta illo sint voluptatem autem. Qui doloremque ut et fuga tenetur exercitationem aut.\n\nSunt exercitationem voluptatem ullam qui similique iusto. Expedita voluptate ea fugiat omnis. Vero rem sed ad dolores cupiditate ut minima. Neque et sunt illo molestiae ipsam nemo. Quam cupiditate placeat voluptas inventore sed.', 'open', 'General Inquiry', 'Illum autem reiciendis id aut rem iusto iste assumenda.', 0.58, NULL, '2025-08-02 21:14:58', '2025-08-29 12:17:19'),
('01K3VF1SHHVKFJXNY30D9PRYXA', 'Eos accusamus cumque mollitia rem qui veniam voluptas id.', 'Modi nemo doloribus omnis consequuntur quos veritatis dolore eos. Molestiae provident qui nemo mollitia. Perspiciatis odit facere repellendus quia rerum unde mollitia.\n\nUnde deleniti ut repellat omnis ullam delectus deserunt. Adipisci nemo qui praesentium non et sed. Atque odio et sit esse.\n\nDolores dolorum eligendi minima et. Maxime eligendi id aut nesciunt nisi quia facilis. Eos commodi velit quam officiis nam veniam nam doloribus.', 'pending', 'Feature Request', 'Qui vel rem et est magni quis nesciunt eos.', 1.00, 'Voluptates omnis laboriosam qui iste eaque ex.', '2025-08-14 14:37:20', '2025-08-29 12:17:19'),
('01K3VF1SHHVKFJXNY30D9PRYXB', 'Cumque voluptatem et voluptas ut.', 'Numquam autem aut similique occaecati cumque. Itaque modi repudiandae sed veniam porro. Non rerum cum qui aliquam recusandae. Dolores est hic consequatur id rerum sapiente et.\n\nVoluptate molestiae beatae voluptas id non vel. Corporis mollitia id sed veritatis. Omnis tempora quo dolores eum necessitatibus. Assumenda atque voluptas sapiente sapiente ratione.\n\nEt consequuntur labore exercitationem quaerat temporibus veniam odio. Dolor aut sed officia totam. Ex dolorum laboriosam esse et. Tempora et et quod dolores aut quam eum. Fugit ipsa molestiae quam fugiat sit.', 'open', 'General Inquiry', 'Quaerat repudiandae nemo nisi aliquam quas amet perferendis iure.', 0.86, 'Voluptas porro illo ipsum consequatur aut aut.', '2025-08-26 15:38:41', '2025-08-29 12:17:19'),
('01K3VF1SHJ0VVSZ97H89QWTNCQ', 'Explicabo eos aut minus voluptas quia corporis enim.', 'Nulla facere dolor eius aut error quidem porro. Sit aut accusamus quos non est illum enim. Eaque vero ducimus ut reprehenderit officiis sit.\n\nOdio placeat maxime sed laboriosam. Fugiat earum illum est laborum. Consequatur tempora ab quam cumque officiis. Voluptas numquam id voluptas quod totam labore illum dolores.\n\nSint illo ratione iste occaecati labore. Dolorum vitae doloribus fugiat autem veritatis. Temporibus dolores architecto corrupti explicabo eum et. Mollitia voluptates possimus officia qui.', 'open', 'General Inquiry', 'Suscipit voluptatem aut debitis fuga voluptas excepturi voluptate.', 0.75, 'Doloremque in dolorem impedit et voluptatem qui.', '2025-07-31 21:18:46', '2025-08-29 12:17:19'),
('01K3VF1SHJ0VVSZ97H89QWTNCR', 'Ullam distinctio illo quam quaerat voluptatem voluptatem.', 'Rem aperiam ratione asperiores perferendis voluptas maiores. Pariatur atque commodi neque dolor adipisci. Dolorem officia quo a voluptates possimus distinctio.\n\nRerum quaerat rerum nulla molestias molestiae nobis sit. Saepe minima sed omnis dolore in minima rerum dolores. Explicabo qui nam qui sunt quasi soluta. Non nesciunt quidem aperiam animi maxime delectus.\n\nDignissimos fuga adipisci asperiores perferendis. Vel deleniti odio aut odio libero qui autem excepturi. Quia aut fugiat magni ea.', 'pending', 'General Inquiry', 'Tenetur esse sed nesciunt voluptatibus est vero id.', 0.92, NULL, '2025-08-03 02:41:36', '2025-08-29 12:17:19'),
('01K3VF1SHJ0VVSZ97H89QWTNCS', 'Nostrum iusto nesciunt dolor provident qui magni in.', 'Repellendus nulla deserunt quo corrupti dolores. Et neque repellendus qui incidunt sint assumenda omnis sapiente. Quos quos cupiditate distinctio. Qui molestiae quidem aliquid assumenda alias.\n\nQui corrupti ut molestiae delectus quasi quasi. Odio ea error explicabo et dolor animi est. Eos fugit qui explicabo. Distinctio fugiat aut repudiandae aut non.\n\nConsectetur repellendus doloribus molestiae est. Facere nihil cupiditate hic enim rem. Corrupti quod qui et commodi fuga quam qui.', 'open', 'Technical', 'Accusantium consequuntur id reiciendis quo.', 0.84, NULL, '2025-08-18 03:19:16', '2025-08-29 12:17:19'),
('01K3VF1SHKV3XS3MKXZGX3QVHZ', 'Aut consequatur nemo voluptatum eum.', 'Sint natus aut quae repellendus exercitationem reiciendis. Expedita sint quasi harum pariatur minus dolor quasi. Id ad harum veniam illum.\n\nSed et libero officiis sed et distinctio. Voluptatum ut aut a atque animi rerum ex. Quo suscipit velit sapiente impedit ducimus quis neque aut.\n\nUllam aut adipisci magni. Ut sunt et qui perferendis qui hic voluptate. Molestiae minus rerum asperiores occaecati qui harum.', 'open', 'Technical', 'Et molestias veritatis sint id voluptatibus non ducimus tempora.', 0.57, NULL, '2025-08-11 02:35:35', '2025-08-29 12:17:19'),
('01K3VF1SHKV3XS3MKXZGX3QVJ0', 'Suscipit illo soluta recusandae ratione ipsa atque.', 'At voluptas animi odio quidem ullam minima. Ut dolores ipsum consequatur molestias doloremque voluptas qui. Laudantium aut adipisci quis.\n\nId soluta ut rerum rerum labore. Perspiciatis voluptas dolorem quos saepe harum esse. Iste aut repudiandae facilis amet consequuntur aut aut. Assumenda nostrum molestias suscipit temporibus qui.\n\nLibero alias ut at. Illo quia rerum ratione consequatur nobis. Dolor praesentium voluptas ut qui delectus similique perferendis. Vero qui odit reprehenderit ipsum.', 'resolved', 'Feature Request', 'Quia illo tenetur adipisci.', 0.53, NULL, '2025-08-13 09:04:54', '2025-08-29 12:17:19'),
('01K3VF1SHKV3XS3MKXZGX3QVJ1', 'Voluptatem dolor nemo reiciendis voluptas cupiditate molestiae dolores.', 'Ducimus sint tempore quia magnam. Quaerat esse ab fugiat iure sunt laudantium. Consequuntur officia minus numquam vero quibusdam. Voluptatem totam quibusdam voluptate vel animi non.\n\nSequi vitae quas nostrum temporibus odio sunt. Eum natus ullam qui sequi voluptatem voluptatem. Perferendis voluptate adipisci facere tenetur.\n\nRepellendus nemo sunt ducimus ut occaecati eum. Soluta perspiciatis nemo dolorem est.', 'open', 'Technical', 'Quaerat quia vel nihil aut adipisci repellat voluptatem.', 0.70, 'Nemo sunt laudantium in.', '2025-08-04 21:51:05', '2025-08-29 12:17:19'),
('01K3VF1SHKV3XS3MKXZGX3QVJ2', 'Voluptatem odio officia suscipit sunt est ut sequi.', 'Dolore molestias ipsa impedit eos. Placeat sit aut nostrum veniam non. At facilis molestiae voluptatibus ducimus. Sint non id natus.\n\nAutem nihil saepe optio mollitia amet. Fugit aut eum ea mollitia maiores ex. Commodi illo aut minus voluptas aspernatur eveniet facilis. A sed rerum dicta repudiandae ipsam rerum optio.\n\nMagnam impedit nihil eum modi quo corrupti. Inventore illum nihil sed aut ducimus nobis a. Ea error iusto in veritatis.', 'resolved', 'General Inquiry', 'Occaecati velit est in aliquid doloremque.', 0.68, NULL, '2025-08-12 09:57:08', '2025-08-29 12:17:19'),
('01K3VF1SHMMETQXJGKZ6ZG3BTP', 'Laboriosam sequi et corrupti voluptas aspernatur voluptatibus et.', 'Nobis animi enim alias minima. Quasi odit culpa quisquam aliquid et. Illum consequatur dolorem quidem blanditiis. Optio eum totam voluptatibus.\n\nCorporis et neque iusto aut repellendus. Qui dolorem adipisci voluptas aut. Excepturi voluptatem expedita repellat ea amet praesentium amet.\n\nEt id et saepe magnam nihil. Nostrum quod voluptas dolorem qui. Repudiandae id odit et tempore.', 'pending', 'Feature Request', 'This seems to be a technical problem with the system.', 0.95, 'Odio et veritatis velit cumque saepe quia done.', '2025-08-25 00:22:32', '2025-08-29 12:40:14'),
('01K3VF1SHMMETQXJGKZ6ZG3BTQ', 'Quo provident ut nemo.', 'Maiores cum placeat sit illo. Molestiae sit quas harum at eveniet modi sed et.\n\nRem reiciendis molestiae numquam impedit nobis consectetur. Odit maiores molestias voluptates distinctio tempore est. Laborum sed inventore tempore eligendi velit.\n\nDoloribus aperiam soluta odio quibusdam ullam ut. Et est sint et enim quia molestias. Enim soluta magni molestias. Quis officia eum ducimus consectetur esse eius.', 'resolved', 'Billing', 'Minus soluta sint velit corporis id omnis.', 0.73, NULL, '2025-08-10 20:58:45', '2025-08-29 12:17:19'),
('01K3VF1SHMMETQXJGKZ6ZG3BTR', 'Veniam et quo nemo.', 'Ut totam magnam error eum impedit cum et. Repellendus modi autem nihil numquam. Officiis ut quisquam odit quia mollitia repudiandae illum. Inventore dolorem eum et in culpa.\n\nFugiat culpa ut veritatis mollitia ad. Corrupti voluptas dolorem praesentium sunt omnis. Esse consequuntur quod in ut maiores voluptatem laudantium.\n\nQuis saepe facere rem temporibus nihil ducimus enim. Sed quo nesciunt nihil. Beatae quis ea molestias ea eos corrupti dicta.', 'resolved', 'Feature Request', 'Reprehenderit est earum qui voluptas non.', 0.51, NULL, '2025-08-16 15:46:29', '2025-08-29 12:17:19'),
('01K3VF1SHMMETQXJGKZ6ZG3BTS', 'Tenetur iste consequatur perspiciatis excepturi.', 'Esse est labore aspernatur fugit aut. Eos aut incidunt nihil voluptatem quo accusamus impedit eos. Nihil sit laborum quia aut ullam corrupti quos. Ad dolor ratione quia dolor iste quidem.\n\nSed voluptate blanditiis eligendi. Incidunt facilis omnis quo eius dicta inventore dolore cumque. Harum rem quia est temporibus.\n\nVoluptatum ut voluptates quas ea ipsam quia veritatis. Ea voluptatibus aspernatur nihil aut aut sed minima. Et omnis reprehenderit quaerat non excepturi excepturi. Corrupti voluptatem esse et amet repudiandae.', 'resolved', 'Billing', 'Doloribus aperiam quae blanditiis nihil.', 0.97, 'Et nihil cumque explicabo magni.', '2025-08-11 07:03:34', '2025-08-29 12:17:19'),
('01K3VF1SHMMETQXJGKZ6ZG3BTT', 'Nihil id molestiae adipisci quo ipsam.', 'Et mollitia nesciunt qui. Unde pariatur autem eum aut ut. Et sit et dolor ut sunt.\n\nQuidem voluptas ullam earum eum sunt porro sit. Totam illo reiciendis qui ipsum corrupti. Totam minus placeat inventore dolor consequuntur asperiores. Necessitatibus saepe aut numquam quia quia.\n\nQuia voluptatibus sit molestias aut. Veniam rerum ea perferendis voluptas. Aperiam est dolore dolorum amet molestiae animi nihil.', 'resolved', 'General Inquiry', 'Fuga veritatis ullam consequatur laboriosam enim dolorum et.', 0.73, NULL, '2025-08-19 02:04:33', '2025-08-29 12:17:19'),
('01K3VF1SHNE8MVHXC9R68Y7XGP', 'Fugiat sed nostrum laboriosam cupiditate dolor rerum.', 'Quia quia labore est. Dolor sit modi soluta sit consectetur error rerum dicta.\n\nSunt quisquam qui aspernatur provident eos recusandae. Totam iste laboriosam et sunt fugit optio. Molestiae tempora dolores pariatur et.\n\nLibero blanditiis iure nostrum sequi est sed error. Facere repellat ad fugiat velit et. Molestias quaerat atque minus quas.', 'pending', 'Technical', 'Est explicabo mollitia ut praesentium.', 0.65, NULL, '2025-08-05 20:35:00', '2025-08-29 12:17:19'),
('01K3VF1SHNE8MVHXC9R68Y7XGQ', 'Sunt incidunt aperiam illo hic consequatur eos.', 'Modi architecto quidem reiciendis perspiciatis et enim accusamus. Dolor architecto sunt reiciendis eligendi aliquam rerum quis.\n\nVelit eaque deserunt nihil quasi. Non pariatur repellendus tenetur mollitia qui soluta.\n\nHic et ipsa cum dolorum eos culpa. Excepturi voluptatum est accusantium incidunt enim. Aut totam veniam ullam ad.', 'resolved', 'Billing', 'Ut qui harum sit consequuntur.', 0.67, NULL, '2025-08-10 18:24:40', '2025-08-29 12:17:19'),
('01K3VF1SHNE8MVHXC9R68Y7XGR', 'Consequatur et minus vero perferendis in veniam.', 'Aut dolor ipsum voluptatibus reiciendis necessitatibus quibusdam labore. Aut dolores error unde culpa dolores aperiam voluptas sint. Eos est qui odit blanditiis inventore autem. Nihil eaque excepturi expedita consequatur.\n\nNecessitatibus molestiae dolorum itaque. Alias fugit consequatur sit et occaecati recusandae nemo. Est illum mollitia necessitatibus similique magni omnis. Dolor reprehenderit et quia rerum.\n\nAmet et quis magnam itaque occaecati in. Aliquam doloribus voluptate atque cumque. Sapiente vitae iste sit voluptas rerum nihil.', 'pending', 'Billing', 'Molestias voluptates ad quod repellat ratione.', 0.61, NULL, '2025-08-15 05:11:39', '2025-08-29 12:17:19'),
('01K3VF1SHNE8MVHXC9R68Y7XGS', 'Dolorem eius suscipit aut architecto iure aliquam.', 'Beatae doloribus atque aut quis suscipit explicabo libero. Eum non aut mollitia aut dolorem beatae. Necessitatibus quia ipsam mollitia vel.\n\nMolestias numquam ipsam nobis voluptatem consequatur ad cum aspernatur. Vel aspernatur odit ratione alias delectus dolorem unde. Et alias eos id nihil dolores vero eveniet.\n\nQuam nostrum dolorem aut optio itaque. Quia qui culpa ut maxime et laborum et. Ratione et ut officia reiciendis dolores qui.', 'resolved', 'Billing', 'Ea totam et voluptatem repellendus earum repudiandae.', 0.69, NULL, '2025-08-02 11:55:57', '2025-08-29 12:17:19'),
('01K3VF1SHNE8MVHXC9R68Y7XGT', 'Voluptatem facere beatae quo.', 'Aut aspernatur autem qui assumenda. Magnam veritatis sequi porro repudiandae est est. Sit atque autem corporis excepturi autem aut. Repellendus sunt perspiciatis aliquid ab debitis pariatur. Tenetur expedita tempore minus.\n\nCorrupti et quia voluptate neque eligendi laborum molestias aut. Dicta voluptatem ut enim commodi. Tempora modi sunt officia.\n\nSequi eligendi quasi quas quia molestias debitis. Explicabo perspiciatis at natus delectus eligendi. Quidem aliquid necessitatibus rerum velit est. Tempore reprehenderit in nesciunt sit qui et.', 'open', 'General Inquiry', 'Laudantium eum aut culpa.', 0.78, NULL, '2025-08-17 08:22:31', '2025-08-29 12:17:19'),
('01K3VF1SHP6NGQP5Q6ZFRZ5AFY', 'Et maxime nisi incidunt expedita eos sint sint in.', 'Optio molestiae optio at consectetur et rem. Porro eius rerum minus voluptatem quia. Modi est et consequuntur quasi sunt laudantium suscipit assumenda. Ut itaque dolorem aut quo laudantium.\n\nRerum at accusantium numquam explicabo vitae autem dolore. Nobis laboriosam ducimus rerum. Adipisci ea excepturi non atque.\n\nReprehenderit quia dolorem nulla deleniti nam et possimus eos. Eligendi animi et recusandae quis magni neque. Recusandae corporis placeat cum dolorem.', 'resolved', 'Feature Request', 'Magni voluptas nemo fugiat beatae.', 0.69, NULL, '2025-08-10 18:28:54', '2025-08-29 12:17:19'),
('01K3VF1SHP6NGQP5Q6ZFRZ5AFZ', 'Officia modi earum et culpa quia.', 'Culpa ipsum est molestiae ipsa eaque at aspernatur. Praesentium excepturi est possimus ad aperiam et minus et. Velit est quasi ut. Adipisci eligendi cum ea enim qui modi omnis. Nihil vitae architecto ullam hic nihil porro.\n\nEum neque maiores earum odit adipisci ea hic. Sapiente ut dolorem sunt praesentium error autem ut. Ea dolor consequatur et quis reiciendis. Voluptas reprehenderit unde molestiae et rerum sed. Velit quidem iusto fugiat aperiam.\n\nUt vel numquam nesciunt fugit et quis aspernatur. Qui veritatis et voluptates est sit illum. Repellat est tenetur aliquid similique eum voluptatibus adipisci. Laudantium veniam quos officiis. Est vel quia consequatur delectus quos in.', 'pending', 'Feature Request', 'Reprehenderit quos ab excepturi consequuntur dolores et.', 0.65, 'Sint aut ut numquam assumenda rerum minus ratione.', '2025-08-21 17:56:35', '2025-08-29 12:17:19'),
('01K3VF1SHP6NGQP5Q6ZFRZ5AG0', 'Quam maxime similique voluptatibus voluptatem hic sint qui at.', 'Repudiandae ea consectetur animi officiis dolorum. Omnis aut omnis et atque eos veniam dolor. Esse aspernatur et a non consequuntur. Voluptates nulla id vel.\n\nTemporibus suscipit quae aliquam facere perspiciatis sunt. Explicabo eum velit et ipsum repellendus nihil. Repellendus incidunt veritatis praesentium cum ullam accusantium exercitationem ab.\n\nSit dolor nihil cumque sapiente reprehenderit quia. Consequuntur earum unde voluptatem et sed ut laboriosam. Officiis quia similique id itaque. Quas est ut et autem iure.', 'resolved', 'Billing', 'This is a general question about our services.', 0.87, NULL, '2025-08-28 07:31:39', '2025-08-29 12:35:04'),
('01K3VF1SHP6NGQP5Q6ZFRZ5AG1', 'Quasi tenetur maxime veniam accusamus natus explicabo est.', 'Odit in vero impedit illum mollitia porro hic aut. Nemo suscipit facere ut voluptatem dolorum cupiditate sint qui.\n\nDeserunt ad voluptatem ut ab. Reiciendis ut nam quia distinctio. Laboriosam architecto in ipsa qui ullam saepe. Quia quia perferendis impedit dolorem debitis recusandae. Sint officia dolorem dolores consectetur laborum.\n\nPariatur voluptatibus recusandae ipsum officiis. Accusamus autem aut natus dolores. Voluptatum ipsa nulla accusantium. Quaerat aut ipsum velit unde aut quia.', 'resolved', 'General Inquiry', 'Vitae temporibus et voluptatum optio.', 0.96, NULL, '2025-08-21 05:15:25', '2025-08-29 12:17:19'),
('01K3VF1SHQYCF4YST87TTN69AZ', 'Omnis perferendis nihil maxime ipsam nobis molestiae.', 'In soluta non tempore quia odio. Sed a temporibus est nihil nostrum aut earum. Reprehenderit quasi corporis dolores nobis doloribus.\n\nPlaceat saepe minus pariatur iste. Molestiae soluta et et atque corporis dolorum. Et sed et quas ut officiis temporibus ratione. Eos qui rerum quo soluta voluptas voluptatem facere. Ab error blanditiis aut deleniti sed ipsum sit mollitia.\n\nFuga aperiam quis quis aut nesciunt. Nemo voluptates itaque voluptatem vitae. Eligendi et saepe ea porro.', 'open', 'Billing', 'Omnis mollitia porro tenetur doloremque consequatur harum.', 0.85, 'Nihil aspernatur ea quibusdam aut velit deserunt enim.', '2025-08-21 23:16:44', '2025-08-29 12:17:19'),
('01K3VF1SHQYCF4YST87TTN69B0', 'Nemo ut sed consequatur rerum.', 'Aspernatur harum atque molestiae exercitationem aliquam odit. Tempore occaecati doloribus eos. Voluptatibus omnis maiores quia odio atque suscipit. Corporis eaque dolorem neque eum id delectus.\n\nEt corrupti architecto aliquam natus. Esse qui reprehenderit iste esse. Eum amet nulla dolorem eum cumque esse saepe.\n\nTempore nobis qui vero id. Voluptatem distinctio autem quas molestias laborum consequuntur. Facilis velit id consequuntur a odio sit aut. Eveniet dolores autem ut odit nemo perspiciatis numquam.', 'resolved', 'Billing', 'Rerum nulla non sequi et velit quos molestiae tempora.', 0.67, NULL, '2025-08-04 15:25:04', '2025-08-29 12:17:19'),
('01K3VF1SHQYCF4YST87TTN69B1', 'Voluptates et quam aspernatur consectetur non ea.', 'Error alias molestiae consequatur adipisci qui sed esse. Ex laborum non consectetur consectetur quod. Quaerat doloribus non amet consequatur. Magnam fugit totam qui sunt molestiae.\n\nEst assumenda qui odio commodi et nihil. Harum deserunt quaerat quis alias aut repudiandae debitis. Voluptatem quo reprehenderit expedita fugiat magnam perspiciatis. Minima neque reiciendis sequi corporis.\n\nIpsum fugiat sed voluptas harum nemo ipsam. Fuga vel voluptate dolor sit. Maxime quam suscipit rerum itaque libero qui.', 'pending', 'General Inquiry', 'Aut sunt numquam sunt eum quia cupiditate sunt.', 0.81, 'Suscipit ut placeat laboriosam ad error.', '2025-08-21 21:06:58', '2025-08-29 12:17:19'),
('01K3VF1SHQYCF4YST87TTN69B2', 'Mollitia qui sapiente est autem molestiae quas consequatur.', 'Rerum beatae consequuntur ipsam quis qui hic voluptate iure. Id qui et earum autem sed. Atque modi magnam accusamus voluptatibus officiis.\n\nVoluptatum dolore doloribus quia voluptatibus quis sunt quae. Voluptas nemo dicta mollitia odit eveniet nobis qui dicta. Quos et quo aspernatur. Nesciunt et beatae voluptate.\n\nSed sed molestias aspernatur error sit. Exercitationem laborum cumque rerum possimus.', 'resolved', 'Technical', 'Culpa nihil ut explicabo velit.', 0.77, 'Quos quia qui autem in corporis voluptas aperiam.', '2025-08-10 03:03:28', '2025-08-29 12:17:19'),
('01K3VGJA5Q3PZERBF21AJ89QWV', 'Payment issue with my subscription', 'I was charged twice this month and need a refund', 'open', 'General Inquiry', 'This is a general question about our services.', 0.73, 'Customer called about this issue', '2025-08-29 12:43:49', '2025-08-29 13:08:32');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Bhargav Patel', 'bhargav@gmail.com', NULL, '$2y$10$pAGeNIHSk0nvNCcv4skkdOxoIQy2fL1K.49q0NBXX7k68qNJJUGEe', NULL, '2025-08-29 18:35:41', '2025-08-29 18:35:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
