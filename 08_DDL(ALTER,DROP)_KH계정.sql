/*
    DDL(ALTER, DROP)
    
    객체들을 새롭게 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문
    
    1. ALTER
    객체 구조를 수정하는 구문
    
    <테이블 수정>
    [표현법]
    ALTER TABLE 테이블명 수정할 내용;
    
    - 수정할 내용
    1) 컬럼 추가 / 수정 / 삭제
    2) 제약조건 추가 / 삭제 -> 수정은 불가 (수정하고자 한다면 삭제 후 새롭게 추가)
    3) 테이블명 / 컬럼명/ 제약조건명 수정
*/
-- 1) 컬럼 추가/ 수정/ 삭제
-- 1_1) 컬럼추가 (ADD) : ADD 추가할 컬럼명 자료형 DEFAULT 기본값
--                      단, DEFAULT 기본값은 생략가능
SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- 새로운 컬럼이 만들어지고, 기본값으로 NULL값이 추가됨

-- LNAME 컬럼 추가 DEFAULT 지정해서
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
-- 새로운 컬럼이 만들어지고 NULL값이 아닌 DEFAULT값으로 채워짐

-- 1_2) 컬럼수정 (MODIFY)
--      컬럼의 자료형 수정 : MODIFY 수정할 컬럼명 바꾸고자하는 자료형
--      DEFAULT값 수정 : MODIFY 수정할 컬럼명 DEFAULT 바꾸고자하는 기본값

-- DEPT_COPY테이블의 DEPT_ID컬럼의 자료형을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- 현재 변경하고자 하는 컬럼에 이미 문자열로 담겨있는 값이 담겨 있으면 완전 다른 타입으로 변경 불가능
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;

-- 현재 변경하고자 하는 컬럼에 담겨있는 값보다 작게는 변경 불가능
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1); 

-- 한번에 여러개의 컬럼 변경 가능
-- DEPT_TITLE컬럼의 데이터타입을 VARCHAR2(40)으로
-- LOCATION_ID컬럼의 데이터타입을 VARCHAR2(2)로
-- LNAME 컬럼의 기본값을 '미국'으로
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';

-- 1_3) 컬럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자하는 컬럼명
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

-- DML문만 ROLLBACK가능 : DDL문은 자동 COMMIT이 돼서 ROLLBACK 안됨
ROLLBACK;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- 테이블에 최소 1개의 컬럼은 존재해야함

-- 2) 제약조건 추가/ 삭제
/*
    2_2) 제약조건 추가
    
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블[(참조할컬럼)];
    
    - UNIQUE : ADD UNIQUE(컬럼명);
    - CHECK : ADD CHECK(컬럼에 대한 조건);
    - NOT NULL : MODIFY 컬럼명 NOT NULL;
    
    나만의 제약조건명 부여하고자 할 때 : CONSTRAINT 제약조건명을 제약조건 앞에다가 추가
    -> CONSTRAINT 제약조건명은 생략 가능 (임의로 이름이 붙음)
    -> 주의사항 : 현재 계정 내에 고유한 이름으로 부여해야 함
*/
-- DEPT_COPY테이블로부터
-- DEPT_ID컬럼에 PRIMARY KEY제약조건 추가
-- DEPT_TITLE컬럼에 UNIQUE제약조건 추가
-- LNAME컬럼에 NOT NULL제약조건 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

/*
    2-2) 제약조건 삭제
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
    NOT NULL : MODIFY 컬럼명 NULL;
*/
-- DEPT_COPY테이블에 DCOPY_PK제약조건 지우기
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_PK;

-- DEPT_COPY테이블에 DCOPY_UQ, DCOPY_NN제약조건 지우기
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_UQ
MODIFY LNAME NULL;

-- 3) 컬럼명/ 제약조건명/ 테이블명 변경(RENAME)
SELECT * FROM DEPT_TEST;

-- 3_1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
-- DEPT_COPY테이블에서 DEPT_TITLE컬럼을 DEPT_NAME으로 바꾸기
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약명 TO 바꿀제약명
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C0011190 TO DCOPY_DID_NN;
-- 3_3) 테이블명 변경 : RENAME TO 바꿀테이블명 --> 기존테이블명이 이미 제시되어 있기 때문에 생략 가능
ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST;
-------------------------------------------------------------------------------------------------
/*
    2. DROP
    객체를 삭제하는 구문
    
    [표현법]
    DROP 객체(TABLE, USER, VIEW...) 삭제하고자하는 객체이름;
*/
-- DEPT_COPY2 테이블 삭제
DROP TABLE DEPT_COPY2;

-- 부모테이블을 만들고, 부모테이블 삭제하기
ALTER TABLE DEPT_TEST
ADD PRIMARY KEY(DEPT_ID); -- PK제약조건 추가

-- EMPLOYEE_COPY3테이블에 외래키 제약조건 추가
-- 이때 부모테이블은 DEPT_TEST테이블의 DEPT_ID참조
ALTER TABLE EMPLOYEE_COPY3
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST(DEPT_ID);

-- 부모테이블 삭제
DROP TABLE DEPT_TEST;
-- 오류 : 자식테이블에서 참조되고 있어서 삭제할 수 없음
-- 어딘가에서 참조되고 있는 부모테이블은 삭제되지 않음
-- 부모테이블 삭제하고 싶다
-- 방법1) 자식테이블을 먼저 삭제하고 부모테이블을 삭제
DROP TABLE EMPLOYEE_COPY3;
DROP TABLE DEPT_TEST;
-- 방법2) 부모테이블만 삭제하되 맞물려있는 외래키 제약조건도 함께 삭제해줌
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;

