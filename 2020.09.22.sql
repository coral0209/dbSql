VIEW 를 사용하는 사례 


1. 첫번째 사례
데이터 노출을 방지할때 사용 ( emp 테이블의 sal, comm 을 제외하고 view 를 생성 , 
hr 계정에게 view 를 조회할 수 있는 권하을 부여한다. 

hr 계정에서는 emp 테이블을 직접 조회하지 못하지만 v_emp 는 가능

==> V_EMP 에는 sal, comm 컬럼 없기 때문에 급여 관련 정보를 감출 수 있었다. 



2. 자주사용되는 쿼리를 view 로 만들어서 재사용한다. 

ex) emp 테이블은 보통 dept 테이블이랑 조인되서 사용되는 경우가 많음 
 view 를 만들지 않을 경우 매번 조인 쿼리를 작성해야하나, view 로만들면 재사용이 가능하다. 
 
 
 emp 테이블과 dept 테이블을 deptno 가 같은 조건으로 조인한 결과를 v_emp_dept 이름으로 
 view 생성 
 
 CREATE OR REPLACE VIEW v_emp_dept AS 
 SELECT emp.* , dept.dname, dept.loc 
 FROM emp , dept 
 WHERE emp.deptno = dept.deptno ; 
 
 ===>
 
 SELECT * 
 FROM v_emp_dept;
 
 
 : 코드가 간단해짐. 새로운 쿼리를 만들어서 자주사용하는애를 사용하는 격이다. 
 
 VIEW 삭제 
 
 
 DROP VIEW 뷰의 이름 ( v_emp_dept) ; 
 
 
 DROP VIEW v_emp_dept; ( 실습없음 하면 지워짐) 
 
 
 
 
 CREATE VIEW v_emp_cnt AS 
 SELECT deptno, COUNT(*) cnt
 FROM emp 
 GROUP BY deptno ; 
 
SELECT * 
FROM v_emp ; 
 
 
 
심플뷰에서는 VIEW 테이블에서의 데이터를 변경하면 원래본 데이터를 변경됨. 

복합뷰는 업데이트가 안된다 예를들어서 
COUNT(*) 
GROUP BY 로 묶은 애의 전체를 조회해봤을때 걔네를 바꾸면 원함수가 어떻게 처리될지 모르겠지? 

식별자 : 열쇠 모양있는애 

그 테이블을 대표하는것. empno 같은것. 

1.sequence 를 사용해서 
시퀀스를 통해서 중복되지 않은 정수값을 구해냄 . 
2. uuid 중복되지 않는 값을 만들어냄 .

sequence : 중복되지 않는 정수값을 만들어내는 오라클 객체 
java  : uuid 클래스를 통해 중복되지 않는 문자열을 생성할 수 있다. 


문법 : CREATE SEQUENCE 시퀀스이름. 


SEQ_사용할테이블이름; 

CREATE SEQUENCE SEQ_emp ; 
만들었음. 

사용방법 : 함수를 생각하자 
함수 테스트 : dual 테이스 

시퀀스 종류 2가지가 있다. 
시퀀스 객체명.nextval : 시퀀스 객체에서 마지막으로 사용한 다음 값을 반환한다. 
시퀀스 객체명.currval : nestval 함수를 실행하고 나서 사용할 수 있다. nexctval 함수를
통해 얻어진 값을 반환. 

SELECT seq_emp.nextval 
FROM dual; 

SELECT seq_emp.currval 
FROM dual ; 

currval 은 방급 뭐를 호출했는지 기억하고 그 값이 나옴 .

자기가 마지막으로 사용한 값을 기억을 하고 있는것. 

사용예 ) 

INSERT INTO emp ( empno, ename, hiredate )                                       
                  VALUES(seq_emp.nextval , 'borwn' , SYSDATE ) ; 
 
 
 SELECT * 
 FROM emp ;
 
 
중복되지 않는 값을 만들어낸다 ->   
 
 의미가 있는 값에 대해서는 시쿠너스만 갖고는 만들 수 없다 
 시퀀스를 통해서는 중복죄다 않는 값을 생성 할 수 있따.
 
 create sequence 
 
 시퀀스는 롤벡을 하더라도 읽은 값이 복원되지 않는다. 
 
 
 CREATE SEQUENCE SEQ_ENO ; 

 * 오라클
 
 캐싱 
 unique 한 값을 생성해야 하므로 동시성 제어가 필요 
 
 동시에 접속하지 못하게 lock을 쓴다. 
 
 
 
 
 인덱스 . 고급개발자로 가려면 잘 알아야 하는것
 
 
 시간복잡도 
 
 n 개 가정 
 -> 
 
 정렬이 되어 있다라는 가정. 
 반씩 잘라서 찾을 수 있다. 
 
 
 
 
 목차 
 
in
 
INDEX : TABLE 의 일부 컬럼을 기준으로 미리 정렬해둔 객체 

ROWID : 테이블에 저장된 행의 위치를 나타내는 값 

