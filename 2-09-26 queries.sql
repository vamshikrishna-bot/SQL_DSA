CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(20),
    salary INT,
    hire_date DATE
);

INSERT INTO employees (emp_id, emp_name, department, salary, hire_date)
VALUES
(1, 'Arun', 'IT', 90000, '2024-01-10'),
(2, 'Bala', 'IT', 80000, '2024-02-15'),
(3, 'Charan', 'IT', 80000, '2024-03-20'),
(4, 'Divya', 'HR', 75000, '2024-01-12'),
(5, 'Esha', 'HR', 70000, '2024-04-01'),
(6, 'Farhan', 'HR', 70000, '2024-05-05'),
(7, 'Gokul', 'Sales', 95000, '2024-02-02'),
(8, 'Hari', 'Sales', 85000, '2024-06-18');

select * from employees; 


select emp_id, emp_name, salary, row_number() over(order by salary desc)  as  sno from employees;
SELECT emp_id, emp_name, salary,(rank() OVER (ORDER BY salary DESC)) AS sno FROM employees;
SELECT emp_id,emp_name,salary, (dense_rank() OVER (ORDER BY salary DESC)) AS sno FROM employees;
SELECT emp_id,emp_name,salary, (row_number() OVER (partition by department ORDER BY salary DESC)) AS sno FROM employees;
SELECT emp_id,emp_name,salary, (rank() OVER (partition by department ORDER BY salary DESC)) AS sno FROM employees;
SELECT emp_id,emp_name,salary, (dense_rank() OVER (partition by department ORDER BY salary DESC)) AS sno FROM employees;
SELECT emp_id,emp_name,salary, (FIRST_VALUE(emp_name) OVER (partition by department ORDER BY salary DESC)) AS high_paid FROM employees;
SELECT emp_id,emp_name,salary, (LAST_VALUE(emp_name) OVER (partition by department ORDER BY salary)) AS low_paid FROM employees;
select * from (SELECT emp_id,emp_name,salary, (dense_rank() OVER (partition by department ORDER BY salary DESC)) AS sno FROM employees) as x where x.sno<=2 ;