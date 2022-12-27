-- 1.
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
BEGIN 
    FOR I IN 2..8
    LOOP
        FOR J IN 1..9
        LOOP 
                DBMS_OUTPUT.PUT_LINE(I||'*'||J||'='||I*J);
        END LOOP;
        I := I+2;
    END LOOP;
END;
/

-- 2_2)
DECLARE I := 2;
BEGIN
    WHILE I <= 8
    LOOP
        WHILE J
        DBMS_OUTPUT.PUT_LINE(I||'*'||J||'='||I*J);
    END LOOP;
END;
/
