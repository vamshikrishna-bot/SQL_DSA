CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    manager_id INT
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    budget INT
);

INSERT INTO departments (dept_id, dept_name, location) VALUES
(10, 'Engineering', 'Chennai'),
(20, 'Sales', 'Hyderabad'),
(30, 'HR', 'Bengaluru'),
(40, 'Research', 'Pune'),
(50, 'Support', 'Chennai');

INSERT INTO employees (emp_id, emp_name, dept_id, salary, manager_id) VALUES
(101, 'Arun', 10, 50000, 103),
(102, 'Bala', 20, 45000, 106),
(103, 'Charan', 10, 80000, NULL),
(104, 'Divya', 30, 40000, 108),
(105, 'Ezhil', 10, 65000, 103),
(106, 'Farah', 20, 75000, NULL),
(107, 'Gokul', 40, 55000, 109),
(108, 'Harini', 30, 70000, NULL),
(109, 'Irfan', 40, 90000, NULL),
(110, 'Janani', 10, 60000, 103);

INSERT INTO projects (project_id, project_name, dept_id, budget) VALUES
(1, 'Cloud Migration', 10, 500000),
(2, 'Mobile App', 10, 300000),
(3, 'CRM Upgrade', 20, 250000),
(4, 'Recruitment AI', 30, 200000);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;

SELECT emp_id, emp_name, dept_id, salary
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
);

SELECT emp_id, emp_name, dept_id, salary
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE dept_id = e.dept_id
);

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);

SELECT emp_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);

SELECT emp_id, emp_name, salary
FROM employees e
WHERE manager_id IS NOT NULL
AND salary > (
    SELECT salary
    FROM employees
    WHERE emp_id = e.manager_id
);


SELECT emp_id, emp_name, salary
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees
    WHERE manager_id = e.emp_id
      AND salary > e.salary
);

SELECT dept_id
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);

SELECT emp_id, emp_name, dept_id, salary
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM employees
    GROUP BY dept_id
    HAVING AVG(salary) > (
        SELECT AVG(salary)
        FROM employees
    )
);

SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE dept_id = (
        SELECT dept_id
        FROM departments
        WHERE dept_name = 'HR'
    )
);

SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE dept_id = (
        SELECT dept_id
        FROM departments
        WHERE dept_name = 'Research'
    )
);

SELECT dept_id, dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM projects
    WHERE dept_id = d.dept_id
);

SELECT emp_id, emp_name, dept_id
FROM employees e
WHERE (
    SELECT COUNT(*)
    FROM projects
    WHERE dept_id = e.dept_id
) > 1;

SELECT emp_id, emp_name, dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM projects
    WHERE budget = (
        SELECT MAX(budget)
        FROM projects
    )
);




