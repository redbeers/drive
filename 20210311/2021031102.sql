2021-03-11-02) �ݺ����� Ŀ��
1.�ݺ���
    -LOOP,WHILE,FOR���� ����
    -�⺻ ������ LOOP��
    1)LOOP��
    .���� ������ �����ϴ� �ݺ���
    .EXIT���� ����Ͽ� �ݺ��� ����� ����
    .�ڹ��� DO���� ����
(�������)
LOOP
�ݺ�ó����(��);
    [EXIT WHEN ����;]
END LOOP;
    -'EXIT WHEN ����' :������ ���� ��� �ݺ��� Ż��
    
��)�������� 4���� LOOP���� �̿��Ͽ� ���
DECLARE
    V_BASE NUMBER:=4;
    V_CNT NUMBER:=0;
    V_RES NUMBER:=0;
BEGIN
    LOOP
        V_CNT:=V_CNT+1;
        EXIT WHEN V_CNT > 9;
        V_RES:=V_BASE*V_CNT;
        
        DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||V_CNT||'='||V_RES);
    END LOOP;
END;

��)1~50���̿� �����ϴ� FIBONACCI NUMBER�� ����Ͻÿ�
ù °, ��° ���� 1,1�� �־����� �� ���� ���� �� �μ��� ���� ������� ��
DECLARE
    PP_NUM NUMBER:=1;
    P_NUM  NUMBER:=1;
    C_NUM  NUMBER:=0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(PP_NUM);
    DBMS_OUTPUT.PUT_LINE(P_NUM);
    LOOP
    C_NUM:=PP_NUM+P_NUM;
    EXIT WHEN C_NUM > 50;
    DBMS_OUTPUT.PUT_LINE(C_NUM);
    PP_NUM:=P_NUM;
    P_NUM:=C_NUM;
    END LOOP;
END;


***PL/SQL���� �ݺ����� �ַ� Ŀ���� ����Ҷ� ���
CURSOR
    .SQLDML DML������� ������� ���� ����
    .������Ŀ���� ����� Ŀ���� ����
    (1)������Ŀ��
    -����ڰ�SELECT���� ����������� �����Ǵ� Ŀ��
    -�̸��� ����
    -�׻� CLOSE������(���� ������ ���� �Ұ���)
    Ŀ���Ӽ�
    SQL%FOUND:Ŀ�� ���� �ڷ�(��)�� �����ϸ� ���� ��ȯ
    SQL%NOTFOUND:Ŀ�� ���� ���(��)�� �������� ������ ���� ��ȯ
    SQL%ISOPEN:Ŀ���� OPEN�Ǿ������� ���� ��ȯ(�׻� FALSE)
    SQL%ROWCOUNT:Ŀ�����ճ��� ���ڵ�(��)�� ����ȯ
    (2)�����Ŀ��
    -����ڰ� Ŀ������ �ο��Ͽ� ������ ��� �߻�
    -���𿵿�(DECLARE)���� ����
    -Ŀ���� ����� 4�ܰ�(����(����)->OPEN->FETCH->CLOSE)�� ����Ǿ�� ��
    (��)Ŀ���� ����(����)
    .����ο��� ���
(�������)
    CURSOR Ŀ����[(�Ű����� LIST)]
    IS
        SELECT ��;
        -'�Ű�����LIST':SELECT������ ���� ������ OPEN������ ���� ������
��뿹)2005��6�� ��ǰ�� ������ ��LIST�� ����ϴ� Ŀ���ۼ�
    ��LIST�� ����ȣ, ����, �ּ�, ��ȭ��ȣ
(�۵����Ѵ�)
DECLARE
    CURSOR CUR_CART02(P_PERIOD VARCHAR2)
    IS
        SELECT  DISTINCT CART_MEMBER
        FROM    CART
        WHERE   CART_NO LIKE P_PERIOD||'%';
BEGIN

END;

(��)Ŀ���� OPEN
.����� Ŀ���� ����� ���� Ŀ���� �ݵ�� OPEN������
.BEGIN BLOCK���� ����
(��뿹)
OPENĿ����[(��LIST)]
-'��LIST' : CURSOR ����ο� ���޵� ��

DECLARE
    CURSOR CUR_CART02(P_PERIOD VARCHAR2)
    IS
        SELECT  DISTINCT CART_MEMBER
        FROM    CART
        WHERE   CART_NO LIKE P_PERIOD||'%';
BEGIN
    OPEN CUR_CART02('200506');

END;
/ --/�� ������ ���� ������ �����϶�

(��)FETCH
    .Ŀ�����ճ��� �����ϴ� �����͸� ������� �о��
    .ù ���ڵ� ���� ������ ���ڵ���� �ڵ����� �о��
(�������)
FETCH Ŀ���� INTO ������;
-Ŀ���� �����ϴ� ���� ���� '����'�� �Ҵ�
-'����'�� ����ο��� ����Ǿ���

(��뿹)
DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(200);
    V_TEL MEMBER.MEM_HP%TYPE;
    CURSOR CUR_CART02(P_PERIOD VARCHAR2)
    IS
        SELECT  DISTINCT CART_MEMBER
        FROM    CART
        WHERE   CART_NO LIKE P_PERIOD||'%';
BEGIN
    OPEN  CUR_CART02('200506');
    DBMS_OUTPUT.PUT_LINE('ȸ����ȣ ��  ��  �ּ�                          ��ȭ��ȣ');
    LOOP  
    FETCH CUR_CART02 INTO V_ID;
    EXIT WHEN CUR_CART02%NOTFOUND;
    SELECT MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_HP INTO
           V_NAME,V_ADDR,V_TEL
    FROM MEMBER
    WHERE MEM_ID = V_ID;
    DBMS_OUTPUT.PUT_LINE(V_ID||'    '||V_NAME||'  '||V_ADDR||'     '||V_TEL);
    END LOOP;
    CLOSE CUR_CART02;
END;

(��)CLOSE
    .����� ����� Ŀ���� ����
    .CLOSE���� ���� Ŀ���� �� OPEN �ɼ� ����
(�������)
CLOSE Ŀ����;
��뿹)2005�� 3�� ��ǰ�� �԰���Ȳ�� ����ϴ� Ŀ���� �ۼ��Ͻÿ�
DECLARE 
    V_ID PROD.PROD_ID%TYPE;
    V_NAME PROD.PROD_NAME%TYPE;
    V_AQTY NUMBER:=0;
    V_AMON NUMBER:=0;
    CURSOR CUR_BUYPOD02
    IS
    SELECT  BUY_PROD,
            PROD_NAME,
            SUM(BUY_QTY),
            SUM(BUY_QTY*PROD_COST)
    FROM    BUYPROD, PROD
    WHERE   PROD_ID=BUY_PROD
    AND     BUY_DATE BETWEEN '20050301' AND '20050331'
    GROUP   BY BUY_PROD,PROD_NAME;
BEGIN
    OPEN CUR_BUYPROD02;
    LOOP
        FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;
        EXIT WHEN CUR_BUYPOD02%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('�� ��: '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('��ǰ��:'||V_NAME);
        DBMS_OUTPUT.PUT_LINE('���Լ���:'||V_AQTY);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||V_AMON);
        DBMS_OUTPUT.PUT_LINE('----------------');
    END LOOP;
    CLOSE CUR_BUYPROD02;
END;

