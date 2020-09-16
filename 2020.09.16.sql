2020 09 16 시작

중요

.1 정답 조회 하는 쿼리 작성
2. sql 에 불필요한 부분이 없는지 점검. 
3. 인라인뷰를 사용하지 말고 하려고 노력해보기. 

join 7. 


SELECT pid, SUM(cnt) 
FROM cycle
GROUP BY pid ; 




     
         -- 실습
 본인 속한 부서의 급여 평균보다 높은 급여를 받는 사람들을 조회 . 
 
 SELECT * 
 FROM emp e
 WHERE sal > ( SELECT AVG (sal)
            FROM emp 
            WHERE deptno = e.deptno ) ; 
         
         * 상호연관 이다. 메인 커리에 있는 컬럼을 가져다 썼다. 
         서브쿼리자체만으로 실행이 불가능하다. 
         
  
  실습 sub 4 
  
  테스트용 데이터 추가 
  
  DESC dept;
  INSERT INTO dept VALUES ( 99, 'ddit' , 'daejeon' ) ; 
  
  -> 한 행이 추가됬다. 
  
  SELECT * 
FROM dept
  
  SELECT * 
  FROM emp 
         
                  


sssssss

1. emp 테이블로 등록된 사원들이 속한 부서 번호 확인 

SELECT deptno
FROM dept

실습 sub 4

SELECT *
FROM dept
WHERE deptno NOT IN ( SELECT deptno 
                       FROM emp ) ; 


실습 sub 5  
PID 가 100이랑 400 

SELECT *
FROM cycle 

SELECT *
FROM product
WHERE pid NOT IN ( SELECT pid
                   FROM CYCLE 
                   WHERE cid = 1  ) 







SELECT *
FROM product
WHERE pnm NOT IN ( SELECT pnm
                    FROM product
                    WHERE pid IN ( 400, 100 ) ) 


SELECT * 
FROM cycle 
WHERE cid = 1 


1번고객이 먹지 않는 제품 정보를 조회한다. 



실습 SUB 6 

                


PID 가 100인것 

SELECT * 
FROM cycle
WHERE cid = 1 
AND pid = 100 ;  
--> 여기가 시작 

SELECT * 
FROM cycle
WHERE cid = 1 
AND pid IN (SELECT pid  
           FROM   CYCLE  
           WHERE  CID = 2 )
 

서브쿼리 ) EXISTS 연산자는 항이 하나다 . 


EXIST 연산자 : 조건을 만족하는 서브쿼리의 행이 존재하면 TRUE 

--메니저가 존재하는 사원 
SELECT * 
FROM  emp e
WHERE exists ( SELECT * 
            FROM emp m 
            WHERE e.mgr = m.empno ) ; 
 
 
 s
 SELECT * 
FROM  emp e
WHERE exists ( SELECT 'x'-- 여기에 x라고 해도 되는게, 그냥 exists 는 true 이기만 하면 됨  
            FROM emp m 
            WHERE e.mgr = m.empno ) ; 
 
 
 
 king 을 검색하면 . 
SELECT * 
FROM  emp e
WHERE exists ( SELECT * 
            FROM emp m 
            WHERE null = m.empno ) ; 


exists 가 상호연관커리로 사용된다 대부분
만약 비상호커리로 되면 각각 테이블이 2개가 나올텐데 (독립) 서브쿼리가 존재하면 그냥 전체가 다 나오고
서브쿼리가 존재하지않으면 전체쿼리도 나오지 않음. 
전체가 다 조회가 되거나 전체가 다 조회 안되거나 이렇게 된다. 


SELECT * 
FROM emp a JOIN  emp b ON ( a.mgr = b.empno )  


SELECT * 
FROM emp a 
WHERE EXISTS( SELECT '*' 
               FROM emp b 
               WHERE b.empno = a.mgr ) ; 
               

실습 9 . 

SELECT pid , pnm
FROM product p
WHERE EXISTS ( SELECT 'X'
               FROM cycle c 
               WHERE p.pid = '100' 
               OR   p.pid = '400')

SELECT pid , pnm
FROM product p
WHERE EXISTS ( SELECT 'X'
               FROM cycle c 
     
     
               WHERE cid = '1' )


