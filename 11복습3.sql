drop view empvu80;

create view empvu80 as
    select employeee_id, last_name, department_id
    from employees
    where department_id = 80;

select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
create or replace view empvu80 as
    select employee_id, job_id
    from employees 
    where department_id = 80;
    
drop view dept50;

create or replace view dept50(empno, employee, deptng) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option CONSTRAINT dept50_ck;
    
drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50
values(300, 'Marketing');
select count(*) from teams;

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option;
    
insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support');

create or replace view empvu10(employee_id, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;

insert into empvu10 values (501, 'abel', 'sales');

drop sequence team_teamid_seq;
create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

create sequence x_xid_seq
    start with 10
    increment by 5
    maxvalue 20
    nocache 
    nocycle;
    
select x_xid_seq.nextval from dual;

create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

insert into dept(department_id, department_name)
values (dept_deptid_seq.nextval, 'Education');

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees;

select index_name, index_type, table_owner, table_name
from user_indexes;

create index dept_deptname_idx
on dept(department_name);

drop synonym team;

create synonym team
for departments;

select * from team;

drop synonym emps;

create sysnonym emps
for employees;

select * from emps;