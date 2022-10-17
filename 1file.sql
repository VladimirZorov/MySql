INSERT INTO `addresses`(`address`,`town`,`country`,`user_id`)
SELECT (u.`username`),(u.`password`),( u.`ip`),( u.`age`) FROM `users` as u
WHERE u.`gender` LIKE 'M';

UPDATE `addresses` as a
SET a.`country` =
	CASE 
		WHEN `country` LIKE 'B%' THEN  'Blocked'
		WHEN `country` LIKE 'T%' THEN  'Test'
		WHEN `country` LIKE 'P%' THEN 'In Progress'
        END;
        