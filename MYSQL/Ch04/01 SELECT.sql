use shopdb;

CREATE TABLE userTbl( 
userID CHAR(8) NOT NULL PRIMARY KEY, 
Name VARCHAR(10) NOT NULL, 
birthYear INT NOT NULL, 
addr CHAR(2) NOT NULL, 
mobile1 CHAR(3), 
mobile2 CHAR(8), 
height SMALLINT,
mDate DATE 
);

CREATE TABLE buyTbl( 
num INT PRIMARY KEY,
userID CHAR(8) NOT NULL, 
prodName CHAR(15) NOT NULL, 
groupName CHAR(6),
price INT NOT NULL,
amount SMALLINT NOT NULL,
FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

INSERT INTO userTbl VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-8-8');
INSERT INTO userTbl VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-4-4');
INSERT INTO userTbl VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-7-7');
INSERT INTO userTbl VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-4-4');
INSERT INTO userTbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO userTbl VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-9-9');
INSERT INTO userTbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO userTbl VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-3-3');
INSERT INTO userTbl VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO userTbl VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-5-5');

INSERT INTO buyTbl VALUES(1,'KBS','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(2,'KBS','노트북','전자',1000,1);
INSERT INTO buyTbl VALUES(3,'JYP','모니터','전자',200,1);
INSERT INTO buyTbl VALUES(4,'BBK','모니터','전자',200,5);
INSERT INTO buyTbl VALUES(5,'KBS','청바지','의류',50,3);
INSERT INTO buyTbl VALUES(6,'BBK','메모리','전자',80,10);
INSERT INTO buyTbl VALUES(7,'SSK','책','서적',15,5);
INSERT INTO buyTbl VALUES(8,'EJW','책','서적',15,2);
INSERT INTO buyTbl VALUES(9,'EJW','청바지','의류',50,1);
INSERT INTO buyTbl VALUES(10,'BBK','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(11,'EJW','책','서적',15,1);
INSERT INTO buyTbl VALUES(12,'BBK','운동화',NULL,30,2);

-- 01 Select 
select * from usertbl;
select userId,addr from usertbl;
select userId as '아이디',addr as '주소' from usertbl;

-- 02 Select where 비교연산자
select * from  usertbl where name='김경호';
select * from usertbl where userId='LSG';
select * from usertbl where birthyear>=1900;
select * from usertbl where height <=170;

-- 03 Select where 논리연산자(or,and)
-- 조건식 and 조건식	: 왼쪽/오른쪽 조건식 둘다 참인경우 
-- 조건식 or 조건식	: 왼쪽/오른쪽 둘중 하나라도 참인경우
select * from usertbl where birthyear>=1900 and height>=182;
select * from usertbl where birthyear>=1900 or height>=182;
-- 1910 <= birthYear <=1970
select * from usertbl where birthyear>=1910 and birthyear<=1970;
select * from usertbl where birthyear between 1910 and 1970;
 
-- 04 In , Like
select * from usertbl;
select * from usertbl where addr in('서울','경남');
select * from usertbl where name like '김%'; -- 첫문자가 '김'인 모든 문자(길이제한x)
select * from usertbl where name like '김__'; -- 첫문자가 '김'인 모든 문자(_만큼의길이제한)
select * from usertbl where name like '%수'; -- 끝문자가 '김'인 모든 문자(길이제한x)
select * from usertbl where name like '__수'; -- 끝문자가 '김'인 모든 문자(_만큼의길이제한)
select * from usertbl where name like '%경%'; -- 경을 포함하는 모든 문자

-- 05 서브쿼리(쿼리 안에 쿼리)
-- 김경호보다 큰 키를 가지는 모든열의 값
select height from usertbl where name = '김경호';
select * from usertbl where height > (select height from usertbl where name = '김경호');
-- 성시경보다 나이(birthyear)가 많은 모든 값 출력
select birthyear from usertbl where name = '성시경';
select * from usertbl where birthyear < (select birthyear from usertbl where name = '성시경');
-- 지역이 '경남'인 heright보다 큰 행 출력
select height from usertbl where addr = '경남';  -- 173, 170
select * from usertbl where height > any(select height from usertbl where addr = '경남');
select * from usertbl where height > all(select height from usertbl where addr = '경남');

-- 문제
-- 1. amount가 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)
select * from buytbl where price > (select price from buytbl where amount = '10');
-- 2. uesrid가 k로 시작하는 행의 amount보다 큰 행을 출력하세요(서브쿼리+any)
select * from buytbl where amount > any(select amount from buytbl where userid like 'k%');
-- 3. amount가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리+all)
select * from buytbl where price > all(select price from buytbl where amount = '5');
 
-- 06 order by
select * from usertbl;
select * from usertbl order by mDate;
select * from usertbl where birthYear >= 1970 order by mDate asc;
select * from usertbl where birthYear >= 1970 order by mDate desc;
select * from usertbl order by height, name asc;
 
-- 07 distinct
select addr from usertbl;
select distinct addr from usertbl;
select distinct addr, birthyear from usertbl;

-- 08 limit
select * from usertbl;
select * from usertbl limit 3;  -- 0번 인덱스 부터 3라인까지 표시
select * from usertbl limit 2,3;  -- 2번 인덱스부터 시작

-- 09 테이블 복사
-- 1) 구조 + 값 복사(기본키(pk)나 외래키(fk)는 복사x)
create table tbl_buy_copy(select * from buytbl);
select * from buytbl;
select * from tbl_buy_copy;
desc buytbl;
desc tbl_buy_copy;
create table tbl_buy_copy2(select userid,prodname from buytbl);

-- 2) 구조만 복사(pk, fk 복사o)
create table tbl_buy_copy3 like buytbl;
desc tbl_buy_copy3;
select * from tbl_buy_copy3;

-- 3) 데이터만 복사(만들어둔 구조에)
insert into tbl_buy_copy3 select * from buytbl where amount >= 2;
select * from tbl_buy_copy3;

-- 문제
-- 1번 userid 오름차순 정렬
select * from buytbl order by userid;
-- 2번 price 내림차순 정렬
select * from buytbl order by price desc;
-- 3번 amount 오름차순 prodname 내림차순 정렬
select * from buytbl order by amount,prodname desc;
-- 4번 prodname을 오름차순으로 정렬시 중복 제거
select distinct prodname from buytbl order by prodname;
-- 5번 userid열의 검색시 중복된 아이디 제거하고 select
select distinct userid from buytbl;
-- 6번 구매양(amount)가 3이상인 행을 prodname 내림차순으로 정렬
select * from buytbl where amount >= 3 order by prodname desc;
-- 7번 userid의 addr 가 서울, 경기인 값들을 cusertbl에 복사
create table cusertbl(select * from usertbl where addr in('서울','경기'));
select * from cusertbl;
