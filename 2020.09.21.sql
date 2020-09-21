1. PRIMARY KEY : NOT NULL + UNIQUE 
2. FOREIGN KEY : 
3. NOT NULL :
4. UNIQUE :
5. CHECK : 
테이블생성하는것과 FOREINT KEY 문제가 나옴.... 


명명규칙 primary key : pk_테이블명 
FOREIGN KEY : FK_소스테이블명_참조테이블명 

제약조건 삭제 
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명; 

1. 부서 테이블에 PRIMARY KEY 제약조건 
2. 부서 테이블에 PRIMARY KEY 제약 조건 추가 
3. 사원 테이블 - 부서 테이블관 FOREIGN KEY 제약 조건. 

자식이 있는데 부모를 먼저 삭제할 수 없다. 

제약조건 삭제시는 데이터 입력과 반대로 자식부터 먼저 삭제 
3번을 먼저 삭제 PRIMARY KEY는 독립적인것이기 때문에 상관이 없다. 

ALTER TABLE emp_test DROP CONSTRAINT FK_emp_test_dept_test; 
ALTER TABLE dept_test DROP CONSTRAINT pk_dept_test; 
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test; 

 
SELECT * 
FROM user_constraints
WHERE table_name IN ( 'EMP_TEST' , 'DEPT_TEST') ; 

내가 삭제를 안해도 잠깐 비활성화 해놓을 수 있는게 있다. 








SELECT * 
FROM  user_tables; 

SELECT * 
FROM user_constraints
WHERE table_name IN ( 'EMP_TEST' , 'DEPT_TEST' ) ; 


제약조건 생성 

1.

SELECT * 
FROM dept_test




ALTER TABLE dept_test ADD CONSTRAINT pk_dept_test PRIMARY KEY ( deptno );  
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (emp) ;
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) 
REFERENCES dept_test(deptno);


제약조건 조회하는거 

SELECT * 
FROM user_constraints
WHERE table_name IN ( 'EMP_TEST' , 'DEPT_TEST' ) ; 

제약조건 활성화 - 비활성화 테스트
테스트 데이터 준비 : 부모 - 자식관계가 있는 테이블에서는 부모테이블에 데이터를 먼저 입력한다. 
dept_test ==> emp_test

INSERT INTO dept_test VALUES ( 10, 'ddit' ) ; 

SELECT *
FROM dept_test


INSERT INTO emp_test VALUES ( 98, 'sally' , 20 ) ; 

20번 부서는 dept_test 테이블에 존재하지 않는 데이터이기 때문에 fk에 의해 입력이 불가능하다. 

SELECT * 
FROM emp_test ;


FK 를 비활성화 한후 다시 입력
ALTER TABLE emp_test DISABLE CONSTRAINT FK_emp_test_dept_test; 
INSERT INTO emp_test VALUES (98, 'sally' , 20 ) ; 






SELECT * 
FROM user_constraints
WHERE table_name IN ( 'EMP_TEST' , 'DEPT_TEST' ) ; 


FK 제약조건 재활성화 

ALTER TABLE emp_test ENABLE CONSTRAINT FK_emp_test_dept_test; 



SELECT * 
FROM emp_test ;

SELECT * 
FROM dept_test;


테이블, 컬럼 주석 ( COMMENTS ) 생성 가능 
테이블 주석 정보확인 
SELECT * 
FROM user_tab_comments; 
comments 가 주석정보가 나와있다. 

테이블 주석 작성 방법

COMMENT ON TABLE 테이블명 IS '주석' ; 

EMP 테이블에 주석 ( 사원) 생성하기; 

COMMENT ON TABLE emp IS '사원' ; 

* 테이블뿐만아니라 컬럼주석도 만들수가 있다. 

컬럼 주석 확인 

SELECT * 
FROM user_col_comments; 

간단하게 
SELECT * 
FROM user_col_comments
WHERE table_name = 'EMP' 


컬럼 주석 다는 문법 

