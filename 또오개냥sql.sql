/*DROP TABLE B_LIKE;
DROP TABLE SAVE;
DROP TABLE PET;
DROP TABLE MESSAGE;
DROP TABLE CHATROOM;
DROP TABLE MATE;
DROP TABLE ATTACHMENT;
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE CATEGORY;
DROP TABLE MEMBER;


DROP SEQUENCE SEQ_UNO;
DROP SEQUENCE SEQ_BNO;
DROP SEQUENCE SEQ_CNO;
DROP SEQUENCE SEQ_MNO;
DROP SEQUENCE SEQ_FNO;
DROP SEQUENCE SEQ_RNO;*/


CREATE TABLE MEMBER (
	USER_NO	NUMBER	NOT NULL,
	USER_ID	VARCHAR2(30 )	NOT NULL UNIQUE,
	USER_PWD	VARCHAR2(100)	NOT NULL,
	USER_NAME	VARCHAR2(15)	NOT NULL,
	USER_NICKNAME	VARCHAR2(100)	NOT NULL UNIQUE,
	PHONE	VARCHAR2(13)	NULL,
	EMAIL	VARCHAR2(100)	NULL,
	ADDRESS	VARCHAR2(100)	NULL,
	HOBBY	VARCHAR2(100)	NULL,
	ENROLL_DATE	DATE DEFAULT SYSDATE	NOT NULL,
	MODIFY_DATE	DATE	NULL,
	STATUS	VARCHAR2(1)	NOT NULL
);
COMMENT ON COLUMN MEMBER.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.USER_NICKNAME IS '회원닉네임';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.HOBBY IS '취미';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '가입일';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '정보수정일';
COMMENT ON COLUMN MEMBER.STATUS IS '상태값(가입1, 탈퇴2, 대기3, 거절4)';
/*회원번호 발생시킬 시퀀스*/
CREATE SEQUENCE SEQ_UNO
NOCACHE;
/*MEMBER테이블에 행추가*/
INSERT INTO MEMBER VALUES(SEQ_UNO.NEXTVAL, 'admin', '1234', '관리자', '관리자', NULL, NULL, NULL, NULL, SYSDATE, SYSDATE, 1); 


CREATE TABLE PET (
	USER_NO	NUMBER	NOT NULL,
	SPECIES	VARCHAR2(15)	NOT NULL,
	GENDER	VARCHAR2(5)	NOT NULL,
	PET_NAME	VARCHAR2(100)	NOT NULL
);
COMMENT ON COLUMN PET.USER_NO IS '회원번호';
COMMENT ON COLUMN PET.SPECIES IS '종(DOG/CAT)';
COMMENT ON COLUMN PET.GENDER IS '성별';
COMMENT ON COLUMN PET.PET_NAME IS '펫이름';


CREATE TABLE BOARD (
	BOARD_NO	NUMBER	NOT NULL,
	BOARD_TYPE	NUMBER	NOT NULL,
	BOARD_CATEGORY	NUMBER	NULL,
	BOARD_TITLE	VARCHAR2(100)	NOT NULL,
	BOARD_CONTENT	VARCHAR2(4000)	NOT NULL,
	BOARD_WRITER	NUMBER	NOT NULL,
	COUNT	NUMBER	NULL,
	CREATE_DATE	DATE DEFAULT SYSDATE	NOT NULL,
	SALE	VARCHAR2(1)	NULL,
    ADDRESS VARCHAR2(100) NULL,
    LATITUDE NUMBER NULL,
    LONGITUDE NUMBER NULL,
	STATUS	VARCHAR2(1) DEFAULT 'Y'	NOT NULL
);
COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_TYPE IS '게시글타입(산책1/자유2/거래3/공지4)';
COMMENT ON COLUMN BOARD.BOARD_CATEGORY IS '카테고리번호(자랑1/후기2/정보3/질문4)';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '작성자회원번호';
COMMENT ON COLUMN BOARD.COUNT IS '조회수';
COMMENT ON COLUMN BOARD.CREATE_DATE IS '작성일';
COMMENT ON COLUMN BOARD.SALE IS '나눔/거래 게시판 판매중/판매완료(Y/N)';
COMMENT ON COLUMN BOARD.ADDRESS IS '산책/거래게시판 주소설정';
COMMENT ON COLUMN BOARD.LATITUDE IS '마커 위도';
COMMENT ON COLUMN BOARD.LONGITUDE IS '마커 경도';
COMMENT ON COLUMN BOARD.STATUS IS '상태값(Y/N)';
/*게시글번호 발생시킬 시퀀스*/
CREATE SEQUENCE SEQ_BNO
NOCACHE;


