2021-03-05-01)
비연관 서브쿼리예)부서테이블에서 상위부서번호(parent_id)가 null인 부서에 속한
사원정보를 조회하시오
alias는 사원번호, 사원명, 소속부서번호,부서명

[메인쿼리:부서테이블과 사원테이블에서 사원정보를 조회]
select A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        A.DEPARTMENT_ID AS 소속부서번호,
        B.DEPARTMENT_NAME AS 부서명
FROM    EMPLOYEES A, DEPARTMENRS B
WHERE   A.DEPARTMENT_ID=(서브쿼리)

[사브쿼리: 사위부서번호(PARENT_ID)가 NULL인 부서번호
SELECT DEPARTMENT_ID
FROM    DEPARTMENTS
WHERE   PARENT_ID IS NULL;

[결합]
select A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        A.DEPARTMENT_ID AS 소속부서번호,
        B.DEPARTMENT_NAME AS 부서명
FROM    EMPLOYEES A, DEPARTMENTS B
WHERE   A.DEPARTMENT_ID=B.DEPARTMEN_ID
AND     A.DEPARTMENT_ID=(SELECT DEPARTMENT_ID
                        FROM    DEPARTMENTS
                        WHERE   PARENT_ID IS NULL);
                        
사용예)사원테이블과 직무이력 테이블(JOB_HISTORY)에서 같은 사원번호와 직무코드를 
    갖고있는 사원정보를 조회하시오
    ALIAS는 사원번호, 사원명, 직무코드
    
[메인쿼리:사원테이블에서 사원번호, 사원명, 직무코드 출력]
SELECT  EMPLOYEE_ID AS 사원번호, 
        EMP_NAME AS 사원명, 
        JOB_ID AS 직무코드
FROM    EMPLOYEES
WHERE   (EMPLOYEE_ID,JOB_ID)=(서브쿼리)

[서브쿼리:직무이력테이블(JOB_HISTORY)에서 사원번호와 직무코드 출력]
SELECT EMPLOYEE_ID, JOB_ID
FROM    JOB_HISTORY

[결합]
SELECT  EMPLOYEE_ID AS 사원번호, 
        EMP_NAME AS 사원명, 
        JOB_ID AS 직무코드
FROM    EMPLOYEES
WHERE   (EMPLOYEE_ID,JOB_ID)=ANY(  
                                SELECT EMPLOYEE_ID, JOB_ID
                                FROM    JOB_HISTORY
                              );
                              
                              
사요예)회원테이블엣 기념일이 3월에 속한 회원드엑 그회원드의 평균마일리지의 10%를 추가지급하려한다. 이를 수행하시오

[메인쿼리:회원테이블의 3월에 속한 회원들의 마일리지변경]
UPDATE MEMBER
SET     MEM_MILEAGE=MEM_MILEAGE+(
                    SELECT  ROUND (AVG(MEM_HILEAGE)*0.1)
                    FROM    MEMBER
                    WHERE   EXTRACT(MONTHH FROM MEM_MEMORIALDAY)=
                            EXTRACT(MONTH FORM SYSDATE)=
WHERE WCTRACT(MONTH FROM MEM_MEMORIALDAY(=EXTRACT(MONTH FROM SYSDATE);

SELECT MEM_NAME, MEM_MILEAGE
FROM    MEMBER
WHERE   EXTRACT(MONTH FROM MEM_MEMOIALDAY)EXTRACT(MONTH FROM SYSDATE);

[서브쿼리:회원테이블에서 기념일이 3월에 속한 회원들 평균 마일리지]
SELECT ROUND(AVG(MEM_HILEAGE)*0.1)
FROM    MEMBER
WHERE   EXTRACT(MONTH FROM MEM_MEMORIALDAY)=EXTRACT(MONTH FORM SYSDATE);

다음 조건에 맞는 재고수별 테이블을 생성하시오
    1)테이블명:REMAIN
    2)컬럼
========================================================
  컬럼명           데이터타입           제약사항
========================================================
REMAIN_YEAR       CHAR(4)           PK
REMAIN_PROD       VARCHAR2(10)      PK/FK
REMAIN_J_00       NUMBER(5)         DEFAULT 0
REMAIN_I          NUMBER(5)         DEFAULT 0
REMAIN_O          NUMBER(5)         DEFAULT 0
REMAIN_J_99       NUMBER(5)         DEFAULT 0
REMAIN_DATE       DATE

CREATE TABLE REMAIN(
REMAIN_YEAR       CHAR(4)           ,
REMAIN_PROD       VARCHAR2(10)      ,
REMAIN_J_00       NUMBER(5)         DEFAULT 0,
REMAIN_I          NUMBER(5)         DEFAULT 0,
REMAIN_O          NUMBER(5)         DEFAULT 0,
REMAIN_J_99       NUMBER(5)         DEFAULT 0,
REMAIN_DATE       DATE,
CONSTRAINT PK_REMAIN PRIMARY KEY(REMAIN_YEAR, REMAIN_PROD),
CONSTRAINT FK_REMAIN_PROD FOREIGN KEY(REMAIN_PROD)
REFERENCES PROD(PROD_ID));

예)
문제]재고수불테이블(PEMAIN)에 초기자료를 입력하시오
    초기자료는 상품테이블의 자료를 이용하여 입력할것
    재고년도 : 2005년
    상품코드 : 상품테이블의 상품코드
    기초재고 : 상품테이블의 적정재고량(PROD_PROPERSTOCK)
    일자 : 2004/12/31
[메이눠리:재고수불테이블에 자료 삽입]

[서브쿼리:상품테이블에서 삼품코드,적정재고량 검색]
INSERT INTO REMAIN(REMAIN_YEAR,REMAIN_PROD,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
SELECT '2005',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20041231')
FROM    PROD;

SELECT*FROM REMAIN;

SELECT PROD_ID,PROD_PROPERSTOCK
FROM PROD;