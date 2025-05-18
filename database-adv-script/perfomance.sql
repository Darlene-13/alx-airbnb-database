-- Initial Query: Retrieves all bookings with user, property, and payment details
SELECT 
    b.id AS booking_id,
    b.booking_date,
    b.status,
    u.id AS user_id,
    u.name AS user_name,
    u.email,
    p.id AS property_id,
    p.title AS property_title,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.payment_date,
    pay.status AS payment_status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON b.id = pay.booking_id;

----- Analyze the performance
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.booking_date,
    b.status,
    u.id AS user_id,
    u.name AS user_name,
    u.email,
    p.id AS property_id,
    p.title AS property_title,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.payment_date,
    pay.status AS payment_status
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON b.id = pay.booking_id;

-- Refactored Query with optimized joins and selected fields
SELECT 
    b.id AS booking_id,
    b.booking_date,
    u.name AS user_name,
    p.title AS property_title,
    pay.amount AS payment_amount
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON b.id = pay.booking_id
WHERE
    b.booking_date >= '2024-01-01' -- index-friendly filter
    AND
    b.booking_date <= '2024-12-31' -- index-friendly filter
ORDER BY
    b.booking_date DESC; -- Make sure there's an index on booking_date

--- With analyze
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.booking_date,
    u.name AS user_name,
    p.title AS property_title,
    pay.amount AS payment_amount
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
LEFT JOIN 
    payments pay ON b.id = pay.booking_id
WHERE
    b.booking_date >= '2024-01-01' -- index-friendly filter
    AND
    b.booking_date <= '2024-12-31' -- index-friendly filter
ORDER BY
    b.booking_date DESC; -- Make sure there's an index on booking_date