CREATE TABLE CATEGORY (
	CATEGORY_NO	NUMBER	NOT NULL,
	CATEGORY_NAME	VARCHAR2(30)	NOT NULL
);
COMMENT ON COLUMN CATEGORY.CATEGORY_NO IS '카테고리번호';
COMMENT ON COLUMN CATEGORY.CATEGORY_NAME IS '카테고리이름';
/*CATEGORY테이블에 행추가*/
INSERT INTO CATEGORY VALUES(1,'이거보시개(자랑)');
INSERT INTO CATEGORY VALUES(2,'궁금해요!(질문)');
INSERT INTO CATEGORY VALUES(3,'정보다냥(정보)');
INSERT INTO CATEGORY VALUES(4,'들어보시개(후기)');


CREATE TABLE SAVE (
	USER_NO	NUMBER	NOT NULL,
	BOARD_NO	NUMBER	NOT NULL
);
COMMENT ON COLUMN SAVE.USER_NO IS '찜한회원번호';
COMMENT ON COLUMN SAVE.BOARD_NO IS '찜된게시글번호';


CREATE TABLE ATTACHMENT (
	FILE_NO	NUMBER	NOT NULL,
	REF_BNO	NUMBER	NULL,
	REF_MNO	NUMBER	NULL,
	ORIGIN_NAME	VARCHAR2(300)	NOT NULL,
	CHANGE_NAME	VARCHAR2(300)	NOT NULL,
	FILE_PATH	VARCHAR2(1000)	NOT NULL,
	UPLOAD_DATE	DATE DEFAULT SYSDATE	NOT NULL,
	FILE_LEVEL	NUMBER	NULL,
	STATUS	VARCHAR2(1) DEFAULT 'Y'	NOT NULL
);
COMMENT ON COLUMN ATTACHMENT.FILE_NO IS '파일번호';
COMMENT ON COLUMN ATTACHMENT.REF_BNO IS '참조게시글번호';
COMMENT ON COLUMN ATTACHMENT.REF_MNO IS '참조회원번호';
COMMENT ON COLUMN ATTACHMENT.ORIGIN_NAME IS '파일원본명';
COMMENT ON COLUMN ATTACHMENT.CHANGE_NAME IS '파일수정명';
COMMENT ON COLUMN ATTACHMENT.FILE_PATH IS '저장폴더경로';
COMMENT ON COLUMN ATTACHMENT.UPLOAD_DATE IS '업로드일';
COMMENT ON COLUMN ATTACHMENT.FILE_LEVEL IS '파일레벨';
COMMENT ON COLUMN ATTACHMENT.STATUS IS '상태값(Y/N)';
/*파일번호 발생시킬 시퀀스*/
CREATE SEQUENCE SEQ_FNO
NOCACHE;


CREATE TABLE REPLY (
	REPLY_NO	NUMBER	NOT NULL,
	REF_BNO	NUMBER	NOT NULL,
	REPLY_WRITER	NUMBER	NOT NULL,
	REPLY_CONTENT	VARCHAR2(500)	NOT NULL,
	CREATE_DATE	DATE DEFAULT SYSDATE	NOT NULL,
	STATUS	VARCHAR2(1) DEFAULT 'Y'	NOT NULL
);
COMMENT ON COLUMN REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN REPLY.REF_BNO IS '참조게시글번호';
COMMENT ON COLUMN REPLY.REPLY_WRITER IS '작성자회원번호';
COMMENT ON COLUMN REPLY.REPLY_CONTENT IS '댓글내용';
COMMENT ON COLUMN REPLY.CREATE_DATE IS '작성일';
COMMENT ON COLUMN REPLY.STATUS IS '상태값(Y/N)';
/*댓글번호 발생시킬 시퀀스*/
CREATE SEQUENCE SEQ_RNO
NOCACHE;


