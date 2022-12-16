/*
    <함수 FUNCTION>
    자바로 따지면 메소드와 같은 존재
    매개변수로 전달된 값들을 읽어서 계산한 결과를 반환 -> 호출해서 쓴다.
    
    - 단일행 함수 : n개의 값을 읽어서 n개의 결과를 리턴(매 행마다 함수 실행 후 결과 반환)
    - 그룹 함수 : n개의 값을 읽어서 1개의 결과를 리턴(하나의 그룹별로 함수 실행 후 결과 반환)
    
    단일행 함수와 그룹 함수는 함께 사용할 수 없음 : 결과 행의 개수가 다르기  때문
*/
-------------------단일행 함수---------------------
/*
    <문자열과 관련된 함수>
    <LENGTH / LENGTHB>
    
    - LENGTH(문자열) : 해당 전달된 문자열의 글자 수 반환
    - LENGTHB(문자열) : 매개변수로 전달된 문자열의 바이트 수 반환
    
    결과값은 숫자로 반환한다 => NUMBER 데이터타입
    문자열 : 문자열형식의 리터럴 혹은 문자열에 해당하는 컬럼
    
    한글 : '김' -> 'ㄱ', 'ㅣ', 'ㅁ' => 한 글자당 3바이트 취급
    영문, 숫자, 특수문자 : 한 글자당 1BYTE로 취급
*/
SELECT LENGTH('오라클 쉽네'), LENGTHB('오라클 쉽네')
FROM DUAL; -- 가상테이블(DUMMY TABLE) : 산술연산이나 가상컬럼값 등 한번만 출력하고 싶을 때 사용하는 테이블

SELECT '오라클', 1, 2, 3, 'AAAAAAA'
FROM DUAL;

/*
    <INSTR>
    
    - INSTR(문자열, 특정문자, 찾을 위치의 시작값, 순번) : 문자열로부터 특정문자의 위치값 반환
    
    찾을 위치의 시작값과 순번은 생략 가능
    결과값은 NUMBER타입으로 반환
    
    찾을 위치의 시작값 (1 / -1)
    1 : 앞에서부터 찾겠다(생략 시 기본값)
    -1 : 뒤에서부터 찾겠다 
*/
SELECT INSTR ('AABAACAABBAA', 'B') FROM DUAL;
-- 앞에서부터 B를 찾아서 첫번째로 찾은 B의 위치를 반환해줌 : 3

SELECT INSTR ('AABAACAABBAA', 'B', 1) FROM DUAL;
-- 위와 동일

SELECT INSTR ('AABAACAABBAA', 'B', -1) FROM DUAL;
-- 뒤에서부터 첫번째로 찾은 B의 위치를 앞에서부터 세서 반환해줌 : 10

SELECT INSTR ('AABAACAABBAA', 'B', -1, 2) FROM DUAL;
-- 뒤에서부터 두번째로 찾은 B의 위치를 앞에서부터 세서 반환해줌 : 9

SELECT INSTR ('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
-- 앞에서부터 두번째로 찾은 B의 위치를 반환해줌 : 9

SELECT INSTR ('AABAACAABBAA', 'B', -1, 0) FROM DUAL;
-- 에러발생

-- 인덱스처럼 글자의 위치를 찾는 것은 맞음
-- 자바처럼 0부터가 아니라 1부터 찾는다.

-- EMPLOYEE테이블에서 EMAIL컬럼에서 @의 위치를 찾아보기
SELECT EMP_NAME, EMAIL, INSTR (EMAIL, '@') AS "골뱅이의 위치"
FROM EMPLOYEE;

/*
    <SUBSTR>
    
    문자열로부터 특정 문자열을 추출하는 함수
    
    - SUBSTR(문자열, 처음위치, 추출할 문자 개수)
    
    결과값은 CHARACTER타입으로 반환(문자열 형태)
    추출할 문자개수 생략 가능(생략시에는 문자열 끝까지 추출)
    처음 위치는 음수로 제시 가능 : 뒤에서부터 N번째 위치로부터 문자를 추출하겠다는 뜻
*/
SELECT SUBSTR('ORACLEDATABASE', 7) FROM DUAL;

SELECT SUBSTR('ORACLEDATABASE', 7, 4) FROM DUAL;

SELECT SUBSTR('ORACLEDATABASE', -4) FROM DUAL;

-- 주민등록번호에서 성별부분을 추출해서 남자(1,3)/여자(2,4)인지를 체크
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS 성별
FROM EMPLOYEE;

-- 이메일에서 ID부분만 추출해서 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS ID
FROM EMPLOYEE;

-- 남자사원들만 조회
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1, 3);
-- 여자사원들만 조회
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (2, 4);

