-- 1.
SET SERVEROUTPUT ON;

DECLARE ENAME EMPLOYEE.EMP_NAME%TYPE;
        SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_NAME, (SALARY+SALARY*NVL(BONUS, 0))*12
      INTO ENAME, SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE(ENAME||'사원의 연봉은 '||SALARY||'입니다.');
END;
/

-- 2.
-- 2-1)
DECLARE
    RESULT NUMBER;
BEGIN 
    FOR DAN IN 2..9
    LOOP
       IF MOD(DAN, 2)=0 -- 2로 나눴을 때 나머지가 0인 경우
            THEN
                FOR SU IN 1..9
                LOOP
                    RESULT := DAN*SU;
                    DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' || RESULT);
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('');
       END IF;
    END LOOP;
END;
/

-- 2_2)
DECLARE 
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN
    WHILE DAN <= 9
    LOOP
        SU := 1;
        IF MOD(DAN, 2) = 0
            THEN
                WHILE SU <= 9
                LOOP
                    RESULT := DAN * SU;
                     DBMS_OUTPUT.PUT_LINE(DAN || '*' || SU || '=' || RESULT);
                     SU := SU + 1;
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('');
        END IF;
        DAN := DAN + 2;
    END LOOP;
END;
/
