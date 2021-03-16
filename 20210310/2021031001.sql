2021-03-10-01)
4)�ε��� �������
CREATE  [UNIQUE|BITMAP]INDEX �ε�����
ON      ���̺��(�÷���1[,�÷���2,...][ABC|DESC]);
      .'���̺�'�� '�÷�'���� �������� ��������(ASC)�Ǵ� ��������(DESC)
        ���� �ε��� ����.(�⺻�� ASC��)
        NULL���� ������ �ִ� ������ �ϳ��� �������ִ�.
        �ε������� IDX�� ����Ѵ�
        
��뿹)������̺��� ������� �������� �ε����� �����Ͻÿ�
CREATE  INDEX IDX_EMP01
ON      EMPLOYEES(EMP_NAME);

CREATE  INDEX IDX_MEM01
ON      MEMBER(SUBSTR(MEM_REGNO2,4));

CREATE  INDEX IDX_KOR_LOAN
ON      KOR_LOAN_STATUS(PERIOD, REGION);

(�ε��� Ȱ��X)
SELECT * 
FROM    KOR_LOAN_STATUS
WHERE   PERIOD='201111'; --�ε��� ���� ȿ���� ���� ����

(�ε���Ȱ��)
SELECT * 
FROM    KOR_LOAN_STATUS
WHERE   PERIOD='201111'
AND     REGION IN('�泲','����','����');

5)�ε����� �籸��
    -�������� ����, ����, ������ �߻��ϸ� �ε����� �� ������
    -�籸���� WORK SPACE�� ����ǰų� �������� ���Ի����� �ټ� �߻��� ����
     REBUILD ������� ����
(�������)
ALTER INDEX �ε����� REBUILD;
(��뿹)
ALTER INDEX IDX_KOR_LOAN REBUILD;