/*
    <LPAD / RPAD>
    
    - LPAD/RPAD(문자열, 최종적으로 반환할 문자의 길이(BYTE), 덧붙이고자 하는 문자)
    : 제시한 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
    
    결과값은 CHARACTER타입으로 반환
    덧붙이고자 하는 문자 : 생략가능
*/
SELECT LPAD(EMAIL, 16), LENGTH(EMAIL) FROM EMPLOYEE;
-- 덧붙이고자 하는 문자 생략시 공백이 문자열값의 왼쪽에 붙어서 반환됨

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 주민등록번호 조회 : 123456-1234567 => 123456-1******
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE;

-- 1단계 : 주민번호 뒷부분은 *로 채우는 방법
SELECT RPAD('123456-1', 14, '*') AS 주민번호 FROM DUAL;

-- 2단계 : 주민번호를 앞 8자리까지만 가져오는 방법
SELECT SUBSTR(EMP_NO, 1, 8) AS "주민번호 앞자리"
FROM EMPLOYEE;

-- 3단계 : 1단계+2단계
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS 주민번호
FROM EMPLOYEE;

/*
    <LTRIM/RTRIM>
    
    -LTRIM/RTRIM(문자열, 제거하고자 하는 문자)
    : 문자열의 왼쪽 또는 오른쪽에서 제거시키고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
    
    결과값은 CHARACTER타입으로 반환
    제거시키고자하는 문자 생략 가능 => ' '이 제거됨
*/
SELECT LTRIM('   정 지 연     ')
FROM DUAL;

SELECT RTRIM('0001230456000', '0')
FROM DUAL;

SELECT LTRIM('1313131KH123', '123')
FROM DUAL; 
-- 제거하고자 하는 문자열을 통으로 지워주는 게 아니라 문자 하나 단위로 검사해서 제거하고자 하는 문자에 그 문자가 포함되면 삭제됨

/*
    <TRIM>
    
    -TRIM(BOTH/LEADING/TRAILING '제거하고자 하는 문자' FROM '문자열')
    : 문자열에서 양쪽/ 앞쪽/ 뒤쪽에 있는 특정문자를 제거한 나머지 문자열을 반환
    
    결과값은 CHARACTER타입으로 반환
    BOTH/LEADING/TRAILING은 생략가능, 기본값은 BOTH
*/
SELECT TRIM('        K        H       ')
FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL;

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZZ')
FROM DUAL;

/*
    <LOWER/UPPER/INITCAP>
    
    - LOWER(문자열)
    : 소문자로 변경
    - UPPER(문자열)
    : 대문자로 변경
    - INITCAP(문자열)
    : 각 단어의 앞글자만 대문자로 변환
    
    결과값은 모두 CHARACTER타입으로 반환
*/
SELECT LOWER('WELCOME TO C CLASS'), UPPER('welcome to c class'), INITCAP('welcome to c class')
FROM DUAL;

/*
    <CONCAT>
    
    -CONCAT(문자열1, 문자열2)
    : 전달된 문자열 두개를 하나의 문자열로 합쳐서 반환
    
    결과값은 CHARACTER
*/
SELECT CONCAT('가나다', '라마바사') FROM DUAL;
SELECT '가나다' || '라마바사' FROM DUAL;

SELECT CONCAT(CONCAT('가나다', '라마바사'), '아') FROM DUAL; -- 매개변수 두개만 가능
SELECT '가나다' || '라마바사' || '아' FROM DUAL;

/*
    <REPLACE>
    자주 사용되는 키워드
    
    -REPLACE(문자열, 찾을 문자, 바꿀 문자)
    : 문자열로부터 찾을 문자를 찾아서 바꿀 문자로 치환해줌
*/
SELECT REPLACE('서울시 강남구 역삼동 테헤란로 6번길 남도빌딩 3층', '3층', '2층 C클래스')
FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'iei.or.kr')
FROM EMPLOYEE;

