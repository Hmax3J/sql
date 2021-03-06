-- 6장 

-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees 
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;
---------------------------

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

-- 테이블 별명을 컬럼 앞에 접두사를 사용 할 수 있다.
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- error using 컬럼에 접두사가 있어서 에러다.

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; -- error using 컬럼은 접두사를 못쓴다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; -- error 누구의 manager_id인지 몰라 에러다.

select e.last_name, d.department_name
from employees e join departments d
using(department_id) -- 공통 컬럼 중 using에 쓴건 접두사를 못쓰고 
where d.manager_id = 100; -- 다른 공통컬럼은 접두사를 써야한다.
--------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제] 위 문장을, using 으로 refactoring 하라.
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using (location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;

-- 과제] Toronto 에 위치한 부서에서 일하는 사원들의
--       이름, 직업, 부서번호, 부서명, 도시를 조회하라.
select e.last_name, e.job_id, e.department_id, 
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-----------------------

-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; -- error selfjoin 에선 접두사가 필수다.

-- 과제] 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id -- <>와 != 는 같은 용도다.
order by 1, 2, 3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies' 
and d.hire_date < e.hire_date
order by 2;

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저입사일을 조회하라.
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and w.hire_date < m.hire_date;
---------------------------

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- outer join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의사번을 조회하라.
--        king 사장도 테이블에 포함한다.
select w.last_name, w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
--------------------

-- 옛날 문법
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

-- right outer join 옛날 문법
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- 포함되어 있지 않은 부서이름도 나타낸다.

-- left outer join 옛날 문법
select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- 그랜트도 나타낸다.

-- self join 옛날 문법
select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;