use shopdb;

create table tbl_copy_buytbl(select * from buytbl);

select * from tbl_copy_buytbl;
desc tbl_copy_buytbl;
delete from tbl_copy_buytbl where num >=6;

-- 01 insert values 값 여러개 넣기
insert into tbl_copy_buytbl(num,userid,prodname,groupname,price,amount)
values
(6, 'aaa', '운동화', '의류', 1000, 2),
(7, 'aab', '운동화', '의류', 1000, 2),
(8, 'aac', '운동화', '의류', 1000, 2),
(9, 'aad', '운동화', '의류', 1000, 2),
(10, 'aae', '운동화', '의류', 1000, 2);

-- 02 insert 시 auto_increment(번호 순차부여 및 어딘가에 값이 저장 지워도 다음 번호로 뜸)
create table tbl_test
(id int primary key auto_increment,
name varchar(20),
addr varchar(100));
desc tbl_test;
insert into tbl_test(id,name,addr) values(null,'홍길동','대구');
select * from tbl_test;
delete from tbl_test;
select * from tbl_test;
insert into tbl_test(id,name,addr) values(null,'홍길동','대구');

-- auto_increment 초기화
alter table tbl_test auto_increment=0;
commit;
insert into tbl_test(id,name,addr) values(null,'홍길동','대구');
select * from tbl_test;

