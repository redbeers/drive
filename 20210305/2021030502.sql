2021-03-05-02)
2.연관성 있는 서브쿼리
  - 메인쿼리에 사용되는 테이블과 서브쿼리에 사용된 테이블이 JOIN으로 연결된
    서브쿼리
예)직무이력테이블(JOB_HISTORY)에 존재하는 부서를 조회하시오
  Alias는 부서코드, 부서명이다. 
[메인쿼리:부서테이블에서 부서코드, 부서명 출력]
SELECT A.DEPARTMENT_ID AS 부서코드, 
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID = (서브쿼리) 
 
[서브쿼리:직무이력테이블(JOB_HISTORY)에서 부서 조회) 
SELECT DEPARTMENT_ID
  FROM JOB_HISTORY; 
  
[결합:EXISTS연산자 사용]
SELECT A.DEPARTMENT_ID AS 부서코드, 
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT B.DEPARTMENT_ID
                 FROM JOB_HISTORY B
                WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID); 
 
SELECT A.DEPARTMENT_ID AS 부서코드, 
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM JOB_HISTORY B
                WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID);   
                
[IN 또는 ANY등을 사용]
SELECT A.DEPARTMENT_ID AS 부서코드, 
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                             FROM JOB_HISTORY B);   
                             
SELECT A.DEPARTMENT_ID AS 부서코드, 
       A.DEPARTMENT_NAME AS 부서명
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID =ANY (SELECT B.DEPARTMENT_ID
                             FROM JOB_HISTORY B);  
                             
예)직무이력테이블의 자료를 조회하여 다음을 출력하시오.
   Alias 사원번호,사원명,부서명,직무명
SELECT A.EMPLOYEE_ID AS 사원번호,
       (SELECT B.EMP_NAME 
          FROM EMPLOYEES B
         WHERE B.EMPLOYEE_ID=A.EMPLOYEE_ID) AS 사원명,
       (SELECT C.DEPARTMENT_NAME 
          FROM DEPARTMENTS C
         WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID) AS 부서명,
       (SELECT D.JOB_TITLE 
          FROM JOBS D
         WHERE D.JOB_ID=A.JOB_ID) AS  직무명
  FROM JOB_HISTORY A;
  
예)사원테이블에서 본인이 속한 부서의 평균 급여보다 더 많은 급여를 받는
   사원들을 조회하시오.
   Alias는 사원번호,사원명,부서명,부서평균급여,사원의급여
SELECT TBLA.EMPLOYEE_ID AS 사원번호,
       TBLA.EMP_NAME AS  사원명,
       TBLA.DEPARTMENT_ID AS 부서코드,
       TBLB.DNAME AS 부서명,
       TBLB.DAVG AS 부서평균급여,
       TBLA.SALARY AS 사원의급여
  FROM EMPLOYEES TBLA, (SELECT B.DEPARTMENT_ID AS DID,
                               C.DEPARTMENT_NAME AS DNAME,
                               ROUND(AVG(B.SALARY),1) AS DAVG
                          FROM EMPLOYEES B, DEPARTMENTS C 
                         WHERE C.DEPARTMENT_ID=B.DEPARTMENT_ID
                         GROUP BY B.DEPARTMENT_ID,C.DEPARTMENT_NAME) TBLB 
 WHERE TBLA.SALARY > TBLB.DAVG
   AND TBLA.DEPARTMENT_ID = TBLB.DID
 ORDER BY 3;
   
   
예)사원들이 속한 부서의 평균 급여보다 더 많은 급여를 받는 사원이 존재하는 부서코드와
   부서명을 출력하시오
SELECT A.DEPARTMENT_ID AS 부서코드,
       A.DEPARTMENT_NAME AS 부서명   
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES B
                WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                  AND B.SALARY > (SELECT AVG(C.SALARY)
                                    FROM EMPLOYEES C
                                   WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID));
                                   
연관성 있는 서브쿼리를 이용한 자료 삽입
오늘이 2005년 1월 31일이라고 가정하고 매입테이블을 참조하여 재고수불테이블을 UPDATE
하시오.
UPDATE REMAIN A
   SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
       (SELECT A.REMAIN_I+B.SQTY,A.REMAIN_J_99+B.SQTY,'20050131'
          FROM (SELECT BUY_PROD AS BID,
                       SUM(BUY_QTY) AS SQTY
                  FROM BUYPROD
                 WHERE BUY_DATE BETWEEN '20050101' AND '20050131'
                 GROUP BY BUY_PROD) B
         WHERE B.BID=A.REMAIN_PROD)
 WHERE A.REMAIN_YEAR='2005'
   AND A.REMAIN_PROD IN (SELECT BUY_PROD
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN '20050101' AND '20050131');
   
SELECT * FROM REMAIN;   
   
                             
                             