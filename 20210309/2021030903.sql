2021-03-09-03)���Ǿ� (SYNONYM)��ü
    -����Ŭ���� ���Ǵ� ��ü�� �ο��Ǵ� ������ �̸�
    -�÷���Ī�� ���̺� ��Ī���� �������� ���Ǿ�� ������ ������
    -�� ���ڿ��� ������ ���̺�� ���� ��ġ�� ���ڿ� ����
    ��)�ٸ� ������ ���̺� ���ٽ� '��Ű����.��ü��'���� �����ؾ���
    ->�̰�� '��Ű����.��ü��'�� ���ܾ�� �����Ͽ� ���
    EX)DUAL���̺��� SYS���� ������ ���̺��̱⶧���� DUAL���̺�
    ����� FULL NAME�� SYS.DUAL�̴�.
    SELECT SYSDATE FROM SYS.DUAL;--���糯¥���
(�������)
CREATE OR REPLACE [PUBLIC] SYNONYM ���Ǿ��̸�
FOR    ��ü��;
.'PUBLIC' : ���� ���Ǿ� ����

��뿹)
CREATE OR REPLACE SYNONYM DT FOR DEPARTMENTS;
CREATE OR REPLACE SYNONYM EM FOR EMPLOYEES;

SELECT  A.EMP_NAME AS �����,
        A.SALARY AS �޿�,
        B.DEPARTMENT_NAME AS �μ���
FROM    EP A, DT B
WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND     A.SALARY >= 15000;

SELECT * FROM DT
WHERE PARENT_ID IS NULL;

CREATE OR REPLACE SYNONYM MD FOR SYS.DUAL;

SELECT SYSDATE FROM MD;