----------------------------------------------------------------------------------------------

/*
    <숫자와 관련된 함수>
    <ABS>
    
    - ABS(숫자) : 절대값을 구해주는 함수
    
    결과값은 NUMBER
*/
SELECT ABS(-19) FROM DUAL;

SELECT ABS(-10.9) FROM DUAL;

/*
    <MOD>
    모듈러 연산 -> %
    
    -MOD(숫자, 나눌값) : 두 수를 나눈 '나머지값'을 반환해주는 함수
    
    결과값은 NUMBER
*/
SELECT MOD(10, 3) FROM DUAL;

SELECT MOD(-10, 3) FROM DUAL;

SELECT MOD(10.9, 3) FROM DUAL;

/*
    <ROUND>
    
    - ROUND(반올림하고자 하는 수, 반올림할 위치) : 반올림해주는 함수
    
    반올림할 위치 : 소수점 기준으로 아래 N번째 수까지 반올림 하겠다
                  생략가능(기본값은 0, 소숫점 첫번째 자리에서 반올림 하겠다 = 소수점이 0개다)
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

/*
    <CEIL>
    
    - CEIL(올림처리할 숫자) : 소수점 아래 수를 무조건 올림처리 해주는 함수
    
    <FLOOR>
    
    -FLOOR(버림처리할 숫자) : 소수점 아래 수를 무조건 버림처리 하는 함수
    
    둘 다  반환형은 NUMBER
*/
SELECT CEIL(123.1111111) FROM DUAL;
SELECT FLOOR(123.9999) FROM DUAL;

-- 각 직원별로 근무일수 구하기 (오늘날짜 - 고용일 => 소숫점)
SELECT EMP_NAME, HIRE_DATE, CONCAT(FLOOR(SYSDATE-HIRE_DATE), '일') AS 근무일수
FROM EMPLOYEE;

/*
    <TRUNC>
    
    - TRUNC(버림처리할 숫자, 위치) : 위치가 지정 가능한 버림처리 해주는 함수
    
    결과값은 NUMBER
    위치 : 생략가능. 생략시 기본값은 0
*/
SELECT TRUNC(123.786, -1) FROM DUAL;

--------------------------------------------------------------------------------------

/*
    <날짜 관련 함수>
    
    DATE 타입 : 년도, 월, 일, 시, 분, 초를 다 포함하고 있는 자료형
*/

-- SYSDATE : 현재 시스템 날짜 반환
SELECT SYSDATE FROM DUAL;

-- 1. MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월수를 반환 (결과값은 NUMBER)
-- DATE2가 미래일 경우 음수가 나옴

-- 각 직원별 근무일수, 근무 개월수
SELECT EMP_NAME,
       FLOOR(SYSDATE - HIRE_DATE) || '일' 근무일수,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' 근무개월
FROM EMPLOYEE;

-- 2. ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼 개월수를 더한 날짜를 반환 (결과값은 DATE)
-- 많이 쓰임

-- 오늘 날짜로부터 5개월 후
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- 전체 사원들의 1년 근속일 (= 입사일 기준 1주년)
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 12) "1년 근속일" 
FROM EMPLOYEE;

-- 3. NEXT_DAY(DATE, 요일(문자/숫자)) : 특정날짜에서 가장 가까운 요일을 찾아 그 날짜를 반환
-- 1 : 일요일, 2 : 월요일, 3 : 화요일 ... 7 : 토요일
SELECT NEXT_DAY(SYSDATE, '토') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 3) FROM DUAL; -- 숫자를 더 많이 사용
-- 토요일은 가능한데 SATURDAY에서는 오류남 -> 현재 컴퓨터 셋팅이 KOREAN이기 때문에

-- 언어를 변경
-- DDL(데이터 정의 언어) : CREATE, ALTER, DROP
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT NEXT_DAY(SYSDATE, 'MON') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- 4. LAST_DAY(DATE) : 해당 특정 날짜 달의 마지막 날짜를 구해서 반환
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 이름, 입사일, 입사한 달의 마지막 날짜 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

