# CompanyDB — SQL Server practice database

A small company database built step by step in SQL Server: tables and relationships, then filtering, aggregates and subqueries, then an employee hierarchy inside a single table.

Built as part of the Keylife Training SQL Server tasks.

## What it covers

| Script | Topics |
|---|---|
| `01_setup_and_basic_queries.sql` | Tables, primary and foreign keys, identity columns, `INSERT`, `INNER JOIN`, `GROUP BY` |
| `02_filters_and_aggregates.sql` | `ALTER TABLE`, `CASE`, `WHERE`, `AVG`, `HAVING`, `TOP`, subqueries, correlated subqueries |
| `03_manager_hierarchy.sql` | Self-referencing foreign key, self join, `LEFT JOIN`, `ISNULL` |

## Data model

```
Departments (DepartmentID PK, DepartmentName)
      ▲
      │ DepartmentID FK
Employees (EmployeeID PK, EmployeeName, Salary, DepartmentID, JoinDate, ManagerID FK → Employees.EmployeeID)
```

`ManagerID` points back to `Employees`, so the CEO (no manager) sits at the top and everyone else reports up to him.

## Run it

Requires SQL Server (any edition) and SSMS or `sqlcmd`. Run the scripts in order:

```
01_setup_and_basic_queries.sql
02_filters_and_aggregates.sql
03_manager_hierarchy.sql
```

Script 01 creates the `CompanyDB` database if it doesn't exist and rebuilds the tables, so it is safe to re-run from the start.
