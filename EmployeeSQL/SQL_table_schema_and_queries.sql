-- Employee SQL Challenge - Table Schema
-- Exported & editted from QuickDBD 

CREATE TABLE Employees (
    emp_no SERIAL   NOT NULL,
    birth_date VARCHAR   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Titles (
    emp_no SERIAL   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE Salaries (
    emp_no SERIAL   NOT NULL,
    salary INT   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE Departments (
    dept_no VARCHAR(5),
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);
-- whoops, little spelling error in table name. gonna roll w/ it for now
CREATE TABLE DeptEmpoyee (
    emp_no SERIAL   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

CREATE TABLE DeptManager (
    dept_no VARCHAR   NOT NULL,
    emp_no SERIAL   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL
);

ALTER TABLE Titles ADD CONSTRAINT fk_Titles_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE DeptEmpoyee ADD CONSTRAINT fk_DeptEmpoyee_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE DeptEmpoyee ADD CONSTRAINT fk_DeptEmpoyee_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE DeptManager ADD CONSTRAINT fk_DeptManager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE DeptManager ADD CONSTRAINT fk_DeptManager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);


-- Employee SQL Challenge - Queries

-- Get a list of employee information that includes their salary

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.gender, S.salary
FROM Employees 
JOIN Salaries AS S 
	ON Employees.emp_no = S.emp_no
	ORDER BY S.salary DESC;

-- Get a list of employees hired in 1986

SELECT emp_no, first_name, last_name, hire_date
FROM Employees
WHERE hire_date LIKE '1986%'
ORDER BY hire_date;

-- Get the full list of department managers.
-- Include dept number & name, manager's employee number...
-- ...last name, first name & start & end dates

SELECT 
	DeptManager.dept_no, 
	D.dept_name, 
	DeptManager.emp_no,
	E.last_name,
	E.first_name,
	DeptManager.from_date,
	DeptManager.to_date
FROM
	DeptManager
JOIN
	Departments AS D
	ON DeptManager.dept_no = D.dept_no
JOIN
	Employees AS E
	ON DeptManager.emp_no = E.emp_no;

-- Get a list of employee's with their departments.
-- Include employee number, last name & first name & dept name.

SELECT 
	DeptEmpoyee.dept_no,
	D.dept_name,
	DeptEmpoyee.emp_no,
	E.last_name, 
	E.first_name
FROM
	DeptEmpoyee
JOIN
	Departments AS D
	ON DeptEmpoyee.dept_no = D.dept_no
JOIN
	Employees AS E
	ON DeptEmpoyee.emp_no = E.emp_no;

-- Get a list of all employees named Hercules whose a last name begins with B

SELECT emp_no, first_name, last_name, gender, hire_date
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- Get a list of employees from Sales/Dev

SELECT
	DE.emp_no,
	DE.dept_no,
	D.dept_name,
	E.last_name AS Last_Name,
	E.first_name AS First_Name
FROM DeptEmpoyee AS DE
	LEFT JOIN Employees AS E ON DE.emp_no = E.emp_no
	LEFT JOIN Departments AS D ON DE.dept_no = D.dept_no
	WHERE D.dept_name = 'Sales'
	OR D.dept_name = 'Development';

-- get frequency of last names...
-- -- by last name descending (1)

SELECT
	Employees.last_name
	COUNT(Employees.last_name) AS last_name_totals
FROM 
	Employees
GROUP BY
	Employees.last_name
ORDER BY
	Employees.last_name DESC;

-- -- by frequency count descending (2)

SELECT
	Employees.last_name,
	COUNT(Employees.last_name) AS last_name_totals
FROM 
	Employees
GROUP BY
	Employees.last_name
ORDER BY
	last_name_totals DESC;