-- 4. EXTRACT : 년도, 월, 일 정보를 추출해서 반환(결과값은 NUMBER)
/*
    - EXTRACT(YEAR FROM 날짜) : 특정 날짜로부터 년도만 추출
    - EXTRACT(MONTH FROM 날짜) : 특정 날짜로부터 월만 추출
    - EXTRACT(DAY FROM 날짜) : 특정 날짜로부터 일만 추출
*/
SELECT EXTRACT(YEAR FROM SYSDATE),
       EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-----------------------------------------------------------------------------------

/*
    <형변환 함수>
    NUMBER/DATE => CHARACTER
    
    - TO_CHAR(NUMBER/DATE, 포맷)
    : 숫자형 또는 날짜형 데이터를 문자형 타입으로 반환(포맷에 맞춰서)
*/
-- 숫자를 문자열로
SELECT TO_CHAR(123456) FROM DUAL;

SELECT TO_CHAR(123, '00000') FROM DUAL;
-- 빈칸을 0으로 채움

SELECT TO_CHAR(1234, '99999') FROM DUAL;
-- 빈칸을 ' '으로 채움

SELECT TO_CHAR(1234, 'L00000') FROM DUAL;
-- L : LOCAL => 현재 설정된 나라의 화폐단위
-- 1234 => ￦01234

SELECT TO_CHAR(1234,'L99,999') FROM DUAL;
-- 1234 => ￦1,234

-- 급여정보를 3자리마다 ,를 추가해서 확인
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999') 급여
FROM EMPLOYEE;

-- 날짜를 문자열로
SELECT TO_CHAR(SYSDATE) FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;

-- HH24 : 24시간 형식
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;

-- MON : 몇 '월' 형식, DY : 요일을 알려주는데 금요일에서 요일을 뺌
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;

-- 년으로써 사용할 수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;
-- YY와 RR의 차이점
-- R이 뜻하는 단어 : ROUND(반올림)
-- YY : 앞자리에 무조건 20이 붙음 => (20)21
-- RR : 50년 기준 작으면 20이 붙음, 크면 19가 붙음 => (19)89

-- 월로써 사용할 수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일로써 사용할 수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'D'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DDD')
FROM DUAL;
-- D: 1주일 기준으로 일요일부터 며칠째인지 알려주는 포맷
-- DD : 1달 기준으로 1일부터 몇일째인지 알려주는 포맷
-- DDD : 1년 기준으로 1월 1일부터 며칠째인지 알려주는 포맷

-- 요일로써 사용할 수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- 2022년 12월 14일 (수) 포맷으로 적용하기
SELECT TO_CHAR(SYSDATE, 'YYYY') || '년 ' ||  TO_CHAR(SYSDATE, 'MM') || '월 ' || TO_CHAR(SYSDATE, 'DD') ||
'일 ' || TO_CHAR(SYSDATE, '(DY)')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" (DY)')
FROM DUAL;

-- 2010년 이후에 입사한 사원들의 사원명, 입사일 포맷은 위의 형식대로
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)') -- 2013년 03월 01일
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;
--WHERE HIRE_DATE >= '10/01/01'; 자동형변환으로 비교

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'FMYYYY"년" MM"월" DD"일" (DY)') -- 2013년 3월 1일
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;

/*
    NUMBER/CHARACTER => DATE
    
    - TO_DATE(NUMBER/CHARACTER, 포맷) : 숫자형, 문자형 데이터를 날짜로 변환
*/

SELECT TO_DATE(20221104)
FROM DUAL; -- 기본포맷 YY/MM/DD로 변환

SELECT TO_DATE(000101) -- 정수값중에 0으로 시작하는 숫자는 없기 때문에 에러 발생
FROM DUAL;

SELECT TO_DATE('000101')
FROM DUAL; -- 0으로 시작하는 년도를 다룰 때는 반드시 ''을 붙여서 문자열처럼 다뤄줘야 함

SELECT TO_DATE('20221104', 'YYYYMMDD')
FROM DUAL; -- YY/MM/DD

SELECT TO_DATE('091129 143050', 'YYMMDD HH24:MI:SS')
FROM DUAL;

SELECT TO_DATE('220806', 'YYMMDD')
FROM DUAL; -- 2022년도

