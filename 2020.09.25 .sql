REPORT GROUP FUNCTION 
GROUP BY 의 확장 : SUBGROUP 을 자동으로 생성하여 하나의 결과로 합쳐준다. 
1. ROLLup(col1, col2 ... ) 
기술된 컬럼을 오른쪽에서부터 지워나가며 서브그룹을 생성
2. GROUPING SETS ( ( col1, col2 ) , col 3 )
, 단위로 기술된 서브 그룹을 생성 

3. CUBE ( col1, col2...... ) 
    . 컬럼의 순서는 지키되 가능한 모든 조합을 생성한다. 
GROUP BY CUBE ( job, deptno ) 
                 -- 컬럼하나가 적용이 됬을때, 안될때 이렇게 2가지가 있다. 
job  deptno
0      0       ==> GROUP BY job, deptno 
0      x       ==> GROUP BY job 
x      0       ==> GROUP BY deptno (rollup 에는 없던 서브 그룹 )  
x      x       ==> GROUP BY 전체 

GROUP BY ROLLUP ( job, deptno ) --> 3개가 생성 
SELECT job, deptno, SUM(sal + NVL(comm , 0 )) sal 
FROM emp 
GROUP BY CUBE (job, deptno ) ; 

CUBE (col1, col2, col3 ) 

CUBE 의 경우 가능한 모든 조합으로 서브 그룹을 생성하기 때문에 
2의 기술한 컬럼 개수 승 만큼의 서브 그룹이 생성된다. 


CUBE (col1, col2 ) : 4개
CUBE (col1, col2, col3 ) : 8개 
CUBE (col1, col2, col3, col4 ) : 16개 

REPORT GROUP FUNCTION 조합 

GROUP BY job , ROLLUP(deptno ) , CUBE(mgr) 
                deptno             mgr
                 전체               전체



               job  ,depno, mgr
               job  ,deptno   
               job  ,mgr
               job  ,전체





job은 디폴트 rollup랑 cube에 대한 디폴트값

SELECT job, deptno, mgr , SUM(sal + NVL(comm, 0 ) ) sal
FROM emp 
GROUP BY job, ROLLUP ( deptno ) , CUBE (mgr) 

** 이값을 잘 보는거 중요해. 

서브쿼리 

예전에는 업데이트 할때는 비상호 연관쿼리로 했어 





1. emp_test 삭제 
2. emp 테이블을 하영하여 emp_test 테이블 생성 ( 모든 컬럼, 모든 데이터 ) 
3. emp_test 테이블에는 dname 컬럼을 추가 (varchar2(14) ) 
4. 상호 연관 서브쿼리를 이용하여 emp_test 테이블의 dname컬럼을 dept 를 이용하여 update 

1.
DROP TABLE emp_test ; 

2.
CREATE TABLE emp_test AS 
SELECT * 
FROM emp ; 

3. 
ALTER TABLE emp_test ADD ( dname VARCHAR2(14)) ; 

4. UPDATE emp_test SET dname = (SELECT dname FROM dept WHERE deptno = emp_test.deptno )  

SELECT count(deptno) 
FROM dept 
WHERE deptno = emp_test.deptno





SELECT * 
FROM dept_test; 

문제

SELECT * 
FROM dept_test;
1.
DROP TABLE dept_test; 
2.
CREATE TABLE dept_test AS
SELECT * 
FROM dept;
3. 
ALTER TABLE dept_test ADD ( empcnt NUMBER ) ; 

4. 
UPDATE dept_test SET empcnt = (
SELECT a.deptno
FROM
(SELECT deptno ,count(deptno ) 
FROM dept 
GROUP BY deptno ) a
WHERE a.deptno = dept_test.deptno 
)


더 간단하게 함 

UPDATE dept_test SET empcnt =
(SELECT count(deptno) 
FROM dept 
WHERE dept.deptno = dept_test.deptno
GROUP BY deptno )

SELECT *
FROM dept_test


UPDATE dept_test SET empcnt = 
(SELECT count(*) 
FROM emp 
WHERE deptno = dept_test.deptno )


sub_a2 

