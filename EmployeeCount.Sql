


CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  managerId INTEGER,
  FOREIGN KEY (managerId) REFERENCES employees(id)
);

INSERT INTO employees(id, name, managerId) VALUES(1, 'Rob', null);
INSERT INTO employees(id, name, managerId) VALUES(2, 'Tom', null);
INSERT INTO employees(id, name, managerId) VALUES(3, 'Roger', 1);
INSERT INTO employees(id, name, managerId) VALUES(4, 'Victor', 3);
INSERT INTO employees(id, name, managerId) VALUES(5, 'John', 4);
INSERT INTO employees(id, name, managerId) VALUES(6, 'Shawn', 2);




WITH EmployeeCTE
     AS (SELECT e.id,e.name, e.managerId as topmanager
         FROM   employees e, employees m
         WHERE  e.managerId = m.id AND m.managerId IS NULL
         UNION ALL
         SELECT e.id,e.name, mgr.topmanager
         FROM   employees e, EmployeeCTE mgr
         WHERE  e.managerId = mgr.id)
SELECT topmanager as Id, count(*) EmployeeCount
FROM   EmployeeCTE AS u
GROUP BY topmanager;