SELECT ROWID, empno, ename 
FROM emp ;
 
 만약 rowid 를 알 수만 있으면 해당 테이블의 모든 데이터를 뒤지지 않아도 해당 행에
 바로 접근을 할 수가 있다. 
 SELECT * 
 FROM emp 
 WHERE ROWID = 'AAAE5hAAFAAAACMAAH'
 
 
 SELECT * 
 FROM TABLE(dbms_xplan.display); 
 
rowid를 알고 있기때문에 한건의 데이터를 읽기 위해서 한건의 데이터에 접근을 한것. 

테이블의 원하는 행에 빠르게 접근할 수 있다. rowid 로 



oracle db data structure 

테이블스페이스 tablespace  
밑에 블럭의 개념 : 
block : 오라클의 기본 입출력 단위이다. 
block 의 크기는 데이터 베이스 생성시 결정, 기본값 8k byte
emp 
desc emp; 
emp 테이블 한행은 최대 54byte 
block 하나에는 emp 테이블을 8000/54 = 약 160
블럭하나에는 160개의 행이 들어갈 수 있음

*사용자가 한행을 읽어도 해당 행이 담겨져 있는 block을 전체로 읽는다. 
왜냐면 오라클의 기본 입출력단위가 블럭이기 때문 


이진 탐색 

이진 트리로 구성 
자식이 두개 

root 20  

자료구조


어제 과제. 
SELECT * 
FROM user_constraints
WHERE table_name = 'EMP' ; 

emp 테이블의 empno 컬럼에 primary key 추가
ALTER TABLE emp ADD constraint pk_emp PRIMARY KEY (empno ) ; 

PRIMARY KEY ( UNIQUE + NOT NULL)  , UNIQUE 제약을 생성하면 해당 컬럼으로 인덱스를 생성한다. 
==> 인덱스가 있으면 값을 빠르게 찾을 수 있다. 
해당 컬럼에 중복된 값을 빠르게 찾기 위한 제한사항 

-0---
인덱스는 인덱스 구성 컬럼으로 정렬이 되어있다. 인덱스 구성컬럼 옆에는 rowid 를 가지고 있다. 

시나리오 0 
테이블만 있는 경우 ( 제약조건, 인덱스가 없는 경우 ) 
SELECT * 
FROM emp 
WHERE empno = 7782; 
테이블에는 순서가 없기 때문에 emp 테이블의 14건의 데이터를 모두 뒤져보고 
empno 값이 7782 인 한건에 대해서만 사용자에게 반환을 한다 

시나리오 1 

emp 테이블의 empno 컬럼에 PK_EMP 유니크 인덱스가 생성된 경우
(우리는 인덱스를 직접 생성하지 않았고 PRIMARY KEY 제약조건에 의해 자동으로 생성 됨 ) 
SELECT * 
FROM emp 
WHERE emp = 7782;
*트리로 찾아갈 수 있는것. 
바로 7782 를 바로 알게 되고 ( 반으로 나눈 트리처럼 ) rowid 를 옆에 있는 애를 읽고 
그것으로 테이블 정보를 알수 있는것. ( 바로 ) ( rowid 가 인덱스이다. ) 
정확히 얘기하면 2개의 행을 읽은것 


EXPLAIN PLAN FOR 
SELECT * 
FROM emp 
WHERE empno = 7782 ;

SELECT * 
FROM TABLE(dbms_xplan.display) ; 


2 -> 1-> 0 번으로 읽고 . 

filter는 컬럼 데이터를 다 읽는것. 
eccess 는 rowid로 읽는것이고

데이터가 많아질수록 차이가 크다. 

시나리오 2 

emp 테이블의 emp 컬럼에 PRIMARY KEY 제약조건이 걸려 있는 경우 

EXPLAIN PLAN FOR
SELECT empno  -- 위에거랑 여기부분만 바꼈는데 그냥 인덱스만 읽고 결과를 준거다. 
FROM emp
WHERE empno = 7782 ; 

SELECT * 
FROM TABLE(dbms_xplan.display ) ; 



UNIQUE 인덱스 : 인덱스 구성의 컬럼의 중복 값을 허용하지 않는 인덱스 ( emp.empno )  
NON- UNIQUE 인덱스 : 인덱스 구성 컬럼의 중복값을 허용하는 인덱스  ( emp.deptno , emp.job ) 


시나리오3 
emp 테이블의 empno 컬럼에 non-unique 인덱스가 있는 경우 
ALTER TABLE emp DROP CONSTRAINT pk_emp ; 

인덱스 만드는것 

