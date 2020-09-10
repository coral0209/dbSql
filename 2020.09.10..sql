그룹함수 : 여러 개의 행을 입력으로 받아 하나의 행으로 결과를 반환하는 함수



*많이 쓰이는 함수, 잘 알아두자 ( 개념적으로 혼돈하지 말고 잘 정리하자 - select 절에 올 수 있는 컬럼에 대해 잘 정리 ) 

오라클 제공 그룹함수

MIN( 컬럼| 익스프레션 ) : 그룹중에 최솟값을 반환 / 문자열은 가장 먼저 오는 알파벳?인듯 
MAX (컬럼 | 익스프레션 ) : 그룹중에 최대값을 반환
AVG(컬럼 | 익스프레션) : 그룹의 평균값을 반환
SUM(컬럼 | 익스프레션) : 그룹의 합계값을 반환
COUNT(컬럼 | 익스프레션 | * ) : 그룹핑된 행의 갯수 

SELECT 행을 묶을 컬럼, 그룹함수 
FROM 테이블명 
[WHERE] 
GROUP BY 행을 묶을 컬럼; 


SELECT *
FROM emp
ORDER BY deptno; 

SELECT deptno,  MIN(enam) COUNT(*), MIN(sal), MAX (sal) , SUM(sal), AVG(sal)
FROM emp
GROUP BY deptno 

* 오류를 해결하는법 : 부서이름에 함수를 적용해주면 됨 
그룹함수에서 많이 어려워하는 부분
SELECT 절에 기술할 수 있는 컬럼의 구분  : GROUP BY 절에 나오지 않은 컬럼이 SELECT 절에 나오면 에러 

전체 직원중에 가장 많은 급여를 받는 사람의 값 

전체 행을 대상으로 그룹핑을 할경우 group by 절을 기술하지 않는다. 


SELECT  MAX(sal)
FROM emp;


전체 직원중에 가장 큰 급여 값을 알 수는 있지만 해당 급여를 받는 사람이 누군지는 그룹함수만 이용해서는
구할 수 없다. 

emp 테이블 가장 큰 급여를 받는 사람의 값이 5000인 것은 알지만 해당 사원이 누구인지는
그룹함수만 사용해서는 누군지 식별할 수 없다. 
==> 추후 진행 



COUNT 함수 * 인자 
* : 행의 개수를 반환 
컬럼 | 익스프레션 : NULL 값이 아닌 행의 개수
그러니까 숫자를 세는데 NULL값을 빼고 세는 것임

다른 함수에서는 * 는 못쓰지만 COUNT 함수에서만 쓸 수 있음 

SELECT * 
FROM EMP;

SELECT COUNT(*) , COUNT(mgr) , COUNT(COMM) 
FROM emp; 


그룹함수의 특징 : NULL값을 무시 
NULL 연산의 특징 : 결과 항상 NULL이다 

그룹함수에서 계산을 할때 NULL값을 가진 애들을 빼버리고 계산 

EX) COMM 함수에 4개 빼고 NULL이다 그러면 SUM 함수를 쓰면 연산해서 NULL이나올거같지만
NULL을 빼고 나머지를 합해서 씀 

SELECT SUM (sal + comm), SUM (sal ) + SUM(comm)  
FROM emp; 

했을때 


그룹함수 특징 2: 그룹화와 관련없는 상수들은 SELECT절에 기술할 수 있다 

SELECT deptno, SYSDATE, 'TEST', 1, COUNT(*) 
FROM emp 
GROUP BY deptno; 

그룹함수 특징 3 : 
    single row 함수의 경우 where 에 기술하는 것이 가능하다 
    ex : SELECT * 
         FROM emp
         WHERE ename = UPPER('smith') ; 


그룹함수의 경우 where 에서 사용하는 것이 불가능 하다 
--> HAVING 절에서 그룹함수에 대한 조건을 기술하여 행을 제한 할 수 있다. 


그룹함수는 where절에 사용 불가 
SELECT deptno, COUNT(*) 
FROM emp 
WHERE COUNT(*) >=5
GROUP BY deptno; 
-- 여기에 where 절을 넣으면 안된다. 

