2021-03-11-03)
2)WHILE문
    .응용프로그램 개발언어의 WHILE과 유사
(사용형식)
WHILE 조건 LOOP
    반복처리문(들);
END LOOP;
    -'조건'의 결곽 FALSE인 경우 반복을 벗어남
사용예) 구구단의 4단을 출력하시오
DECLARE
    V_CNT NUMBER:=0;
BEGIN
    WHILE V_CNT <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('4*'||V_CNT||'='||4*V_CNT);
        V_CNT:=V_CNT+1;
    END LOOP;
END;

사용예)LOOP문으로 구현한 커서문을 WHILE문으로 재구성하시오
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
    FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;--SQL은 해당자료가 있는지 확인해야 명령을 수행가능하다
    WHILE CUR_BUYPROD02%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('순 번: '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('제품명:'||V_NAME);
        DBMS_OUTPUT.PUT_LINE('매입수량:'||V_AQTY);
        DBMS_OUTPUT.PUT_LINE('매입금액:'||V_AMON);
        DBMS_OUTPUT.PUT_LINE('----------------');
        FETCH CUR_BUYPROD02 INTO V_ID, V_NAME, V_AQTY, V_AMON;
    END LOOP;
    CLOSE CUR_BUYPROD02;
END;

해보기] 첫날에 100원, 두번째날부터는 전날의 2배씩 저축을하려한다
    최초로 100만원을 넘는 날은 몇칠째이고 그날까지 저축한 액수를 구하시오
    LOOP와 WHILE문으로 구성할것)

(결과의 2배 합)
(LOOP 연산)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_RES||'일'||V_CNT||'원');--프린트부분
        V_RES:=V_RES+1;
        V_CNT:=V_CNT+(V_CNT*2);
        EXIT WHEN V_CNT >= 1000000;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('최초로 100만원을 넘는 날은 '||V_RES||'일째이고 그날까지 저축한 액수는 '||V_CNT||'원 이다.');--프린트부분
END;

(LOOP,WHILE 형식)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
BEGIN
    WHILE V_CNT <= 1000000 LOOP
        DBMS_OUTPUT.PUT_LINE(V_RES||'일'||V_CNT||'원');--프린트부분
        V_RES:=V_RES+1;
        V_CNT:=V_CNT+(V_CNT*2);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('최초로 100만원을 넘는 날은 '||V_RES||'일째이고 그날까지 저축한 액수는 '||V_CNT||'원 이다.');--프린트부분
END;



(가진돈의 2배 합)
(LOOP 연산)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
    V_HAM NUMBER:=100;
BEGIN
    LOOP
        EXIT WHEN V_HAM >= 1000000;
        DBMS_OUTPUT.PUT_LINE(V_RES||'일'||v_HAM||'원');--프린트부분
        V_CNT := (V_CNT*2);
        V_HAM := V_HAM + V_CNT;
        V_RES:=V_RES+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('최초로 100만원을 넘는 날은 '||V_RES||'일째이고 그날까지 저축한 액수는 '||v_HAM||'원 이다.');--프린트부분
END;

(LOOP,WHILE 형식)
DECLARE
    V_CNT NUMBER:=100;
    V_RES NUMBER:=1;
    V_HAM NUMBER:=100;
BEGIN
    WHILE V_HAM <= 1000000 LOOP
          DBMS_OUTPUT.PUT_LINE(V_RES||'일'||v_HAM||'원');--프린트부분
        V_CNT := (V_CNT*2);
        V_HAM := V_HAM + V_CNT;
        V_RES:=V_RES+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('최초로 100만원을 넘는 날은 '||V_RES||'일째이고 그날까지 저축한 액수는 '||v_HAM||'원 이다.');--프린트부분
END;

