-- ============================
-- Airbnb Clone Database Schema
-- ============================

-- 1. Users Table
CREATE TABLE User (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Properties Table
CREATE TABLE Property (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    price_per_night NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- 3. Bookings Table
CREATE TABLE Booking (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (property_id) REFERENCES Property(id)
);

-- 4. Payments Table
CREATE TABLE Payment (
    id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Booking(id)
);

-- 5. Reviews Table
CREATE TABLE Review (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (property_id) REFERENCES Property(id)
);

-- =====================
-- Indexes for Performance
-- =====================
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_payment_status ON Payment(status);
