# 🧾 Airbnb Clone – Database Schema (DDL)

This directory contains the **SQL schema** for the Airbnb clone database. It was designed using PostgreSQL and defines the structure and relationships of the system.

---

## ✅ Tables Defined

1. **User**
   - Stores account information for guests and hosts.

2. **Property**
   - Listings added by users (hosts) for rental.

3. **Booking**
   - Represents reservation details between users and properties.

4. **Payment**
   - Payment data linked to each booking.

5. **Review**
   - Feedback from users after booking stays.

---

## 🔐 Constraints and Keys

- All tables use `id` as the primary key.
- Foreign keys ensure relational integrity across:
  - `user_id` in Property, Booking, Review
  - `property_id` in Booking, Review
  - `booking_id` in Payment
- Unique constraint on `User.email` to avoid duplicate accounts.
- CHECK constraint on `Review.rating` (1–5 stars only).

---

## ⚡ Performance Optimization

- **Indexes** added to:
  - `User.email` – for fast login/query
  - `Property.location` – for location-based search
  - `Booking` date range – for availability search
  - `Payment.status` – for reporting/filtering

---

> Built with PostgreSQL. Optimized for real-world performance, relationships, and scalability.
