2021-03-12-01)
--PL/SQL�� ���� : �߸������� ����Ÿ�� ����
/*
Package : ��Ű��
User function : ����� ���� �Լ�
Stored procedure : ���� ���α׷�
Trigger : Ʈ����
Anonymous block : �͸��� ���


CURSOR �Ӽ�

%ISOPEN : Ŀ���� ���� ���¸� TRUE
%NOTFOUND : SQL���� �� �����Ͱ� ������ TRUE
%FOUND : SQL���� �� �����Ͱ� ������ TRUE
%ROWCOUNT : ���� ��
*/


**FOR���� CURSOR
��뿹) ������̺��� �μ���ȣ 90�� �μ��� ���� ���������� ����Ͻÿ�
    ALIAS�� �����ȣ, �����, �Ի���

/
DESC EMPLOYEES;--���̺��� �ڷ���Ȯ��
/
SET SERVEROUTPUT;--DVMS�ѱ�
/
DECLARE
    --SCALAR����
    V_ID VARCHAR2(30);
    V_NAME VARCHAR2(60);
    V_DATE DATE;
    
    --REFERENCE ���� = NUMBER(6)
    V_DID  EMPLOYEES.DEPARTMENT_ID%TYPE;
    
    CURSOR CUR IS--Ŀ�� ����
    SELECT EMPLOYEE_ID �����ȣ 
         , EMP_NAME �����
         , HIRE_DATE �Ի���
         , DEPARTMENT_ID �μ���ȣ
    FROM   EMPLOYEES
    WHERE  DEPARTMENT_ID = 90;
BEGIN
    --Ŀ���� ���� �޸� �Ҵ� �� ������ ���� (���ε�)
    OPEN CUR;
    --�е���
    LOOP
        FETCH CUR INTO V_ID, V_NAME, V_DATE, V_DID;
        --Ŀ���� �Ⱥ��̸� ������
        EXIT WHEN CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_ID || V_NAME || ', ' || V_DATE || V_DID);
    END LOOP;
    CLOSE CUR;--Ŀ���� �ݰ� ���ۿ����� ������� �޸𸮸� ��ȯ
END;
/


��뿹)ȸ���� ���ϸ��� ��Ȳ�� ����ϱ�, �� ������ �ֺ��� ȸ���� ���
    ALIAS : MEM_NAME, MEM_MILEAGE
    ���� : MEM_NAME ��������
/
DESC MEMBER;
/
DECLARE
    --SCALAR����
    M_NAME VARCHAR2(15);
    --REFERENCE ���� = NUMBER(6);
    M_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
    CURSOR CUR IS--Ŀ�� ����
            
        SELECT  MEM_NAME AS ȸ���̸�, 
                NVL(MEM_MILEAGE,0) AS ���ϸ���--�ιٶ�
        FROM    MEMBER
        WHERE   MEM_JOB = '�ֺ�'
        ORDER   BY 1;
BEGIN
    --Ŀ���� ���� �޸� �Ҵ� �� ������ ���� (���ε�)
    OPEN CUR;
    --�е���
    LOOP
        FETCH CUR INTO M_NAME, M_MILEAGE;
        
        EXIT WHEN CUR%NOTFOUND;--Ŀ���� �Ⱥ��̸� ������
        DBMS_OUTPUT.PUT_LINE(M_NAME || M_MILEAGE);
    END LOOP;
    --Ŀ���� �ݰ� ���ۿ����� ������� �޸𸮸� ��ȯ
    CLOSE CUR;
END;


(FOR�� ���)
DECLARE
    CURSOR CUR IS--Ŀ�� ����
            
        SELECT  MEM_NAME , 
                NVL(MEM_MILEAGE,0) MEM_MILEAGE --�ιٶ�
        FROM    MEMBER
        WHERE   MEM_JOB = '�ֺ�'
        ORDER   BY 1;
BEGIN
   FOR CUR_REC IN CUR LOOP
   --SYSTEM.OUP.PRINTLN();
    DBMS_OUTPUT.PUT(CUR%ROWCOUNT || '��°��');
    DBMS_OUTPUT.PUT_LINE(CUR_REC.MEM_NAME || ', '|| CUR_REC.MEM_MILEAGE);
   END LOOP;
END;


(FOR�� ��� �ڵ����̱�)

BEGIN
   FOR CUR_REC IN (  SELECT  MEM_NAME , 
                     NVL(MEM_MILEAGE,0) MEM_MILEAGE--�ιٶ�
                     FROM    MEMBER
                     WHERE   MEM_JOB = '�ֺ�'
                     ORDER   BY 1) LOOP
   --SYSTEM.OUP.PRINTLN();
    DBMS_OUTPUT.PUT_LINE(CUR_REC.MEM_NAME || ', '|| CUR_REC.MEM_MILEAGE);
   END LOOP;
END;
/
SET SERVEROUTPUT ON;
/
--������ �Է¹޾Ƽ� FOR LOOP�� �̿��ϴ� CURSOR
--FOR���
ACCEPT P_JOB PROMPT '������ �Է��ϼ���:'
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
        DBMS_OUTPUT.PUT_LINE(MEMBER_CUR%ROWCOUNT || '��°' || V_NAME || ', ' || V_MILEAGE);
    END LOOP;
    CLOSE MEMBER_CUR;
END;

(FOR�� ���)

ACCEPT P_JOB PROMPT '������ �Է��ϼ���:'
BEGIN
    FOR MEMBER_CUR IN ( SELECT  MEM_NAME,
                                MEM_MILEAGE
                        FROM    MEMBER
                        WHERE   MEM_JOB = '&P_JOB')LOOP
    DBMS_OUTPUT.PUT_LINE(MEMBER_CUR.MEM_NAME || ', ' || MEMBER_CUR.MEM_MILEAGE);                        
    END LOOP;
END;