

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