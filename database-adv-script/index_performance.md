## Implementing Indexes for Optimization

### 🧠 Step 1: Identify High-Usage Columns

Based on typical queries, here are commonly used columns:

| Table        | High-Usage Columns                       | Usage Context          |
| ------------ | ---------------------------------------- | ---------------------- |
| `users`      | `id`, `email`                            | Joins, WHERE           |
| `bookings`   | `user_id`, `property_id`, `booking_date` | Joins, WHERE, ORDER BY |
| `properties` | `id`, `location`, `price`                | Joins, WHERE, ORDER BY |

---

### 🛠 Step 2: Create Indexes

Create a file called **`database_index.sql`** and add the following SQL commands:

```sql
-- Index on users.id for fast joins
CREATE INDEX idx_users_id ON users(id);

-- Index on users.email for login lookups or filtering
CREATE INDEX idx_users_email ON users(email);

-- Index on bookings.user_id for joins
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index on bookings.property_id for joins
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on bookings.booking_date for date filtering or sorting
CREATE INDEX idx_bookings_date ON bookings(booking_date);

-- Index on properties.id for joins
CREATE INDEX idx_properties_id ON properties(id);

-- Index on properties.location for filtering
CREATE INDEX idx_properties_location ON properties(location);

-- Index on properties.price for range queries
CREATE INDEX idx_properties_price ON properties(price);
```

---

### 🔍 Step 3: Measure Performance with EXPLAIN

Before and after creating indexes, run your query like this:

```sql
EXPLAIN ANALYZE
SELECT 
    b.id, u.name, p.title
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.id
JOIN 
    properties p ON b.property_id = p.id
WHERE 
    b.booking_date >= '2024-01-01'
ORDER BY 
    b.booking_date DESC;
```

Observations:

* **Query plan steps**: After addinng indexes, index scans are being used instead of sequential scans.
* **Execution time**: The execution time dropped after adding indexes.

---

### 📚 Notes for Learning

* **Indexes speed up reads**, especially with large datasets.
* **Too many indexes can slow down inserts/updates**, so apply them wisely.
* Use **`EXPLAIN ANALYZE`** to observe query improvements after indexing.
* Keep indexes updated when schema changes.

---
