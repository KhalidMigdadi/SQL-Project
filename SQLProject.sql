Create DataBase LibrarySystem;
 use LibrarySystem;


  Create Table Members (
	ID int Primary Key Identity,
	Name varchar(50),
	Contact_Information varchar(50) UNIQUE,
	Type varchar(50),
	Registration_Date date
 );


  Create Table Category (
	ID int Primary Key Identity,
	Cat_Name varchar(50),
	Description varchar(255)
 );  

 Create Table LibraryStaff (
	ID int Primary Key Identity,
	Name varchar(50) Not NUll,
	Contact_Info varchar(50) UNIQUE,
	Assigned_Section varchar(50),
	Employment_Date date

 );


 Create Table Books (
	ID int Primary Key Identity,
	Title varchar(50),
	Author varchar(50),
	Genre varchar(50),
	Published_Year date,
	Status varchar(50),
	CategoryID int,
    FOREIGN KEY (CategoryID) REFERENCES Category(ID)
 );



  Create Table Borrowing (
	ID int Primary Key Identity,
	Borrowing_Date date,
	Due_Date date,
	Retuen_Date date,
	BookID int,
	MemberID int,
	FOREIGN Key (BookID) REFERENCES Books(ID),
	FOREIGN Key (MemberID) REFERENCES Members(ID)
 );


 create Table Reservations (
	ID int Primary Key Identity,
	Reservation date,
	Status varchar(50),
	BookID int,
	MemberID int,
	FOREIGN Key (BookID) REFERENCES Books(ID),
	FOREIGN Key (MemberID) REFERENCES Members(ID)
 );




 INSERT INTO Category (Cat_Name, Description) VALUES
('Fiction', 'Books that contain fictional stories'),
('Science', 'Books related to science and research'),
('History', 'Historical books and records'),
('Technology', 'Books on technology and computers'),
('Philosophy', 'Books about philosophical thoughts');

INSERT INTO Books (Title, Author, Genre, Published_Year, Status, CategoryID) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', '1925-04-10', 'Available', 1),
('A Brief History of Time', 'Stephen Hawking', 'Science', '1988-03-01', 'Available', 2),
('Sapiens', 'Yuval Noah Harari', 'History', '2011-06-04', 'Available', 3),
('Clean Code', 'Robert C. Martin', 'Technology', '2008-08-01', 'Available', 4),
('The Republic', 'Plato', 'Philosophy', '2000-01-01', 'Available', 5);

UPDATE Books
SET Title = 'The Republic'  
WHERE ID IN (4, 3);  

UPDATE Books
SET Title = 'Clean Code'  
WHERE ID IN (4); 

UPDATE Books
SET Title = 'Sapiens'  
WHERE ID IN (3); 

Select *From Books;

INSERT INTO Members (Name, Contact_Information, Type, Registration_Date) VALUES
('Alice Johnson', 'alice@example.com', 'Student', '2023-01-15'),
('Bob Smith', 'bob@example.com', 'Teacher', '2023-02-20'),
('Charlie Brown', 'charlie@example.com', 'Visitor', '2023-03-10'),
('David Lee', 'david@example.com', 'Student', '2023-04-05'),
('Emma Wilson', 'emma@example.com', 'Teacher', '2023-05-12');


INSERT INTO LibraryStaff (Name, Contact_Info, Assigned_Section, Employment_Date) VALUES
('John Doe', 'john.doe@example.com', 'Fiction', '2015-06-10'),
('Sarah Connor', 'sarah.connor@example.com', 'Science', '2017-09-22'),
('Mark Twain', 'mark.twain@example.com', 'History', '2018-11-30'),
('Lucy Adams', 'lucy.adams@example.com', 'Technology', '2020-01-15'),
('Michael Brown', 'michael.brown@example.com', 'Philosophy', '2021-07-08');


