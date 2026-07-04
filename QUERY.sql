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