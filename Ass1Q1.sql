--Q1. Write CREATE TABLE command for EMPLOYEES table. Where Employee_id is PK, job_id is FK to Jobs.job_id,manager_id RFK to employees.employee_id and Department_id is FK to departments.department_id. 
CREATE TABLE EMPLOYEES (
  Employee_id int PRIMARY KEY,
  First_name varchar(20),
  Last_name varchar(25) NOT NULL,
  Email varchar(25) NOT NULL,
  Phone_number varchar(20),
  Hire_date DATE NOT NULL,
  Job_id int NOT NULL,
  Salary money,
  Commission_pct int,
  Manager_id int,
  Department_id int NOT NULL,
  CONSTRAINT emp_job_fk FOREIGN KEY (Job_id) REFERENCES JOBS (Job_id),
  CONSTRAINT emp_manager_fk FOREIGN KEY (Manager_id) REFERENCES EMPLOYEES (Employee_id),
  CONSTRAINT emp_dept_fk FOREIGN KEY (Department_id) REFERENCES DEPARTMENTS (Department_id)
);

--Q2. Write CREATE TABLE command for Jobs table. Analyze constraint yourself. 
CREATE TABLE Jobs (
  Job_id int PRIMARY KEY,
  Job_title nvarchar(50) NOT NULL,
  Min_salary money,
  Max_salary money,
  CONSTRAINT min_salary_check CHECK (Min_salary >= 0),
  CONSTRAINT max_salary_check CHECK (Max_salary >= Min_salary)
);

--Q3. Write insert command to insert a row into locations table by using macro substitution. 
DECLARE @location_id int = 111;
DECLARE @street_address varchar(50) = '123 Main St';
DECLARE @postal_code varchar(10) = '12345';
DECLARE @city varchar(30) = 'Anytown';
DECLARE @state_province varchar(30) = 'CA';
DECLARE @country_id int = 101;
INSERT INTO Locations (Location_id, Street_address, Postal_code, City, State_province, Country_id) 
VALUES (@location_id, @street_address, @postal_code, @city, @state_province, @country_id);

--Q4. Evaluate this SQL statement:
--SELECT ename, sal, 12*sal+100 FROM emp;
--The SAL column stores the monthly salary of the employee. Which change must be made to the above
--syntax to calculate the annual compensation as "monthly salary plus a monthly bonus of $100, multiplied by
--12"?

select first_name, salary, 12*salary+100 as 'monthly salary plus a monthly bonus of $100, multiplied by

12' from employees;

--Q5. In EMP table phno column have 6 digits, change it to 7 digits. Update rows by adding 2 as prefix to each

--phone number.

alter table employees alter column phone_number numeric(7,0);

UPDATE EMPLOYEES SET phone_number = CONCAT('2', phone_number); -----Q.6-----

/*Evaluate this DELETE statement:

 DELETE employee_id, salary, job_id FROM employees WHERE dept_id = 90;

Why does the DELETE statement fail when you execute it?*/

DELETE employee_id, salary, job_id FROM employees WHERE dept_id = 502;

/* ANS: When using the DELETE statement to delete data from a table, we should only specify the table name

and the WHERE clause that identifies the rows to be deleted. You should not include the column names in the DELETE statement.

The correct syntax would be: DELETE FROM employees WHERE dept_id = 90;

*/

-----Q.7-----

/*Which statement produces the number of different departments that have employees with last name

Smith?*/

SELECT COUNT(DISTINCT department_id)

FROM employees

WHERE last_name = 'Smith';

-----Q.8-----

/*You query the database with this SQL statement:

 SELECT empname,hire_date HIREDATE, salary FROM EMP ORDER BY hire_date;

How will the results be sorted? */

SELECT first_name, last_name, hire_date HIREDATE, salary

FROM EMPLOYEES

ORDER BY hire_date;

-----Q.9-----

/*The STUDENT_GRADES table has these columns:

STUDENT_ID NUMBER(12)

SEMESTER_END DATE

GPA NUMBER(4,3)

The registrar requested a report listing the students' grade point averages (GPA) sorted from highest grade

point average to lowest. Write Query.*/

create table student_grades(

student_id NUMERIC(12),

semester_end date,

gpa NUMERIC(4,3));

INSERT INTO student_grades VALUES

(101,'12-05-2022',9.6),

(102,'03-04-2022',7.6),

(103,'09-08-2022',8.8);

SELECT * FROM student_grades;

SELECT STUDENT_ID, GPA

FROM STUDENT_GRADES

ORDER BY GPA DESC;

----Q.10----

/*You need to display the employees who have not been assigned to any department.*/

SELECT first_name, job_id, salary

FROM employees

LEFT OUTER JOIN departments

ON employees.department_id = departments.department_id

WHERE departments.department_id IS NULL;

-----Q.11-----

/*The CUSTOMERS table has these columns:

CUSTOMER_ID NUMBER(4) NOT NULL

CUSTOMER_NAME VARCHAR2(100) NOT NULL

CUSTOMER_ADDRESS VARCHAR2(150)

CUSTOMER_PHONE VARCHAR2(20)

You need to produce output that states "Dear Customer customer_name, ". The customer_name data values

come from the CUSTOMER_NAME column in the CUSTOMERS table.*/

create table customers(

customer_id numeric(4) not null,

customer_name varchar(100) not null,

customer_address varchar(150),

customer_phone varchar(20));

insert into customers values

(101,'Abhinav','ABC House',9087867545),

(102,'Rahul','Achyutham',8088787654),

(103,'Daya','Karthika',7089765645);

select * from customers;

select 'Dear customer ' + customer_name + ', ' from customers;

-----Q.12-----

/*A. Consider an EMP table having id, name, sal, comm_pct, pf, hra, tearn, tded, net. Complete insert into

command by leaving pf, hra, tearn, tded and net columns.

 Insert into emp values(…

 B. Fill records by calculating…

 1. pf = 10% of sal

 2. hra = 12% of Sal

 3. tearn = sal+hra

 4. tded = pf + 4% of sal

 5. net = tearn – tded*/

CREATE TABLE emp (

 id INT,

 name VARCHAR(50),

 sal DECIMAL(10,2),

 comm_pct DECIMAL(3,2),

 pf DECIMAL(10,2),

 hra DECIMAL(10,2),

 tearn DECIMAL(10,2),

 tded DECIMAL(10,2),

 net DECIMAL(10,2)

);

INSERT INTO emp (id, name, sal, comm_pct) VALUES

(1, 'John', 50000, 0.05),

(2, 'Jane', 60000, 0.10),

(3, 'Bob', 75000, 0.08);

select * from emp;

UPDATE emp

SET pf = sal * 0.1,

  hra = sal * 0.12,

  tearn = sal + (sal * 0.12),

  tded = (sal * 0.1) + (sal * 0.04),

  net = sal + (sal * 0.12) - ((sal * 0.1) + (sal * 0.04));