INSERT into dept_test ( deptno, dname, loc ) VALUES( 99, 'it1', 'daejeon' ) ; 
INSERT into dept_test ( deptno, dname, loc ) VALUES( 98, 'it2', 'daejeon' ) ; 


SELECT deptno, dname 
FROM dept_test


부서에 속한 직원이 없는 부서를 삭제하는 쿼리를 작성하세요. 
행을 삭제 

DELETE dept_test WHERE empcnt is NULL 

DELETE dept_test WHERE deptno != ( SELECT deptno 
                                    FROM dept 
                                    WHERE dept_test.deptno =  dept.deptno ) 

DELETE dept_test 
WHERE 0 = (SELECT COUNT(*) 
        FROM emp 
         WHERE deptno = dept_test.deptno) ; 


DELETE dept_test 
WHERE deptno NOT IN (SELECT deptno 
                      FROM emp) ; 

DELETE dept_test 
AND NOT EXISTS ( SELECT 'X'
                 FROM emp 
                 WHERE deptno = dept_test.deptno ) ; 
 




ALTER TABLE dept_test DROP COLUMN empcnt





SELECT count(*)
FROM emp 
WHERE deptno = 40 ; 






SELECT * 
FROM dept_test


with 절

다른사람들이랑 주고받고 질문할때 




달력만들기 : 행을 열로 만들기 - 레포트 쿼리에서 자주 사용하는 형태 

SELECT SYSDATE , LEVEL 
FROM dual 
CONNECT BY LEVEL <= 30  
      LEVEL 값을 사용. 



행을 원하는 계수 

9월 . 

SELECT SYSDATE , LEVEL 
FROM dual 
CONNECT BY LEVEL <= 30  
30


SYSDATE 를 사용하여 

SELECT SYSDATE + LEVEL dt ,  LEVEL
FROM dual 
CONNECT BY LEVEL <= 10 ; 

SELECT DAY, d, DECODE(d, 1, day ) suu, DECODE ( d, 2 , day) mon, DECODE( D, 3, day) tue,
DECODE( d, 4, day) wed, DECODE ( d, 5, day ) thu , DECODE ( d, 6, day ) fri, DECODE(d, 7, day) sat 
FROM
(SELECT TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 day ,
TO_CHAR(TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 , 'D') d, LEVEL 
FROM dual 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ( '202002' , 'YYYYMM') ) , 'DD' )) ; 



SELECT TO_CHAR (SYSDATE, 'iw' ) , TO_CHAR(sysdate+1 , 








SELECT DAY, d, iw, 
DECODE(d, 1, day ) suu,
DECODE ( d, 2 , day) mon,
DECODE( D, 3, day) tue,
DECODE( d, 4, day) wed,
DECODE ( d, 5, day ) thu ,
DECODE ( d, 6, day ) fri,
DECODE(d, 7, day) sat 
FROM
(SELECT TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 day ,
TO_CHAR(TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 , 'D') d, LEVEL,  
TO_CHAR(TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 , 'iw') iw
FROM dual 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ( '202002' , 'YYYYMM') ) , 'DD' )) ; 








d, iw  지우기 

SELECT DECODE ( d, 1, IW + 1 , IW) ,
MIN(DECODE(d, 1, day )) sun, 
MIN(DECODE ( d, 2 , day)) mon, 
MIN(DECODE( D, 3, day)) tue,
MIN(DECODE( d, 4, day)) wed, 
MIN(DECODE ( d, 5, day )) thu ,
MIN(DECODE ( d, 6, day )) fri, 
MIN(DECODE(d, 7, day)) sat 
FROM
(SELECT TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 day ,
TO_CHAR(TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 , 'D') d, LEVEL,  
TO_CHAR(TO_DATE('202002' , 'YYYYMM' )+ LEVEL -1 , 'iw') iw
FROM dual 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ( '202002' , 'YYYYMM') ) , 'DD' )) 
GROUP BY DECODE ( d, 1, IW + 1 , IW)
ORDER BY DECODE ( d, 1, IW + 1 , IW); 


날짜만 쓰기 



