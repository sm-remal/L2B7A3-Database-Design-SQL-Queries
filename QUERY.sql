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