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
