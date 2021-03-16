2021-03-12-01)
--PL/SQL의 종류 : 발리가려면 뻐스타고 가자
/*
Package : 패키지
User function : 사용자 정의 함수
Stored procedure : 저장 프로그램
Trigger : 트리거
Anonymous block : 익명의 블록


CURSOR 속성

%ISOPEN : 커서가 열린 상태면 TRUE
%NOTFOUND : SQL실행 후 데이터가 없으면 TRUE
%FOUND : SQL실행 후 데이터가 있을때 TRUE
%ROWCOUNT : 행의 수
*/


**FOR문과 CURSOR
사용예) 사원테이블에서 부서번호 90번 부서에 속하 직원정보를 출력하시오
    ALIAS는 사원번호, 사원명, 입사일

/
DESC EMPLOYEES;--테이블의 자료형확인
/
SET SERVEROUTPUT;--DVMS켜기
/
DECLARE
    --SCALAR변수
    V_ID VARCHAR2(30);
    V_NAME VARCHAR2(60);
    V_DATE DATE;
    
    --REFERENCE 변수 = NUMBER(6)
    V_DID  EMPLOYEES.DEPARTMENT_ID%TYPE;
    
    CURSOR CUR IS--커서 선언
    SELECT EMPLOYEE_ID 사원번호 
         , EMP_NAME 사원명
         , HIRE_DATE 입사일
         , DEPARTMENT_ID 부서번호
    FROM   EMPLOYEES
    WHERE  DEPARTMENT_ID = 90;
BEGIN
    --커서에 대한 메모리 할당 및 정보를 저장 (바인드)
    OPEN CUR;
    --패따찍
    LOOP
        FETCH CUR INTO V_ID, V_NAME, V_DATE, V_DID;
        --커서가 안보이면 나간다
        EXIT WHEN CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_ID || V_NAME || ', ' || V_DATE || V_DID);
    END LOOP;
    CLOSE CUR;--커서를 닫고 버퍼용으로 사용중이 메모리를 반환
END;
/


사용예)회원의 마일리지 현황을 출력하기, 단 직업이 주부인 회원만 출력
    ALIAS : MEM_NAME, MEM_MILEAGE
    정렬 : MEM_NAME 오름차순
/
DESC MEMBER;
/
DECLARE
    --SCALAR변수
    M_NAME VARCHAR2(15);
    --REFERENCE 변수 = NUMBER(6);
    M_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
    CURSOR CUR IS--커서 선언
            
        SELECT  MEM_NAME AS 회원이름, 
                NVL(MEM_MILEAGE,0) AS 마일리지--널바라
        FROM    MEMBER
        WHERE   MEM_JOB = '주부'
        ORDER   BY 1;
BEGIN
    --커서에 대한 메모리 할당 및 정보를 저장 (바인드)
    OPEN CUR;
    --패따찍
    LOOP
        FETCH CUR INTO M_NAME, M_MILEAGE;
        
        EXIT WHEN CUR%NOTFOUND;--커서가 안보이면 나간다
        DBMS_OUTPUT.PUT_LINE(M_NAME || M_MILEAGE);
    END LOOP;
    --커서를 닫고 버퍼용으로 사용중이 메모리를 반환
    CLOSE CUR;
END;


(FOR문 사용)
DECLARE
    CURSOR CUR IS--커서 선언
            
        SELECT  MEM_NAME , 
                NVL(MEM_MILEAGE,0) MEM_MILEAGE --널바라
        FROM    MEMBER
        WHERE   MEM_JOB = '주부'
        ORDER   BY 1;
BEGIN
   FOR CUR_REC IN CUR LOOP
   --SYSTEM.OUP.PRINTLN();
    DBMS_OUTPUT.PUT(CUR%ROWCOUNT || '번째행');
    DBMS_OUTPUT.PUT_LINE(CUR_REC.MEM_NAME || ', '|| CUR_REC.MEM_MILEAGE);
   END LOOP;
END;


(FOR문 사용 코드줄이기)

BEGIN
   FOR CUR_REC IN (  SELECT  MEM_NAME , 
                     NVL(MEM_MILEAGE,0) MEM_MILEAGE--널바라
                     FROM    MEMBER
                     WHERE   MEM_JOB = '주부'
                     ORDER   BY 1) LOOP
   --SYSTEM.OUP.PRINTLN();
    DBMS_OUTPUT.PUT_LINE(CUR_REC.MEM_NAME || ', '|| CUR_REC.MEM_MILEAGE);
   END LOOP;
END;
/
SET SERVEROUTPUT ON;
/
--직업을 입력받아서 FOR LOOP를 이용하는 CURSOR
--FOR사용
ACCEPT P_JOB PROMPT '직업을 입력하세요:'
DECLARE
    V_NAME VARCHAR2(30);
    V_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
CURSOR MEMBER_CUR IS
    SELECT  MEM_NAME,
            MEM_MILEAGE
    FROM    MEMBER
    WHERE   MEM_JOB = '&P_JOB';
BEGIN
    FOR MEMBER_CUR IN ( SELECT  MEM_NAME,
                                MEM_MILEAGE
                        FROM    MEMBER
                        WHERE   MEM_JOB = '&P_JOB')
    OPEN MEMBER_CUR;
    
        FETCH MEMBER_CUR INTO V_NAME, V_MILEAGE;
        EXIT WHEN MEMBER_CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(MEMBER_CUR%ROWCOUNT || '번째' || V_NAME || ', ' || V_MILEAGE);
    END LOOP;
    CLOSE MEMBER_CUR;
END;

(FOR문 사용)

ACCEPT P_JOB PROMPT '직업을 입력하세요:'
BEGIN
    FOR MEMBER_CUR IN ( SELECT  MEM_NAME,
                                MEM_MILEAGE
                        FROM    MEMBER
                        WHERE   MEM_JOB = '&P_JOB')LOOP
    DBMS_OUTPUT.PUT_LINE(MEMBER_CUR.MEM_NAME || ', ' || MEMBER_CUR.MEM_MILEAGE);                        
    END LOOP;
END;