-- 5장 group function, null값을 무시한다.

-- group function 은 파라미터 레코드 개수가 n개다.
-- single 이나 group이나 리턴값은 1개다.
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- 날짜에 max, min 사용 할 경우 max는 최근 일이다.
-- 마지막 방문일, 휴면계정 등등에 사용 할 수 있다.
-- single에서 nvl, sysdate가 자주 쓰인다.
select min(hire_date), max(hire_date)
from employees;

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;
--------------------------

-- group에서 자주 쓰이는 펑션
-- count

select count(*) -- 그룹 안에 레코드 개수를 나타낸다.
from employees;

-- 과제] 70번 부서원이 몇명인 지 조회하라.
select count(*) 
from employees
where department_id = 70;

-- employee_id 는 primary key라 null값이 없고 각기 다른 값을 가지고 있다.
-- 레코드 전부 검색하고 싶으면 count(*)이나 count(primary key)를 쓴다.
select count(employee_id) -- group함수에서 파라미터 값이 null이면 무시한다.
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;
-------------------------

select avg(salary)
from employees;

select avg(distinct salary) -- 중복제거
from employees;

select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;
-----------------------

select department_id, count(employee_id) -- count가 그룹의 개수만큼 실행한다.
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id) -- 그룹펑션, 그룹바이에 나온 레이블을 쓸 수 있다.
from employees
group by department_id -- select에 등장 할 수 있다.
order by department_id; -- error

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;
-----------------------

select department_id, max(salary) -- 그룹이 갖고 있는 필드명을 쓰면 된다.
from employees
group by department_id
having department_id > 50; -- 그룹을 만들고나서 그룹을 골라낸다.

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error having에서는 별명을 못쓴다.

select department_id, max(salary)
from employees
where department_id > 50 -- where은 group by 보다 먼저 와야 한다.
group by department_id; -- 결과는 having과 같지만 알고리즘이 다르다. 레코드를 골라내 그 레코드 결과를 그룹으로 만든다.

select department_id, max(salary)
from employees
where max(salary) > 10000 -- having은 그룹을 골라낸다.
group by department_id; -- error 조건문에 그룹 펑션이 포함되었으면 having을 쓴다.