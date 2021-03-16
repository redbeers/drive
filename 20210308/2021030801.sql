2021-03-08-01)
3.단일형 서브쿼리
    -서브쿼리의 결과가 1개의 생으로 구성된경우
    -관계연산자가 사용된경우(조건)
    
사용예)회원테이블에서 회원의 평균 마일리지보다 많은 마일리지를 보유한 회원정보
        ALIAS는 회원번호, 회원명, 마일리지, 평균마일리지

SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_MILEAGE AS 마일리지, 
        (SELECT ROUND(AVG(MEM_MILEAGE))
         FROM   MEMBER) AS 평균마일리지        
FROM    MEMBER
WHERE   MEM_MILEAGE >= (SELECT AVG(MEM_MILEAGE)
                        FROM MEMBER);
                        
사용예)SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_MILEAGE AS 마일리지, 
        (SELECT ROUND(AVG(MEM_MILEAGE))
         FROM   MEMBER) AS 평균마일리지        
FROM    MEMBER
WHERE   MEM_MILEAGE >= (SELECT SUM(MEM_MILEAGE)
                        FROM MEMBER);
 모든 회원별 구매현황을 조회하시오
    ALIAS는 회원번호, 회원명, 구매수량합계, 구매금액합계
SELECT  B.MEM_ID AS 회원번호, 
        B.MEM_NAME AS 회원명, 
        NVL(D.SQTY ,0) AS 구매수량합계, 
        NVL(D.SAMT ,0) AS 구매금액합계
FROM    MEMBER B ,(SELECT   CART_MEMBER AS DID,
                            SUM(CART_QTY) AS SQTY,
                            SUM(CART_QTY*PROD_PRICE) AS SAMT
                    FROM    CART, PROD
                    WHERE   CART_PROD=PROD_ID
                    AND     CART_NO LIKE '200506%'
                    GROUP   BY CART_MEMBER)D
WHERE   B.MEM_ID = D.DID(+);

서브쿼리 : 2005년 6월 회원별 구매현황)
SELECT CART_MEMBER,
        SUM(CART_QTY) AS SQTY,
        SUM(CART_QTY*PROD_PRICE) AS SAMT
FROM    CART, PROD
WHERE   CART_PROD=PROD_ID
AND     CART_NO LIKE '200506%'
GROUP   BY CART_MEMBER;

4.다중행 서브쿼리
    -복수개의 결과를 반환하는 서브쿼리
    -IN, ANY, EXISTS 등의 연산자의 결합
사용예)사원테이블에서 2007년 이후에 입사한 사원중 2005년도에 입사한 사원들의 
    최저 급여보다 더 많은 급여를 받는 사원을 조회하시오
    ALIAS는 사원번호, 사원명, 입사일, 급여, 직책명

SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        A.HIRE_DATE AS 입사일, 
        A.SALARY AS 급여, 
        B.JOB_TITLE AS 직책명
FROM    EMPLOYEES A, JOBS B
WHERE   A.HIRE_DATE >= TO_DATE('20070101')
AND     A.SALARY >= ANY (SELECT SALARY 
                         FROM   EMPLOYEES
                         WHERE  EXTRACT(YEAR FROM HIRE_DATE)=2004)
AND     A.JOB_ID=B.JOB_ID;

(EXISTS 연산자 사용)
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        A.HIRE_DATE AS 입사일, 
        A.SALARY AS 급여, 
        B.JOB_TITLE AS 직책명
FROM    EMPLOYEES A, JOBS B
WHERE   A.HIRE_DATE >= TO_DATE('20070101')
AND     EXISTS (SELECT 1
                FROM   EMPLOYEES B
                WHERE  EXTRACT(YEAR FROM HIRE_DATE)=2004
                AND    A.SALARY >= B.SALARY)
AND     A.JOB_ID=B.JOB_ID;

문제)부서테이블과 사원테이블을 이용하여 다음문제를 해결하시오
    상위부서(PARENT_ID)가 90번 부서에 속한 하위부서 속한 직원중 본인이 속한
    부서의 평균급여보다 많으 급여를 지급 받는 사원정보 조회
    ALIAS는 사원번호, 사원명, 부서번호, 부서명, 평균급여
    단, INLINE SUBQUERY로 작성하시오

(별도의 테이블)
SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        D.DID AS 부서번호, 
        D.BU AS 부서명, 
        D.AV AS 평균급여
FROM    EMPLOYEES A,(SELECT  B.DEPARTMENT_ID AS DID,
                            B.DEPARTMENT_NAME AS BU,
                            ROUND(AVG(A.SALARY))AS AV
                    FROM    EMPLOYEES A, DEPARTMENTS B
                    WHERE   B.PARENT_ID = 90
                    AND     A.DEPARTMENT_ID = B.DEPARTMENT_ID
                    GROUP   BY B.DEPARTMENT_NAME,B.DEPARTMENT_ID)D
WHERE   D.AV <= SALARY
AND     A.DEPARTMENT_ID = DID


        
SELECT  B.DEPARTMENT_NAME AS DID,
        ROUND(AVG(A.SALARY))
FROM    EMPLOYEES A, DEPARTMENTS B
WHERE   B.PARENT_ID = 90
AND     A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP   BY B.DEPARTMENT_NAME

