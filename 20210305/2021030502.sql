2021-03-05-02)
2.������ �ִ� ��������
  - ���������� ���Ǵ� ���̺�� ���������� ���� ���̺��� JOIN���� �����
    ��������
��)�����̷����̺�(JOB_HISTORY)�� �����ϴ� �μ��� ��ȸ�Ͻÿ�
  Alias�� �μ��ڵ�, �μ����̴�. 
[��������:�μ����̺��� �μ��ڵ�, �μ��� ���]
SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID = (��������) 
 
[��������:�����̷����̺�(JOB_HISTORY)���� �μ� ��ȸ) 
SELECT DEPARTMENT_ID
  FROM JOB_HISTORY; 
  
[����:EXISTS������ ���]
SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT B.DEPARTMENT_ID
                 FROM JOB_HISTORY B
                WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID); 
 
SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM JOB_HISTORY B
                WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID);   
                
[IN �Ǵ� ANY���� ���]
SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                             FROM JOB_HISTORY B);   
                             
SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
       A.DEPARTMENT_NAME AS �μ���
  FROM DEPARTMENTS A
 WHERE A.DEPARTMENT_ID =ANY (SELECT B.DEPARTMENT_ID
                             FROM JOB_HISTORY B);  
                             
��)�����̷����̺��� �ڷḦ ��ȸ�Ͽ� ������ ����Ͻÿ�.
   Alias �����ȣ,�����,�μ���,������
SELECT A.EMPLOYEE_ID AS �����ȣ,
       (SELECT B.EMP_NAME 
          FROM EMPLOYEES B
         WHERE B.EMPLOYEE_ID=A.EMPLOYEE_ID) AS �����,
       (SELECT C.DEPARTMENT_NAME 
          FROM DEPARTMENTS C
         WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID) AS �μ���,
       (SELECT D.JOB_TITLE 
          FROM JOBS D
         WHERE D.JOB_ID=A.JOB_ID) AS  ������
  FROM JOB_HISTORY A;
  
��)������̺��� ������ ���� �μ��� ��� �޿����� �� ���� �޿��� �޴�
   ������� ��ȸ�Ͻÿ�.
   Alias�� �����ȣ,�����,�μ���,�μ���ձ޿�,����Ǳ޿�
SELECT TBLA.EMPLOYEE_ID AS �����ȣ,
       TBLA.EMP_NAME AS  �����,
       TBLA.DEPARTMENT_ID AS �μ��ڵ�,
       TBLB.DNAME AS �μ���,
       TBLB.DAVG AS �μ���ձ޿�,
       TBLA.SALARY AS ����Ǳ޿�
  FROM EMPLOYEES TBLA, (SELECT B.DEPARTMENT_ID AS DID,
                               C.DEPARTMENT_NAME AS DNAME,
                               ROUND(AVG(B.SALARY),1) AS DAVG
                          FROM EMPLOYEES B, DEPARTMENTS C 
                         WHERE C.DEPARTMENT_ID=B.DEPARTMENT_ID
                         GROUP BY B.DEPARTMENT_ID,C.DEPARTMENT_NAME) TBLB 
 WHERE TBLA.SALARY > TBLB.DAVG
   AND TBLA.DEPARTMENT_ID = TBLB.DID
 ORDER BY 3;
   
   
��)������� ���� �μ��� ��� �޿����� �� ���� �޿��� �޴� ����� �����ϴ� �μ��ڵ��
   �μ����� ����Ͻÿ�
SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
       A.DEPARTMENT_NAME AS �μ���   
  FROM DEPARTMENTS A
 WHERE EXISTS (SELECT 1
                 FROM EMPLOYEES B
                WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                  AND B.SALARY > (SELECT AVG(C.SALARY)
                                    FROM EMPLOYEES C
                                   WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID));
                                   
������ �ִ� ���������� �̿��� �ڷ� ����
������ 2005�� 1�� 31���̶�� �����ϰ� �������̺��� �����Ͽ� ���������̺��� UPDATE
�Ͻÿ�.
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
   
                             
                             