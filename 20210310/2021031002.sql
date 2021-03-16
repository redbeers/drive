2021-03-10-02)PL/SQL
    -PROCEDUAL LANGUAGE SQL�� ����
    -ǥ�� SQL�� ���α׷��� �帧�� �����ϴ� ��ɰ� �������� �������� ����
    -PL/SQL�� �帧������� ����� �����ϰ� ���� ����� �����ϴ�
     ��� ������ ���α׷��� �������Ͽ� ���డ���� ���·� ������ ����
    -BLOOK ������ ����
    -���ȭ, ĸ��ȭ �������
    -ANONYMOUS BLOOK, SORTOED PROCEDURE, USER DEFINED FUNATION,
     PACKAGE, TRIGGER�� ����

1.ANONYMOUS BLOOK
    -�̸��� �ο����� ���� ���
    -PL/SQL�� �⺻���� ����
(����)
DECLARE
    �����;
BEGIN
    �����;
    [EXCEPTION
      ����ó����;
    ]
END;
.'�����':����, ���, Ŀ�� ����
.'�����':SELCECT, DML ������� ������ �����Ͻ� ���� ó�� ����
.'����ó����':���ܹ߻��� ó���� �� ���

��뿹)Ű����� ȸ����ȣ�� �Է¹޾� ȸ�������� ����ϴ� ����� �ۼ�
    ALIAS�� ȸ����ȣ, ȸ����, ���ϸ���

ACCEPT P_ID PROMPT 'ȸ����ȣ: '
DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_MILE NUMBER(5):=0;
    V_RES VARCHAR2(100);
BEGIN
    SELECT   MEM_ID, MEM_NAME, MEM_MILEAGE INTO V_ID, V_NAME, V_MILE
    FROM     MEMBER
    WHERE    MEM_ID='&P_ID';

V_RES:=V_ID||','||V_NAME||'->'||V_MILE;

DBMS_OUTPUT.PUT_LINE('---------------------------------');
DBMS_OUTPUT.PUT_LINE(V_RES);
DBMS_OUTPUT.PUT_LINE('---------------------------------');
END;

1)����
    -���α׷� ���߾���� ����ȭ ���� ����
    -����ο��� ���
    (�������)
    ������ ������Ÿ��
    ������ ������Ÿ��[(ũ��)][:=�ʱⰪ];
    .������Ÿ�� : ǥ�� SQL���� ����ϴ� ������ Ÿ��, BOOLEAN, PLS_INTEGER,
     BINARY_INTEGER �� ������ ��� ����
    .PLS_INTEGER, BINARY_INTEGER : 4BYTE ����(-214783648 ~ 214783647)
    .������ : �ش����̺��� ��(ROW)�� ��(COLUMN)�� ������ Ÿ�� �� ũ�⸦ ���� 
     ���� ����
     ���̺��.�÷���%TYPE : �÷� ����
     ���̺��%ROWTYPE : �ش� ���̺� ���� ��� ����(�迭 ȿ��)
     .������ ������ �����ϱ��� �ݵ�� �ʱ�ȭ
 2)����
    -���α׷����� ������ �ʴ� ���� ǥ��
    -����� �Ҵ翬������ ����(LEFT VALUE)�� ��� �Ұ�
    (��������)
    ������ CONSTANT ������Ÿ��[(ũ��)]:=�ʱⰪ;
    .�ݵ�� �ʱ�ȭ�� �ʿ�
��뿹)���� �Է¹޾� 2005�� �ش� ���� �������踦 ����ϴ� �͸� ��� �ۼ�
    ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Լ���
(���� �߻� ��Ű��)
ACCEPT P_MONTH PROMPT '��(01~12) : '
DECLARE
    V_CODE PROD.PROD_ID%TYPE;
    V_NAME PROD.PROD_NAME%TYPE;
    V_QTY_AMT NUMBER:=0;
    V_SDATE CONSTANT DATE:=TO_DATE('2005'||'&P_MONTH'||'01');
    V_EDATE CONSTANT DATE:=LAST_DAY(TO_DATE('2005'||'&P_MONTH'||'01'));
