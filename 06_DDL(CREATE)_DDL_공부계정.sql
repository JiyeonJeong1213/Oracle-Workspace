/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 삭제하는(DROP) 명령문
    즉, 구조자체를 정의하는 언어로 DB관리자, 설계자가 사용한다.
    
    오라클에서 객체(DB를 이루는 구조들)
    테이블, 사용자(USER), 함수(FUNCTION), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 등등...
*/

/*
    <CREATE TABLE>
    테이블 : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체 종류 중 하나
            모든 데이터는 테이블을 통해서 저장됨(데이터를 조작하고자 하려면 무조건 테이블을 만들어야 함)
            
    표현법
    CREATE TABLE 테이블명(
    컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형,
    ...
    );
    <자료형 종류>
    - 문자 (CHAR(크기)/ VARCHAR2(크기)) : 크기는 BYTE 수이다.
                                        (숫자, 영문자, 특수문자 => 1글자당 1BYTE)
        CAHR(바이트 수) : 최대 2000BYTE까지 지정가능
                       고정길이(아무리 작은 값이 들어와도 빈 공간은 공백으로 채워서 처음 할당한 크기를 유지함)
                       주로 들어올 값의 글자수가 정해져 있을 경우 사용
                       예) 성별 : 남/여, M/F
                           주민번호 : 6-7 -> 14BYTE
        VARCHAR2(바이트 수) : 최대길이 4000BYTE까지 가능
                           가변길이 (적은 값이 들어온 경우 그 담긴 값에 맞춰 크기가 줄어든다)
                           VAR는 가변 2는 2배를 의미함
                           주로 들어올 값의 글자수가 정해져 있지 않은 경우 사용
                           매개변수에 CHAR가 들어온 경우 BYTE단위로 데이터 체크하지 않고 문자의 개수로 체크함
                           VARCHAR2(CHAR 10) => 10글자 허용
        NVARCHAR : 문자열의 바이트가 아닌, 문자 개수 자체를 길이로 취급하여 유니코드를 지원하기 위한 자료형 -> VARCHAR2(CHAR 10)과 동일
    - 숫자 (NUMBER) : 정수/실수 상관없이 NUMBER
    - 날짜 (DATE) : 년/월/일/시/분/초 형식으로 지정
*/
-- 회원들의 정보를 담을 테이블(MEMBER) -> (아이디, 비밀번호, 이름, 생년월일)
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20), -- 대소문자 구분하지 않음. 따라서 낙타등표기법이 의미 없음 => 언더바로 구분
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);
SELECT * FROM MEMBER;

-- 테이블 확인 방법 : 데이터 딕셔너리 이용
-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- USER_TABLES : 현재 이 사용자 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리

-- 컬럼들 확인 방법
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 사용자 계정이 가지고 있는 테이블들의 모든 컬럼의 정보를 조회할 수 있는 데이터 딕셔너리

/*
    컬럼에 주석 달기 (컬럼에 대한 설명)
    
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원생년월일';

-- INSERT문(데이터를 테이블에 추가할 수 있는 구문) => DML문
-- 한 행으로 추가(행 기준으로 데이터 추가함), 추가할 값을 기술(값의 순서 중요!)
-- INSERT INTO 테이블명 VALUES (첫번째 컬럼값, 두번째 컬럼값, ...)
INSERT INTO MEMBER VALUES ('USER01', 'PASS01', '정지연', '1994-12-13');
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL); -- 아이디, 비밀번호, 이름에 NULL값이 존재해도 될까?
-- 위의 NULL값이나 중복된 아이디값은 유효하지 않은 값들이다.
-- 유효한 데이터값을 유지하기 위해서 제약조건을 추가해야 함
-- 무결성 보장을 위해선 제약조건을 추가해야 함

/*
    <제약조건 CONSTRAINTS>
    
    - 원하는 데이터값만 유지하게 위해서 특정 컬럼마다 설정하는 제약
    - 제약조건이 부여된 컬럼에 들어올 데이터가 문제가 있는지 없는지 자동으로 검사할 목적
    
    - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    - 컬렝메 제약조건을 부여하는 방삭 : 컬럼레벨, 테이블레벨
*/

/*
    1. NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야만 할 경우 사용
    => 즉, NULL값이 절대 들어와서는 안되는 컬럼에 부여하는 계약조건
        삽입/수정시 NULL값을 허용하지 않도록 제한하는 제약조건
        
        주의사항 : 컬럼레벨방식 밖에 안 됨
*/
-- NOT NULL 제약조건을 가진 테이블 설정
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자 하는 컬럼 뒤에 곧바로 기술
CREATE TABLE MEMBER_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEMBER_NOTNULL VALUES(2, 'USER01', 'PASS01', NULL, NULL, NULL, NULL);
INSERT INTO MEMBER_NOTNULL VALUES(1, 'USER01', 'PASS01', '정지연', NULL, NULL, NULL);
--> NOT NULL 제약조건에 위배되어 오류가 발생
--> NOT NULL 제약조건 추가하지 않은 컬럼에 대해서는 NULL값을 추가해도 무방

/*
    2. UNIQUE 제약조건
        컬럼에 중복값을 제한하는 제약조건
        삽입/수정 시 기존에 해당 컬럼값에 중복된 값이 있을 경우 추가 또는 수정이 되지 않게 제약
        
        컬럼레벨방식/ 테이블레벨방식 둘 다 가능
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL
);

DROP TABLE MEM_UNIQUE;

-- 테이블레벨방식 : 모든 컬럼을 다 기술하고 그 이후에 제약조건을 나열
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    UNIQUE(MEM_ID) -- 테이블레벨방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'USER01', 'PASS01', '민경민');
INSERT INTO MEM_UNIQUE VALUES(2, 'USER02', 'PASS02', '민경민');
INSERT INTO MEM_UNIQUE VALUES(3, 'USER01', 'PASS03', '민경민3'); 
-- UNIQUE 제약조건에 위배됨
-- 제약조건 부여시 직접 제약조건의 이름을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여함
-- SYS C~~~(고유한, 중복되지 않은 이름으로 지정)
/*
    제약조건 부여시 제약조건 명도 지정하는 방법
    > 컬럼레벨방식
    CREATE TABLE 테이블명 (
        컬럼명 자료형 제약조건1 제약조건2,
        컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
        ...
    );
    > 테이블레벨방식
    CREATE TABLE 테이블명 (
        컬럼명 자료형,
        컬럼명 자료형,
        ...
        CONSTRAINT 제약조건명 제약조건(컬럼명)
    );
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL, -- 컬럼레벨방식
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) -- 테이블레벨방식
);
INSERT INTO MEM_UNIQUE VALUES(1, 'USER01', 'PASS01', '민경민');
INSERT INTO MEM_UNIQUE VALUES(2, 'USER02', 'PASS02', '민경민2');
INSERT INTO MEM_UNIQUE VALUES(3, 'USER01', 'PASS03', '민경민3');

/*
    3. PRIMARY KEY (기본키) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 칼럼에 부여하는 제약조건
    => 각 행들을 구별할 수 있는 식별자의 역할
       EX) 사번, 부서아이디, 직급코드, 회원번호 ...
    => 식별자의 조건 : 중복X, 값이 없어도 안됨 (NOT NULL + UNIQUE)
    
    주의사항 : 한 테이블 당 한 개의 컬럼값만 지정가능
*/
CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);
