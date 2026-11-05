-- CompanyDB: employee hierarchy with a self-referencing foreign key (Keylife Task 4)
-- Run after 02_filters_and_aggregates.sql
USE CompanyDB;
GO

-- The CEO gets his own department
INSERT INTO Departments (DepartmentName)
VALUES ('Executive');
GO

UPDATE Employees
SET DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Executive')
WHERE EmployeeID = 1;

-- Each employee points to his manager in the same table
ALTER TABLE Employees
ADD ManagerID INT;

ALTER TABLE Employees
ADD FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID);
GO

-- Employee 1 (Ahmad) is the CEO: ManagerID stays NULL
UPDATE Employees SET ManagerID = 1 WHERE EmployeeID IN (2, 3, 7, 10);
UPDATE Employees SET ManagerID = 2 WHERE EmployeeID IN (4, 8);
UPDATE Employees SET ManagerID = 3 WHERE EmployeeID IN (5, 6, 9);
GO

-- Each employee with his manager (LEFT JOIN keeps the CEO, ISNULL labels him)
SELECT E.EmployeeName AS Employee,
       ISNULL(M.EmployeeName, 'CEO') AS Manager
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;

-- The full table after the changes
SELECT * FROM Employees;
