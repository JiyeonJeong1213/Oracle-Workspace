-- 1.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3. 
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT CATEGORY_PK PRIMARY KEY(NAME);

-- 4.
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME NOT NULL;

-- 5. 
ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

-- 6. 
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;

ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

-- 7. 
ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C0011204 TO PK_CLASS_TYPE_NO;

ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT CATEGORY_PK TO PK_CATEGORY_NAME;

-- 8. 
INSERT INTO TB_CATEGORY VALUES('공학', 'Y');
INSERT INTO TB_CATEGORY VALUES('자연과학', 'Y');
INSERT INTO TB_CATEGORY VALUES('의학', 'Y');
INSERT INTO TB_CATEGORY VALUES('예체능', 'Y');
INSERT INTO TB_CATEGORY VALUES('인문사회', 'Y');
COMMIT;

-- 9. 
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

GRANT CREATE VIEW TO WORKBOOK;

-- 10,
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS 주소
    FROM TB_STUDENT;
    
-- 11. 
CREATE VIEW VW_지도면담
AS SELECT STUDENT_NO 학번, DEPARTMENT_NAME 학과이름, PROFESSOR_NAME
    FROM TB_STUDENT S
    LEFT JOIN TB_PROFESSOR P ON S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
    LEFT JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
    ORDER BY DEPARTMENT_NAME;
    
SELECT * FROM VW_지도면담;

-- 12.
CREATE VIEW VW_학과별학생수
AS SELECT DEPARTMENT_NAME, COUNT(STUDENT_NO) STUDENT_COUNT
    FROM TB_DEPARTMENT
    JOIN TB_STUDENT USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME;
    
-- 13. 
UPDATE VW_학생일반정보
SET 학생이름 = '정지연'
WHERE 학번 = 'A213046';

-- 14.
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS 주소
    FROM TB_STUDENT WITH READ ONLY;
    
-- 15.
SELECT S.*
FROM (
    SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
    FROM TB_CLASS
    JOIN TB_GRADE USING (CLASS_NO)
    WHERE TERM_NO LIKE '2009%' OR TERM_NO LIKE '2008%' OR TERM_NO LIKE '2007%'
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY "누적수강생수(명)" DESC)S
WHERE ROWNUM <= 3;
