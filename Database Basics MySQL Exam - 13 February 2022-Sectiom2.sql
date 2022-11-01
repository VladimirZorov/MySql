INSERT INTO reviews (content, picture_url, published_at, rating)
SELECT LEFT(p.description, 15), reverse(p.name), DATE('2010/10/10'), p.price / 8
FROM products p
WHERE p.id >= 5;

UPDATE `products` p
SET p.quantity_in_stock = p.quantity_in_stock - 5
WHERE p.quantity_in_stock BETWEEN 60 AND 70;

DELETE c FROM customers c
        LEFT JOIN
    orders o ON c.id = o.customer_id 
WHERE
    o.customer_id IS NULL;

SELECT 
    `id`, `name`
FROM
    `categories`
ORDER BY `name` DESC;

SELECT 
    `id`, `brand_id`, `name`, `quantity_in_stock`
FROM
    `products`
WHERE
    `price` >= 1000
        AND `quantity_in_stock` < 30
ORDER BY `quantity_in_stock` , `id`;

SELECT 
    *
FROM
    reviews r
WHERE
    (SELECT r.content LIKE 'My%')
        AND LENGTH(r.content) > 61
ORDER BY r.rating DESC;


