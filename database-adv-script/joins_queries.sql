--- Note: I am using postgresql dialect
-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT 
     bookings.id AS booking_id
    ,bookings.start_date
    ,bookings.end_date
    ,users.id AS user_id
    ,users.full_name
    ,users.email
FROM 
    bookings
INNER JOIN 
    users ON bookings.user_id = users.id;

-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    properties.id AS property_id,
    properties.title,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM 
    properties
LEFT JOIN 
    reviews ON properties.id = reviews.property_id
ORDER BY property_id, review_id;

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT 
    users.id AS user_id
    ,users.full_name
    ,bookings.id AS booking_id
    ,bookings.start_date
    ,bookings.end_date
FROM 
    users
FULL OUTER JOIN 
    bookings ON users.id = bookings.user_id;
