2021-03-11-03)
2)WHILE��
    .�������α׷� ���߾���� WHILE�� ����
(�������)
WHILE ���� LOOP
    �ݺ�ó����(��);
END LOOP;
    -'����'�� ��� FALSE�� ��� �ݺ��� ���
��뿹) �������� 4���� ����Ͻÿ�
DECLARE
    V_CNT NUMBER:=0;
BEGIN
    WHILE V_CNT <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('4*'||V_CNT||'='||4*V_CNT);
        V_CNT:=V_CNT+1;
    END LOOP;
END;

��뿹)LOOP������ ������ Ŀ������ WHILE������ �籸���Ͻÿ�
DECLARE 
    V_ID PROD.PROD_ID%TYPE;
    V_NAME PROD.PROD_NAME%TYPE;
    V_AQTY NUMBER:=0;
    V_AMON NUMBER:=0;
    CURSOR CUR_BUYPROD02
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
    FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;--SQL�� �ش��ڷᰡ �ִ��� Ȯ���ؾ� ����� ���డ���ϴ�
    WHILE CUR_BUYPROD02%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('�� ��: '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('��ǰ��:'||V_NAME);
        DBMS_OUTPUT.PUT_LINE('���Լ���:'||V_AQTY);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||V_AMON);
        DBMS_OUTPUT.PUT_LINE('----------------');
        FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;
    END LOOP;
    CLOSE CUR_BUYPROD02;
END;

�غ���] ù���� 100��, �ι�°�����ʹ� ������ 2�辿 �������Ϸ��Ѵ�
    ���ʷ� 100������ �Ѵ� ���� ��ĥ°�̰� �׳����� ������ �׼��� ���Ͻÿ�
    LOOP�� WHILE������ �����Ұ�)

(����� 2�� ��)
(LOOP ����)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_RES||'��'||V_CNT||'��');--����Ʈ�κ�
        V_RES:=V_RES+1;
        V_CNT:=V_CNT+(V_CNT*2);
        EXIT WHEN V_CNT >= 1000000;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('���ʷ� 100������ �Ѵ� ���� '||V_RES||'��°�̰� �׳����� ������ �׼��� '||V_CNT||'�� �̴�.');--����Ʈ�κ�
END;

(LOOP,WHILE ����)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
BEGIN
    WHILE V_CNT <= 1000000 LOOP
        DBMS_OUTPUT.PUT_LINE(V_RES||'��'||V_CNT||'��');--����Ʈ�κ�
        V_RES:=V_RES+1;
        V_CNT:=V_CNT+(V_CNT*2);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('���ʷ� 100������ �Ѵ� ���� '||V_RES||'��°�̰� �׳����� ������ �׼��� '||V_CNT||'�� �̴�.');--����Ʈ�κ�
END;



(�������� 2�� ��)
(LOOP ����)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
    V_HAM NUMBER:=100;
BEGIN
    LOOP
        EXIT WHEN V_HAM >= 1000000;
        DBMS_OUTPUT.PUT_LINE(V_RES||'��'||v_HAM||'��');--����Ʈ�κ�
        V_CNT := (V_CNT*2);
        V_HAM := V_HAM + V_CNT;
        V_RES:=V_RES+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('���ʷ� 100������ �Ѵ� ���� '||V_RES||'��°�̰� �׳����� ������ �׼��� '||v_HAM||'�� �̴�.');--����Ʈ�κ�
END;

(LOOP,WHILE ����)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
    V_HAM NUMBER:=100;
BEGIN
    WHILE V_HAM <= 1000000 LOOP
          DBMS_OUTPUT.PUT_LINE(V_RES||'��'||v_HAM||'��');--����Ʈ�κ�
        V_CNT := (V_CNT*2);
        V_HAM := V_HAM + V_CNT;
        V_RES:=V_RES+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('���ʷ� 100������ �Ѵ� ���� '||V_RES||'��°�̰� �׳����� ������ �׼��� '||v_HAM||'�� �̴�.');--����Ʈ�κ�
END;

