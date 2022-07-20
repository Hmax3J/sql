drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname -- 테이블 목록 조회
from tab;

select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_date(id) values(3);

commit;

select *
from hire_dates;

