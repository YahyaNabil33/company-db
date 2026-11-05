-- CompanyDB: schema, sample data and basic queries (Keylife Task 2)
IF DB_ID('CompanyDB') IS NULL CREATE DATABASE CompanyDB;
GO
USE CompanyDB;
GO

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments(
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Employees(
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments (DepartmentName)
VALUES ('HR'), ('IT'), ('Sales');

INSERT INTO Employees (EmployeeName, Salary, DepartmentID)
VALUES
('Ahmad', 3000.00, 1),
('Khaled', 2700.00, 2),
('Maya', 2500.00, 2),
('Sara', 1200.50, 2),
('Omar', 950.75, 3),
('Lina', 1100.00, 2),
('Yousef', 1900.00, 1),
('Rana', 1350.00, 3),
('Dina', 870.50, 1),
('Fadi', 1050.00, 3);
GO

-- 1- Each employee with his salary
SELECT EmployeeName, Salary
FROM Employees;

-- 2- The employee with the highest salary
SELECT TOP 1 EmployeeName
FROM Employees
ORDER BY Salary DESC;

-- 3- Each employee with his department name
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 4- Number of employees in each department
SELECT DepartmentName, COUNT(EmployeeID) AS EmployeeCount
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY DepartmentName;
