drop user hr2 cascade;

create user hr2 identified by hr2 default tablespace users;
grant connect, resource to hr2;

create table hr2.laborers(
    laborer_id number(2) constraint laborers_laborerid_pk primary key,
    laborer_name varchar2(12),
    hire_date date);

create sequence hr2.laborers_laborerid_seq;