CREATE TABLE CHATROOM (
	CR_NO	NUMBER	NOT NULL,
	CR_NAME	VARCHAR2(30)	NULL,
	CREATE_DATE	DATE DEFAULT SYSDATE	NOT NULL,
	STATUS	VARCHAR2(1) DEFAULT 'Y'	NOT NULL,
	SELLER	NUMBER	NOT NULL,
	BUYER	NUMBER	NOT NULL
);
COMMENT ON COLUMN CHATROOM.CR_NO IS '채팅방번호';
COMMENT ON COLUMN CHATROOM.CR_NAME IS '채팅방이름';
COMMENT ON COLUMN CHATROOM.CREATE_DATE IS '생성일자';
COMMENT ON COLUMN CHATROOM.STATUS IS '상태(Y/N)';
COMMENT ON COLUMN CHATROOM.SELLER IS '셀러회원번호(관리자일경우문의)';
COMMENT ON COLUMN CHATROOM.BUYER IS '바이어회원번호';
/*채팅방번호 발생시킬 시퀀스*/
CREATE SEQUENCE SEQ_CNO
NOCACHE;


CREATE TABLE MESSAGE (
	MESSAGE_NO	NUMBER	NOT NULL,
	CR_NO	NUMBER	NOT NULL,
	USER_NO	NUMBER	NOT NULL,
    M_CONTENT	VARCHAR2(100)	NOT NULL,
	CREATE_DATE	DATE DEFAULT SYSDATE	NOT NULL,
	M_CHECK	VARCHAR2(1) DEFAULT 'N'	NOT NULL
);
COMMENT ON COLUMN MESSAGE.MESSAGE_NO IS '메세지번호';
COMMENT ON COLUMN MESSAGE.CR_NO IS '참조채팅방번호';
COMMENT ON COLUMN MESSAGE.USER_NO IS '보낸회원번호';
COMMENT ON COLUMN MESSAGE.M_CONTENT IS '메세지내용';
COMMENT ON COLUMN MESSAGE.CREATE_DATE IS '작성일자';
COMMENT ON COLUMN MESSAGE.M_CHECK IS '확인여부(Y/N)';
/*메세지번호 발생시킬 시퀀스*/
CREATE SEQUENCE SEQ_MNO
NOCACHE;


CREATE TABLE MATE (
	USER_NO	NUMBER	NOT NULL,
	BOARD_NO	NUMBER	NOT NULL,
	STATUS	VARCHAR2(1)	NOT NULL
);
COMMENT ON COLUMN MATE.USER_NO IS '회원번호';
COMMENT ON COLUMN MATE.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN MATE.STATUS IS '상태값(1:신청,2:수락,3:거절)';


CREATE TABLE B_LIKE (
	BOARD_NO	NUMBER	NOT NULL,
	USER_NO	NUMBER	NOT NULL
);
COMMENT ON COLUMN B_LIKE.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN B_LIKE.USER_NO IS '회원번호';

/*각 테이블들 PK값*/
ALTER TABLE MEMBER ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	USER_NO
);

ALTER TABLE PET ADD CONSTRAINT PK_PET PRIMARY KEY (
	USER_NO
);

ALTER TABLE BOARD ADD CONSTRAINT PK_BOARD PRIMARY KEY (
	BOARD_NO
);

ALTER TABLE CATEGORY ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (
	CATEGORY_NO
);

ALTER TABLE SAVE ADD CONSTRAINT PK_SAVE PRIMARY KEY (
	USER_NO,
	BOARD_NO
);

