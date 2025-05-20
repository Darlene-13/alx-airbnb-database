-- ============================
-- Airbnb Clone Database Schema
-- ============================
-- UUID Extension for security purposes
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- 1. Users Table
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    profile_picture VARCHAR(255),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    email_verified BOOLEAN DEFAULT FALSE
);


-- 2. Properties Table
CREATE TABLE property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    property_type VARCHAR(50) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    county VARCHAR(100),
    postal_code VARCHAR(20),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,
    max_guests INT NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    
    FOREIGN KEY (host_id) REFERENCES users(user_id) ON DELETE CASCADE
);
-- trigger function for the properties table
CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURN TRIGGER AS $$
    BEGIN
        NEW.updated_at = CURRENT_TIMESTAMP;
    END;
    $$ LANGUAGE plpgsql;
--trigger for the properties table
CREATE TRIGGER set_updated_at
BEFORE UPDATE ON properti
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- 3. Bookings Table
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    guests_count INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'canceled', 'completed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    
    CHECK (end_date > start_date),
    CHECK (guests_count > 0),
    CHECK (total_price >= 0)
);
-- trigger for the bookings table, uses the same trigger function as the property's table
CREATE TRIGGER set_booking_updated_at
BEFORE UPDATE ON bookings
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();


-- 4. Payments Table
CREATE TABLE payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL,
    user_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe', 'other')),
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),
    transaction_status VARCHAR(50),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    refund_amount DECIMAL(10, 2),
    refund_date TIMESTAMP,
    refund_reason TEXT,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    
    CHECK (amount > 0),
    CHECK (refund_amount IS NULL OR refund_amount <= amount)
);
-- trigger for the payment table
CREATE TRIGGER set_payment_updated_at
BEFORE UPDATE ON payment
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();


-- 5. Reviews Table
CREATE TABLE review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    host_response TEXT,
    host_response_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,

    CHECK (rating BETWEEN 1 AND 5),

    UNIQUE (booking_id)
);

-- 6. Saved Table
CREATE TABLE saved (
    saved_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    date_saved TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,

    UNIQUE (user_id, property_id)
);

-- 7. Availability Table
CREATE TABLE availability (
    availability_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    date DATE NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,

    UNIQUE (property_id, date)
);

-- 8. Messages Table
CREATE TABLE messages (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    conversation_id UUID NOT NULL,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    booking_id UUID,
    message_body TEXT NOT NULL,
    read_status BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_date TIMESTAMP,

    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL
);


-- =====================
-- Indexes for Performance
-- =====================
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
