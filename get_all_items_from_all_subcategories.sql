/* Get all items from all subcategories. */

/* http://sqlfiddle.com/#!9/af3605/2 */

-------------------------------------------------------------------------------------------------

select group_concat(id)
into @group_ids
from    (select * from catalog
         order by parent_id, id) catalog_sorted,
        (select @pv := '5') initialisation
where   find_in_set(parent_id, @pv) > 0
and     @pv := concat(@pv, ',', id);

select * from good where find_in_set(catalog_id, @group_ids) > 0;

-------------------------------------------------------------------------------------------------

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `catalog` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `title` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `catalog` (`id`, `parent_id`, `title`) VALUES
(1, 5, 'toys'),
(2, 6, 'fructs'),
(4, 6, 'vegetables'),
(5, NULL, 'games'),
(6, NULL, 'meal'),
(7, 5, 'real games'),
(8, 5, 'computer games'),
(9, 8, 'shooter'),
(10, 8, 'strategy');

CREATE TABLE `good` (
  `id` int(11) NOT NULL,
  `catalog_id` int(11) NOT NULL,
  `title` varchar(20) NOT NULL,
  `article` varchar(20) NOT NULL,
  `product_type_characteristic` varchar(20) NOT NULL,
  `image` varchar(200) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `good` (`id`, `catalog_id`, `title`, `article`, `product_type_characteristic`, `image`, `description`) VALUES
(1, 2, 'banana', 'xo2851', 'banana.ico', 'banana.jpg', 'big yellow banana'),
(2, 4, 'tomato', 'io8282', 'tomato.ico', 'tomato.jpg', 'big red tomato'),
(3, 7, 'hide and seek', 'oi2888', 'hide.ico', 'hide.jpg', 'hide and seek super game'),
(4, 7, 'polo', 'ox2882', 'polo.ico', 'polo.jpg', 'polo average game'),
(5, 1, 'car', 'ix5122', 'car.ico', 'car.jpg', 'super small blue car'),
(6, 9, 'contra', 'xo2882', 'contra.ico', 'contra.jpg', 'contra super game'),
(7, 9, 'army', 'xo29929', 'army.ico', 'army.jpg', 'super army game'),
(8, 10, 'hero strategy game', 'ox29929', 'hero.ico', 'hero.jpg', 'super hero strategy game');

ALTER TABLE `catalog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `catalog2catalog` (`parent_id`);

ALTER TABLE `good`
  ADD PRIMARY KEY (`id`),
  ADD KEY `good2catalog` (`catalog_id`);

ALTER TABLE `catalog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `good`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `catalog`
  ADD CONSTRAINT `catalog2catalog` FOREIGN KEY (`parent_id`) REFERENCES `catalog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `good`
  ADD CONSTRAINT `good2catalog` FOREIGN KEY (`catalog_id`) REFERENCES `catalog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;
