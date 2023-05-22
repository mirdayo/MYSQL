use shopdb;
select * from buytbl;

-- 01 Group by
-- 1) sum 합
select userid,sum(amount) from buytbl group by userid;
select userid,sum(amount*price) from buytbl group by userid;
select userid,sum(amount*price) as '구매총량' from buytbl group by userid;
-- 2) avg 평균
select userid,avg(amount) from buytbl group by userid;
select userid,truncate(avg(amount),2) from buytbl group by userid;  -- truncate 소수점 n번째 까지만 표시하겠다
-- 3) max min 최대값 1개 최솟값 1개만 나옴
select max(height) from usertbl;
select min(height) from usertbl;  
-- 가장 큰 키와 가장 작은 키를 가지는 유저의 모든 열값을 출력해보세요
select * from usertbl where height=(select max(height) from usertbl);
select * from usertbl where height=(select min(height) from usertbl);
select * from usertbl where height=(select max(height) from usertbl) or height=(select min(height) from usertbl);
-- count 총 열수
select count(*) from usertbl;
select count(mobile1) from usertbl;

-- 문제
use shopdb;
-- 1) buytbl에서 userid 별로 구매량(amount)의 합을 출력하세요
select userid,sum(amount) from buytbl group by userid;
-- 2) usertbl에서 키의 평균값을 구하세요
select truncate(avg(height),2) from usertbl;
-- 3) buytbl에서 최대구매량과 최소구매량을 userid와 함께 출력하세요
select userid,amount from buytbl where amount=(select max(amount) from buytbl);
select userid,amount from buytbl where amount=(select min(amount) from buytbl);
select userid,amount from buytbl where amount=(select max(amount) from buytbl) or amount=(select min(amount) from buytbl);
-- 참고) where절과 group by절은 같이 못씀 나중에 다시 할거임
-- 4) buytbl의 groupname의 개수를 출력하세요
select count(groupname) from buytbl;
select * from buytbl where groupname is null;
select * from buytbl where groupname is not null;

-- 문제
use classicmodels;
-- 1) classicmodels db의 customers 테이블의 city를 그룹으로 creditlimit의 평균을 구하세요
select city,avg(creditlimit) from customers group by city;
-- 2) orderdetails 테이블의 ordernumber를 그룹으로 quantityordered의 총합을 출력하세요
select ordernumber,sum(quantityordered) from orderdetails group by ordernumber;
-- 3) products 테이블의 productvendor를 그룹으로 quantityinstock의 총합을 출력하세요
select productvendor,sum(quantityinstock) from products group by productvendor;

-- 02 Group by + Having
-- buytbl에서 userid로 amount 총합
use shopdb;
select userid,sum(amount) as '총량' from buytbl group by userid having sum(amount)>=5;
select groupname,sum(amount) from buytbl group by groupname having sum(amount) >= 5;
select addr,avg(height) from usertbl group by addr having avg(height) >= 175;

-- 03 Rollup
select num,groupname,sum(price*amount) from buytbl group by groupname,num with rollup;
select userid,addr,avg(height) from usertbl group by addr,userid with rollup;

-- 문제
-- 1) prodname별로 그룹화 한 뒤 userid / prodname / price*amount 순으로 출력
select userid,prodname,sum(price*amount) from buytbl group by prodname,userid;
-- 2) 1번 명령어에서 price*amount 값이 1000이상인 행만 출력
select userid,prodname,sum(price*amount) from buytbl group by prodname,userid having sum(price*amount) >= 1000;
-- 3) price 가격이 가장 큰 행과 작은 행의 userid, prodname, price을 출력
select distinct userid,prodname,price from buytbl where price=(select max(price) from buytbl) or price=(select min(price) from buytbl);
-- 4) 다음 행중에 그룹네임이 있는 행만 출력
select * from buytbl where groupname is not null;
-- 5) prodname 별로 총합을 구해보새요(rollup 사용)
select * from buytbl;
select prodname,sum(price*amount) from buytbl group by prodname with rollup;
select num,prodname,sum(price*amount) from buytbl group by prodname,num with rollup;
