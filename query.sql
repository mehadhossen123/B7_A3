

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
    match_id int  references matches(match_id),
    seat_number varchar(50),
    payment_status varchar(50) check (payment_status in('Pending','Confirmed','Cancelled','Refunded')),
    total_cost decimal(10,2) check (total_cost >=0)
    
);



-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO Users ( full_name, email, role, phone_number) VALUES
( 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
( 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
( 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
('Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO Matches ( fixture, tournament_category, base_ticket_price, match_status) VALUES
( 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
( 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
( 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
( 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out')


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO Bookings ( user_id, match_id, seat_number, payment_status, total_cost) VALUES
( 1, 1, 'A-12', 'Confirmed', 150.00),
( 1, 2, 'B-04', 'Confirmed', 120.00),
( 2, 1, 'A-13', 'Confirmed', 150.00),
( 2, 1, NULL, NULL, 150.00),
( 3, 2, 'C-20', 'Pending', 120.00);

-- Start from all query 

--Query 1: Retrieve all upcoming football matches belonging to the 'Champions League'
--where the match status is 'Available'.

select * from matches where match_status='Available' and tournament_category='Champions League';



--Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque'
  --(case-insensitive).
select * from users where full_name ilike('tanvir%') or full_name ilike('%Haque%') ;




--Query 3: Retrieve all booking records where the payment status is missing (NULL), 
 -- replacing the empty result with 'Action Required'.
select booking_id,user_id,match_id,seat_number,
  coalesce(payment_status,'Action required')as payment_status ,total_cost from 
  bookings where payment_status is null;



  --Query 4: Retrieve match booking details along with the User's full name 
 -- and the scheduled Match fixture teams.

  select booking_id, full_name,fixture,total_cost
  from users inner join bookings on 
  users.user_id=bookings.user_id 
  inner join matches on bookings.match_id=matches.match_id;



  --Query 5: Display a comprehensive list of all users and their booking IDs, 
 -- ensuring that fans who have never bought a ticket are still listed.
--Concepts used: LEFT JOIN / Full JOIN


select users.user_id,  full_name,booking_id
  from users left join bookings on 
  users.user_id=bookings.user_id;



  --Query 6: Find all ticket bookings where the total cost is
 -- strictly higher than the average cost of all ticket bookings.

select avg(total_cost)  from bookings 
select booking_id,match_id,total_cost from bookings where total_cost > 
  (select avg(total_cost)  from bookings);
