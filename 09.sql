-- 9장 DML(Data Manipulation language)

drop table emp; -- table을 삭제한다. DDL이다.
drop table dept; -- table을 삭제한다.

create table emp( -- table을 생성한다. DDL이다.
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4));

create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4));
-------------------------

-- DML, insert
insert into dept(department_id, department_name, manager_id, location_id) -- 필드네임
values (300, 'Public Ralation', 100, 1700); -- 필드밸류, 필드네임과 개수가 같아야 한다.

insert into dept(department_id, department_name)
values (310, 'Purchasing'); -- 기본값은 null 이다.

-- 과제 row 2건이 insert 성공됐는 지, 확인하라.
select *
from dept;

commit; -- 메모리상에 있는 걸 물리적으로 저장한다. transaction

insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values (300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate,
        'AC_ACCOUNT', 6900, null,
        205, 110);

insert into emp -- 필드네임이 설정한 테이블과 순서가 같다면 생략이 가능하다.
values(310, 'Jark', 'Klein',
        'Klein@gmail.com', '010-753-4635', to_date('2022/06/15', 'YYYY/MM/DD'),
        'IT_PROG', 8000, null,
        120, 190); -- 필드 값은 순서에 맞게 다 입력해야 한다.

insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-632-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100, 30);

commit;

drop table sa_reps;

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2));

insert into sa_reps(id, name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees -- 데이터 타입을 맞게 설정한다. 서브쿼리가 가능하다.
    where job_id like '%REP%';
commit;

declare
    base number(6) := 400;
begin
    for i in 1..10 loop
        insert into sa_reps(id, name, salary, commission_pct) -- 프로시저라 한다.
        values(base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/

select * from sa_reps;

-- 과제] procedure 로 insert 한 row들을 조회하라.
select *
from sa_reps
where id > 400;
----------------------

-- DML, update
-- 기존에 있던 로우의 필드의 값을 변경한다.
select employee_id, salary, job_id
from emp
where employee_id = 300;

update emp
set salary = 9000, job_id = null
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback; -- 트랜잭션을 취소한다.

select job_id, salary
from emp
where employee_id = 300;

update emp
set (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

commit;
-------------------

-- DML, delete
delete dept
where department_id = 300;

select *
from dept;

rollback;

select *
from dept;

delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Contracting');
    
select *
from emp;

commit;