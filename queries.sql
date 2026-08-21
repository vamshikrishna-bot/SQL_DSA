

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(30) NOT NULL UNIQUE,
location VARCHAR(30)
);

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(40) NOT NULL,
dept_id INT NULL,
manager_id INT NULL,
salary DECIMAL(10,2) NOT NULL,
hire_date DATE NOT NULL,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE projects (
project_id INT PRIMARY KEY,
project_name VARCHAR(40),
dept_id INT,
budget DECIMAL(12,2),
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE employee_project (
emp_id INT, project_id INT, hours INT,
PRIMARY KEY (emp_id, project_id),
FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments VALUES
(10,'Engineering','Chennai'),(20,'Sales','Hyderabad'),
(30,'HR','Bengaluru'),(40,'Research','Pune');

INSERT INTO employees VALUES
(101,'Asha',10,NULL,120000,'2021-01-10'),
(104,'Dev',20,NULL,110000,'2020-11-05');
INSERT INTO employees VALUES
(102,'Bala',10,101,80000,'2022-03-15'),
(103,'Charu',NULL,101,75000,'2023-07-01'),
(105,'Eshan',20,104,70000,'2022-09-12'),
(106,'Farah',10,101,90000,'2024-02-20');

INSERT INTO projects VALUES
(501,'Cloud Migration',10,500000),(502,'AI Assistant',10,800000),
(503,'CRM Revamp',20,300000),(504,'Future Lab',40,1000000);

INSERT INTO employee_project VALUES
(101,501,20),(102,501,35),(102,502,15),
(104,503,25),(105,503,40),(106,502,30);



SELECT * FROM departments;
SELECT * FROM projects;
SELECT * FROM employee_project;
SELECT * FROM employees;


select e.emp_id, e.emp_name, d.dept_name from employees as e 
inner join departments as d on e.dept_id = d.dept_id order by e.emp_id;

select e.emp_id, e.emp_name, d.dept_name from employees as e 
left join departments as d on e.dept_id = d.dept_id order by e.emp_id;

select e.emp_id, e.emp_name, d.dept_name from employees as e 
right join departments as d on e.dept_id = d.dept_id order by e.emp_id;

select e.emp_id, e.emp_name, d.dept_name from employees as e 
join departments as d on e.dept_id = d.dept_id order by e.emp_id;

select e.emp_id, e.emp_name, d.dept_name from employees as e 
join departments as d on e.dept_id = d.dept_id order by e.emp_id;

select e.emp_id, e.emp_name, d.dept_name from employees as e 
right join departments as d on e.dept_id = d.dept_id 
union all
select e.emp_id, e.emp_name, d.dept_name from employees as e 
join departments as d on e.dept_id = d.dept_id;

SELECT e.emp_id, e.emp_name, d.dept_name, m.emp_name AS manager_name
FROM employees AS e
LEFT JOIN departments AS d ON e.dept_id = d.dept_id
LEFT JOIN employees AS m ON e.manager_id = m.emp_id ORDER BY e.emp_id;

SELECT e.emp_id, e.emp_name, d.dept_name, d.location FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

SELECT e.emp_id,e.emp_name,d.dept_name FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

SELECT d.dept_id,d.dept_name FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id WHERE e.emp_id IS NULL;

SELECT e.emp_name,p.project_name,d.dept_name, ep.hours FROM employees e
JOIN employee_project ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id
JOIN departments d ON p.dept_id = d.dept_id;

SELECT e.emp_name AS employee_name, m.emp_name AS manager_name FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

SELECT e.emp_name,p.project_name,d.dept_name,ep.hours FROM employees e
JOIN employee_project ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id
JOIN departments d ON p.dept_id = d.dept_id;