BEGIN
    SELECT  BUY_PROD, PROD_NAME, SUM(BUY_QTY) 
    INTO    V_CODE, V_NAME, V_QTY_AMT
    FROM    BUYPROD, PROD
    WHERE   BUY_PROD=PROD_ID
    AND     BUY_DATE BETWEEN V_SDATE AND V_EDATE
    GROUP   BY BUY_PROD, PROD_NAME;
    
    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||V_CODE);
    DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('���Լ��� : '||V_QTY_AMT);
    
    EXCEPTION WHEN OTHERS THEN--�߻��� ���ܸ� �˷��ش�
        DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
END;

(��������)
  ACCEPT P_MONTH PROMPT '��(01~12) : '
    DECLARE
        V_CODE PROD.PROD_ID%TYPE;
        V_NAME PROD.PROD_NAME%TYPE;
        V_QTY_AMT NUMBER:=0;
        CURSOR BUYQTY_CUR(V_SDATE DATE,V_EDATE DATE)
        IS
             SELECT BUY_PROD,PROD_NAME,SUM(BUY_QTY) 
                FROM BUYPROD,PROD
            WHERE BUY_PROD=PROD_ID
                AND BUY_DATE BETWEEN V_SDATE AND V_EDATE
            GROUP BY BUY_PROD,PROD_NAME;
    BEGIN
        OPEN BUYQTY_CUR(TO_DATE('2005'||'&P_MONTH'||'01'),
                                LAST_DAY(TO_DATE('2005'||'&P_MONTH'||'01')));
        LOOP
            FETCH BUYQTY_CUR INTO V_CODE,V_NAME,V_QTY_AMT;
            EXIT WHEN BUYQTY_CUR%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||V_CODE); 
            DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||V_NAME); 
            DBMS_OUTPUT.PUT_LINE('���Լ��� : '||V_QTY_AMT);
            DBMS_OUTPUT.PUT_LINE('---------------------------------');
        END LOOP;
         DBMS_OUTPUT.PUT_LINE('���԰Ǽ� : '||BUYQTY_CUR%ROWCOUNT);  --ROWCOUNT =>��ü ���� �� 
      CLOSE BUYQTY_CUR;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
    END;




3).�б⹮
    -���� IF �� ELSE �� ������ �����ؾ��Ѵ�.
    -���߾���� �б⹮(IF ��)�� ���� ��� ����
    (�������_1)
    IF ���ǽ� THEN
       ��ɹ�_1;
    [ELSE
        ��ɹ�_2];
    END IF;

    (�������_2)
    IF ���ǽ�_1 THEN
       ��ɹ�_1;
    [ELSE ���ǽ�_2 THEN
        ��ɹ�_2];
    END IF;
    
    (�������_3)
    IF ���ǽ�_1 THEN
       IF ���ǽ�_2 THEN
       ��ɹ�_1;
    [ELSE
        ��ɹ�_2];
    END IF;
    
    [ELSIF ���ǽ�_3 THEN
          ��ɹ�_3
    [ELSE
        ��ɹ�_2]];
    END IF;

��뿹)������ �μ��� ���� ����� �޿��� ��ȸ�Ͽ� �� �μ����� ù��° ��ȸ��
    ����� �޿��� 5000�����̸� '���α� ���', 5001~15000�̸�
    '����ӱ� ���', �� �̻��̸� '���ӱ� ���'�� ����Ͻÿ�
DECLARE
    V_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE:=ROUND(DBMS_RANDOM.VALUE(10,110),-1);
    V_EMP_NAME EMPLOYEES.EMP_NAME%TYPE;
    V_SALARY EMPLOYEES.SALARY%TYPE;
    V_MESSAGE VARCHAR2(100);
BEGIN
    SELECT EMP_NAME,SALARY INTO V_EMP_NAME,V_SALARY
    FROM   EMPLOYEES
    WHERE  DEPARTMENT_ID=V_DEPT
    AND    ROWNUM=1;
    IF     V_SALARY <=5000 THEN
           V_MESSAGE:='���ӱ� ���';
    ELSIF
           V_SALARY >= 15000 THEN
           V_MESSAGE:='���ӱ� ���';
    
    END IF;   
           V_MESSAGE:=V_EMP_NAME||' '||V_SALARY||'--->'||V_MESSAGE;
           DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
           
END;