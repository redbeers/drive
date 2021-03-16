2021-03-05-01)
�񿬰� ����������)�μ����̺��� �����μ���ȣ(parent_id)�� null�� �μ��� ����
��������� ��ȸ�Ͻÿ�
alias�� �����ȣ, �����, �ҼӺμ���ȣ,�μ���

[��������:�μ����̺�� ������̺��� ��������� ��ȸ]
select A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        A.DEPARTMENT_ID AS �ҼӺμ���ȣ,
        B.DEPARTMENT_NAME AS �μ���
FROM    EMPLOYEES A, DEPARTMENRS B
WHERE   A.DEPARTMENT_ID=(��������)

[�������: �����μ���ȣ(PARENT_ID)�� NULL�� �μ���ȣ
SELECT DEPARTMENT_ID
FROM    DEPARTMENTS
WHERE   PARENT_ID IS NULL;

[����]
select A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        A.DEPARTMENT_ID AS �ҼӺμ���ȣ,
        B.DEPARTMENT_NAME AS �μ���
FROM    EMPLOYEES A, DEPARTMENTS B
WHERE   A.DEPARTMENT_ID=B.DEPARTMEN_ID
AND     A.DEPARTMENT_ID=(SELECT DEPARTMENT_ID
                        FROM    DEPARTMENTS
                        WHERE   PARENT_ID IS NULL);
                        
��뿹)������̺�� �����̷� ���̺�(JOB_HISTORY)���� ���� �����ȣ�� �����ڵ带 
    �����ִ� ��������� ��ȸ�Ͻÿ�
    ALIAS�� �����ȣ, �����, �����ڵ�
    
[��������:������̺��� �����ȣ, �����, �����ڵ� ���]
SELECT  EMPLOYEE_ID AS �����ȣ, 
        EMP_NAME AS �����, 
        JOB_ID AS �����ڵ�
FROM    EMPLOYEES
WHERE   (EMPLOYEE_ID,JOB_ID)=(��������)

[��������:�����̷����̺�(JOB_HISTORY)���� �����ȣ�� �����ڵ� ���]
SELECT EMPLOYEE_ID, JOB_ID
FROM    JOB_HISTORY

[����]
SELECT  EMPLOYEE_ID AS �����ȣ, 
        EMP_NAME AS �����, 
        JOB_ID AS �����ڵ�
FROM    EMPLOYEES
WHERE   (EMPLOYEE_ID,JOB_ID)=ANY(  
                                SELECT EMPLOYEE_ID, JOB_ID
                                FROM    JOB_HISTORY
                              );
                              
                              
��俹)ȸ�����̺� ������� 3���� ���� ȸ���忢 ��ȸ������ ��ո��ϸ����� 10%�� �߰������Ϸ��Ѵ�. �̸� �����Ͻÿ�

[��������:ȸ�����̺��� 3���� ���� ȸ������ ���ϸ�������]
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

[��������:ȸ�����̺��� ������� 3���� ���� ȸ���� ��� ���ϸ���]
SELECT ROUND(AVG(MEM_HILEAGE)*0.1)
FROM    MEMBER
WHERE   EXTRACT(MONTH FROM MEM_MEMORIALDAY)=EXTRACT(MONTH FORM SYSDATE);

���� ���ǿ� �´� ������ ���̺��� �����Ͻÿ�
    1)���̺��:REMAIN
    2)�÷�
========================================================
  �÷���           ������Ÿ��           �������
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

��)
����]���������̺�(PEMAIN)�� �ʱ��ڷḦ �Է��Ͻÿ�
    �ʱ��ڷ�� ��ǰ���̺��� �ڷḦ �̿��Ͽ� �Է��Ұ�
    ���⵵ : 2005��
    ��ǰ�ڵ� : ��ǰ���̺��� ��ǰ�ڵ�
    ������� : ��ǰ���̺��� �������(PROD_PROPERSTOCK)
    ���� : 2004/12/31
[���̴���:���������̺� �ڷ� ����]

[��������:��ǰ���̺��� ��ǰ�ڵ�,������� �˻�]
INSERT INTO REMAIN(REMAIN_YEAR,REMAIN_PROD,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
SELECT '2005',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20041231')
FROM    PROD;

SELECT*FROM REMAIN;

SELECT PROD_ID,PROD_PROPERSTOCK
FROM PROD;