-- 3장 single function

desc dual
select * from dual;

-- 소문자로 바꾼다.
select lower('SQL Course')
from dual;

-- 대문자로 바꾼다.
select upper('SQL Course')
from dual;

-- 단어 첫 글자를 대문자로 바꾼다. 나머지는 소문자로 바뀐다.
select initcap('SQL course')
from dual;

-- 데이터는 대소문자를 구분한다.
select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';
-- lower의 리턴값이 피연산자다.

select concat('Hello', 'World')
from dual;

-- sql은 인덱스가 1부터 시작한다.
select substr('HelloWorld', 2, 5)
from dual;
-- 뒤에서 부터 가져오려면 -를 준다. 뒤에서부터 -1,-2로 인덱스 지정된다.
select substr('Hello', -1, 1)
from dual;

-- 글자수를 파악한다.
select length('Hello')
from dual;

-- 처음으로 발견된 글자의 인덱스를 리턴하고 끝낸다.
select instr('Hello', 'l')
from dual;
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*')
from employees;
select rpad(salary, 5, '*')
from employees;

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.
-- select last_name, rpad('*', trunc(salary / 1000), '*') "월급그래프"
-- from employees;
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- 과제] 위 그래프를 월급 기준 내림차순 정렬하라.
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
-- 과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
select trim(' Hello World ')
from dual;

-- 과제] 아래 문장에서, where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--      이름은 첫글자는 대문자, 나머지는 소문자로 출력하라.
select initcap(last_name), length (last_name)
from employees
where last_name like 'J%' or 
    last_name like 'A%' or 
    last_name like 'M%';
---------------------

-- 숫자를 다루는 펑션

-- 반올림 하는 펑션
select round(45.926, 2)
from dual;
-- 자리수 지정하는 펑션 값을 내림한다.
select trunc(45.926, 2)
from dual;

select round(45.923, 0), round(45.923)
from dual;
-- trunc는 정수로 바꾸기는 하지만 내림처리 한다.
select trunc(45.923, 0), trunc(45.923)
from dual;

-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary, 
    round(salary * 1.155) "New Salary", 
    round(salary * 1.155) - salary "Increase"
from employees;
------------------------

-- 날짜를 다루는 펑션

-- 서버의 현재 시각을 나타낸다. 표시형식을 년/월/일만 해서 년월일만 나온다.
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

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select MONTHS_BETWEEN('2022/12/31','2021/12/31')
FROM DUAL;

select add_months('2022/07/14', 1)
from dual;

-- 해당하는 요일의 후 날짜를 구한다. 
-- 1 = 일요일, 2 = 월요일, 3 = 화요일, 4 = 수요일, 5 = 목요일
-- 6 = 금요일, 7 = 토요일
select next_day('2022/07/14', 5)
from dual;

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

-- 해당하는 달의 마지막 일을 구한다.
select last_day('2022/07/14')
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--      월급을 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;