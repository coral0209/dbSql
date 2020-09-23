인덱스 생성 방법 
1. 자동 생성 

UNIQUE, PRIMARY KEY 생성시
해당 컬럼으로 이루어진 인덱스가 없을 경우 해당 제약조건 명으로 인덱스를 자동생성해준다. 

UNIQUE : 컬럼의 중복된 값이 없음을 보장하는 제약조건 
PRIMARY KEY : UNIQUE + NOT NULL 

DBMS 입장에서는 신규 데이터가 입력되거나 기존 데이터가 수정된 때 UNIQUE 제약에 문제가 없는지 확인 -> 무결성을 지키기위해 
시간이 많이 걸리겠다. 
속도적인 부분 : 빠른 속도로 중복 데이터 검증을 위해 오라클에서는 UNIQUE, PRIMARY KEY 생성시 
해당 컬럼으로 인덱스 생성을 강제한다. 

PRIMARY KEY 제약조건 생성 후 해당 인덱스를 삭제해보면 삭제가 불가. 
* 인덱스가있어야지만 빠르게 참조할 수 있다. 참조하는 테이블에 인덱스가 반드시 존재해야지만 만들수 있다. 

FOREIGN KEY : 입력하려는 데이터가 참조하는 테이블의 컬럼에 존재하는 데이터만 입력되도록 제한 

EMP 테이블에 brown 사원을 50번 부서에 입력을 하게 되면 50번 부서가 dept 테이블의 deptno 컬럼에 존재여부를 확인하여 존재할 시에만 emp 테이블에
데이터를 입력 . 



 



ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno ) ; 
empno 컬럼을 선두컬럼을 하는 인덱스가 없을 경우 pk_emp 이름으로 UNIQUE 인덱스자동생성  

index 

*  인덱스 명명규칙 
idx_테이블명 _n_01  


DDL index 실습 1번 2번. 

CREAT   

1.
CTAS  ( 테이블 만드는거 ) 



CREATE TABLE dept_test2 AS 
SELECT * 
FROM dept
WHERE 1=1 ; 

CREATE UNI


1. UNIQUE 인덱스 생성 

CREATE INDEX 이름 ON 이름 (컬럼명)

CREATE UNIQUE INDEX idx_dept_test2_u_01 ON dept_test2 (deptno); 
DROP INDEX idx_dept_test2_u_01;
CREATE INDEX idx_dept_test2_n_02 ON dept_test2 (dname); 
DROP INDEX idx_dept_test2_n_02;
CREATE INDEX idx_dept_test2_n_03 ON dept_test2 (deptno, dname ); 
DROP INDEX idx_dept_test2_n_03;

실습 3 


목적 : 인덱스 


SELECT * 
FROM emp 
WHERE empno = :empno; 

중복도 없고 null도 없다. 
1.empno 입력값 CREATE UNIQUE INDEX idx_emp_test_u_01 ON emp (:empno, :ename);
CREATEINDEX idx_emp_test_u_01 ON emp (:deptno);


2.ename 입력값 CREATE INDEX idx_emp_test_n_01 ON emp (:ename); 
3.deptno 는 입력한 값이어야 하고. empno 는empno를 입력한 값에서 뽑아서 쓰거나 또는 아무값. 
4. sal 를 입력하는 값 사이에의 값 and deptno 는 입력하는거
5. 조인된 것중에 오른쪽 메니저테이블 전체를 조회하는데 이고. deptno 는 입력하는 값.
CREATE TABLE emp_test_02 AS 
SELECT * 
FROM emp m , emp e 
WHERE e.mgr = m.empno 
CREATE INDEX idx_dept_test_02_n_01 ON dept_test_02 (dname); 

6. deptno 로 그룹되었고, hiredate 로 그룹된 테이블인데 deptno 랑 hiredate 랑 전체 수 조회하기 


