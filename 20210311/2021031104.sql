2021-03-11-04)
3)FOR��
    .�ݺ�Ƚ���� �˰� �ְų� �ݺ�Ƚ���� �߿��� ��Ȱ�� ������ �� ���
(�������_1)
FOR �ε��� IN(REVERSE] �ʱⰪ..������
LOOP
    �ݺ�ó����(��);
END LOOP;
    -'�ε���'�� �ý��ۿ��� �ڵ� ��������(�������� ����)
    -�������� ó���Ҷ��� 'REVERSE'�� �߰� ���
     (�ʱ�, ������ ��� ��ġ ��������)
��뿹) �������� 4�� ���
DECLARE
    V_BASE NUMBER:=4;
BEGIN
    FOR CNT IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||CNT||'*'||V_BASE*CNT);
    END LOOP;
END;

(�������_2)
FOR ���ڵ� IN Ŀ����[(��LIST)]
LOOP
    �ݺ�ó����(��);
END LOOP;
    -Ŀ���� �÷��� �����Ҷ��� '���ڵ��.�÷���'���� ����
    -OPEN, FETCH, CLOSE�� ����
    
    
��뿹)LOOP������ ������ Ŀ������ WHILE������ �籸���Ͻÿ�
DECLARE 
    CURSOR CUR_BUYPROD02
    IS
    SELECT  BUY_PROD,PROD_NAME,
            SUM(BUY_QTY) AS SQTY,
            SUM(BUY_QTY*PROD_COST) AS SAMT
    FROM    BUYPROD, PROD
    WHERE   PROD_ID=BUY_PROD
    AND     BUY_DATE BETWEEN '20050301' AND '20050331'
    GROUP   BY BUY_PROD,PROD_NAME;
BEGIN
    FOR REC_BUY01 IN CUR_BUYPROD02
    LOOP
        DBMS_OUTPUT.PUT_LINE('�� ��: '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('��ǰ��:'||REC_BUY01.PROD_NAME);
        DBMS_OUTPUT.PUT_LINE('���Լ���:'||REC_BUY01.SQTY);
        DBMS_OUTPUT.PUT_LINE('���Աݾ�:'||REC_BUY01.SAMT);
        DBMS_OUTPUT.PUT_LINE('----------------');
    END LOOP;
END;