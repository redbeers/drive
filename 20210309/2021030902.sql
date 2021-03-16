2021-03-09-02)SEQUENCE ��ü
    -���������� �����ϴ� ������ �߻�
    -�ٸ� DBMS(MYSQL, SQL_SERVER ��)������ AUTO INCREMENT �� ����
    -���̺� ���������� ���
    -�⺻Ű�� �����ϱ⿡ �������÷��� ���� ���,
     ������ ������ �ʿ��� ���(�Խ����� �۹�ȣ ��)�� �ַ� ���
(�������)
CREATE SEQUENCE ��������

--������ʹ� �ɼ�
    [START WITH n]
    [INCREMENT BY n]
    [MAXVALUE n|NOMAXVALUE]
    [MINVALUE n|NOMINVALUE]
    [CYCLE|NOCYCLE]
    [CACHE|NOCACHE]
    [ORDER|NOORDER]
--������� �ɼ�

. START WITH n : ���۰�, �⺻���� �����϶� MINVALUE, �����϶� MAXVALUE
. INCREMENT BY n : ������
. MAXVALUE n : �ִ�(default�� 10^27��),'nomaxvalue'�� �⺻
. MINVALUE n : �ּҰ�(default�� 1),'NOMINVALUE'�� �⺻
. CYCLE : �ִ� �Ǵ� �ּҰ� ������ �ٽ� ����(default MOCYCLE)
. CACHE : �޸𸮿� �̸� �����Ͽ� �Ҵ����� ����(default �� CACHE 20)
. ORDER : ��û�� ������� ������ ����(default �� NOORDER)(���)��ŵ�� �ڷ�� �ٽû���� �Ұ���

(�������� ���)
------------------------------------------------------------------------------
�ǻ��÷�(PSEUDO COLUMN) �ǹ�
------------------------------------------------------------------------------
��������.NEXTVAL        ��������ü�� ���� �� ��ȯ
��������.CURRVAL        ��������ü�� ���� �� ��ȯ
**�������� ������ �� ù ��° ����� '��������.NEXTVAL'�� ����Ǿ�� ��
  �� ��������.CURRVAL�� �ش� ���ǿ��� ��������.NEXTVAL�� �ּҷ� ���� 
  �� ������ ������ �� �ִ�.
  
��뿹)��ǰ�з����̺�(LPROD)�� ���� �ڷḦ �߰��Ͻÿ�
    ��, ����(LPROD_ID)�� SEQUENCE�� �����Ͽ� ����Ͻÿ�
    �з��ڵ� : 'p501'
    �з���  : '�ӻﹰ'
    
    �з��ڵ� : 'p502'
    �з���  : '���깰'
    
    �з��ڵ� : 'p503'
    �з���  : '��깰'

SELECT MAX(LPROD_ID) FROM LPROD; 
(������ ����)
CREATE  SEQUENCE SEQ_LPROD
START   WITH 10;

INSERT INTO LPROD
VALUES(SEQ_LPROD.NEXTVAL,'p501','�ӻ깰');

INSERT INTO LPROD
VALUES(SEQ_LPROD.CURRVAL,'p502','���깰');

INSERT INTO LPROD
VALUES(SEQ_LPROD.NEXTVAL,'p503','��깰');


SELECT * FROM LPROD;

SELECT SEQ_LPROD.CURRVAL FROM DUAL;