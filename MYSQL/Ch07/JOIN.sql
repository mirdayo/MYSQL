-- Inner join
-- on이하의 조건절이 만족되는 열만 출력
use shopdb;
select * from usertbl;
select * from buytbl;

-- 01 Inner join 기본
select * from usertbl
inner join buytbl
on usertbl.userid = buytbl.userid;

-- 02 Inner join 이름충돌 에러
select usertbl.userid,prodname,groupname,price,amount from usertbl
inner join buytbl
on usertbl.userid = buytbl.userid;

-- 03 Inner join 테이블 별칭 지점
select U.userid,prodname,groupname,price,amount from usertbl U
inner join buytbl B
on U.userid = B.userid;

-- 04 Inner join + where
select U.userid,prodname,groupname,price,amount from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount >= 5;

-- 문제
-- 1) 바비킴의 userid, birthyear, prodname, groupname을 출력하세요
select U.userid, birthyear,prodname,groupname from usertbl U
inner join buytbl B
on U.userid = B.userid
where name = '바비킴';
-- 2) amount * price의 값이 100이상인 행의 name,addr,prodname,mobile1 - mobile2를(concat()함수사용) 출력하세요alter
select U.name,addr,prodname,(concat(mobile1,'-',mobile2)) as phone from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount * price >= 100;
-- 3) groupname이 전자인 행의 userid,name,birthyear prodname을 출력하세요
select U.userid,name,birthyear,prodname from usertbl U
inner join buytbl B
on U.userid = B.userid
where groupname = '전자';  -- 아 ㅋㅋㅋㅋㅋ 전자가 앞쪽에 정렬하라는 소리인줄~~

use classicmodels;
select * from products;
select * from orderdetails;

select * from products P
inner join orderdetails O
on P.productcode = O.productcode;

-- outer Join
-- 01 left outer join(on 조건을 만족하지 않는 left 테이블의 행도 출력)
select * from usertbl left outer join buytbl
on usertbl.userid = buytbl.userid;

-- 02 right outer join
select * from buytbl right outer join usertbl
on usertbl.userid = buytbl.userid;

-- 03 full outer join(on 조건을 만족하지 않는 left, right 테이블의 행도 출력)
-- mysql에서는 full outer join을 지원하지 않는다.
-- 대신 union을 사용하여 left right outer join을 연결한다.
select * from usertbl left join buytbl on usertbl.userid = buytbl.userid
union 
select * from usertbl right join buytbl on usertbl.userid = buytbl.userid;


USE shopDB;
CREATE TABLE stdTbl(
	stdName CHAR(10) NOT NULL PRIMARY KEY,
	addr CHAR(4) NOT NULL
);
CREATE TABLE clubTbl(
	clubName CHAR(10) NOT NULL PRIMARY KEY,
	roomNo CHAR(4) NOT NULL
);
CREATE TABLE stdclubTbl(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	stdName CHAR(10) NOT NULL,
	clubName CHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
	FOREIGN KEY(clubName)REFERENCES clubTbl(clubname)
);

INSERT INTO stdTbl VALUES
('김범수','경남'),('성시경','서울'),('조용필','경기'),('은지원','경북'),('바비킴','서울');

INSERT INTO clubTbl VALUES
('수영','101호'),('바둑','102호'),('축구','103호'),('봉사','104호');

INSERT INTO stdclubTbl VALUES
(null,'김범수','바둑'),(null,'김범수','축구'),(null,'조용필','축구'),(null,'은지원','축구'),(null,'은지원','봉사'),(null,'바비킴','봉사');

select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

-- inner join
select num,S.stdname,addr,C.clubname,roomno from stdtbl S
inner join stdclubtbl SC
on S.stdname = SC.stdname
inner join clubtbl C
on SC.clubname = C.clubname;

-- left outer join
select * from stdtbl S
left outer join stdclubtbl SC
on S.stdname = SC.stdname
left outer join clubtbl C
on SC.clubname = C.clubname;

-- right outer join
select * from stdtbl S
right outer join stdclubtbl SC
on S.stdname = SC.stdname
right outer join clubtbl C
on SC.clubname = C.clubname;

-- union
select * from stdtbl S
left outer join stdclubtbl SC
on S.stdname = SC.stdname
union
select * from stdclubtbl SC
right outer join clubtbl C
on SC.clubname = C.clubname;

-- 문제
use classicmodels;
select * from products;
select * from productlines;
select * from orderdetails;

select * from products P
inner join orderdetails OD
on P.productcode = OD.productcode
inner join orders O
on O.ordernumber = OD.ordernumber
inner join customers C
on O.customernumber = C.customernumber;
