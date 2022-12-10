SELECT (`id`), (`first_name`),( `last_name`), (`birthdate`), (`card`), (`review`)
FROM `clients`
ORDER BY `birthdate` DESC;

SELECT (`first_name`),( `last_name`), (`birthdate`),(`review`)
FROM `clients`
WHERE (`birthdate` BETWEEN '1978-01-01' and '1994-12-31')
AND
`card` IS  NULL  
ORDER BY `last_name` DESC 
LIMIT 5;

SELECT concat(`last_name`, `first_name`, char_length(`first_name`), "Restaurant") AS `username`,
reverse(substring(`email`, 2,12)) AS `password`
FROM `waiters` 
WHERE `salary` IS NOT NULL
ORDER BY `password` DESC;




SELECT 
    `id`, `name`, COUNT(*) AS `count`
FROM
    `products`
        RIGHT JOIN
    `orders_products` ON `products`.`id` = `orders_products`.`product_id`
GROUP BY `name`
HAVING `count` >=5
ORDER BY `count` DESC , `name` ASC;



SELECT t.`id` , t.`capacity`, COUNT(t.`capacity`) as `count_clients`,
 (CASE
            WHEN t.`capacity` = COUNT(t.`capacity`) THEN 'Full'
            WHEN t.`capacity` > COUNT(t.`capacity`) THEN 'Free seats'
            ELSE 'Extra seats'
           END)  as `availability`
 FROM `tables` t
RIGHT JOIN `orders` o ON t.`id` = o.`table_id`
RIGHT JOIN `orders_clients` c ON o.`id` = c.`order_id`
 WHERE `floor` = 1
 GROUP BY `id`
ORDER BY `table_id` DESC;


delimiter $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50)) 
RETURNS DOUBLE
DETERMINISTIC
BEGIN
DECLARE bill double;
    SET bill := (
        SELECT SUM(p.`price`)  
        FROM `products` p
                inner JOIN `orders_products` op on p.id = op.`order_id`
                 JOIN `orders_clients` oc on op.`order_id` = oc.`client_id`
                 JOIN `clients` c on c.`id` = oc.`client_id`
        WHERE CONCAT(c.first_name, ' ', c.last_name) = full_name 
        GROUP BY  c.`first_name`);
RETURN bill;
END$$
delimiter ;

SELECT c.first_name,c.last_name, udf_client_bill('Silvio Blyth') as 'bill' FROM clients c
WHERE c.first_name = 'Silvio' AND c.last_name= 'Blyth';
