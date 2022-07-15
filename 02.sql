-- 2장 where
select employee_id, last_name, department_id
from employees
where department_id = 90;

-- 과제] 176번 사원의 사번, 이름, 부서번호를 조회하라.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

-- 과제] $12,000 이상 버는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';
-----------------------

-- between
select last_name, salary
from employees
where salary BETWEEN 2500 and 3500;

select last_name
from employees
where last_name BETWEEN 'King' and 'Smith';

--과제] 'King' 사원의 frist name, last name, 직업, 월급을 조회하라.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date BETWEEN '2002/01/01' and '2002/12/31';
------------------

-- in
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201);

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;
    
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');
-------------------

-- like
select last_name
from employees
where last_name like 'S%';

select last_name
from employees
where last_name like '%r';

-- 과제] first_name 에 s가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%s%';

-- 과제] 2005년에 입사한 사원들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where hire_date like '2005%';
-- like 비교는 문자로 한다. 숫자는 비슷하다가 없다. 
-- 와일드카드는 임의의 0개 이상 글자를 말한다.
-- _는 임의의 1글자를 말한다.
-- 검색 할 때 like를 쓴다.
select last_name
from employees
where last_name like 'K___';

-- 과제] 이름의 두번째 글자가 o인 사원의 이름을 조회하라.
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';
-- escape 는 특수문자를 일반문자로 바꿔준다.
-- escape 문자는 사용자가 직접 정할 수 있다.
select last_name, job_id
from employees
where job_id like 'I_[_%' escape '[';

-- 과제] 직업에 _R이 포함된 사원들의 이름, 직업을 조회하라.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';
----------------------

-- is null
select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;

select last_name, manager_id
from employees
where manager_id is null;
---------------------

-- and, or
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

-- 과제] 월급이 $5000 이상 $12000 이하 이다. 그리고,
--      20번이나 50번 부서에 일하는 사원들의 이름, 월급, 부서번호를 조회하라.
select last_name, salary, department_id
from employees
where (salary BETWEEN 5000 and 12000) and 
    department_id in (20, 50);

-- 과제] 이름에 a와 e가 포함된 사원들의 이름을 조회하라.
select last_name
from employees
where last_name like '%a%' and 
    last_name like '%e%';
---------------------

-- not
select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');
-- in 했을 때 결과값의 나머지(반대값)를 구한다.

select last_name, salary
from employees
where salary not BETWEEN 10000 and 15000;
-- between 했을 때 포함되지 않는 값을 나타낸다.

select last_name, job_id
from employees
where job_id not like '%IT%';
-- IT가 포함되지 않은 값을 나타낸다.

select last_name, job_id
from employees
where commission_pct is not null;
-- commission_pct가 비어있는 값만 나타낸다.

select last_name, salary
from employees
where manager_id is null and salary >= 20000;

select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

-- 과제] 직업이 영업이다. 그리고, 월급이 $2500, $3500가 아니다.
--      위 사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in (2500, 3500);
-------------------

-- order by
-- 오름차순에서 null은 가장 큰 값으로 취급 한다.
select last_name, department_id
from employees
order by department_id;

-- 내림차순
select last_name, department_id
from employees
order by department_id desc;

-- 인덱스 값으로 정렬
select last_name, department_id
from employees
order by 2 desc;

-- 별명으로 정렬
select last_name, department_id dept_id
from employees
order by dept_id desc;

-- select에 없는 테이블로도 정렬이 가능하다.
select last_name
from employees
where department_id = 100
order by hire_date;

-- 1차로 부서번호를 기준으로 오름차순, 2차로 월급을 내림차순으로 정렬
select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc;