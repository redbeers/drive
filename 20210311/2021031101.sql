2021-03-11-01
2.case문
    -다중 분기기능 제고
    -java의 dwitch ~ case와 유사
    -표준 sql에서는 select문에서 사용하나 pl/sql에서는 begin block에서
     분기목적으로 사용
(사용형식1)
CASE WHEN 표준식 THEN
          명령문1;
    WHEN  표준식 THEN
          명령문2;
    ....
    ELSE
          명령문N;
END CASE;

(사용형식2)

CASE 표현식
WHEN 결과1 THEN
     명령문1;
WHEN 결과2 THEN
     명령문2;
    ....
ELSE
     명령문N;
END CASE;

사용예)수도요금 계산
입력자료 : 사용량(톤)
    요금 : 1)물사용료
    1~10: 톤당 250원
    11~20:톤당 350원
    21~30:톤당 500원
    그 이상 : 톤당 750원
    2)하수도 사용료
    사용량(톤) * 150원
    
예를 들어 25톤을 사용하면 
처음 10톤 : 10*250 = 2500
다음 10톤 : 10*350 = 3500
나머지 5톤 : 5*500 = 2500
-----------------------------
                    8500원
물이용 분담금(하수도 사용료)
            25*150
-----------------------------
            합계 : 12250원

ACCEPT  P_AMT PROMPT '수도 사용량(톤) : '
declare
    V_AMT NUMBER:=TO_NUMBER('&P_AMT');--수도 사용량
    V_HAP NUMBER:=0;--요금
BEGIN
    CASE WHEN V_AMT <= 10 THEN
              V_HAP:=V_AMT*250;
         WHEN V_AMT <= 20 THEN
              V_HAP:=(10*250)+(V_AMT-10)*350;
         WHEN V_AMT <= 30 THEN
              V_HAP:=(10*250)+(10*350)+(V_AMT-20)*500;
         ELSE 
              V_HAP:=(10*250)+(10*350)+(10*350)+(V_AMT-30)*750;
    END CASE;
    V_HAP:=V_HAP+(V_AMT*150);
    
    DBMS_OUTPUT.PUT_LINE('물 사용량 : '||V_AMT||'톤');
    DBMS_OUTPUT.PUT_LINE('수도요금 : '||TO_CHAR(V_HAP,'999,999')||'원');
END;