ALTER TABLE ATTACHMENT ADD CONSTRAINT PK_ATTACHMENT PRIMARY KEY (
	FILE_NO
);

ALTER TABLE REPLY ADD CONSTRAINT PK_REPLY PRIMARY KEY (
	REPLY_NO
);

ALTER TABLE CHATROOM ADD CONSTRAINT PK_CHATROOM PRIMARY KEY (
	CR_NO
);

ALTER TABLE MESSAGE ADD CONSTRAINT PK_MESSAGE PRIMARY KEY (
	MESSAGE_NO
);

ALTER TABLE B_LIKE ADD CONSTRAINT PK_LIKE PRIMARY KEY (
	BOARD_NO,
	USER_NO
);

/* 식별제약조건 */
ALTER TABLE PET ADD CONSTRAINT FK_MEMBER_TO_PET_1 FOREIGN KEY (
	USER_NO
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE SAVE ADD CONSTRAINT FK_MEMBER_TO_SAVE_1 FOREIGN KEY (
	USER_NO
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE SAVE ADD CONSTRAINT FK_BOARD_TO_SAVE_1 FOREIGN KEY (
	BOARD_NO
)
REFERENCES BOARD (
	BOARD_NO
);

ALTER TABLE B_LIKE ADD CONSTRAINT FK_BOARD_TO_LIKE_1 FOREIGN KEY (
	BOARD_NO
)
REFERENCES BOARD (
	BOARD_NO
);

ALTER TABLE B_LIKE ADD CONSTRAINT FK_MEMBER_TO_LIKE_1 FOREIGN KEY (
	USER_NO
)
REFERENCES MEMBER (
	USER_NO
);

/* 비식별제약조건 */
ALTER TABLE BOARD ADD CONSTRAINT FK_CATEGORY_TO_BOARD_1 FOREIGN KEY (
	BOARD_CATEGORY
)
REFERENCES CATEGORY (
	CATEGORY_NO
);

ALTER TABLE BOARD ADD CONSTRAINT FK_MEMBER_TO_BOARD_1 FOREIGN KEY (
	BOARD_WRITER
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE ATTACHMENT ADD CONSTRAINT FK_BOARD_TO_ATTACHMENT_1 FOREIGN KEY (
	REF_BNO
)
REFERENCES BOARD (
	BOARD_NO
);

ALTER TABLE ATTACHMENT ADD CONSTRAINT FK_MEMBER_TO_ATTACHMENT_1 FOREIGN KEY (
	REF_MNO
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE REPLY ADD CONSTRAINT FK_BOARD_TO_REPLY_1 FOREIGN KEY (
	REF_BNO
)
REFERENCES BOARD (
	BOARD_NO
);

ALTER TABLE REPLY ADD CONSTRAINT FK_MEMBER_TO_REPLY_1 FOREIGN KEY (
	REPLY_WRITER
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE CHATROOM ADD CONSTRAINT FK_MEMBER_TO_CHATROOM_1 FOREIGN KEY (
	SELLER
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE CHATROOM ADD CONSTRAINT FK_MEMBER_TO_CHATROOM_2 FOREIGN KEY (
	BUYER
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE MESSAGE ADD CONSTRAINT FK_CHATROOM_TO_MESSAGE_1 FOREIGN KEY (
	CR_NO
)
REFERENCES CHATROOM (
	CR_NO
);

ALTER TABLE MESSAGE ADD CONSTRAINT FK_MEMBER_TO_MESSAGE_1 FOREIGN KEY (
	USER_NO
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE MATE ADD CONSTRAINT FK_MEMBER_TO_MATE_1 FOREIGN KEY (
	USER_NO
)
REFERENCES MEMBER (
	USER_NO
);

ALTER TABLE MATE ADD CONSTRAINT FK_BOARD_TO_MATE_1 FOREIGN KEY (
	BOARD_NO
)
REFERENCES BOARD (
	BOARD_NO
);