emp테이블의 인덱스 생성 . 
(sal, hiredate 
---------------------------------
SELECT sal , count(sal)
FROM emp 
GROUP BY sal

, count(hiredate)
SELECT TO_CHAR (hiredate , 'yyyymm' )  , count(TO_CHAR (hiredate , 'yyyymm' ) )
FROM emp 
GROUP BY TO_CHAR (hiredate , 'yyyymm' ) 

hiredate 가 공통인애(2개가진애) 가 3개로 sal 2개 보다 1개가 더 많다. 
그래서 sal로 먼저 인덱스를 한다. 





CREATE TABLE emp_test AS 
SELECT * 
FROM emp 
WHERE 1=1 ; 

empno 는 primary key 여야 하고. 



SELECT * 
FROM EMP
WHERE emp.deptno = :deptno 
AND emp.empno LIKE : empno || '%' ; 









1번 2번이 사용할 애들 : CREATE UNIQUE INDEX idx_emp_test_u_01 ON emp (:empno, :ename);
3번은 따로 조건내용(이해못한부분)을 인덱스로 만드는게 가장 좋을거라고 생각한다. 
어떻게 만드는지 모르겠다. 
4번 6번 이 사용할 애들
CREATE INDEX idx_emp_test_u_01 ON emp (:deptno);
5번 
CREATE TABLE emp_test_02 AS 
SELECT * 
FROM emp m , emp e 
WHERE e.mgr = m.empno 
CREATE INDEX idx_dept_test_02_n_01 ON dept_test_02 (deptno); 

6번 


SELECT deptno, TO_CHAR(hiredate, 'yyyymm' ) , count(*) cnt
FROM emp 
GROUP BY deptno,  TO_CHAR(hiredate, 'yyyymm' )

CREATE INDEX idx_emp_test_u_01 ON emp (:deptno, );




실습 idx3] 
1) empno (=) 
2) ename (=) 
3) deptno(=) , empno(LIKE : empno || '%' )
4) deptno(=) , sal(BETWEEN) 
5) deptno(=) , mgr 컬럼이 있을경우 테이블 엑세스 불필요 
   empno(=) 
6)  
deptno , hiredate 컬럼으로 구성된 인덱스가 있을 경우 테이블 엑세스 불필요. 


CREATE UNIQUE INDEX idx_emp_u_01 ON emp ( empno, deptno ) ; 
CREATE INDEX idx_emp_02 ON emp ( ename ) ;
CREATE INDEX idx_emp_03 ON emp(deptno, sal, mgr , hiredate ) ; 


FBI : Function Based Index 
함수기반인덱스 함수적용한 애를 인덱스로 만든것. 
이런 기반이 있지만 , 함수를 왼쪽 즉 컬럼에 적용하지 않도록 하는게 좋다. 


인덱스 사용에 있어서 중요한점 
인덱스 구성컬럼이 모두 null이면 인덱스에 저장을 하지 않는다. 
즉 테이블에 접근을 해봐야지만 해당 행에 대한 정보를 알 수 있다. 
가급적이면 컬럼에 값이 NULL 이 들어오지 않을 경우는 NOT NULL제약을 적극적으로 활용
==> 오라클 입장에서 실행계획을 세우는데 도움이된다. 

-----------------------동의어 synonym 

오라클 객체에 별칭을 생성 
오라클 객체를 짧은 이름으로 지어줄 수 있다. 

생성방법 
CREATE [PUBLIC] SYNONYM 동의어_이름 FOR 오라클 객체 
PUBLIC : 공용동의어 생성시 사용하는 옵션. 
         시스템 관리자 권한이 있어야 생성이 가능하다. 
         
SEM, HR 계정에 SYNONYM 을 생성할 수 있는 권한을 부여 
GRANT CREATE SYNONYM TO AURORA ; 
GRANT CREATE SYNONYM TO hr ; 


emp 테이블에 e 라는 이름으로 synonym을 생성 
CREATE SYNONYM e FOR emp ; 

조회해보기 

SELECT * 
FROM emp; 

SELECT * 
FROM e;


hr 계정에서 
SELECT * 
FROM aurora.V_emp ;  


CREATE SYNONYM v_emp FOR sem.v_emp ; 


-----------------------------------------------------
시스템권한 : 테이블을 만들수 있는 권한

객체권한 : hr 에 권한을 주었고 그것을 읽을 수 있는 권한 (내가보여주기싫은것 뺀애들을)

스키마 : 



권한을 부여받은 사용자가 다른 사용자에게 줄수있는권한 

객체권한 회수할때 차이점 : 

시스템 권한 회수 : 


role 권한들의 집합 


DICTIONARY : 시스템 정보를 조회할 수 있는 VIEW 

4가지 카테고리로 나뉜다. 



테이블 정보 조회해보기 

dictionary : 오라클의 객체 정보를 볼 수 있는 view 
dictionary 의 종류는 dictionary view 를 통해 조회가 가능

SELECT * 
FROM dictionary; 

dictionary 는 크게 4가지로 구분이 가능하다. 
USER_ : 해당 사용자가 소유한 객체만 조회 
ALL_ : 해당 사용자가 소유한 객체 + 다른 사용자로부터 권한을 부여받은 객체 
DBA_ : 시스템 관리자만 볼 수 있으며 모든 사용자의 객체 조회 
V$ : 시스템 성능과 관련된 특수 VIEW  

SELECT * 
FROM user_tables; 


내가 볼 수 있는 애를 볼수있어 내꺼아닌데 보이는거(dual ) 같이 
SELECT * 
FROM all_tables; 

DBA 권한이 있는 계정에서만 조회가 가능 ( SYSTEM, SYS) 
SELECT * 
FROM dba_tables; 



