SELECT TO_DATE('980806', 'YYMMDD')
FROM DUAL; -- 2098년도
-- TO_DATE() 함수를 이용해서 DATE형식으로 변환시 두자리 년도에 대해서 YY형식을 적용시키면 무조건 현재세기(20)를 붙여줌

SELECT TO_DATE('220806', 'RRMMDD')
FROM DUAL; -- 2022년도

SELECT TO_DATE('980806', 'RRMMDD')
FROM DUAL; -- 1998년도
-- 두자리 년도에 대해서 RR포맷을 적용시킬 경우 => 50이상이면 이전세기, 50미만이면 현재세기(반올림)

/*
    CHARACTER => NUMBER
    
    - TO_NUMBER(CHARACTER, 포맷) : 문자형데이터를 숫자형으로 변환
*/
-- 자동형변환의 예시 (문자열 -> 숫자)
SELECT '123'+'123'
FROM DUAL; -- 123123X 246O : 자동형변환 후 산술연산이 진행됨

SELECT '10,000,000'+'550,000' 
FROM DUAL; -- ,문자를 포함하고 있어서 자동형변환이 안됨

SELECT TO_NUMBER('10,000,000', '99,999,999')+TO_NUMBER('550,000', '999,999') 
FROM DUAL;

SELECT TO_NUMBER('0123')
FROM DUAL;

-- 문자열, 숫자, 날짜 형변환 끝 --
-----------------------------------------------------------------------------------

-- NULL : 값이 존재하지 않음을 의미
-- NULL 처리 함수들 : NVL, NVL2, NULLIF

/*
    <NULL> 처리 함수
    NVL(컬럼명, 해당 컬럼값이 NULL일 경우 반환할 반환값)
    -- 해당 커럼값이 존재할 경우(NULL이 아닐 경우) 기존의 컬럼값을 반환
    -- 해당 컬럼값이 존재하지 않을 경우(NULL일 경우) 내가 제시한 특정값을 반환
*/

-- 사원명, 보너스, 보너스가 없는 경우 0을 출력
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 보너스 포함 연봉 조회 (SALARY+(SALARY*BONUS))*12
SELECT EMP_NAME, (SALARY+(SALARY*NVL(BONUS,0)))*12 AS "보너스가 포함된 연봉"
FROM EMPLOYEE;

-- 사원명, 부서코드(부서코드가 없는 경우 '없음') 조회
SELECT EMP_NAME, NVL(DEPT_CODE, '없음')
FROM EMPLOYEE;

-- NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼에 값이 존재할 경우 결과값1 반환
-- 해당 컬럼에 값이 NULL일 경우 결과값2 반환

-- 보너스가 있는 사원은 '보너스 있음', 보너스가 없는 사원은 '보너스 없음'
SELECT EMP_NAME, BONUS, NVL2(BONUS, '보너스 있음', '보너스 없음')
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2) : 동등비교
-- 두 값이 동일할 경우 NULL 반환
-- 두 값이 동일하지 않을 경우 비교대상 1을 반환

SELECT NULLIF('456', '123')
FROM DUAL;

-- 선택함수 : DECODE => SWITCH문
-- 선택함수 친구 : CASE WHEN THEN 구문 => IF문
/*
    <선택함수>
    
    - DECODE(비교대상, 조건값1, 결과값1, 조건값2, 결과값2, 조건값3, 결과값3, ..., 결과값)
    - 자바에서 SWITCH문과 유사
    switch(비교대상) {
    case 조건값1 : 결과값1; break;
    case 조건값2 : 결과값2; break;
    case 조건값3 : 결과값3; break;
    ...
    default : 결과값
    }
    비교대상에는 컬럼명, 산술연산, 함수가 들어갈 수 있음
*/
-- 사번, 사원명, 주민번호, 주민번호로부터 성별을 추출하여 1이면 남, 2면 여자 출력
SELECT 
    EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여')성별
FROM EMPLOYEE;

-- 각 직원들의 급여를 인상시켜서 조회
-- 직급코드가 'J7'인 사원은 급여를 20% 인상해서 조회
-- 직급코드가 'J6'인 사원은 급여를 15% 인상해서 조회
-- 직급코드가 'J5'인 사원은 급여를 50% 인상해서 조회
-- 그 외 직급은 급여를 10%만 인상해서 조회
-- 사원명, 직급코드, 변경 전 급여, 변경 후 급여 

