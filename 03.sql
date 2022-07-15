-- 3�� single function

desc dual
select * from dual;

-- �ҹ��ڷ� �ٲ۴�.
select lower('SQL Course')
from dual;

-- �빮�ڷ� �ٲ۴�.
select upper('SQL Course')
from dual;

-- �ܾ� ù ���ڸ� �빮�ڷ� �ٲ۴�. �������� �ҹ��ڷ� �ٲ��.
select initcap('SQL course')
from dual;

-- �����ʹ� ��ҹ��ڸ� �����Ѵ�.
select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';
-- lower�� ���ϰ��� �ǿ����ڴ�.

select concat('Hello', 'World')
from dual;

-- sql�� �ε����� 1���� �����Ѵ�.
select substr('HelloWorld', 2, 5)
from dual;
-- �ڿ��� ���� ���������� -�� �ش�. �ڿ������� -1,-2�� �ε��� �����ȴ�.
select substr('Hello', -1, 1)
from dual;

-- ���ڼ��� �ľ��Ѵ�.
select length('Hello')
from dual;

-- ó������ �߰ߵ� ������ �ε����� �����ϰ� ������.
select instr('Hello', 'l')
from dual;
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*')
from employees;
select rpad(salary, 5, '*')
from employees;

-- ����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�.
--      �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
-- select last_name, rpad('*', trunc(salary / 1000), '*') "���ޱ׷���"
-- from employees;
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- ����] �� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')
from dual;
select trim('l' from 'hello')
from dual;
select trim(' ' from ' Hello ')
from dual;
-- ����] �� query���� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
select trim(' Hello World ')
from dual;

-- ����] �Ʒ� ���忡��, where ���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--      �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����϶�.
select initcap(last_name), length (last_name)
from employees
where last_name like 'J%' or 
    last_name like 'A%' or 
    last_name like 'M%';
---------------------

-- ���ڸ� �ٷ�� ���

-- �ݿø� �ϴ� ���
select round(45.926, 2)
from dual;
-- �ڸ��� �����ϴ� ��� ���� �����Ѵ�.
select trunc(45.926, 2)
from dual;

select round(45.923, 0), round(45.923)
from dual;
-- trunc�� ������ �ٲٱ�� ������ ����ó�� �Ѵ�.
select trunc(45.923, 0), trunc(45.923)
from dual;

-- ����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�.
select last_name, salary, 
    round(salary * 1.155) "New Salary", 
    round(salary * 1.155) - salary "Increase"
from employees;
------------------------

-- ��¥�� �ٷ�� ���

-- ������ ���� �ð��� ��Ÿ����. ǥ�������� ��/��/�ϸ� �ؼ� ����ϸ� ���´�.
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

-- ����] 90�� �μ� ������� �̸�, �ټӳ���� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select MONTHS_BETWEEN('2022/12/31','2021/12/31')
FROM DUAL;

select add_months('2022/07/14', 1)
from dual;

-- �ش��ϴ� ������ �� ��¥�� ���Ѵ�. 
-- 1 = �Ͽ���, 2 = ������, 3 = ȭ����, 4 = ������, 5 = �����
-- 6 = �ݿ���, 7 = �����
select next_day('2022/07/14', 5)
from dual;

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

-- �ش��ϴ� ���� ������ ���� ���Ѵ�.
select last_day('2022/07/14')
from dual;

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--      ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;