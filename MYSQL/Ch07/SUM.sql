use shopdb;
select * from buytbl;
select userid, 
sum(if(prodname='모니터',amount,0)) as '모니터', 
sum(if(prodname='책',amount,0)) as '책',
sum(if(prodname='청바지',amount,0)) as '청바지',
sum(if(prodname='메모리',amount,0)) as '메모리',
sum(amount) as '합계' 
from buytbl
group by userid with rollup;

-- usertbl의 지역(addr)별 가입 인원 현황을 출력해보세요
select * from usertbl;
select 
sum(if(addr='서울',1,0)) as '서울',
sum(if(addr='경기',1,0)) as '경기',
sum(if(addr='경남',1,0)) as '경남',
sum(if(addr='경북',1,0)) as '경북',
sum(if(addr='전남',1,0)) as '전남',
count(addr) as '총합'
from usertbl;

-- buytbl의 userid와 groupname을 이용해서 userid별로 어떤 groupname을 구매했는지 만들기
select * from buytbl;
select userid,
sum(if(groupname='전자',1,0)) as '전자',
sum(if(groupname='의류',1,0)) as '의류',
sum(if(groupname='서적',1,0)) as '서적',
sum(if(groupname is null,1,0)) as 'null',
count(*)
from buytbl
group by userid with rollup;



















