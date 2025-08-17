----fa23-bse-151--
----pakeeza hassan--


create database BookStoreManagementSystem
use BookStoreManagementSystem

-- Employee Table
CREATE TABLE Employee (
    EmployeeID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    HireDate DATE NOT NULL,
    Position VARCHAR(100) NOT NULL CHECK (Position IN ( 'Cashier', 'Manager','Helper')),
    Salary INT NOT NULL CHECK (Salary > 0)
);

-- Cashier Table
CREATE TABLE Cashier (
    EmployeeID VARCHAR(100) PRIMARY KEY,
    Shift VARCHAR(100) NOT NULL, 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Manager Table 
CREATE TABLE Manager (
    EmployeeID VARCHAR(100) PRIMARY KEY,
    Bonus INT NOT NULL CHECK (Bonus >= 0),  -- Bonus for the manager
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE ON UPDATE CASCADE

);

-- Helper Table (Specialization of Employee)
CREATE TABLE Helper (
    EmployeeID VARCHAR(100) PRIMARY KEY,
    PartTime VARCHAR(100) NOT NULL CHECK (PartTime IN ( 'Yes', 'No')) ,  
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE ON UPDATE CASCADE

);


CREATE TABLE Supplier (
    SupplierID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Zip VARCHAR(100) NOT NULL
);

CREATE TABLE Author (
    AuthorID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Publisher (
    PublisherID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Genre (
    GenreID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    BookID VARCHAR(100) PRIMARY KEY,
    ISBN VARCHAR(100) NOT NULL UNIQUE,
    Title VARCHAR(100) NOT NULL,
    PublicationYear VARCHAR(4) NOT NULL,
    PublisherID VARCHAR(100) NOT NULL,
    AuthorID VARCHAR(100) NOT NULL,
    GenreID VARCHAR(100) NOT NULL,
    Stock INT NOT NULL,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Supplies (
    SupplierID VARCHAR(100) NOT NULL,
    BookID VARCHAR(100) NOT NULL,
    PRIMARY KEY (SupplierID, BookID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Customer (
    CustomerID VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Zip VARCHAR(100) NOT NULL
);

CREATE TABLE Order_ (
    OrderID VARCHAR(100) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID VARCHAR(100) NOT NULL,
    EmployeeID VARCHAR(100) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contains_ (
    BookID VARCHAR(100) NOT NULL,
    OrderID VARCHAR(100) NOT NULL,
    Price INT NOT NULL CHECK (Price > 0),
	Quantity INT NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (BookID, OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (OrderID) REFERENCES Order_(OrderID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Employee Table
INSERT INTO Employee VALUES
('E001', 'Ahmed Khan', '03001234567', 'ahmed.khan@example.com', '2024-01-15', 'Manager', 50000),
('E002', 'Maria Ali', '03011234567', 'maria.ali@example.com', '2023-06-20', 'Cashier', 25000),
('E003', 'Bilal Shah', '03021234567', 'bilal.shah@example.com', '2024-03-10', 'Helper', 18000),
('E004', 'Sara Malik', '03031234567', 'sara.malik@example.com', '2023-08-05', 'Manager', 65000),
('E005', 'Asif Raza', '03041234567', 'asif.raza@example.com', '2024-05-01', 'Cashier', 22000);

-- Cashier Table
INSERT INTO Cashier (EmployeeID, Shift) VALUES
('E002', 'Morning'),
('E005', 'Night'),
('E006', 'Evening'),
('E007', 'Afternoon'),
('E008', 'Morning');

-- Manager Table
INSERT INTO Manager (EmployeeID, Bonus) VALUES
('E001', 8000),
('E004', 9000),
('E009', 10000),
('E010', 7500),
('E011', 6500);

-- Helper Table
INSERT INTO Helper (EmployeeID, PartTime) VALUES
('E003', 'No'),
('E012', 'Yes'),
('E013', 'No'),
('E014', 'Yes'),
('E015', 'No');

-- Supplier Table
INSERT INTO Supplier (SupplierID, Name, PhoneNo, Email, Street, City, State, Zip) VALUES
('S001', 'Pak Supply Co.', '03121234567', 'info@paksupply.com', '123 Main Street', 'Lahore', 'Punjab', '54000'),
('S002', 'Karachi Traders', '03131234567', 'contact@karachitraders.com', '456 Market Street', 'Karachi', 'Sindh', '74000'),
('S003', 'Islamabad Supplies', '03141234567', 'info@isb-supplies.com', '789 Central Avenue', 'Islamabad', 'Islamabad', '44000'),
('S004', 'Multan Suppliers', '03151234567', 'contact@multansuppliers.com', '321 Riverside Drive', 'Multan', 'Punjab', '60000'),
('S005', 'Peshawar Traders', '03161234567', 'peshawar@traders.com', '654 Bazaar Street', 'Peshawar', 'KPK', '25000');

-- Author Table
INSERT INTO Author (AuthorID, Name) VALUES
('A001', 'Faiza Iftikhar'),
('A002', 'Omar Khalid'),
('A003', 'Ali Abbas'),
('A004', 'Nida Kirmani'),
('A005', 'Usman Javed');


-- Publisher Table
INSERT INTO Publisher (PublisherID, Name, PhoneNo, Email) VALUES
('P001', 'Pak Books', '03211234567', 'pub@pakbooks.com'),
('P002', 'Karachi Publications', '03221234567', 'karachipubs@example.com'),
('P003', 'Lahore Publishers', '03231234567', 'lahorepubs@example.com'),
('P004', 'Islamabad Press', '03241234567', 'isbpress@example.com'),
('P005', 'Multan Publishing House', '03251234567', 'multanpubs@example.com');

-- Genre Table
INSERT INTO Genre (GenreID, Name) VALUES
('G001', 'Fiction'),
('G002', 'Mystery'),
('G003', 'Thriller'),
('G004', 'Romance'),
('G005', 'Science Fiction');

-- Customer Table
INSERT INTO Customer (CustomerID, Name, PhoneNo, Email, Street, City, State, Zip) VALUES
('C001', 'Javeria Aslam', '03061234567', 'javeria.aslam@example.com', '123 Commerce Street', 'Faisalabad', 'Punjab', '36000'),
('C002', 'Zaid Ahmed', '03071234567', 'zaid.ahmed@example.com', '456 Green Avenue', 'Karachi', 'Sindh', '74000'),
('C003', 'Reema Khalid', '03081234567', 'reema.khalid@example.com', '789 Mall Road', 'Lahore', 'Punjab', '54000'),
('C004', 'Ahsan Shah', '03091234567', 'ahsan.shah@example.com', '321 Market Street', 'Rawalpindi', 'Islamabad', '47000'),
('C005', 'Fatima Iqbal', '03101234567', 'fatima.iqbal@example.com', '654 High Street', 'Peshawar', 'KPK', '25000');

-- Order Table
INSERT INTO Order_ (OrderID, OrderDate, CustomerID, EmployeeID) VALUES
('O001', '2024-11-01', 'C001', 'E002'),
('O002', '2024-12-02', 'C002', 'E005'),
('O003', '2024-9-03', 'C003', 'E002'),
('O004', '2024-10-04', 'C004', 'E002'),
('O005', '2024-12-05', 'C005', 'E005');


-- Book Table
INSERT INTO Book (BookID, ISBN, Title, PublicationYear, PublisherID, AuthorID, GenreID, Stock) VALUES
('B001', '978-0-123456-47-2', 'The Journey Within', '2022', 'P001', 'A001', 'G001',100),
('B002', '978-0-123456-48-9', 'Silent Whispers', '2023', 'P002', 'A002', 'G002',200),
('B003', '978-0-123456-49-6', 'Lost Memories', '2021', 'P003', 'A003', 'G003',300),
('B004', '978-0-123456-50-2', 'Shadows of the Past', '2024', 'P004', 'A004', 'G004',259),
('B005', '978-0-123456-51-9', 'Echoes of the Heart', '2023', 'P005', 'A005', 'G005',99);

-- Supplies Table
INSERT INTO Supplies (SupplierID, BookID) VALUES
('S001', 'B001'),
('S002', 'B002'),
('S003', 'B003'),
('S004', 'B004'),
('S005', 'B005');


-- Contains Table
INSERT INTO Contains_ (BookID, OrderID, Price, Quantity) VALUES
('B001', 'O001', 1500, 1),
('B002', 'O002', 1200, 2),
('B003', 'O003', 1800, 3),
('B004', 'O004', 2200, 4),
('B005', 'O005', 1300, 5);

--PROCEDURES 

--1
-- Adds a new book to the Book table
CREATE PROCEDURE AddNewBook (@BookId Varchar(100), @ISBN Varchar(100), @Title Varchar(100), @PublicationYear Int, @PublisherID Varchar(100), @AuthorID Varchar(100), @GenreID Varchar(100), @Stock Int)
As 
    Insert Into Book (BookID, ISBN, Title, PublicationYear, PublisherID, AuthorID, GenreID, Stock)
    Values (@BookId, @ISBN, @Title, @PublicationYear, @PublisherID, @AuthorID, @GenreID, @Stock);
    Select * From Book 
    Where BookID = @BookId;

Exec AddNewBook 'B006', '123-4-56-789012-3', 'Sample Book Title', 2024, 'P001', 'A001', 'G001', 100;


--2
--sales report for a specific month and year.
CREATE PROCEDURE GenerateMonthlySalesReport (@Month Int, @Year Int)
As
    Select o.OrderID, o.OrderDate, cust.Name As CustomerName, emp.Name As EmployeeName, b.Title, (c.Price * c.Quantity) as TotalAmount 
    From Order_ o 
	Inner Join Contains_ c On o.OrderID = c.OrderID 
	Inner Join Customer cust On o.CustomerID = cust.CustomerID 
	Inner Join Employee emp On o.EmployeeID = emp.EmployeeID 
	Inner Join Book b On c.BookID = b.BookID
    Where Month(o.OrderDate) = @Month And Year(o.OrderDate) = @Year;

Exec GenerateMonthlySalesReport 12, 2024;

--3
--Calculates total amount for a given order based on items and quantities.
CREATE PROCEDURE CalculateTotalOrderAmount (@OrderID Varchar(100))
As
    Select @OrderID As OrderID, Sum(Price * Quantity) As TotalAmount 
	From Contains_ 
	Where OrderID = @OrderID;

Exec CalculateTotalOrderAmount 'O001';

--4
--Updates the salary of a specific employee and shows before/after details.
CREATE PROCEDURE updateSalary @EmployeeID Varchar(100), @Salary int
As 
Select EmployeeID, Name, Salary from Employee where EmployeeID = @EmployeeID
Update Employee set Salary = @Salary where EmployeeID = @EmployeeID
Select EmployeeID,Name, Salary as [Updated Salary] from Employee where EmployeeID = @EmployeeID

exec updateSalary 'E001', 60000

--5
--Checks the stock availability of a specific book.
CREATE PROCEDURE checkBookStock @BookID Varchar(100)
As
Select BookID, Title, Stock from Book where BookID = @BookID

exec checkBookStock 'B003'



--VIEWS

--1
--all orders with related customer, employee, and book info.
CREATE VIEW OrderSummary As
    Select o.OrderID, o.OrderDate, cust.Name As CustomerName, emp.Name As EmployeeName, b.Title, c.Quantity, c.Price, 
    (c.Quantity * c.Price) As TotalAmount
    From Order_ o 
	Inner Join Contains_ c On o.OrderID = c.OrderID 
	Inner Join Customer cust On o.CustomerID = cust.CustomerID 
	Inner Join Employee emp On o.EmployeeID = emp.EmployeeID 
	Inner Join Book b On c.BookID = b.BookID;

Select * from OrderSummary

--2
--Lists books along with their genre, author, publisher, publication year, and available stock.
CREATE VIEW BooksByGenreAndAuthor AS
	Select g.Name AS Genre, a.Name AS Author, b.Title AS BookTitle, b.PublicationYear, b.Stock AS AvailableStock, p.Name AS Publisher
	From  Book b
	join  Genre g ON b.GenreID = g.GenreID
	join  Author a ON b.AuthorID = a.AuthorID
	join  Publisher p ON b.PublisherID = p.PublisherID;

Select * From BooksByGenreAndAuthor

--3
--Detailed book information including author, publisher, genre, and publication year.
CREATE VIEW viewBookDetails As
	Select B.BookID, B.Title, B.Stock, A.Name as [Author Name], P.Name as [Publisher Name], G.Name as [Genre], B.PublicationYear, B.ISBN
	from Book as B join Author as A
	on B.AuthorID = A.AuthorID
	join Publisher as P
	on B.PublisherID = P.PublisherID
	join Genre as G
	on B.GenreID = G.GenreID

Select * from viewBookDetails

--4
--total revenue generated by each cashier employee from their processed orders.
CREATE VIEW revenueByEmployees As
	Select E.EmployeeID, E.Name as [Employee Name], SUM(C.Price * C.Quantity) as [Total Revenue]
	from Employee as E join Order_ as O
	on E.EmployeeID = O.EmployeeID
	join Contains_ as C
	on O.OrderID = C.OrderID
	where E.Position = 'Cashier'
	Group by E.EmployeeID, E.Name

Select * from revenueByEmployees

--5
--employee salary details including bonuses for managers and total compensation.
CREATE VIEW EmployeeSalaryReport As
	Select E.EmployeeID, E.Name, E.Position, E.Salary,
	CASE 
		WHEN E.Position = 'Manager' then M.Bonus
		else 0
	END AS [Bonus], (E.Salary + COALESCE(M.Bonus, 0)) AS [Total Salary]
	from Employee as E left join Manager as M
	on E.EmployeeID = M.EmployeeID
	left join Helper as H
	on E.EmployeeID = H.EmployeeID
	left join Cashier as C
	on E.EmployeeID = C.EmployeeID

Select * from EmployeeSalaryReport


