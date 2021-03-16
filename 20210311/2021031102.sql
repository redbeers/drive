2021-03-11-02) 반복문과 커서
1.반복문
    -LOOP,WHILE,FOR문이 제공
    -기본 구조는 LOOP문
    1)LOOP문
    .무한 루프를 수행하는 반복문
    .EXIT문을 사용하여 반복을 멈출수 있음
    .자바의 DO문과 유사
(사용형식)
LOOP
반복처리문(들);
    [EXIT WHEN 조건;]
END LOOP;
    -'EXIT WHEN 조건' :조건이 참인 경우 반복을 탈출
    
예)구구단의 4단을 LOOP문을 이용하여 출력
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

예)1~50사이에 존재하는 FIBONACCI NUMBER를 출력하시오
첫 째, 둘째 값은 1,1로 주어지고 그 다음 부터 전 두수의 합이 현재수가 됨
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


***PL/SQL에서 반복문은 주로 커서를 사용할때 사용
CURSOR
    .SQLDML DML명령으로 영향받은 형의 집합
    .묵시적커서와 명시적 커서가 존재
    (1)묵시적커서
    -사용자가SELECT문을 수행시켰을때 생성되는 커서
    -이름이 없음
    -항상 CLOSE상태임(내부 데이터 접근 불가능)
    커서속성
    SQL%FOUND:커서 내에 자료(행)가 존재하면 참을 반환
    SQL%NOTFOUND:커서 내에 사료(행)가 존재하지 않으면 참을 반환
    SQL%ISOPEN:커서가 OPEN되어있으면 참을 반환(항상 FALSE)
    SQL%ROWCOUNT:커서집합내에 레코드(행)의 수반환
    (2)명시적커서
    -사요자가 커서명을 부여하여 선언한 경우 발생
    -선언영역(DECLARE)에서 선언
    -커서의 사용은 4단계(생성(선언)->OPEN->FETCH->CLOSE)로 수행되어야 함
    (가)커서의 생성(선언)
    .선언부에서 기술
(사용형식)
    CURSOR 커서명[(매개변수 LIST)]
    IS
        SELECT 문;
        -'매개변수LIST':SELECT문에서 사용될 변수로 OPEN문에서 값을 배정함
사용예)2005년6월 상품을 구매한 고객LIST를 출력하는 커서작성
    고객LIST는 고객번호, 고객명, 주소, 전화번호
(작동안한다)
DECLARE
    CURSOR CUR_CART02(P_PERIOD VARCHAR2)
    IS
        SELECT  DISTINCT CART_MEMBER
        FROM    CART
        WHERE   CART_NO LIKE P_PERIOD||'%';
BEGIN

END;

(나)커서의 OPEN
.명시적 커서의 사용을 위해 커서를 반드시 OPEN애햐함
.BEGIN BLOCK에서 수행
(사용예)
OPEN커서명[(값LIST)]
-'값LIST' : CURSOR 선언부에 전달될 값

DECLARE
    CURSOR CUR_CART02(P_PERIOD VARCHAR2)
    IS
        SELECT  DISTINCT CART_MEMBER
        FROM    CART
        WHERE   CART_NO LIKE P_PERIOD||'%';
BEGIN
    OPEN CUR_CART02('200506');

END;
/ --/를 만나면 위에 쿼리를 실행하라

(다)FETCH
    .커서집합내에 존재하는 데이터를 행단위로 읽어옴
    .첫 레코드 부터 마지막 레코드까지 자동으로 읽어옴
(사용형식)
FETCH 커서명 INTO 변수명;
-커서에 존재하는 열의 값을 '변수'에 할당
-'변수'는 선언부에서 선언되야함

(사용예)
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
    DBMS_OUTPUT.PUT_LINE('회원번호 이  름  주소                          전화번호');
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

(라)CLOSE
    .사용이 종료된 커서를 닫음
    .CLOSE되지 않은 커서는 재 OPEN 될수 없음
(사용형식)
CLOSE 커서명;
사용예)2005년 3월 제품별 입고현황을 출력하는 커서를 작성하시오
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
        DBMS_OUTPUT.PUT_LINE('순 번: '||CUR_BUYPROD02%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('제품명:'||V_NAME);
        DBMS_OUTPUT.PUT_LINE('매입수량:'||V_AQTY);
        DBMS_OUTPUT.PUT_LINE('매입금액:'||V_AMON);
        DBMS_OUTPUT.PUT_LINE('----------------');
    END LOOP;
    CLOSE CUR_BUYPROD02;
END;

