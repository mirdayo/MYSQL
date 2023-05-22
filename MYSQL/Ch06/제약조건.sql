use shopdb;

-- PK 제약조건
-- 01 테이블 생성시 PK 설정
create table tbl_test01
(id char(10) primary key,
name char(10) not null);
desc tbl_test01;

create table tbl_test02
(id char(10),
name char(10) not null,
primary key(id));
desc tbl_test02;

create table tbl_test03
(id char(10),
name char(10) not null,
primary key(id,name));
desc tbl_test03;

-- 확인
select * from information_schema.columns 
where table_schema='shopdb'and table_name='tbl_test03' and column_key='PRI';

-- 02 PK 설정(테이블 생성이후)
create table tbl_test04
(id char(10),
name char(10) not null);
desc tbl_test04;

-- PK 추가
alter table tbl_test04 add constraint pk_tbl_test04 primary key(id,name);
desc tbl_test04;

-- 03 PK 제거
desc tbl_test01;
alter table tbl_test01 drop primary key;

-- 문제
-- 1) buytbl을 c_buytbl 구조+데이터 복사하고 num을 primary key로 설정해보세요
create table c_buytbl(select * from buytbl);
select * from c_buytbl;
desc c_buytbl;
alter table c_buytbl add constraint pk_c_buytbl primary key(num);
desc c_buytbl;

-- FK 제약조건
-- 생성시 FK 설정
desc tbl_test01;
alter table tbl_test01 add constraint pk_tbl_test01 primary key(id);
create table tbl_test01_fk
(no int primary key,
id char(10) not null,
constraint FK_test01_FK_test01 foreign key(id) references tbl_test01(id));
desc tbl_test01_fk;

-- on update, on delete 옵션
-- Cascade : PK 열의 값이 변경시 FK 열의 값도 함께 변경
-- No Action : PK 열의 값이 변경시 FK 열의 값은 변경x
-- RESTRIC : PK 열의 값이 변경시 FK 열의 값의 변경 차단
-- Set null : PK 열의 값이 변경시 FK 열의 값을 NULL로 변경
-- Set Default : PK 열의 값이 변경시 FK 열의 값은 Default로 설정된 기본값을 적용

create table tbl_test02_fk
(no int primary key,
id char(10) not null,
constraint FK_test01_FK_test02 foreign key(id) references tbl_test01(id)
on update cascade
on delete set null);
desc tbl_test02_fk;

-- 생성 이후 FK 설정
create table tbl_test03_fk
(no int primary key,
id char(10),
constraint FK_test01_FK_test03 foreign key(id) references tbl_test01(id)
on update cascade
on delete set null);
desc tbl_test03_fk;
-- mysql에서는 FK설정시 자동으로 해당열이 Index열로 지정된다

create table tbl_test04_fk
(no int primary key,
id char(10));
desc tbl_test04_fk;
alter table tbl_test04_FK add
constraint FK_tbl_test01_test04_FK foreign key(id) references tbl_test01(id)
on update cascade
on delete cascade;
desc tbl_test04_fk;

-- 문제
-- 1) buy을 copy_buytbl로 구조+데이터 복사 이후 num을 pk 설정 
-- userid를 fk 설정(on delete restrict on update cascade)
create table copy_buytbl(select * from buytbl);
select * from copy_buytbl;
alter table copy_buytbl add constraint pk_copy_buytbl primary key(num);
desc copy_buytbl;
alter table copy_buytbl add constraint fk_copy_buytbl foreign key(userid) 
references usertbl(userid)
on update cascade
on delete restrict;
desc copy_buytbl;
-- 확인
show create table tbl_test04_fk;

-- upadate / delete시 옵션 적용 확인

-- fk열이 포함되어져 있는 테이블의 데이터 삭제시 x
drop table tbl_test01; -- PK가 FK가 있는 테이블과 연결되어 있을때는 삭제가X
drop table tbl_test01_fk; -- FK열이 있는 테이블은 삭제가능
desc tbl_test;
drop table tbl_test;

-- FK가 걸려있는 PK테이블 강제 삭제
set foreign_key_checks = 0;
drop table tbl_test01;
set foreign_key_checks = 1;

-- UNIQUE 제약조건(중복허용x, null)
create table tbl_test05
(id int primary key,
name varchar(25),
email varchar(50) unique);

create table tbl_test06
(id int primary key,
name varchar(25),
email varchar(50),
constraint uk_email unique(email));

create table tbl_test07
(id int primary key,
name varchar(25),
email varchar(50));

alter table tbl_test07 add constraint uk_test07_email unique(email); 
desc tbl_test07;
-- 삭제
alter table tbl_test07 drop constraint uk_test07_email;
desc tbl_test07;
-- 확인
show create table tbl_test07;

-- CHECK 제약조건
create table tbl_test08
(id varchar(20) primary key,
name varchar(20) not null,
age int check(age>=10 and age<=50),  					-- age는 10 ~ 50세 까지만 입력 가능
addr varchar(5)
constraint ck_addr check(addr in('대구', '인천'))			-- addr은 서울,대구,인천만 가능하도록 설정
);			
desc tbl_test08;
show create table tbl_test08;
select * from infomation_schema.check_constraint;

alter table tbl_test08 drop check ck_addr;
desc tbl_test08;

-- default 설정
create table tbl_test09
(id varchar(20) primary key,
name varchar(20) default '이름없음',
age int check(age>=10 and age<=50) default 20,  					
addr varchar(5) default '인천'
constraint ck_addr check(addr in('대구', '인천'))
);
desc tbl_test09;
alter table tbl_test09 alter column name set default '홍길동';
alter table tbl_test09 alter column age drop default;
desc tbl_test09;