IDX ( 다를수있지만 이렇게 했었데. ) 
IDX_테이블명_U (유니크일때
IND_테이블명_N_ 순번 붙여주기 . (논유니크일때  

CREATE INDEX IDX_emp_N_01 ON emp ( empno ) ; 
emp 테이블 왼쪽에서 보면 인덱스에서보면 유니크네스에 논유니크라고 써있어


EXPLAIN PLAN FOR 
SELECT * 
FROM emp 
WHERE empno = 7782; 

SELECT * 
FROM TABlE(dbms_xplan.display) 

지금은 인덱스값이 중복이 가능하다 ( 인덱스값이 있고 없고가 중요한게 아니라 ) 
인덱스를 허용한다. 
7782 에 접근을 하고 (rowid 로 ) 
정렬이 되어 있기때문에 다음꺼를 읽고 7782이면 중복값이 존재하는거고 그게아니면 읽을필요가
없다. 순서크기대로 정렬이 되어 있는거기 때문에 
다음값을 한번더 읽어봐야지 plus non scan 이라고 표현을 하기도 해 ( index range scan )  


시나리오 4 
emp 테이블의 job 컬럼으로 non_unique 인덱스를 생성한 경우
CREATE INDEX idx_emp_n_02 ON emp ( job ); 

emp 테이블에는 현재 인덱스가 2개 존재 
idx_emp_n_01 : empno 
idx_emp_n_02 : job 



EXPLAIN plan FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' ; 

SELECT * 
FROM TABLE(dbms_xplan.display); 


인덱스를 4건 테이블은 3건을 읽음 




시나리오 5

emp 테이블에는 현재 인덱스가 2개 존재 
idx_emp_n_01 : empno 
idx_emp_n_02 : job 

EXPLAIN plan FOR
SELECT *
FROM emp 
WHERE job = 'MANAGER' 
AND   ename LIKE 'C%' ; -- 이부분은 emp 테이블에 가서 봐야지 알 수 있는 부분이다. 

SELECT * 
FROM TABLE(dbms_xplan.display); 


인덱스를 4건 테이블은 3건을 읽음 

시나리오 6
CREATE INDEX idx_emp_n_03 ON emp ( job, ename ) ; 
emp 테이블에는 현재 인덱스가 2개 존재 
idx_emp_n_01 : empno 
idx_emp_n_02 : job 
idx_emp_n_03 : job , ename --job 컬럼으로 정렬을 하고 job 이 같은 애들은 ename 으로 정렬 

SELECT job, ename, ROWID 
FROM emp 
ORDER BY job, ename ; 


EXPLAIN PLAN FOR 
SELECT * 
FROM emp 
WHERE job = 'MANAGER' 
AND  ename LIKE 'C%' ; 

SELECT * 
FROM TABLE (dbms_xplan.display) 
--접근일때도 ACCESS 일때도 조건이 있고 FILTER 에서도 조건이 있다. 
-- ACCESS 에서만 데이터를 읽고 FILTER 에서는 하나만 읽으면 된다. 
그래서 어떤 인덱스로 만들지를 중요하게 생각을 해봐야한다. 


시나리오 7
DROP INDEX idx_emp_n_03; 
CREATE INDEX idx_emp_n_04 ON emp ( ename, job ) ; 
emp 테이블에는 현재 인덱스가 2개 존재 
idx_emp_n_01 : empno 
idx_emp_n_02 : job 
idx_emp_n_03 : ename, job 

SELECT ename, job, ROWID 
FROM emp 
ORDER BY ename, job; 

SELECT ename
FROM emp 
ORDER BY ename, job; 

SELECT job
FROM emp 
ORDER BY ename, job; 


EXPLAIN PLAN FOR
SELECT * 
FROM emp 
WHERE job = 'MANAGER' 
AND    ename LIKE 'C%' ; 


SELECT * 
FROM TABLE (dbms_xplan.display) ; 

-- 왼쪽에 있는 화살표하나를 access라고 할 수 있다. 
--테이블왼쪽테이블을 전부 access 라고 하진 않는다. 
--오른쪽테이블에 가는 화살표는 access 라고 보기 어렵다. 

시나리오 8
DROP INDEX idx_emp_n_01; 
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY( empno ) ; 
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY ( deptno ) ; 

emp 테이블에는 현재 인덱스가 3개 존재 
pk_emp_n_01 : empno 
idx_emp_n_02 : job 
idx_emp_n_04 : ename, job 


dept 테이블에는 현재 인덱스가 1개 존재 
pk_dept : deptno 


dept 테이블의 deptno 컬럼에 unique 인덱스 생성 


emp =-=> dept 4가지  2가지 == 조합 : 8가지    or dept ==> emp 2가지  4가지 == 조합 : 8가지 
총 16가지 
각각에서도 인덱스를 쓸것인가 안쓸것인가 

SELECT ename, dname, loc
FROM emp, dept 
WHERE emp.deptno = dept.deptno 
AND emp.empno = 7788; 


상수값인 7788 을 먼저 읽을 가능성이 높다. 

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept 
WHERE emp.deptno = dept.deptno 
AND emp.empno = 7788; 

SELECT * 
FROM TABLE (dbms_xplan.display) ; 

실행계획 읽기 :  3, 2, 5, 4, 1, 0 
 
 
 
 
 
 
 
 
 
 
 
 
 