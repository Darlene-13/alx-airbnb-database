-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT 
    user_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT 
    property_id,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY total_bookings DESC) AS dense_rank
FROM (
    SELECT 
        property_id,
        COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY property_id
) AS booking_counts;
