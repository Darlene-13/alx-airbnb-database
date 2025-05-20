# 🌱 Airbnb Clone – Database Seeding (`seed.sql`)

This file contains SQL `INSERT` statements used to **populate the Airbnb Clone PostgreSQL database** with realistic sample data. It supports development, testing, and validation of the schema by simulating real-world user interactions such as property creation, bookings, reviews, and payments.

---


---

## 🎯 Objective

- Populate the database with consistent, relational, real-world test data
- Validate foreign key relationships and table constraints
- Simulate core app flows: user registration, property listing, booking, and communication
- Support backend/API testing and UI development with mock data

---

## ⚙️ Technologies Used

- **PostgreSQL 13+**
- `uuid-ossp` extension for UUID generation
- SQL subqueries to dynamically link relational data
- `TIMESTAMP`, `BOOLEAN`, and `CHECK` constraints
- Relational data normalization and foreign keys

---

## 🧱 Tables Seeded

| Table         | Description                                      |
|---------------|--------------------------------------------------|
| `users`       | Creates 4 users (hosts and guests)               |
| `property`    | Adds 2 listings posted by hosts                  |
| `bookings`    | 2 bookings created by guests for listed homes    |
| `payment`     | Payments tied to bookings, using realistic methods |
| `review`      | Guest feedback tied to completed bookings        |
| `saved`       | Users save favorite properties                   |
| `availability`| Indicates open dates for listings                |
| `messages`    | Guest-host communication related to bookings     |

---

## 👥 Sample Characters Used

- **Darlene Wendie** – Host
- **Joy Khalayi** – Host
- **Stacy Phanice** – Guest
- **Tech ToTheWord** – Guest

These characters simulate real roles and behaviors in an Airbnb-like platform.

---

## 🔗 Relationships Demonstrated

| Relationship                           | Description |
|----------------------------------------|-------------|
| `users → property.host_id`             | A host owns property listings |
| `bookings → property + user`           | A guest books a property |
| `payment → bookings + user`            | A guest pays for a booking |
| `review → booking + user + property`   | A guest reviews a booking |
| `messages → users + booking`           | Communication between host and guest |
| `saved → users + property`             | Guests save favorite listings |
| `availability → property + date`       | Tracks if a property is available |

---

## 📄 Sample SQL Snippets

```sql
-- Insert Users
INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES ('Darlene', 'Wendie', 'darlenewendie@mail.com', 'hashed_pw_1', 'host');

-- Insert Property linked to host
INSERT INTO property (host_id, name, description, property_type, ...)
VALUES ((SELECT user_id FROM users WHERE email = 'darlenewendie@mail.com'), 'Garden View Cottage', ...);

-- Insert Booking linked to guest and property
INSERT INTO bookings (property_id, user_id, start_date, end_date, ...)
VALUES (
  (SELECT property_id FROM property WHERE name = 'Garden View Cottage'),
  (SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'),
  '2024-06-01', '2024-06-03', 2, 7000.00
);

-- Insert Payment tied to Booking
INSERT INTO payment (booking_id, user_id, amount, payment_method, payment_status)
VALUES (
  (SELECT booking_id FROM bookings WHERE total_price = 7000.00),
  (SELECT user_id FROM users WHERE email = 'stacyphanice@mail.com'),
  7000.00, 'credit_card', 'completed'
);
```
## 🧪 Setup & Execution
### 1. Ensure Schema is Loaded
- Before seeding, make sure your database (airbnb_app) is already created and all tables have been built using the schema.
  ``` psql -U postgres -d airbnb_app ```
  ``` sql
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
  ```
### 2. Run the Seeder
```psql -U postgres -d airbnb_app -f seed.sql```
### 3. Verify Sample Data
```SELECT * FROM users;
SELECT * FROM property;
SELECT * FROM bookings;
SELECT * FROM payment;
SELECT * FROM review;
SELECT * FROM messages;
```
## 📌 Notes
-All UUIDs are auto-generated using uuid_generate_v4()

-Foreign keys and CHECK constraints are fully respected

-Sample dates and locations reflect real-world examples (Kenya context)

-Messages simulate booking-related conversations

-UNIQUE (booking_id) constraint in review ensures one review per booking

