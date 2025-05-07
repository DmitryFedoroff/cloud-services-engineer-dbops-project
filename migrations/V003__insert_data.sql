-- Миграция: Наполнение таблиц тестовыми данными

-- Заполнение таблицы товаров (сосисок)
INSERT INTO product (id, name, picture_url, price) 
VALUES
    (1, 'Сливочная',     'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/6.jpg', 320.00),
    (2, 'Особая',        'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/5.jpg', 179.00),
    (3, 'Молочная',      'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/4.jpg', 225.00),
    (4, 'Нюренбергская', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/3.jpg', 315.00),
    (5, 'Мюнхенская',    'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/2.jpg', 330.00),
    (6, 'Русская',       'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/1.jpg', 189.00);

-- Генерация 1 млн тестовых заказов с разными статусами и датами за последние 90 дней
INSERT INTO orders (id, status, date_created)
SELECT 
    i,
    (ARRAY['pending', 'shipped', 'cancelled'])[1 + floor(random() * 3)],
    CURRENT_DATE - (floor(random() * 90)::INTEGER) -- Случайная дата в пределах 90 дней
FROM 
    generate_series(1, 1000000) AS s(i);

-- Генерация позиций заказов с разным количеством сосисок
INSERT INTO order_product (quantity, order_id, product_id)
SELECT 
    1 + floor(random() * 50)::INTEGER, -- Случайное количество от 1 до 50
    i,
    1 + floor(random() * 6)::INTEGER   -- Случайный id продукта от 1 до 6
FROM 
    generate_series(1, 1000000) AS s(i);
