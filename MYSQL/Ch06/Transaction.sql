create table tbl_test(
no int primary key,
name varchar(20),
age int,
gender char(1));

delete from tbl_test;
insert into tbl_test values(1, 'aa', 66, 'w');
insert into tbl_test values(2, 'ab', 66, 'w');
insert into tbl_test values(3, 'ac', 66, 'w');
select * from tbl_test;
commit;

start transaction;
	savepoint s1;
	insert into tbl_test values(4, 'ag', 66, 'w');
	insert into tbl_test values(5, 'ah', 66, 'w');
	insert into tbl_test values(6, 'ai', 66, 'w');
    savepoint s2;
	insert into tbl_test values(7, 'aj', 66, 'w');
	insert into tbl_test values(8, 'ak', 66, 'w');
    savepoint s3;
	insert into tbl_test values(9, 'al', 66, 'w');
	insert into tbl_test values(10, 'am', 66, 'w');
rollback to s2;

select * from tbl_test;
    

-- AUTOCOMMIT 모드 비활성화
drop procedure Tx_Test;
DELIMITER $$
create procedure TX_Test()
begin
	declare continue handler for SQLEXCEPTION
    begin
		show errors;
        rollback;
    end;
    start transaction;
		savepoint sp;
		insert into tbl_test values(7,'aa',66,'W');
		insert into tbl_test values(7,'ab',66,'W');
		insert into tbl_test values(8,'ac',66,'W');    
	commit;
    release savepoint sp;
end $$
DELIMITER ;

call TX_Test();
show procedure status;
select * from tbl_test;

show procedure status;
select * from tbl_test;



