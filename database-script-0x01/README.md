# 🏡 Airbnb Clone – Database Schema (DDL)

This project contains the complete **PostgreSQL database schema** (DDL) for an **Airbnb Clone** application. It supports features like property listings, bookings, reviews, payments, saved listings, availability, and internal messaging.

---

## ⚙️ Technologies Used

- **PostgreSQL 16+**
- `uuid-ossp` extension for UUID generation
- SQL constraints: `FOREIGN KEY`, `CHECK`, `UNIQUE`
- Auto-updating timestamps using `TRIGGERS`
- Indexing for query optimization

---

## 📐 ERD (Entity Relationship Diagram)

> You can include a diagram like the one below:

![ERD](./ERD/airbnb_erd.png)

---

## 🧱 Tables & Purpose

| Table        | Purpose                                               |
|--------------|--------------------------------------------------------|
| `users`      | Stores guests, hosts, and admins                      |
| `property`   | Hosts list apartments, homes, or other property types |
| `bookings`   | Booking records between guests and properties         |
| `payment`    | Payment transactions for bookings                     |
| `review`     | Guest reviews after a stay                            |
| `saved`      | Saved/favorited properties                            |
| `availability` | Available dates for each property                   |
| `messages`   | Messaging system between users                        |

---

## 🚀 Key Features

- **UUIDs** for all primary keys using `uuid_generate_v4()`
- **Auto-updating `updated_at`** using PostgreSQL `TRIGGER`s
- **Data integrity** using `FOREIGN KEY`, `CHECK`, `UNIQUE`
- **Performance optimized** with indexes on common query fields

---

## 📊 Indexes for Performance

```sql
CREATE INDEX idx_property_host ON property(host_id);
CREATE INDEX idx_property_location ON property(city, county);
CREATE INDEX idx_booking_property ON bookings(property_id);
CREATE INDEX idx_booking_user ON bookings(user_id);
CREATE INDEX idx_booking_dates ON bookings(start_date, end_date);
CREATE INDEX idx_payment_booking ON payment(booking_id);
CREATE INDEX idx_review_property ON review(property_id);
CREATE INDEX idx_message_sender ON messages(sender_id);
CREATE INDEX idx_message_recipient ON messages(recipient_id);
CREATE INDEX idx_message_conversation ON messages(conversation_id);
CREATE INDEX idx_availability_property_date ON availability(property_id, date);
```

---
## ⚡ Trigger to Auto-update updated_at
```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- And then updated like this

CREATE TRIGGER set_<table>_updated_at
BEFORE UPDATE ON <table>
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

```

## 🔐 Constraints and Keys

- All tables use `id` as the primary key.
- Foreign keys ensure relational integrity across:
  - `user_id` in Property, Booking, Review
  - `property_id` in Booking, Review
  - `booking_id` in Payment
- Unique constraint on `User.email` to avoid duplicate accounts.
- CHECK constraint on `Review.rating` (1–5 stars only).

---

## 🔧Setup Guide

### 1. Create the database and enable the UUID support
``` sql
CREATE DATABASE airbnb_app;
\c airbnb_app
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```
### 2. Run the schema files: In order or via one combined file like schema.sql
```psql -U postgres -d airbnb_app -f schema.sql```

## 📄 License
- This project is licensed under the MIT License.
- You are free to use, modify, and distribute it for personal or commercial use.


> Built with PostgreSQL. Optimized for real-world performance, relationships, and scalability.
