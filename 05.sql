-- 5�� group function, null���� �����Ѵ�.

-- group function �� �Ķ���� ���ڵ� ������ n����.
-- single �̳� group�̳� ���ϰ��� 1����.
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

-- ��¥�� max, min ��� �� ��� max�� �ֱ� ���̴�.
-- ������ �湮��, �޸���� �� ��� �� �� �ִ�.
-- single���� nvl, sysdate�� ���� ���δ�.
select min(hire_date), max(hire_date)
from employees;

-- ����] �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;
--------------------------

-- group���� ���� ���̴� ���
-- count

select count(*) -- �׷� �ȿ� ���ڵ� ������ ��Ÿ����.
from employees;

-- ����] 70�� �μ����� ����� �� ��ȸ�϶�.
select count(*) 
from employees
where department_id = 70;

-- employee_id �� primary key�� null���� ���� ���� �ٸ� ���� ������ �ִ�.
-- ���ڵ� ���� �˻��ϰ� ������ count(*)�̳� count(primary key)�� ����.
select count(employee_id) -- group�Լ����� �Ķ���� ���� null�̸� �����Ѵ�.
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct, 0))
from employees;
-------------------------

select avg(salary)
from employees;

select avg(distinct salary) -- �ߺ�����
from employees;

select avg(all salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����] �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;
-----------------------

select department_id, count(employee_id) -- count�� �׷��� ������ŭ �����Ѵ�.
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id) -- �׷����, �׷���̿� ���� ���̺��� �� �� �ִ�.
from employees
group by department_id -- select�� ���� �� �� �ִ�.
order by department_id; -- error

-- ����] ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;
-----------------------

select department_id, max(salary) -- �׷��� ���� �ִ� �ʵ���� ���� �ȴ�.
from employees
group by department_id
having department_id > 50; -- �׷��� ������� �׷��� ��󳽴�.

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error having������ ������ ������.

select department_id, max(salary)
from employees
where department_id > 50 -- where�� group by ���� ���� �;� �Ѵ�.
group by department_id; -- ����� having�� ������ �˰����� �ٸ���. ���ڵ带 ��� �� ���ڵ� ����� �׷����� �����.

select department_id, max(salary)
from employees
where max(salary) > 10000 -- having�� �׷��� ��󳽴�.
group by department_id; -- error ���ǹ��� �׷� ����� ���ԵǾ����� having�� ����.