COMMENT ON COLUMN 테이블명.컬럼명 IS '주석'; 



COMMENT ON COLUMN emp.EMPNO is '사번' ;  
COMMENT ON COLUMN emp.ENAME is '사원이름';    
COMMENT ON COLUMN emp.JOB is '담당역할'   ;   
COMMENT ON COLUMN emp.MGR is '메니저 사번' ;     
COMMENT ON COLUMN emp.HIREDATE is '입사일자'; 
COMMENT ON COLUMN emp.SAL is '급여'      ;
COMMENT ON COLUMN emp.COMM is '성과급'    ; 
COMMENT ON COLUMN emp.DEPTNO is '부서번호' ;  
                                     

table comments 실습 comment1 

SELECT * 
FROM user_tab_comments 

SELECT * 
FROM user_col_comments 


공통 : table_name 

찾을것 table_name , tab.table type,  comments

SELECT col.table_name , table_type , col.comments tab_comment , 
col.column_name , col.comments col_comment 
FROM user_col_comments col , user_tab_comments tab 
WHERE col.table_name IN ( 'CUSTOMER' , 'PRODUCT' , 'CYCLE' , 'DAILY' ) 
AND col.TABLE_NAME = tab.TABLE_NAME


SELECT *
FROM user_col_comments col , user_tab_comments tab 
WHERE col.table_name IN ( 'CUSTOMER' , 'PRODUCT' , 'CYCLE' , 'DAILY' ) 
AND col.TABLE_NAME = tab.TABLE_NAME

----------------------------테이블 커멘트 끝 

SELECT * 
FROM user_constraints
WHERE table_name IN( 'EMP', 


EXERD scott 에서


SELECT * 
FROM emp

SELECT * 
FROM dept


ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY ( empno ) 
ALTER TABLE emp ADD CONSTRAINT PK_dept PRIMARY KEY ( deptno ) 

과제로 해와 ~~ 

-----------------

view 

문법 

create or replace view 뷰이름 as 
SELECT 쿼리 ; 

뷰 만들기 

emp 테이블에서 sal, comm 컬럼 두개를 제외한 나머지 6개 컬럼으로 v_emp 이름으로 view 생성 


CREATE OR REPLACE VIEW v_emp AS 
SELECT empno, ename, job, mgr, hiredate, deptno 
FROM emp; 

GRANT CONNECT, RESOURCE TO 계정명 ; 
VIEW 에 대한 생성권한은 RESOURCE 에 포함되지 않는다. 
--system 계정에서 grant 를 하고 위에 create 를 해야한다. 

1.
SELECT * 
FROM v_emp ; 


2.
SELECT * 
FROM 
(SELECT empno, ename, job, mgr, hiredate, deptno 
FROM emp ) ; 

1번과 2번이 동일하지만 1번은 계속 쓸 수 있고 2번은 기술할때 마다 써줘야 한다. 


view 는 쿼리다. 
셀렉트쿼리에서 정의된 논리적인 데이터 정의 집합이다. 
테이블처럼 물리적인 데이터를 가지고 있는게 아니다. 
- > 만약 emp 테이블에서 14개가 있는데 10번 부서에 속하는
3개를 지우면 . 동일하게 11개가 (SELECT empno, ename, job, mgr, hiredate, deptno 
FROM emp ) ; 여기서도 나오고 얘를 가지고 만든 SELECT * 
FROM v_emp ;  
얘도 동일하게 11개가 나온다. 


view : vies 는 쿼리이다. (VIEW 는 테이블이라는 것은 잘못된 표현이다. ) 
물리적인 데이터를 갖고 있지 않고, 논리적인 데이터 정의 집합이다(SELECT 쿼리 ) 
VIEW가 사용하고 있는 테이블의 데이터가 바뀌면 VIEW 조회 결과도 같이 바뀐다. 

AURORA 계정에 있는 V_EMP 뷰를 HR 계정에게 조회할 수 있도록 권한 부여 

GRANT SELECT ON v_emp TO HR; 











