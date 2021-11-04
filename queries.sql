--- Select Doctor who work in the same hospital but in different specialities , to do so we join the table to it self as follow


Select d1.*
from doctors d1
join doctors d2 on d1.id <> d2.id 
and d1.hospital = d2.hospital 
and d1.speciality <> d2.speciality



---- SQL Query to fetch all the duplicate records in a table


Select user_id, user_name, email
from (select *,
row_number() over (partition by user_name order by user_id) as rn
from users u
order by user_id) x
where x.rn <> 1; 


--- SQL query to fetch the second last record from employee table

Select emp_id, emp_name, dept_name, salary
from (select *,
row_number() over (order by emp_id desc) as rn
from employee e) x
where x.rn = 2;


--- SQL query to display only the details of employees who either earn the highest salary or the lowest salary in each department from the employee table

Select x.*
from employee e
join (select *,
max(salary) over (partition by dept_name) as max_salary,
min(salary) over (partition by dept_name) as min_salary
from employee) x
on e.emp_id = x.emp_id
and (e.salary = x.max_salary or e.salary = x.min_salary)
order by x.dept_name, x.salary;

--- From the login_details table, fetch the users who logged in consecutively 3 or more times

Select distinct repeated_names
from (select *,
case when user_name = lead(user_name) over(order by login_id)
and  user_name = lead(user_name,2) over(order by login_id)
then user_name else null end as repeated_names
from login_details) x
where x.repeated_names is not null; 
