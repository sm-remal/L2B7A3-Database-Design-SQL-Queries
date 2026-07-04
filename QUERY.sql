// Query

-- User Table

CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  role VARCHAR(50) CHECK (role IN ('Football Fan', 'Ticket Manager')),
  phone_number VARCHAR(20)
);


INSERT INTO Users (full_name, email, role, phone_number) VALUES
('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
('Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
('Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL); 



-- Match Table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(100) NOT NULL,
    base_ticket_price DECIMAL (10,2) CHECK (base_ticket_price >= 0) NOT NULL,
    match_status VARCHAR(50) CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed')) NOT NULL
);


INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');



-- Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT REFERENCES Users(user_id) NOT NULL,
    match_id INT REFERENCES Matches(match_id) NOT NULL,
    seat_number VARCHAR(20),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost NUMERIC(10,2) CHECK (total_cost >= 0) NOT NULL
);


INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL,  NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);




--  ==========================================================================
--  QUERY START:

-- QUERY 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

SELECT match_id, fixture, base_ticket_price FROM Matches 
WHERE tournament_category = 'Champions League' AND match_status = 'Available'



-- QUERY 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

SELECT user_id, full_name, email FROM Users
WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%'



-- QUERY 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.

SELECT booking_id, user_id, match_id, COALESCE(payment_status, 'Action Required') AS systematic_status FROM Bookings
WHERE payment_status IS NULL



-- QUERY 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.

SELECT booking_id, full_name, fixture, total_cost FROM Bookings AS B
INNER JOIN Users as U ON B.user_id = U.user_id
INNER JOIN Matches as M ON B.match_id = M.match_id