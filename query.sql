

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
    tournament_category varchar(100),
    base_ticket_price decimal(10,2) check (base_ticket_price>0),
    match_status varchar(100) check (match_status in ('Available','Selling Fast','Sold Out','Postponed'))
    
    
);


