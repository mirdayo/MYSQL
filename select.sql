-- 01 select
use shopdb;
select * from usertbl;
select userid,addr from usertbl;
select userid as '아이디', addr as '주소' from usertbl;

-- 02 select where
select * from usertbl where name='김경호';
select * from usertbl where userid='LSG';
select * from usertbl where birthyear>=1900;
select * from usertbl where height <=170;

-- 03 select where 논리연산자(or,and)
-- 조건식 and 조건식 : 왼쪽/오른쪽 조건식 둘다 참인 경우
-- 조건식 or 조건식 : 왼쪽/오른쪽 둘중 하나라도 참인 경우
select * from usertbl where birthyear >= 1900 and height >= 182;
select * from usertbl where birthyear >= 1900 or height >= 182;
-- 1910 <= birthyear <= 1950
select * from usertbl where birthyear >= 1910 and birthyear <= 1970;
select * from usertbl where birthyear between 1910 and 1970;

-- 04 in, like
select * from usertbl;
select * from usertbl where addr in('서울', '경남');
select * from usertbl where name like '김%';  -- 첫 문자가 '김'인 모든 문자(길이제한x)
select * from usertbl where name like '김__';  -- 첫 문자가 '김'인 모든문자(_만큼 길이제한) 
select * from usertbl where name like '%수';  -- 끝 문자가 '수'인 모든 문자(길이제한x)
select * from usertbl where name like '__수';  -- 끝 문자가 '수'인 모든문자(_만큼 길이제한) 
select * from usertbl where name like '%김%';  -- '김'을 포함하는 모든 문자
-- 문제
select * from buytbl;
-- 1 구매양(amount)이 5개 이상인 행을 출력
select * from buytbl where amount >= 5;
-- 2 가격(price)이 50이상 500이하인 행의 userid와 prodname만 출력
select userid, prodname from buytbl where price >=50 and price <=500;
select userid, prodname from buytbl where price between 50 and 500;
-- 3 구매양(amount)이 10이상 이거나 가격(price이 100이상인 행 출력
select * from buytbl where amount >= 10 or price >= 100;
-- 4 userid가 k로 시작하는 행 출력
select * from buytbl where userid like 'k%';
-- 5 '서적'이거나 '전자'인 행 출력
select * from buytbl where groupname in('서적', '전자');
-- 6 상품(prodname)이 책이거나 userid가 w로 끝나는 행 출력
select * from buytbl where prodname in('책') or userid like '%w';
-- 7 groupname이 비어있지 않는 행만 출력(!=, <>)
select * from buytbl where groupname!='null';  -- 혹은 <> 사용
select * from buytbl;

-- 5 서브쿼리(쿼리 안에 쿼리)
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


