
INSERT INTO `products`(`name`, `type`,`price`)
SELECT 
(w.`last_name`+ " " + "specialty"),
("Coctail"),
(ceil(w.`salary`*0.01))
FROM `waiters` as w
WHERE `id`> 6;

UPDATE `orders`  as o
SET o.table_id = o.table_id - 1
WHERE o.id BETWEEN 12 AND 23;

DELETE w FROM `waiters` w
LEFT JOIN `orders` o ON w.`id` = o. `waiter_id`
WHERE o. `waiter_id` IS NULL;

