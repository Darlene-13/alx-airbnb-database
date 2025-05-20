-- ==========================================
-- Airbnb Clone: Sample Data Seeding Script
-- ==========================================

-- USERS
INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES 
  ('Darlene', 'Wendie', 'darlenewendie@mail.com', 'hashed_pw_1', 'host'),
  ('Joy', 'Khalayi', 'joykhalayi@mail.com', 'hashed_pw_2', 'host'),
  ('Stacy', 'Phanice', 'stacyphanice@mail.com', 'hashed_pw_3', 'guest'),
  ('Tech', 'ToTheWord', 'techtotheword@mail.com', 'hashed_pw_4', 'guest');

-- PROPERTIES
INSERT INTO property (host_id, name, description, property_type, room_type, city, county, postal_code, latitude, longitude, bedrooms, bathrooms, max_guests, price_per_night)
VALUES 
  ((SELECT user_id FROM users WHERE email = 'darlenewendie@mail.com'), 'Garden View Cottage', 'A serene getaway in the countryside', 'cottage', 'entire_place', 'Nairobi', 'Nairobi County', '00100', -1.2921, 36.8219, 2, 1, 4, 3500.00),
  ((SELECT user_id FROM users WHERE email = 'joykhalayi@mail.com'), 'Urban Apartment', 'Modern apartment with skyline view', 'apartment', 'entire_place', 'Kisumu', 'Kisumu County', '40100', -0.0917, 34.7680, 1, 1, 2, 5000.00);

-- BOOKINGS
INSERT INTO bookings (property_id, user_id, start_date, end_date, guests_count, total_price)
VALUES 
  ((SELECT property_id FROM property WHERE name = 'Garden View Cottage'), (SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'), '2024-06-01', '2024-06-03', 2, 7000.00),
  ((SELECT property_id FROM property WHERE name = 'Urban Apartment'), (SELECT user_id FROM users WHERE email = 'techtotheword@mail.com'), '2024-06-10', '2024-06-12', 1, 10000.00);

-- PAYMENTS
INSERT INTO payment (booking_id, user_id, amount, payment_method, payment_status)
VALUES 
  ((SELECT booking_id FROM bookings WHERE total_price = 7000.00), (SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'), 7000.00, 'credit_card', 'completed'),
  ((SELECT booking_id FROM bookings WHERE total_price = 10000.00), (SELECT user_id FROM users WHERE email = 'techtotheword@mail.com'), 10000.00, 'paypal', 'completed');

-- REVIEWS
INSERT INTO review (booking_id, property_id, user_id, rating, comment)
VALUES 
  ((SELECT booking_id FROM bookings WHERE total_price = 7000.00), (SELECT property_id FROM property WHERE name = 'Garden View Cottage'), (SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'), 5, 'Amazing experience!'),
  ((SELECT booking_id FROM bookings WHERE total_price = 10000.00), (SELECT property_id FROM property WHERE name = 'Urban Apartment'), (SELECT user_id FROM users WHERE email = 'techtotheword@mail.com'), 4, 'Very clean and modern.');

-- SAVED
INSERT INTO saved (user_id, property_id)
VALUES 
  ((SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'), (SELECT property_id FROM property WHERE name = 'Urban Apartment')),
  ((SELECT user_id FROM users WHERE email = 'techtotheword@mail.com'), (SELECT property_id FROM property WHERE name = 'Garden View Cottage'));

-- AVAILABILITY
INSERT INTO availability (property_id, date, is_available)
VALUES 
  ((SELECT property_id FROM property WHERE name = 'Garden View Cottage'), '2024-06-04', TRUE),
  ((SELECT property_id FROM property WHERE name = 'Urban Apartment'), '2024-06-13', TRUE);

-- MESSAGES
INSERT INTO messages (conversation_id, sender_id, recipient_id, booking_id, message_body)
VALUES 
  (gen_random_uuid(), (SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'), (SELECT user_id FROM users WHERE email = 'darlenewendie@mail.com'), (SELECT booking_id FROM bookings WHERE total_price = 7000.00), 'Hi Darlene, your place was beautiful!'),
  (gen_random_uuid(), (SELECT user_id FROM users WHERE email = 'joykhalayi@mail.com'), (SELECT user_id FROM users WHERE email = 'techtotheword@mail.com'), (SELECT booking_id FROM bookings WHERE total_price = 10000.00), 'Thanks for the booking. Let me know if you need anything.');