-- Insert additional records to ensure some books are borrowed more than 3 times
INSERT INTO Borrowing (Borrowing_Date, Due_Date, Retuen_Date, BookID, MemberID) VALUES
('2024-04-01', '2024-04-15', '2024-04-14', 1, 1),
('2024-04-05', '2024-04-20', '2024-04-18', 1, 2),
('2024-04-10', '2024-04-25', '2024-04-22', 1, 3),
('2024-04-12', '2024-04-27', '2024-04-24', 2, 4),
('2024-04-15', '2024-04-30', '2024-04-28', 2, 5);



INSERT INTO Borrowing (Borrowing_Date, Due_Date, Retuen_Date, BookID, MemberID) VALUES
('2024-01-05', '2024-01-20', '2024-01-18', 1, 1),
('2024-01-10', '2024-01-25', '2024-01-23', 2, 2),
('2024-02-01', '2024-02-15', '2024-02-14', 3, 3),
('2024-02-10', '2024-02-25', '2024-02-24', 4, 4),
('2024-03-01', '2024-03-15', '2024-03-14', 5, 5);

UPDATE Borrowing
SET Retuen_Date = '2024-03-18'  -- Set return date to be later than Due_Date
WHERE ID IN (4, 5);  -- ID 4 and 5 are the last two records (from the original insert)

INSERT INTO Borrowing (Borrowing_Date, Due_Date, Retuen_Date, BookID, MemberID)
VALUES 
('2024-04-01', '2024-04-15', NULL, 1, 1),  -- Member 1 has not returned Book 1
('2024-04-05', '2024-04-20', NULL, 2, 2);  -- Member 2 has not returned Book 2



UPDATE Borrowing
SET BookID = 3  
WHERE ID IN (4, 5);  

SELECT * FROM Borrowing;



INSERT INTO Reservations (Reservation, Status, BookID, MemberID) VALUES
('2024-01-02', 'Pending', 1, 2),
('2024-01-15', 'Cancelled', 2, 3),
('2024-02-05', 'Completed', 3, 4),
('2024-02-20', 'Pending', 4, 5),
('2024-03-10', 'Cancelled', 5, 1);


-- Q1 
Select *From Members where Registration_Date = '2023-01-15';

-- Q2 
Select *From Books where Books.Title = 'Clean Code';

-- Q3
Alter Table Members Add Email varchar(50);

-- Q4

INSERT INTO Members VALUES ('Khalid', 'kkkk@example.com', 'Student', '2023-01-15', 'khalid#gmail.com')

-- Q5
Select *From Reservations where Status = 'Completed';

-- Q6

Select *
From Members
Inner Join Borrowing ON Members.ID = Borrowing.BookID
Inner Join Books ON Borrowing.BookID = BookID
Where Books.Title = 'The Great Gatsby'



-- Q7 
--Select *
--From Members 
--Inner Join Borrowing ON Members.ID = Borrowing.Retuen_Date 

SELECT *
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.MemberID
INNER JOIN Books ON Borrowing.BookID = Books.ID
WHERE Books.Title = 'Sapiens';

-- Q8

Select *
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.MemberID
WHERE Borrowing.Retuen_Date > Borrowing.Due_Date;

-- Q9

SELECT Books.Title, COUNT(*) AS BorrowCount
FROM Borrowing 
INNER JOIN Books ON Borrowing.BookID = Books.ID
GROUP BY Books.Title
HAVING COUNT(*) > 3;


-- Q10

SELECT *
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.MemberID
WHERE Borrowing.Borrowing_Date BETWEEN '2024-01-01' AND '2024-01-10';

0
-- Q11

SELECT COUNT(*) AS TotalBooksAvailable
FROM Books WHERE Status = 'Available';

-- Q12

Select* 
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.MemberID
WHERE Borrowing.Retuen_Date IS NULL;


-- Q13

SELECT*
FROM Members
INNER JOIN Borrowing ON Members.ID = Borrowing.MemberID
INNER JOIN Books ON Borrowing.BookID = Books.ID
INNER JOIN Category ON Books.CategoryID = Category.ID
WHERE Category.Cat_Name = 'Science';
