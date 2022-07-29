-- 10장 DDL(Data definition Language)
drop table hire_dates; -- 물리적으로 삭제는 안되고 휴지통에 담아둔다.

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname -- 테이블 목록 조회
from tab; -- data dictionary

-- 과제] drop table 후, 위 문장을 실행한 결과에서, 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;
--------------------

-- DCL(Data Control Language)
-- system connection 으로 변경한다. system user
-- system유저가 실행할 권한이 있다. hr은 권한이 없다.
create user you identified by you;
grant connect, resource to you; -- 연결, 관리(drop, create 등) 권한을 준다.

-- 프로젝트 할 때 새로운 유저를 만들어 진행한다. 
-- you connection 으로 변경한다. you user
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000), -- 업무적인 조건에 사용한다.
department_id number(3),
constraint emps_email_uk unique(email), -- 유일한 값을 가지게 하는 제약조건
constraint emps_deptid_fk foreign key(department_id) -- 자식테이블, 차일드 레코드
    references depts(department_id)); -- 부모테이블, 페어런트 키 
    
select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;
delete depts; -- error 부모를 지우면 자식이 참조하는 값이 없어져 무결성에 위배된다.

insert into depts values(100, 'Marketing'); -- error, 100이 이미 있기 때문에 에러다.
insert into depts values(null, 'Marketing'); -- error, pk는 null값 못들어간다.
insert into emps values(501, null, 'good@gmail.com', 6000, 100); -- error, null 안된다.
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); -- error, email이 이미 있다.
insert into emps values(501, 'abel', 'good@gmail.com', 6000, 200); -- error

drop table emps cascade constraints; -- 제약조건 까지 다 삭제한다.

select constraint_name, constraint_type, table_name
from user_constraints;

-- system user 로 권한 설정을 해주어야 한다.
grant all on hr.departments to you;

drop table employees cascade constraints;
create table employees( -- you.employees 라 hr과 중복되지 않는다.
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20), -- primary key 제약 조건은 1개만 존재한다.
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_uk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id), -- 셀프조인
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--------------------------

-- on delete
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong (
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null); -- foreign key null값 저장 가능하다.
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit;
------------------------

-- disable fk
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); -- error, a테이블에 9 값이 없다.

alter table b disable constraint b_aid_fk; -- 제약조건을 잠재운다.
insert into b values(32, 9); -- 거짓된 데이터, a에 9는 없다. 하지만 개발은 가능하다.

alter table b enable constraint b_aid_fk; -- error
alter table b enable novalidate constraint b_aid_fk; -- 제약조건을 깨운다.

insert into b values(33, 9); -- error, fk에 위배된다.
-------------------------

drop table sub_departments;

create table sub_departments as 
    select department_id dept_id, department_name dept_name
    from hr.departments;
    
desc sub_departments -- 테이블 확인

select * from sub_departments; -- 데이터 확인
----------------------

-- 테이블을 수정하는 방법
drop table users cascade constraints; -- 제약조건까지 깔끔하게 삭제한다.
-- 제약조건은 테이블과 별도의 객체이다. 아주 강하게 관계가 있는 객체다. 테이블이 없으면 의미가 없다.
create table users(
user_id number(3));
desc users

alter table users add(user_name varchar2(10)); -- 컬럼 추가
desc users

alter table users modify(user_name number(7)); -- 컬럼 수정
desc users

alter table users drop column user_name; -- 컬럼 삭제
desc users
--------------------------------

-- 테이블을 읽기전용으로 바꾸는 방법
insert into users values(1); -- 쓰기가 되는지 확인

alter table users read only; -- 읽기 전용으로 바꾼다.
insert into users values(2); -- error, 읽기 전용이라 에러가 난다.

alter table users read write; -- 읽기, 쓰기로 바꾼다.
insert into users values(2);

commit;