

-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template

-- =========================================================================

--create database for Ticket store 
create database ticketBookingSystem

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id serial primary key,
    full_name varchar(100) not null,
    email varchar(50) not null unique,
    role varchar(50) not null,
    phone_number varchar(11)
);



-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id serial primary key ,
    fixture varchar(100) not null,
    tournament_category varchar(100) ,
    base_ticket_price decimal(10,2) check (base_ticket_price>0),
    match_status varchar(100) check (match_status in ('Available','Selling Fast','Sold Out','Postponed'))
    
    
);


-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id serial primary key,
    user_id int not null references users(user_id),
    match_id int not null references matches(match_id),
    seat_number int not null,
    payment_status varchar(50) check (payment_status in('Pending','Confirmed','Cancelled','Refunded')),
    total_cost decimal(10,2) check (total_cost >=0)
    
);


