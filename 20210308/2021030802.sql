2021-03-08-02)���տ�����
    -�����̷п��� �����ϴ� ������(UNION, UNION ALL).������(INTERSECT),
     ������(MINUS)������ ����
    -(�������)
    SELECT �÷�LIST
    FROM    ���̺��
    WHERE   ����
    
UNION|UNION ALL|INTERSECT|MINUS

    SELECT �÷�LIST
    FROM    ���̺��
    WHERE   ����
            :
    .�� SELECT���� �÷��� ������ ������TYPE�� ���ƾ� ��
    .ORDER BY ���� �� ������ SELECT �������� ��� ����
    .CLOB, BLOB, BFILE ���� ���Ұ�
    .����� ������ ù ��° SELECT ����

1.UNION, UNION ALL
    -�������� ��� ��ȯ
    -UNION : �ߺ����� ���� ��� ��ȯ
    -UNION ALL : �ߺ��� ���� ��ȯ
    
��뿹)2005�� 4���� 6���� ��� �Ǹŵ� ��ǰ������ �ߺ������ʰ� ��ȸ�Ͻÿ�
    ALIAS�� ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�
    
(2005�� 4���� �Ǹ޻�ǰ ��ȸ)
SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200504%'

--INTERSECT--�Ⱓ���� �ȸ���ǰ
MINUS--�������� �����Ѵ�
--UNION --�ߺ������ʴ´�.
--UNION ALL--�ߺ��ȴ�.
--(2005�� 6���� �Ǹ޻�ǰ ��ȸ)
SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200506%'
ORDER   BY 1;

1.MINUS(������)
    -A MINUS B : ���� A���� ���� B������ ��Ҹ� ������ ��� ��ȯ
    -A MINUS A : ���� B���� A������ ��Ҹ� ������ �����ȯ

��뿹)2005��4���� �ǸŵȻ�ǰ�� 6�� �Ǹŵ� ��ǰ���� ��ȸ
    ALIAS �� ��ǰ�ڵ�, ��ǳ��
SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200506%'

--INTERSECT--�Ⱓ���� �ȸ���ǰ
MINUS--���� �Ǹŵȹ���
--UNION --�ߺ������ʴ´�.
--UNION ALL--�ߺ��ȴ�.
--(2005�� 6���� �Ǹ޻�ǰ ��ȸ)
SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200504%'
ORDER   BY 1;




SELECT  A.CART_PROD AS ��ǰ�ڵ�, 
        B.PROD_NAME AS ��ǰ��
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '200506%'
AND     B.PROD_ID = A.CART_PROD

--INTERSECT--�Ⱓ���� �ȸ���ǰ
--MINUS--���� �Ǹŵȹ���
UNION --�ߺ������ʴ´�.
--UNION ALL--�ߺ��ȴ�.
--(2005�� 6���� �Ǹ޻�ǰ ��ȸ)
SELECT  B.LPROD_GU AS �з��ڵ�, 
        B.LPROD_NM AS �з���
FROM    LPROD B
ORDER   BY 1;

