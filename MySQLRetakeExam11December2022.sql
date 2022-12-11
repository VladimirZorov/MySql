CREATE DATABASE `airlines_db`;

USE `airlines_db`;

CREATE TABLE `countries`(
`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL UNIQUE,
`description` TEXT,
`currency` VARCHAR(5) NOT NULL
);

CREATE TABLE `airplanes`(
`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
`model` VARCHAR(50) NOT NULL UNIQUE,
`passengers_capacity` INTEGER NOT NULL,
`tank_capacity` DECIMAL(19,2) NOT NULL,
`cost` DECIMAL(19,2) NOT NULL
);

CREATE TABLE `passengers`(
`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30) NOT NULL,
`last_name` VARCHAR(30) NOT NULL,
`country_id` INTEGER NOT NULL,
CONSTRAINT `fk_passengers_countries`
FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`)
);

CREATE TABLE `flights`(
`id` INTEGER PRIMARY KEY AUTO_INCREMENT,
`flight_code` VARCHAR(30) NOT NULL UNIQUE,
`departure_country` INTEGER NOT NULL,
`destination_country` INTEGER NOT NULL,
`airplane_id` INTEGER NOT NULL,
`has_delay` TINYINT(1),
`departure` DATETIME,
CONSTRAINT `fk_flights_countries`
FOREIGN KEY (`departure_country`) REFERENCES `countries`(`id`),
CONSTRAINT `fk_flights_countries1`
FOREIGN KEY (`destination_country`) REFERENCES `countries`(`id`),
CONSTRAINT `fk_flights_airplanes`
FOREIGN KEY (`airplane_id`) REFERENCES `airplanes`(`id`)
);

CREATE TABLE `flights_passengers` (
`flight_id` INTEGER,
`passenger_id` INTEGER,
CONSTRAINT `fk_flights_passengers_flights`
FOREIGN KEY (`flight_id`) REFERENCES `flights`(`id`),
CONSTRAINT `fk_flights_passengers_passengers`
FOREIGN KEY (`passenger_id`) REFERENCES `passengers`(`id`)
);



INSERT INTO `airplanes`(`model`,`passengers_capacity`, `tank_capacity`, `cost`)
SELECT (concat(reverse( `first_name`), '797')), 
(char_length(`last_name`) * 17),
(`id` * 790),
(char_length(`first_name`) * 50.6)
FROM `passengers`
WHERE `id` <= 5;

UPDATE `flights` f
SET f. `airplane_id` = f. `airplane_id` +1 
where f. `departure_country` = 22;

DELETE f
FROM `flights` f
          LEFT JOIN `flights_passengers` fp on f.`id` = fp.`flight_id`
 WHERE fp.`passenger_id` IS NULL;
 

SELECT `id`, `model`, `passengers_capacity`,`tank_capacity`, `cost`
FROM `airplanes`
ORDER BY `cost` DESC, `id` DESC;

SELECT `flight_code`, `departure_country`, `airplane_id`, `departure` 
FROM `flights`
WHERE  year(`departure`) = 2022
ORDER BY `airplane_id` ASC, `flight_code` 
LIMIT 20;
 
 SELECT concat(upper(left (`last_name`, 2)), `country_id`) AS `flight_code`, 
 concat(`first_name`, " ", `last_name`) AS `full_name`,
 `country_id`
 FROM `passengers` p 
  LEFT JOIN `flights_passengers` fp  ON p. `id` = fp.`passenger_id` 
  WHERE `flight_id` IS NULL
 ORDER BY `country_id`;
 
SELECT c.`name`, c.`currency`, COUNT(*) as `booked_tickets`
FROM `countries` c
JOIN  `flights` f ON c. `id` = f. `destination_country`
JOIN  `flights_passengers` fp ON f.`id` = fp.`flight_id`
GROUP BY `name`
HAVING `booked_tickets` >= 20
ORDER BY `booked_tickets` DESC;

SELECT `flight_code`, `departure`, 
(CASE
WHEN time(`departure`) BETWEEN time('5:00:00') AND time('11:59:59') THEN 'Morning'
WHEN time(`departure`) BETWEEN time('12:00:00') AND time('16:59:59') THEN 'Afternoon'
WHEN time(`departure`) BETWEEN time('17:00:00') AND time('20:59:59') THEN 'Evening'
ELSE 'Night'
END) as `day_part`
FROM `flights`
ORDER BY `flight_code` DESC;

DELIMITER $$
CREATE FUNCTION udf_count_flights_from_country(country VARCHAR(50))
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE `flights_count` INT;
    SET `flights_count` := (
        SELECT COUNT(`departure_country`) 
        FROM `flights` f
        JOIN `countries` c ON f.`departure_country` = c. `id`
        WHERE `name` = country
        GROUP BY  c.`name`);
    RETURN `flights_count`;
end $$
DELIMITER ;

SELECT udf_count_flights_from_country('Brazil') AS 'flights_count';

DELIMITER $$
CREATE PROCEDURE `udp_delay_flight`(`code` VARCHAR(50))
BEGIN
    UPDATE `flights` f
   SET  f. `departure` = f.`departure` + time('00:30:00'),
   `has_delay` = '1'
    WHERE f.`flight_code` =  `code`;
END $$
DELIMITER ;

CALL udp_delay_flight('ZP-782');

SELECT * FROM flights
WHERE flight_code = 'ZP-782';

UPDATE `flights` f
   SET  f. `departure` = date_format(f.`departure` + time('00:30:00')),
   `has_delay` = '1'
    WHERE f.`flight_code` =  'YZ-430';




