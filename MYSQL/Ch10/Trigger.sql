use shopdb;
-- 01 After Trigger
select * from usertbl;
create table c_usertbl select * from usertbl;
select * from usertbl;
create table c_usertbl_bak like c_usertbl;
select * from c_usertbl_bak;
alter table c_usertbl_bak add column type char(5);
alter table c_usertbl_bak change column U_D_date U_D_date datetime;
desc c_usertbl_bak;
select * from c_usertbl_bak;

delimiter $$
create trigger trg_c_usertbl_update
after update
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid, old.name, old.birthyear, old.addr, 
    old.mobile1, old.mobile2, old.height, old.mDate,
    '수정',now()
    );
end $$
delimiter ;

show triggers;
show create trigger trg_c_usertbl_update;

select * from c_usertbl;
select * from c_usertbl_bak;
update c_usertbl set name = '비비' where userid = 'BBK';
update c_usertbl set name = '강남' where userid = 'EJW';

-- 02 삭제 트리거
delimiter $$
create trigger trg_c_usertbl_delete
after delete
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid, old.name, old.birthyear, old.addr, 
    old.mobile1, old.mobile2, old.height, old.mDate,
    '삭제',now()
    );
end $$
delimiter ;

delete from c_usertbl where userid = 'KKH';
select * from c_usertbl_bak;

-- buytbl의 c_buytbl의 구조 + 값 복사
-- c_buytbl의 구조만 복사한 c_buytbl_bak 만들기
-- c_buytbl_bak에 type char(5)와 mDate datetime을 만들기
-- c_buytbl의 update시 c_buytbl_bak에 내용 저장되는 trg_c_buytbl_update 트리거 만들기
-- c_buytbl의 delete시 c_buytbl_bak에 내용 저장되는 trg_c_buytbl_delete 트리거 만들기
select * from buytbl;
create table c_buytbl select * from buytbl;
select * from c_buytbl;
create table c_buytbl_bak like c_buytbl;
select * from c_buytbl_bak;
alter table c_buytbl_bak add column type char(5);
alter table c_buytbl_bak add column U_D_date datetime;

-- update
delimiter $$
create trigger trg_c_buytbl_update 
after update
on c_buytbl
for each row
begin
	insert into c_buytbl_bak values(
    old.num, old.userid, old.prodname, old.groupname,
    old.price, old.amount, '수정', now()
    );
end $$
delimiter ;

show triggers;
show create trigger trg_c_usertbl_update;
select * from c_buytbl;
select * from c_buytbl_bak;
update c_buytbl set amount = 5 where num = '1';
update c_buytbl set prodname = '윤동화' where num = '4';

-- delete
drop trigger trg_c_buytbl_delete;
delimiter $$
create trigger trg_c_buytbl_delete
after delete
on c_buytbl
for each row
begin
	insert into c_buytbl_bak values(
    old.num, old.userid, old.prodname, old.groupname,
    old.price, old.amount, '삭제', now()
    );
end $$
delimiter ;

select * from c_buytbl;
show create trigger trg_c_usertbl_delete;
delete from c_buytbl where num = 3;
select * from c_buytbl_bak;