-- 11장 view
drop view empvu80;

create view empvu80 as 
    select employee_id, last_name, department_id
    from employees -- select 컬럼이 view의 구조가 된다.
    where department_id = 80; 
    
desc empvu80

select * from empvu80;

select * from (
    select employee_id, last_name, department_id
    from employees 
    where department_id = 80); 
    
create or replace view empvu80 as
    select employee_id, job_id
    from employees -- 데이터가 없으면 추가하고 이미 있으면 replace 한다.
    where department_id = 80;
    
desc empvu80
---------------

drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;

create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50
values(300, 'Marketing');
select count(*) from teams; -- 뷰에 있었지만 실제로 teams에 데이터가 있다.

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; -- view에 붙힐 수 있는 제약조건이다.
    
insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support'); -- error, 

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; -- view를 읽기전용으로 바꾼다.

insert into empvu10 values(501, 'abel', 'Sales'); -- error, 읽기전용이라 에러다.
----------------


