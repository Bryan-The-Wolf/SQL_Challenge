-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/kO7TfJ
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "Departments" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(5)   NOT NULL
);

CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


SELECT * FROM "Departments" Limit 3;
SELECT * FROM "Dept_Emp" Limit 3;
SELECT * FROM "Dept_Manager" Limit 3;
SELECT * FROM "Employees" Limit 3;
SELECT * FROM "Salaries" Limit 3;
SELECT * FROM "Titles" Limit 3;

 -- Renaming Tables to get rid of quotation marks --
ALTER TABLE "Departments" RENAME TO Departments;
ALTER TABLE "Dept_Emp" RENAME TO Dept_Emp;
ALTER TABLE "Dept_Manager" RENAME TO Dept_Manager;
ALTER TABLE "Employees" RENAME TO Employees;
ALTER TABLE "Salaries" RENAME TO Salaries;
ALTER TABLE "Titles" RENAME TO Titles;

SELECT * FROM Employees Limit 30;
SELECT * FROM Salaries Limit 3;

--1 Using join to look up salary information --
SELECT Employees.emp_no,
Employees.last_name,
Employees.first_name,
Employees.sex,
Salaries.salary
FROM Employees
INNER JOIN Salaries 
ON Employees.emp_no = Salaries.emp_no
ORDER BY last_name;

--2 Looking up hire dates of year 1986 --
SELECT first_name,
last_name,
hire_date
FROM Employees
WHERE hire_date
LIKE '%1986';

-- 4 Employees by department --

SELECT Employees.emp_no,
Employees.last_name,
Employees.first_name,
Departments.dept_name
FROM Employees
INNER JOIN Dept_emp
ON Employees.emp_no = Dept_emp.emp_no
INNER JOIN Departments
ON Departments.dept_no = Dept_Emp.dept_no;

--5 Looking for Hercules B --
SELECT first_name,
last_name,
sex
FROM Employees
WHERE last_name LIKE'B%' AND first_name = 'Hercules';

--6 Employees in the Sales department --

SELECT Employees.emp_no,
Employees.last_name,
Employees.first_name,
Departments.dept_name
FROM Employees
INNER JOIN Dept_emp
ON Employees.emp_no = Dept_emp.emp_no
INNER JOIN Departments
ON Departments.dept_no = Dept_Emp.dept_no
WHERE dept_name= 'Sales';

--7 Employees in the Sales and Development departments --

SELECT Employees.emp_no,
Employees.last_name,
Employees.first_name,
Departments.dept_name
FROM Employees
INNER JOIN Dept_emp
ON Employees.emp_no = Dept_emp.emp_no
INNER JOIN Departments
ON Departments.dept_no = Dept_Emp.dept_no
WHERE dept_name= 'Sales' OR dept_name= 'Development';


--8 Frequency of employee last name in descending order--
SELECT last_name,
COUNT (last_name) as my_count
FROM Employees
GROUP BY last_name
ORDER BY my_count DESC;

-- 3 --
SELECT Dept_Manager.dept_no,
Departments.dept_name,
Employees.emp_no,
Employees.last_name,
Employees.first_name
FROM Employees
INNER JOIN Dept_Manager
ON Employees.emp_no = Dept_Manager.emp_no
INNER JOIN Departments
ON Departments.dept_no = Dept_Manager.dept_no