SELECT DECODE ( d, 1, IW + 1 , IW),
MIN(DECODE(d, 1, day )) sun, 
MIN(DECODE ( d, 2 , day)) mon, 
MIN(DECODE( D, 3, day)) tue,
MIN(DECODE( d, 4, day)) wed, 
MIN(DECODE ( d, 5, day )) thu ,
MIN(DECODE ( d, 6, day )) fri, 
MIN(DECODE(d, 7, day)) sat 
FROM
(SELECT TO_DATE(:YYYYMM , 'YYYYMM' )+ LEVEL -1 day ,
TO_CHAR(TO_DATE(:YYYYMM , 'YYYYMM' )+ LEVEL -1 , 'D') d, LEVEL,  
TO_CHAR(TO_DATE(:YYYYMM , 'YYYYMM' )+ LEVEL -1 , 'iw') iw
FROM dual 
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ( :YYYYMM , 'YYYYMM') ) , 'DD' )) 
GROUP BY DECODE ( d, 1, IW + 1 , IW)
ORDER BY DECODE ( d, 1, IW + 1 , IW); 



12월 30 31 이 문제 (해결해보고 싶은거 생각해보기. ) 

SELECT TO_CHAR(TO_DATE ('20191229', 'YYYYMMDD')


실습 CALENDAR 1 


SELECT K, sales ,     0 jan, 0 feb,0 mar 
FROM
(SELECT  TO_CHAR(DT, 'MM') K  , SUM (SALES) sales 
FROM sales
GROUP BY TO_CHAR(DT, 'MM') 
ORDER BY  TO_CHAR(DT, 'MM')) l



요함수에서 


SELECT K, sales, DECODE( K , 1 , sales ) jan, DECODE( K , 2 , sales ) feb, DECODE( K , 3 , sales ) mar , DECODE( K , 4 , sales ) APR , 
DECODE( K , 5 , sales ) may 
FROM
(SELECT  TO_CHAR(DT, 'MM') K  , SUM (SALES) sales
FROM sales
GROUP BY TO_CHAR(DT, 'MM') 
ORDER BY  TO_CHAR(DT, 'MM')) A


SELECT  MIN(DECODE( K , 1 , sales )) jan, MIN(DECODE( K , 2 , sales ) ) feb, MIN(DECODE( K , 3 , sales , 0 )) mar , MIN(DECODE( K , 4 , sales )) APR , 
MIN(DECODE( K , 5 , sales )) may 
FROM
(SELECT  TO_CHAR(DT, 'MM') K  , SUM (SALES) sales
FROM sales
GROUP BY TO_CHAR(DT, 'MM') 
ORDER BY  TO_CHAR(DT, 'MM')) A



SELECT mm, sales , 0 jan, 0 feb, 0 mar,  0 apr, 0 may, 0 jun  
FROM
(SELECT  TO_CHAR(DT, 'MM') mm  , SUM (SALES) sales
FROM sales
GROUP BY TO_CHAR(DT, 'MM') )


여기서 

SELECT  NVL(MIN(DECODE( mm, '01' , sales )), 0 ) jan, NVL(MIN(DECODE ( mm, '02' , sales)), 0) feb, NVL(MIN(DECODE ( mm, '03' , SALES )), 0 ) mar, 
NVL(MIN(DECODE( mm, 04, sales )) , 0) apr , NVL( MIN(DECODE ( mm , 05, sales)), 0 ) may , NVL( MIN(DECODE( mm, 06 , sales )), 0 ) june
FROM
(SELECT  TO_CHAR(DT, 'MM') mm  , SUM (SALES) sales
FROM sales
GROUP BY TO_CHAR(DT, 'MM') )


*일반적으로 NVL 함수를 MIN 보다 밖에다가 적용하는게 좋다. 





SELECT * 
FROM SALES
---------------------------------------------------------------------------

계층 쿼리 

행과 다른 행을 묶는거라고 생각하자. 


SELECT * 
FROM dept_h; 

탐색 : 밑에서부터 올라가기 , 위에서부터 내려가기 

일반적 : 위에서부터 내려옴 


계층쿼리의 시작 

SELECT *
FROM dept_h
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd ; 

내가 이미 읽은 행 : PRIOR

SELECT deptcd, lpad ( ' ' , (level-1 )*3 ) || deptnm deptnm , LEVEL 
FROM dept_h
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd ; 
















