


----CREATE TABLE Employee (
----    EmployeeID INT PRIMARY KEY,
----    Name VARCHAR(50),
----    ManagerID INT,
----    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
----);

----INSERT INTO Employee VALUES
----(1, 'Alice', NULL),
----(2, 'Bob', 1),
----(3, 'Charlie', 1),
----(4, 'David', 2),
----(5, 'Eve', 2),
----(6, 'Frank', 3),
----(7, 'Grace', 3),
----(8, 'Henry', 4),
----(9, 'Ivy', 4),
----(10, 'Jack', 5);



----Given a table representing a hierarchical structure (e.g., employees and their managers), 
----find all employees who are more than three levels deep in the hierarchy.



WITH  EmployeeHierarchy AS (
    SELECT EmployeeID, Name, ManagerID, 1 AS Level
    FROM Employee
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.Name, e.ManagerID, eh.Level + 1 AS Level
    FROM Employee e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT EmployeeID, Name
FROM EmployeeHierarchy
WHERE Level > 2;
