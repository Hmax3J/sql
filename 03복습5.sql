desc dual
select * from dual;

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello', -1, 1)
from dual;

select instr('hello', 'l')
from dual;

select instr('hello', 'w')
from dual;

select lpad(salary, 5, '*')
from employees;
select rpad(salary, 5, '*')
from employees;

select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual;
select trim(' ' from 'Hello')
from dual;

select '|' || trim(' ' from ' hello ') || '|'
from dual;
select trim(' hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
    
select round(45.926, 2)
from dual;
select trunc(45.926, 2)
from dual;

select round(45.926, 0), round(45.923)
from dual;
select trunc(45.926, 0), trunc(45.923)
from dual;

select last_name, salary,
    round(salary * 1.155) "New salary",
    round(salary * 1.155) - salary "Increase"
from employees;

select sysdate
from dual;

select sysdate + 1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/07/14', 1)
from dual;

select next_day('2022/07/14', 5)
from dual;

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

select last_day('2022/07/14')
from dual;

select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;