SELECT EMP_NAME 사원명, JOB_CODE 직급코드, SALARY "변경 전 급여", DECODE(JOB_CODE, 'J7', SALARY*1.2, 'J6', SALARY*1.15, 'J5', SALARY*1.5, SALARY*1.1) "변경 후 급여"
FROM EMPLOYEE;

/*
    CASE WHEN THEN 구문
    - DECODE 선택함수와 비교하면 DECODE는 해당 조건검사 시 동등비교만을 수행 => SWITCH문과 유사
    - CASE WHEN THEN 구문은 특정조건을 내맘대로 제시 가능 => IF문과 유사
    [표현법]
    CASE WHEN 조건식1 THEN 결과값1
        WHEN 조건식2 THEN 결과값2
        ...
        ELSE 결과값
        END
        => 자바에서 IF~ ELSE IF문과 유사
*/
-- 사번, 사원명, 주민번호, 주민번호로부터 성별을 추출하여 1이면 남, 2면 여자 출력
SELECT 
    EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여')성별
FROM EMPLOYEE;

-- CASE WHEN THEN 구문 이용
-- = : 대입연산자X 동등비교 연산자
SELECT EMP_ID 사번, EMP_NAME 사원명, EMP_NO 주민번호
       , CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남자'
              ELSE '여자'
              END 성별
FROM EMPLOYEE;

-- 사원명, 급여, 급여등급(SAL_LEVEL 사용X)
-- 급여등급 SALARY 값이 500만원 초과일 경우 '고급'
--                    500만원 이하 350만원 초과 '중급'
--                    350이하 '초급'
-- CASE WHEN THEN 구문으로 작성
SELECT EMP_NAME 사원명, SALARY 급여
    , CASE WHEN SALARY > 5000000 THEN '고급'
            WHEN SALARY > 3500000 THEN '중급'
            ELSE '초급' 
            END 급여등급
FROM EMPLOYEE;

-- 여기까지 단일행 함수

-------------------------- <그룹함수> ------------------------------
-- 그룹함수 : 데이터들의 합, 데이터들의 평균 구합니다. SUM, AVG
/*
    N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행 결과 반환)
*/

-- 1. SUM(숫자타입의 컬럼) : 해당 컬럼값들의 총 합계를 반환
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 부서코드가 'D5'인 사원들의 급여 총 합계
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG(숫자타입의 컬럼) : 해당 컬럼값들의 평균을 반환
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANY 타입) : 해당 컬럼값들 중 가장 작은 값 반환
SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(ANY 타입) : 해당 컬럼값들 중 가장 큰 값 반환
SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- MAX함수의 경우 내림차순으로 정렬시 가장 위쪽의 값을 보여줌

-- 5. COUNT(*/컬럼이름/DISTINCT 컬럼이름) : 조회된 행의 개수를 세서 반환
-- COUNT(*) : 조회결과에 해당하는 모든 행의 개수를 다 세서 반환
-- COUNT(컬럼이름) : 제시한 해당 컬럼값이 NULL이 아닌 것만 행의 개수를 세서 반환
-- COUNT(DISTINCT 컬럼이름) : 제시한 해당 컬럼값이 중복값이 있을 경우 하나로만 세서 반환, NULL 세지 않음

-- 전체 사원수에 대해 조회
SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자인 사원수만 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- 부서배치가 완료된 사원수만 조회
-- 부서배치가 완료되었다 = 부서코드가 NULL이 아니다
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 부서배치가 완료된 여자 사원수 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL AND SUBSTR(EMP_NO, 8, 1) = '2';

-- 사수가 있는 사원의 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 유효한 직급의 개수
-- = 사원들 직급의 종류 개수 = 회사에 존재하는 직급의 수
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 직원명, 부서코드, 생년월일, 나이(만) 조회
-- 단, 생년얼일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며
-- 나이는 주민번호에서 추출해서 날짜 데이터로 변환한 다음 계산
SELECT EMP_NAME 직원명, DEPT_CODE 부서코드,
        TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6)), 'YY"년" MM"월" DD"일"') 생년월일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6))) 나이
FROM EMPLOYEE;