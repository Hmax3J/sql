-- 7장 subquery

select last_name, salary
from employees
where salary > (select salary -- 서브 쿼리가 먼저 실행되어 해당하는 값을 저장한다.
                from employees
                where last_name = 'Abel');

-- 과제] Kochhar 에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');

select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
                
-- 과제] IT 부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name = 'IT');

-- 과제] abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
--      이름 순으로 오름차순 정렬한다.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'King'); -- error 서브쿼리의 리턴값이 1개여야 한다.
                
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary) -- select에 있는 min(salary) 조건을 쓴다.
                        from employees  -- group 펑션의 조건이다.
                        where department_id = 50);

-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
--      월급 내림차순 정렬한다.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by salary desc;
----------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees -- error 1개만 리턴해야 하는데 1개 이상 리턴한다.
                group by department_id);

select employee_id, last_name
from employees
where salary in (select min(salary)
                from employees 
                group by department_id);

-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);

select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees -- any는 단독으로 쓰이지 않는다. 다 false이고
                    group by department_id); -- 1개가 true면 true인 1개를 리턴한다.

select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary -- 9000 미만이면 다 나온다.
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary -- 모든 것을 만족해야 true가 되고
                    from employees -- true가 된 값을 리턴한다.
                    where job_id = 'IT_PROG') -- 4200 미만이어야 한다.
and job_id <> 'IT_PROG';

-- 과제] 60번 부서의 일부 사원보다 급여가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                    from employees
                    where department_id = 60);
                    
-- 과제] 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--          사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                from employees
                where job_id = 'IT_PROG');
--------------------

-- no row
select last_name
from employees
where salary = (select salary -- 서브 쿼리가 리턴이 없으면 리턴되는 row가 없고
                from employees -- 메인쿼리도 리턴되는 row가 없다.
                where employee_id = 1);
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');

-- null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);

select last_name
from employees
where employee_id not in (select manager_id
                          from employees);

-- 과제] 위 문장으로 all 연산자로 refactoring 하라.
select last_name    -- 전부 다 달라야 한다. 
from employees -- true && true && ... 마지막 까지 true여야한다.
where employee_id <>all (select manager_id -- 하나라도 null이 있으면 null이다.
                        from employees);
--------------------

select count(*)
from departments d
where exists (select *
                from employees e -- 사원들이 있는 부서들을 카운트한다.
                where e.department_id = d.department_id);

select count(*)
from departments d
where not exists (select *
                from employees e -- 사원이 없는 부서들을 카운트한다.
                where e.department_id = d.department_id);

-- 과제] 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;

select *
from job_history
order by employee_id;