답
SELECT *  
FROM product
WHERE  EXISTS (SELECT *  
              FROM cycle
              WHERE cid = 1 
              AND pid = product.pid ) ; 


 실습 10 SUB 10 
1번 고객이 먹지 않는 제품 정보 조회 
SELECT *  
FROM product
WHERE NOT EXISTS (SELECT *  
              FROM cycle
              WHERE cid = 1 
              AND pid = product.pid ) ; 




새로운 내용 

집합 연산자 : 알아두자 
수학의 집합 연산 
A = { 1,3,5} 
B = {1, 4, 5 } 
합집합  : A U B = { 1, 3, 4, 5} 
                  A U B = B U A  
            교환법칙이 성립하는 연산자 
 
교집합 : A  ^  B = { 1, 5 } 
        ( A ^ B == B ^ A } 
교환법칙이 성립한다. 
차집합 : A - B = { 3 }  (교환법칙 성립하지 않음 A-B != B - A ) 
        B - A = { 4 } 
              
합집합 : UNION      :   수학적 합집합과 개념이 동일 ( 중복을 허용하지 않음 ) 
                       중복을 체크 ==> 두 집합에서 중복된 값을 확인 -> 연산이 느림 
        UNION ALL  :   수학적 집합개념을 떠나서 두개의 집합을 단순히 합친다 
                    ( 중복 데이터 존재 가능 ) 
                  ** 개발자가 두개의 집합에 중복되는 데이터가 없다는 것을 알 수 있는 상황이라면
                   일부러 UNION 연산자를 사용하는 것보다 UNION ALL 을 사용하여 
                   (오라클이 하는) 연산을 절약할 수 있다. 



INTERSECT 교집합 : 수학적 교집합 개념과 동일 
MINUS : 수학적 차집합 개념과 동일 


위아래 집합이 동일하기 때문에 합집합을 하더라도 행이 추가되진 않는다. 

SELECT empno, ename 
FROM emp 
WHERE deptno = 10  
UNION
SELECT empno, ename 
FROM emp 
WHERE deptno = 10 ; 






SELECT empno, ename 
FROM emp 
WHERE deptno = 10  
UNION
SELECT empno, ename 
FROM emp 
WHERE deptno = 20 ; 


위아래 집합에서 7369번 사번은 중복되므로 한번만 나오게 된다 : 전체 행을 3건 
SELECT empno, ename 
FROM emp 
WHERE empno IN ( 7369, 7566 ) 
UNION
SELECT empno, ename 
FROM emp 
WHERE empno IN  ( 7369 , 7782 )  ; 


UNION ALL 연산자는 중복제거 단계가 없다. 총 데이터 4개의 행 

SELECT empno, ename 
FROM emp 
WHERE empno IN ( 7369, 7566 ) 
UNION ALL
SELECT empno, ename 
FROM emp 
WHERE empno IN  ( 7369 , 7782 )  ;

INTERSECT --교집합 
두 집합의 공통된 부분은 7369 
SELECT empno, ename 
FROM emp 
WHERE empno IN ( 7369, 7566 ) 
INTERSECT 
SELECT empno, ename 
FROM emp 
WHERE empno IN  ( 7369 , 7782 )  ;


차집합 

윗쪽 집합에서 아래쪽 집합의 행을 제거하고 남은 행 : 1개의 행 ( 7566 ) 

집합연산자 특징 

1. 컬럼명은 첫번째 집합의 컬럼명을 따라간다. 
2. ORDER BY 절은 마지막 집합에 적용 한다. 
 마지막 SQL이 아닌 SQL에서 정렬을 사용하고 싶은 경우 INLINE-VIEW 를 활용한다. 
 UNION ALL 의 경우 위, 아래 집합을 이어 주기 때문에 집합의 순서를 그대로 유지 하기 때문에 
 요구사항에 따라 정렬된 데이터 집합이 필요하다면 해당 방법을 고려 
SELECT empno e, ename 
FROM emp 
WHERE empno IN ( 7369, 7566 ) 
-- ORDER BY 여기에 하면 안되고 
UNION ALL 
SELECT empno, ename 
FROM emp 
WHERE empno IN  ( 7369 , 7782 )  ;
ORDER BY -- 여기다가 해야한다. 

-- 첫번쨰 위에있는애 empno 가 e니까 전체는 e 가 나오게 됨 

