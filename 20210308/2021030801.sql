2021-03-08-01)
3.������ ��������
    -���������� ����� 1���� ������ �����Ȱ��
    -���迬���ڰ� ���Ȱ��(����)
    
��뿹)ȸ�����̺��� ȸ���� ��� ���ϸ������� ���� ���ϸ����� ������ ȸ������
        ALIAS�� ȸ����ȣ, ȸ����, ���ϸ���, ��ո��ϸ���

SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_MILEAGE AS ���ϸ���, 
        (SELECT ROUND(AVG(MEM_MILEAGE))
         FROM   MEMBER) AS ��ո��ϸ���        
FROM    MEMBER
WHERE   MEM_MILEAGE >= (SELECT AVG(MEM_MILEAGE)
                        FROM MEMBER);
                        
��뿹)SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_MILEAGE AS ���ϸ���, 
        (SELECT ROUND(AVG(MEM_MILEAGE))
         FROM   MEMBER) AS ��ո��ϸ���        
FROM    MEMBER
WHERE   MEM_MILEAGE >= (SELECT SUM(MEM_MILEAGE)
                        FROM MEMBER);
 ��� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, ���ż����հ�, ���űݾ��հ�
SELECT  B.MEM_ID AS ȸ����ȣ, 
        B.MEM_NAME AS ȸ����, 
        NVL(D.SQTY ,0) AS ���ż����հ�, 
        NVL(D.SAMT ,0) AS ���űݾ��հ�
FROM    MEMBER B ,(SELECT   CART_MEMBER AS DID,
                            SUM(CART_QTY) AS SQTY,
                            SUM(CART_QTY*PROD_PRICE) AS SAMT
                    FROM    CART, PROD
                    WHERE   CART_PROD=PROD_ID
                    AND     CART_NO LIKE '200506%'
                    GROUP   BY CART_MEMBER)D
WHERE   B.MEM_ID = D.DID(+);

�������� : 2005�� 6�� ȸ���� ������Ȳ)
SELECT CART_MEMBER,
        SUM(CART_QTY) AS SQTY,
        SUM(CART_QTY*PROD_PRICE) AS SAMT
FROM    CART, PROD
WHERE   CART_PROD=PROD_ID
AND     CART_NO LIKE '200506%'
GROUP   BY CART_MEMBER;

4.������ ��������
    -�������� ����� ��ȯ�ϴ� ��������
    -IN, ANY, EXISTS ���� �������� ����
��뿹)������̺��� 2007�� ���Ŀ� �Ի��� ����� 2005�⵵�� �Ի��� ������� 
    ���� �޿����� �� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�
    ALIAS�� �����ȣ, �����, �Ի���, �޿�, ��å��

SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        A.HIRE_DATE AS �Ի���, 
        A.SALARY AS �޿�, 
        B.JOB_TITLE AS ��å��
FROM    EMPLOYEES A, JOBS B
WHERE   A.HIRE_DATE >= TO_DATE('20070101')
AND     A.SALARY >= ANY (SELECT SALARY 
                         FROM   EMPLOYEES
                         WHERE  EXTRACT(YEAR FROM HIRE_DATE)=2004)
AND     A.JOB_ID=B.JOB_ID;

(EXISTS ������ ���)
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        A.HIRE_DATE AS �Ի���, 
        A.SALARY AS �޿�, 
        B.JOB_TITLE AS ��å��
FROM    EMPLOYEES A, JOBS B
WHERE   A.HIRE_DATE >= TO_DATE('20070101')
AND     EXISTS (SELECT 1
                FROM   EMPLOYEES B
                WHERE  EXTRACT(YEAR FROM HIRE_DATE)=2004
                AND    A.SALARY >= B.SALARY)
AND     A.JOB_ID=B.JOB_ID;

����)�μ����̺�� ������̺��� �̿��Ͽ� ���������� �ذ��Ͻÿ�
    �����μ�(PARENT_ID)�� 90�� �μ��� ���� �����μ� ���� ������ ������ ����
    �μ��� ��ձ޿����� ���� �޿��� ���� �޴� ������� ��ȸ
    ALIAS�� �����ȣ, �����, �μ���ȣ, �μ���, ��ձ޿�
    ��, INLINE SUBQUERY�� �ۼ��Ͻÿ�

(������ ���̺�)
SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        D.DID AS �μ���ȣ, 
        D.BU AS �μ���, 
        D.AV AS ��ձ޿�
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

