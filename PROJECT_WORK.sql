use employees_mod;
 
 # task 1
 #breakdown between the male and female employees working in the company each year starting from 1990
 # write a query to combine data from two tables to get desired result set, so that its easy to create Bar chart in Tableau.
 #The result set has only three columns “calender_year”, “gender”, “num_of_employees”
 
 SELECT
 YEAR(d.from_date) as calender_year,
 e.gender, 
 COUNT(e.emp_no) as num_of_employees
 
 FROM
 t_employees e
 INNER JOIN
 t_dept_emp d 
 on e.emp_no = d.emp_no
 
 GROUP BY calender_year, e.gender
 HAVING  calender_year >= 1990;
 
 
 # task 2
 #compare the average salary of female versus male employees in the entire company until year 2002.
 
 SELECT 
 e.gender, d.dept_name, ROUND(AVG(s.salary), 2) as Salary, YEAR(s.from_date) as calender_year
 FROM
 t_salaries s
 JOIN
 t_employees e ON s.emp_no = e.emp_no
 JOIN
 t_dept_emp de ON de.emp_no = e.emp_no
 JOIN
 t_departments d ON d.dept_no = de.dept_no
 
 GROUP BY d.dept_no, e.gender, calender_year
 HAVING calender_year <= 2002
 ORDER BY d.dept_no;
 
 
 #Task 3
 #Compare the number of male managers to the number of female managers from departments 
 #different departments for each year, starting from 1990.
 
 SELECT 
d.dept_name,
ee.gender,
dm.from_date,
dm.to_date,
e.calender_year,

CASE
WHEN YEAR(dm.to_date) >= e.calender_year AND YEAR(dm.from_date) <=e.calender_year THEN 1
ELSE 0
END  AS active

FROM
(SELECT YEAR(hire_date) AS calender_year
FROM
t_employees
GROUP BY calender_year) e
CROSS JOIN
t_dept_manager	dm
JOIN
t_departments d ON dm.dept_no = d.dept_no
JOIN
t_employees ee ON dm.emp_no=ee.emp_no
ORDER BY dm.emp_no, calender_year;
 
