# 🔄 Database Normalization – Airbnb Clone Project

## 🎯 Objective

The goal of this task is to apply normalization principles to ensure the Airbnb clone database design is efficient, scalable, and adheres to **Third Normal Form (3NF)**. This minimizes redundancy, ensures data integrity, and simplifies future updates or expansions.

---

## 🧱 Step 1: First Normal Form (1NF)

1NF requires that:
- All fields contain **atomic values**
- Each record is **unique**
- There are **no repeating groups**

✅ What I did:
- Ensured all attributes hold a single value (e.g., no list of emails or phone numbers)
- Removed any fields that might represent multiple values in one column

**Example Fix:**  
- Split any composite fields like `full_name` into `first_name` and `last_name`
- Ensured that each row in the `Booking` table represents a single booking

---

## 🧱 Step 2: Second Normal Form (2NF)

2NF requires:
- The table is already in 1NF
- **No partial dependency** on a composite primary key

✅ What I did:
- Verified all tables have single-column primary keys (e.g., `id`)
- Moved host information from the `Property` table into the `User` table, since it depended only on the user and not the entire property entity

**Example Fix:**  
- Removed `host_name` from the `Property` table and linked properties to users via `user_id`

---

## 🧱 Step 3: Third Normal Form (3NF)

3NF requires:
- The table is in 2NF
- No **transitive dependencies** (non-key attributes depending on other non-key attributes)

✅ What I did:
- Created a separate `Payment` table to store payment details instead of embedding them in the `Booking` table
- Made sure that booking status, payment status, etc., are in the correct context and not repeated across unrelated tables

**Example Fix:**  
- Removed `payment_status` and `amount` from `Booking`
- Introduced a `Payment` table with `booking_id`, `amount`, and `status` fields

---

## ✅ Normalized Entities Summary

| Table     | Normalized To | Notes                                                  |
|-----------|----------------|--------------------------------------------------------|
| User      | 3NF            | Atomic, no transitive dependencies                    |
| Property  | 3NF            | Linked to `User` via `user_id`                        |
| Booking   | 3NF            | References both `User` and `Property`                 |
| Payment   | 3NF            | Created to eliminate transitive dependency in Booking |
| Review    | 3NF            | Linked to `User` and `Property`                       |

---

## 🧠 Reflection

Applying 3NF to the database design ensures a clean, efficient, and scalable structure. It also helps avoid data anomalies during insertions, deletions, or updates. This step makes the database easier to maintain and improves long-term flexibility for new features or reporting.

---

> *Normalization is the backbone of a well-structured relational database. Without it, everything falls apart.*
