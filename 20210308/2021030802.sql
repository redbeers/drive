2021-03-08-02)집합연산자
    -집합이론에서 제공하는 합집합(UNION, UNION ALL).교집합(INTERSECT),
     차집합(MINUS)연산자 제공
    -(사용형식)
    SELECT 컬럼LIST
    FROM    테이블명
    WHERE   조건
    
UNION|UNION ALL|INTERSECT|MINUS

    SELECT 컬럼LIST
    FROM    테이블명
    WHERE   조건
            :
    .각 SELECT절의 컬럼의 갯수와 순서및TYPE이 같아야 함
    .ORDER BY 적은 맨 마지막 SELECT 문에서만 사용 가능
    .CLOB, BLOB, BFILE 등은 사용불가
    .출력의 기준은 첫 번째 SELECT 문임

1.UNION, UNION ALL
    -합집합의 결과 반환
    -UNION : 중복하지 않은 결과 반환
    -UNION ALL : 중복된 값을 반환
    
사용예)2005년 4월과 6월에 모두 판매된 상품정보를 중복되지않고 조회하시오
    ALIAS는 상품코드, 상품명, 판매수량합계
    
(2005년 4월에 판메삼품 조회)
SELECT  DISTINCT A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200504%'

--INTERSECT--기간동안 팔린상품
MINUS--같은것을 제거한다
--UNION --중복되지않는다.
--UNION ALL--중복된다.
--(2005년 6월에 판메삼품 조회)
SELECT  DISTINCT A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200506%'
ORDER   BY 1;

1.MINUS(차집합)
    -A MINUS B : 집합 A에서 집합 B에속한 요소를 제거한 결과 반환
    -A MINUS A : 집합 B에서 A에속한 요소를 제거한 결과반환

사용예)2005년4월에 판매된상품중 6월 판매된 상품정보 조회
    ALIAS 는 상품코드, 삼풍명
SELECT  DISTINCT A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200506%'

--INTERSECT--기간동안 팔린상품
MINUS--공통 판매된물건
--UNION --중복되지않는다.
--UNION ALL--중복된다.
--(2005년 6월에 판메삼품 조회)
SELECT  DISTINCT A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명
FROM    CART A, PROD B
WHERE   A.CART_PROD = B.PROD_ID
AND     A.CART_NO LIKE '200504%'
ORDER   BY 1;




SELECT  A.CART_PROD AS 상품코드, 
        B.PROD_NAME AS 상품명
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '200506%'
AND     B.PROD_ID = A.CART_PROD

--INTERSECT--기간동안 팔린상품
--MINUS--공통 판매된물건
UNION --중복되지않는다.
--UNION ALL--중복된다.
--(2005년 6월에 판메삼품 조회)
SELECT  B.LPROD_GU AS 분류코드, 
        B.LPROD_NM AS 분류명
FROM    LPROD B
ORDER   BY 1;

