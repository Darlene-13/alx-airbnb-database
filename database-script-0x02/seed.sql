-- ==========================================
-- Airbnb Clone: Sample Data Seeding Script
-- ==========================================

-- Insert Users
INSERT INTO User (first_name, last_name, email, password_hash)
VALUES
('Alice', 'Mwangi', 'alice@example.com', 'hash_pw_001'),
('Brian', 'Odhiambo', 'brian@example.com', 'hash_pw_002'),
('Cynthia', 'Mutua', 'cynthia@example.com', 'hash_pw_003');

-- Insert Properties
INSERT INTO Property (user_id, title, description, location, price_per_night)
VALUES
(1, 'Nairobi Cozy Apartment', 'A quiet 2-bedroom apartment in Westlands.', 'Nairobi', 4500.00),
(2, 'Beach House in Diani', 'Oceanfront property with a private pool.', 'Diani', 9500.00),
(1, 'Mountain Cabin in Nyeri', 'Perfect for hiking retreats.', 'Nyeri', 3800.00);

-- Insert Bookings
INSERT INTO Booking (user_id, property_id, start_date, end_date, status)
VALUES
(2, 1, '2024-12-01', '2024-12-05', 'confirmed'),
(3, 2, '2024-12-10', '2024-12-15', 'pending'),
(2, 3, '2024-12-20', '2024-12-22', 'cancelled');

-- Insert Payments
INSERT INTO Payment (booking_id, amount, payment_method, status)
VALUES
(1, 18000.00, 'mpesa', 'paid'),
(2, 47500.00, 'credit_card', 'processing');

-- Insert Reviews
INSERT INTO Review (user_id, property_id, rating, comment)
VALUES
(2, 1, 5, 'Amazing stay! Super clean and peaceful.'),
(3, 2, 4, 'Loved the view, but the water pressure was low.'),
(2, 3, 3, 'Great location but slightly overpriced.');
