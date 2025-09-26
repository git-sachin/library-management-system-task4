-- TASK 1

-- Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Table: Members
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    membership_date DATE DEFAULT (CURRENT_DATE)
);

-- Table: Staff
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    hire_date DATE DEFAULT (CURRENT_DATE)
);

-- Table: Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    isbn VARCHAR(20) UNIQUE,
    published_year YEAR,
    available_copies INT DEFAULT 1
);

-- Table: Loans (Borrowing records)
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    staff_id INT,
    loan_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- TASK 2

-- 1.INSERT RECORDS INTO LIBRARY MANAGEMENT DATABASE
-- 2.Handle missing values using NULL or default

-- Inserting to Members
INSERT INTO Members (name, email, phone) VALUES
('Rahul Sharma', 'rahul.sharma@email.com', '9876543210'),
('Priya Verma', 'priya.verma@email.com', NULL),
('Arjun Mehta', 'arjun.mehta@email.com', '9123456789'),
('Neha Gupta', 'neha.gupta@email.com', '9765432109'),
('Karan Singh', 'karan.singh@email.com', NULL),
('Aditi Joshi', 'aditi.joshi@email.com', '9988776655'),
('Sahil Kapoor', 'sahil.kapoor@email.com', '9345678901'),
('Pooja Rani', 'pooja.rani@email.com', NULL),
('Ravi Kumar', 'ravi.kumar@email.com', '8899776655'),
('Simran Kaur', 'simran.kaur@email.com', '9001122334');

-- Inserting to Staff 
INSERT INTO Staff (name, role) VALUES
('Anita Singh', 'Librarian'),
('Ramesh Kumar', 'Assistant'),
('Vikram Malhotra', 'Manager'),
('Sunita Devi', 'Librarian'),
('Deepak Sharma', 'Clerk'),
('Meena Kumari', 'Librarian'),
('Suresh Patel', 'Assistant'),
('Geeta Nair', 'Clerk'),
('Mohit Jain', 'Library IT Admin'),
('Seema Yadav', 'Assistant');

-- Inserting to Books
INSERT INTO Books (title, author, isbn, published_year, available_copies) VALUES
('SQL Basics', 'John Smith', '9781234567890', 2020, 3),
('Database Design', 'Jane Doe', '9780987654321', 2018, 2),
('Advanced SQL Queries', 'Mark Taylor', '9781111111111', 2021, 4),
('Data Warehousing Concepts', 'Paul Brown', '9782222222222', 2019, 5),
('Relational Databases Explained', 'Emily White', '9783333333333', 2017, 2),
('Big Data Fundamentals', 'David Green', '9784444444444', 2022, 6),
('Introduction to NoSQL', 'Michael Black', '9785555555555', 2021, 3),
('Cloud Databases', 'Sophia Lee', '9786666666666', 2020, 4),
('Python for Data Science', 'Kevin Johnson', '9787777777777', 2019, 7),
('Machine Learning with SQL', 'Olivia Martin', '9788888888888', 2023, 5);

-- Inserting to Loans
INSERT INTO Loans (book_id, member_id, staff_id, loan_date, return_date) VALUES
(1, 1, 1, '2025-09-01', NULL),
(2, 2, 2, '2025-09-05', '2025-09-15'),
(3, 3, 3, '2025-09-07', NULL),
(4, 4, 4, '2025-09-08', '2025-09-18'),
(5, 5, 5, '2025-09-09', NULL),
(6, 6, 6, '2025-09-10', NULL),
(7, 7, 7, '2025-09-12', '2025-09-20'),
(8, 8, 8, '2025-09-13', NULL),
(9, 9, 9, '2025-09-14', NULL),
(10, 10, 10, '2025-09-15', '2025-09-25');

--  3.Use UPDATE and DELETE with WHERE conditions

-- Removing SAFE mode to run DELETE And UPDATE commands
SET SQL_SAFE_UPDATES = 0;

-- USING UPDATE with Where conditions

-- Update a member's email
UPDATE Members
SET email = 'ravi.kumar2023@example.com'
WHERE member_id = 1;

-- Update staff role
UPDATE Staff
SET role = 'Senior Librarian'
WHERE staff_id = 1;

-- Extend return date for a loan
UPDATE Loans
SET return_date = '2023-09-30'
WHERE loan_id = 2;

-- USING DELETE with Where conditions

-- Deleteing child rows first 
-- Deleteing from Loans before deleting from Members or Books

-- Delete all loans for member_id = 2
DELETE FROM Loans
WHERE member_id = 2;

-- Now delete the member
DELETE FROM Members
WHERE member_id = 2;

-- Delete a member who left the library
DELETE FROM Members
WHERE member_id = 2;

-- Delete a book by title
DELETE FROM Books
WHERE title = 'Python Crash Course';

-- Delete an old loan record
DELETE FROM Loans
WHERE loan_id = 1;

-- Displaying the records inserted

SELECT*FROM Members;
SELECT*FROM Loans;
SELECT*FROM Staff;
SELECT*FROM Books;

-- TASK 3

-- 1.Use SELECT * and specific columns
-- Select all columns from Members
SELECT * FROM Members;

-- Select only specific columns from Books
SELECT title, author, published_year FROM Books;

-- Select specific columns from Loans
SELECT loan_id, book_id, member_id, loan_date, return_date FROM Loans;

-- 2.Apply WHERE, AND, OR, LIKE, BETWEEN
-- WHERE: Find all members with a phone number provided
SELECT * FROM Members
WHERE phone IS NOT NULL;

-- AND: Find books published in or after 2020 that have more than 3 copies
SELECT * FROM Books
WHERE published_year >= 2020 AND available_copies > 3;

-- OR: Find staff who are Librarians OR Managers
SELECT * FROM Staff
WHERE role = 'Librarian' OR role = 'Manager';

-- LIKE: Find books with 'SQL' in the title
SELECT * FROM Books
WHERE title LIKE '%SQL%';

-- BETWEEN: Find books published between 2019 and 2022
SELECT * FROM Books
WHERE published_year BETWEEN 2019 AND 2022;

--  3.Sort with ORDER BY
-- Sort books by published year ascending
SELECT title, author, published_year FROM Books
ORDER BY published_year ASC;

-- Sort books by available copies descending
SELECT title, available_copies FROM Books
ORDER BY available_copies DESC;

-- Sort members alphabetically by name
SELECT member_id, name, email FROM Members
ORDER BY name ASC;

-- TASK 4

-- 1. Aggregate functions on numeric columns
SELECT COUNT(*) AS total_books FROM Books;
SELECT SUM(available_copies) AS total_copies FROM Books;
SELECT AVG(available_copies) AS avg_copies FROM Books;
SELECT MIN(published_year) AS oldest_book, MAX(published_year) AS newest_book FROM Books;

-- 2. GROUP BY examples
-- Count how many books each author has
SELECT author, COUNT(*) AS book_count
FROM Books
GROUP BY author;

-- Average copies per published year
SELECT published_year, AVG(available_copies) AS avg_copies
FROM Books
GROUP BY published_year;

-- 3. HAVING examples
-- Authors with more than 1 book
SELECT author, COUNT(*) AS book_count
FROM Books
GROUP BY author
HAVING COUNT(*) > 1;

-- Years where total copies available > 10
SELECT published_year, SUM(available_copies) AS total_copies
FROM Books
GROUP BY published_year
HAVING SUM(available_copies) > 10;
