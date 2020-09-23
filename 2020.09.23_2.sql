multiple insert : 조건에 따라 여러 테이블에 데이터를 입력하는 insert 

기존에 배운 쿼리는 하나의 테이블에 여러건의 데이터를 입력하는 쿼리 

INSERT INTO emp ( empno, ename ) 
SELECT empno , ename 
FROM emp ; 



multiple insert 구분

1. unconditional insert : 여러 테이블에 insert 
2. conditional all insert : 조건을 만족하는 모든 테이블에 insert 
3. conditional first insert : 조건을 만족하는 첫번째 테이블에 insert 

1. unconditional insert 조건에 관계없이 입력을 하겠다. 


DROP TABLE emp_test; 
DROP TABLE emp_test2;

CREATE TABLE emp_test AS 
SELECT empno, ename 
FROM emp 
WHERE 1=2; 

CREATE TABLE emp_test2 AS 
SELECT empno, ename 
FROM emp 
WHERE 1=2; 

데이터는 가지고오지 않고 테이블구조만 가지고오고싶을때 

만약 where 1= 1이면 데이터까지 가지고 완벽하게 가지고 옴 . 




INSERT ALL INTO emp_test 
           INTO emp_test2 
SELECT 9999, 'brown' FROM dual UNION ALL
SELECT 9999, 'sally' FROM dual 



SELECT * 
FROM emp_test; 


SELECT * 
FROM emp_test2; 

uncondition insert 실행시 테이블 마다 데이터를 입력할 컬럼을 조작하는 것이 가능 
위에서 : INSERT INTO emp_test VALUES (....) 테이블의 모든 컬럼에 대해 입력 
        INSERT INTO emp_test ( empno) valuse (9999) ..... 
        
INSERT ALL 
INTO emp_test (empno) VALUES (eno)
into emp_test2 (empno, ename ) VALUES ( eno, enm) 
SELECT 9999 eno, 'brown' enm FROM dual UNION ALL
SELECT 9999, 'sally' FROM dual 

SELECT * 
FROM emp_test ; 

SELECT * 
FROM emp_test2 ; 


conditional insert 조건에 따라 데이터를 입력 

CASE 
   WHEN job = 'MANAGER' THEN sal*1.05 
   WHERE job = 'PRESIDENT' THEN sal*1.2
END 

ROLLBACK;



INSERT ALL 
    WHEN eno >= 9500 THEN 
       INTO emp_test VALUES (eno, enm) 
       INTO emp_test VALUES (eno, enm) 
    WHEN eno > 9900 THEN
        INTO emp_test2 VALUES (eno, enm) 
SELECT 9500 eno, 'brown' enm FROM dual UNION ALL
SELECT 9999, 'sally' FROM dual









