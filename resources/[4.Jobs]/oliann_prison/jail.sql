ALTER TABLE `users`
	ADD COLUMN `jail` INT(11) NOT NULL DEFAULT '0';

ALTER TABLE users
    ADD COLUMN jailitems longtext COLLATE utf8mb4_bin DEFAULT NULL