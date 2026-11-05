-- CompanyDB: join dates, filtering, aggregates and subqueries (Keylife Task 3)
-- Run after 01_setup_and_basic_queries.sql
USE CompanyDB;
GO

ALTER TABLE Employees
ADD JoinDate DATE;
GO

UPDATE Employees
SET JoinDate = CASE EmployeeID
    WHEN 1  THEN '2019-03-11'
    WHEN 2  THEN '2020-07-22'
    WHEN 3  THEN '2018-11-05'
    WHEN 4  THEN '2024-09-30'
    WHEN 5  THEN '2022-04-18'
    WHEN 6  THEN '2025-06-02'
    WHEN 7  THEN '2023-02-27'
    WHEN 8  THEN '2024-11-14'
    WHEN 9  THEN '2021-01-15'
    WHEN 10 THEN '2025-06-02'
END;
GO

-- 1- Employees who joined after January 1st, 2024
SELECT EmployeeName, JoinDate
FROM Employees
WHERE JoinDate > '2024-01-01';

-- 2- Employees with a salary above 1900
SELECT EmployeeName, Salary
FROM Employees
WHERE Salary > 1900;

-- 3- Employees in the IT department
SELECT EmployeeName, DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE DepartmentName = 'IT';

-- 4- Average salary per department
SELECT DepartmentName, AVG(Salary) AS AverageSalary
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY DepartmentName;

-- 5- Employees who earn more than the overall average (subquery)
SELECT EmployeeName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 6- Departments with more than 2 employees (HAVING)
SELECT DepartmentName, COUNT(EmployeeID) AS EmployeeCount
FROM Departments D
INNER JOIN Employees E ON E.DepartmentID = D.DepartmentID
GROUP BY DepartmentName
HAVING COUNT(EmployeeID) > 2;

-- 7- The 3 highest-paid employees
SELECT TOP 3 EmployeeName, Salary
FROM Employees
ORDER BY Salary DESC;

-- 8- Each department with its highest-paid employee (correlated subquery)
SELECT D.DepartmentName, E.EmployeeName, E.Salary
FROM Departments D
INNER JOIN Employees E ON E.DepartmentID = D.DepartmentID
WHERE E.Salary = (SELECT MAX(Salary)
                  FROM Employees
                  WHERE DepartmentID = D.DepartmentID);