SELECT deptno, COUNT(*) 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) >= 5; 

-- WHERE절은 못쓰니까 HAVING절을 쓴다. 


기본 뼈대 정리

SELECT 행을 묶을 컬럼, 그룹함수 
FROM 테이블명
[WHERE] 
[GROUP BY] 행을 묶을 컬럼 
[HAVING] 
[ORDER BY] 

* HAVING 과 WHERE 는 같이 못쓴다. 
둘은 사용가능해 그렇지만 GROUP BY 에 대상이 되는 행들을 

SELECT deptno , count(*) 
FROM emp
WHERE sal > 1000
GROUP BY deptno 
얘는 사용이 가능하다 

GOUP FUNCTION 실습 GRP1 



SELECT MAX(SAL) max_sal , MIN(sal) min_sal ,ROUND ( (AVG(sal)) , 2 ) avg_sal ,
SUM(sal) sum_sal, COUNT(SAL) count_sal , COUNT(mgr) count_mgr , COUNT(*)  count_all 
FROM emp


SELECT COUNT (COUNT(*))
SELECT * 
FROM emp 


select * 
FROM emp








DECODE ( deptno, 10 , ' ACCOUNTING', 20 


SELECT
CASE
WHEN deptno = 10 THEN 'accounting'
WHEN deptno = 20 THEN 'reserch'
WHEN deptno = 30 THEN 'sales' 
ELSE null 
END dname
,  MAX(SAL) max_sal , MIN(sal) min_sal ,ROUND ( (AVG(sal)) , 2 ) avg_sal ,
SUM(sal) sum_sal, COUNT(SAL) count_sal , COUNT(mgr) count_mgr , COUNT(*)  count_all 
FROM emp
GROUP BY deptno; 


** GROUP BY 절에 기술한 컬럼이 SELECT 절에 오지 않아도 실행에는 문제는 없다. 

SELECT *
FROM DEPT;

4번 문제 

SELECT *
FROM emp

select  TO_CHAR( HIREDATE , 'YYYYMM' ) hiredate_YYYYMM , COUNT( TO_CHAR( HIREDATE , 'YYYYMM' )) CNT
FROM emp 
GROUP BY TO_CHAR( HIREDATE , 'YYYYMM' )







실습 grp5 



새로운 단원 : JOIN 



rdbms는 중복을 최소화하는 형태의 데이터 베이스 
다른 테이블과 연결. 

**************WHERE + JOIN SELECT SQL 의 모든것 **********
JOIN : 다른 테이블과 연결하여 데이터를 확장하는 문법 
      . COLUMN을 확장한다 
** 행을 확장 -> 집합 연산자( UNION , INTERSECT MINUS )       
   --> 다음에 설명할것   
      

JOIN 문법 구분

1. ANSI - SQL
    : RDBMS에서 사용하는 SQL 표준 문법
    ( 표준을 잘 지킨 모든 RDMBS-MYSQL, MSSQL, POSTGRESQL...에서 실행가능 ) 
2. ORACLE - SQL 
     : ORACLE 사 만의 고유 문법 


ANSI SQL에 있는 

NATURAL JOIN : JOIN 하고자 하는 테이블의 컬럼명이 같은 컬럼끼리 연결 
              컬럼의 값이 같은 행들끼리 연결 
        ANSI - SQL 
        
        SELECT 컬럼
        FROM 테이블명 NATURAL JOIN 테이블명; 
        
        
        
 SELECT emp.empno, deptno, dept.dname 
    FROM emp NATURAL JOIN dept;
    
    그냥 
    
    
SELECT *
FROM emp 
    
SELECT *

FROM dept
    
    컬럼명이 한쪽 테이블에만 존재할 경우 테이블 한정자를 붙이지 않아도 상관없다. 
 
    
    SELECT empno, deptno, dname
    FROM emp Natural JOIN dept;
    
    
-> 테이블간의 column이 같아야되는 제약사항 
조인 컬럼에 테이블 한정자를 붙이면 natural join 에서는 에러로 취급 



NATURAL join 을 oracle문법으로 
1. FROM 절에 조인할 테이블을 나열(   ,   ) 한다.
2. WHERE 절에 테이블 조인 조건을 기술한다 

요렇게 써줘야함
SELECT * 
FROM emp, dept 
WHERE emp.deptno = dept.deptno; 


SELECT * 
FROM emp 



컬럼이 여러개의 테이블에 동시에 존재하는 상황에서 테이블 한정자를 붙이지 않아서 오라클 입장에서는 해당 컬럼이 어떤 테이블의 컬럼인지 알수가 없을때 오류
: 

SELECT * 
FROM emp, dept 
WHERE deptno = deptno;
 --> 오류 




emp 테이블에 있는 부서번호가 dept 테이블에 있는 부서번호랑 같을때 


인라인뷰 별칭처럼 테이블 별칭을 부여하는게 가능 

SELECT * 
FROM emp, dept 
WHERE emp.deptno = dept.deptno; 

SELECT * 
FROM emp e, dept d 
WHERE e.deptno = d.deptno ; 


ANSI - SQL : JOIN WITH USING 
조인 하려는 테이블간 같은 이름의 컬럼이 2개 이상일 때 하나의 컬럼으로만 조인을 하고 싶을 때 사용 

SELECT * 
FROM emp JOIN DEPT USING (deptno);  


ORACLE문법 
SELECT * 
FROM emp, dept 
WHERE emp.deptno = dept.deptno ; 


ANSI-SQL : JOIN WITH ON - 조인 조건을 개발자가 직접 기술
            NATURAL JOIN , JOIN WITH USING 절을 JOIN WITH ON 절을 통해 표현 가능 
            
SELECT * 
FROM emp JOIN dept ON (emp.deptno = dept.deptno) ;  


ORACLE 

SELECT * 
FROM emp, dept 
WHERE emp.deptno = dept.deptno 
AND deptno IN ( 20, 30 ) ; 

----> 오류 


SELECT * 
FROM emp, dept 
WHERE emp.deptno = dept.deptno 
AND emp.deptno IN ( 20, 30 ) ; 
 --> oracle이 deptno이 같은지 모름 우리만 알아 . 
 
 논리적인 형태로 구분을 함 
 
 논리적인 형태에 따른 조인 구분 
 1. SELF JOIN : 조인하는 테이블이 서로 같은 경우  ( 예를들어서 EMP에는 메니저의 숫자가 나와있는게 EMP
 그 안에서 ) 
 SELECT e.empno , e.ename, e.mgr , m.ename 
 FROM emp e  join emp m on (e.mgr = m.empno )
 * 왼쪽에는 mgr 오른쪽 empno 를 연결하는것 
 
 
 ( 지금 써놓은것은 왼쪽의 것 ) 
  __ alias 를 써야해 
 
 ORACLE 
 
 SELECT e.empno, e.ename, e.mgr, m.ename  
 FROM emp e, emp m 
 WHERE e.mgr = m. empno ;

---> king의 경우 메니저 컬럼의 값이 null이기 때문에 e.mgr = m.empno 조건을 충족시키지 못함
그래서 조인 실패해서 14건중 13건의 데이터만 조회 
 
 
 
 
 
 2. nonequi join 조인 조건이 = 이 아닌 조인 
 
 SELECT * 
 FROM emp, dept 
 WHERE emp.empno = 7369 
   AND emp.deptno != dept.deptno ;
   
SELECT *
FROM  salgrade;

SAL를 ㅣㅇ용해서 등급 구하기 


empno, ename sal, 등급 
SELECT empno, ename, sal, 등깁(grade )  
FROM epm, salgrade
WHERE emp.sal >= losal
AND      sal <= hisal; 


empno, ename sal, 등급 
SELECT empno, ename, sal, 등급 ( grade )  
FROM epm, salgrade
WHERE sal between losal and hisal ; 



위의 sql을 ansi - sql 로 변경 

SELECT empno, ename, sal, grade ) 
FROM epm JOIN salgrade ON ( sal >= losal and <= hisal ); 




