2021-03-11-04)
3)FOR문
    .반복횟수를 알고 있거나 반복횟수가 중요한 역활을 수행할 때 사용
(사용형식_1)
FOR 인덱스 IN(REVERSE] 초기값..최종값
LOOP
    반복처리문(들);
END LOOP;
    -'인덱스'는 시스템에서 자동 설정해줌(선언하지 않음)
    -역순으로 처리할때는 'REVERSE'만 추가 기술
     (초기, 최종값 기술 위치 변동없음)
사용예) 구구단의 4단 출력
DECLARE
    V_BASE NUMBER:=4;
BEGIN
    FOR CNT IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_BASE||'*'||CNT||'*'||V_BASE*CNT);
    END LOOP;
END;

(사용형식_2)
FOR 레코드 IN 커서명[(값LIST)]
LOOP
    반복처리문(들);
END LOOP;
    -커서의 컬럼을 참조할때는 '레코드명.컬럼명'으로 참조
    -OPEN, FETCH, CLOSE문 생략
    
    
사용예)LOOP문으로 구현한 커서문을 WHILE문으로 재구성하시오
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
        DBMS_OUTPUT.PUT_LINE('순 번: '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('제품명:'||REC_BUY01.PROD_NAME);
        DBMS_OUTPUT.PUT_LINE('매입수량:'||REC_BUY01.SQTY);
        DBMS_OUTPUT.PUT_LINE('매입금액:'||REC_BUY01.SAMT);
        DBMS_OUTPUT.PUT_LINE('----------------');
    END LOOP;
END;