-- INDEX
-- 데이터 베이스 테이블의 검색 성능을 향상시키기 위해 사용되는 데이터 구조
-- where 이하 조건절열에 index로 지정된 열을 사용한다
-- Index로 지정된 열은 기본적으로 정렬 처리가 된다
-- Unique Index(PK,Unique 제약조건시 기본설정됨)와 Non_unique Index로 나눠진다

-- Mysql Index 종류
-- B-Tree : 기본값, 대부분의 데이터 Index에 잘 적용되어 사용
-- Hash : 해시 함수를 이용한 Index, 정확한 일치 검색에 사용
-- Full-text : 전체 텍스트 검색에 사용된 Index, 텍스트 검색 기능 향상
-- Spatial : 공간데이터(위도/경도 등)을 처리하기 위한 Index, 지리 정보 검색에 유리

-- 01 제약조건PK 설정시 unique index 확인
use shopdb;
create table test_01
(col1 int primary key,
col2 int);
show index from test_01;

-- 02 제약조건unique 설정시 unique index 확인
create table test_02
(col1 int primary key,
col2 int unique,
col3 int);
show index from test_02;

-- PK 열을 기준으로 B-Tree 검색시 용이하도록 오름차순 정렬이 된다
-- Unique 열은 자동정렬되는 열은 아니다

-- 03 index 삭제
alter table test_02 drop primary key;
alter table test_02 drop constraint col2;
show index from test_02;

-- 04 테이블 생성시 Index 설정
create table test_03
(col1 int primary key,
col2 int,
col3 int,
index col2_3_index(col2,col3));
show index from test_03;
drop table test_03;

create table test_04
(col1 int primary key,
col2 int,
col3 int,
unique index col2_3_index(col2,col3));
show index from test_04;

-- 05 테이블 생성이후 Index 설정
create table test_05
(col1 int,
col2 int,
col3 int);
create index clo1_idx on test_05(col1);
create unique index col2_idx on test_05(col2);
show index from test_05;

create table test_6
(userid char(8) not null,
constraint fk_userid_test_06 foreign key(userid) references usertbl(userid)
on update cascade
on delete cascade);
show index from test_6;
