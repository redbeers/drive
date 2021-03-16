2021-03-09-02)SEQUENCE 객체
    -순차적으로 증가하는 정수를 발생
    -다른 DBMS(MYSQL, SQL_SERVER 등)에서는 AUTO INCREMENT 로 제공
    -테이블에 독립적으로 사용
    -기본키로 설정하기에 적합한컬럼이 없는 경우,
     순차적 순번이 필요한 경우(게시판의 글번호 등)에 주로 사용
(사용형식)
CREATE SEQUENCE 시퀀스명

--여기부터는 옵션
    [START WITH n]
    [INCREMENT BY n]
    [MAXVALUE n|NOMAXVALUE]
    [MINVALUE n|NOMINVALUE]
    [CYCLE|NOCYCLE]
    [CACHE|NOCACHE]
    [ORDER|NOORDER]
--여기까지 옵션

. START WITH n : 시작값, 기본값을 증가일때 MINVALUE, 감소일때 MAXVALUE
. INCREMENT BY n : 증감값
. MAXVALUE n : 최대(default는 10^27임),'nomaxvalue'가 기본
. MINVALUE n : 최소값(default는 1),'NOMINVALUE'가 기본
. CYCLE : 최대 또는 최소값 도달후 다시 시작(default MOCYCLE)
. CACHE : 메모리에 미리 생성하여 할당할지 여부(default 는 CACHE 20)
. ORDER : 요청한 순서대로 생성을 보증(default 는 NOORDER)(명령)스킵한 자료는 다시사용이 불가능

(시퀀스의 사용)
------------------------------------------------------------------------------
의사컬럼(PSEUDO COLUMN) 의미
------------------------------------------------------------------------------
시퀀스명.NEXTVAL        시퀀스객체의 다음 값 반환
시퀀스명.CURRVAL        시퀀스객체의 다음 값 반환
**시퀀스가 생성된 후 첫 번째 명령은 '시퀀스명.NEXTVAL'이 수행되어야 함
  즉 시퀀스명.CURRVAL은 해당 세션에서 시퀀스명.NEXTVAL가 최소로 수행 
  된 수에만 참조될 수 있다.
  
사용예)상품분류테이블(LPROD)에 다음 자료를 추가하시오
    단, 순번(LPROD_ID)은 SEQUENCE를 생성하여 사용하시오
    분류코드 : 'p501'
    분류명  : '임삼물'
    
    분류코드 : 'p502'
    분류명  : '수산물'
    
    분류코드 : 'p503'
    분류명  : '농산물'

SELECT MAX(LPROD_ID) FROM LPROD; 
(시퀀스 생성)
CREATE  SEQUENCE SEQ_LPROD
START   WITH 10;

INSERT INTO LPROD
VALUES(SEQ_LPROD.NEXTVAL,'p501','임산물');

INSERT INTO LPROD
VALUES(SEQ_LPROD.CURRVAL,'p502','수산물');

INSERT INTO LPROD
VALUES(SEQ_LPROD.NEXTVAL,'p503','농산물');


SELECT * FROM LPROD;

SELECT SEQ_LPROD.CURRVAL FROM DUAL;