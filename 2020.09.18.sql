DML : DATA Manipulate Language 
1. SELECT 
2. INSERT 
3. UPDATE
4. DELETE 


오라클의 대표적인 객체들 ppt 중 

Table 순서 보장하지 않음. order by 로 순서를 해줘야 했었지. 


DDL : Data Defination Language 
데이터와 관련된 객체를 생성, 수정, 삭제 

테이블에있는 애들 (왼쪽접속 하위파일) 과 같은 이름만들 수 없다. 

오라클 객체 생성, 삭제 명령
CREATE 객체타입 객체이름 - 개발자가 부여 
DROP 객체타입 객체이름; 


***** 
 테이블을 생성하는 문법 (못외워도 찾아서 사용할 수 있으면 된다 .) 
       --모델링 툴을 사용하여 설계를 하게 되면 툴에서 설계된 테이블을 생성하는 구문을 자동으로 만들어준다 
       -- 설계를 다하고 뭔가를 더 추가하고 싶을때는 직접 내가 하게 될 수가 있다. 
CREATE TABLE [오라클 사용자].테이블명 ( 
   컬럼명 컬럼의 데이터 타입, 
    컬럼명 컬럼의 데이터 타입2,
     컬럼명 컬럼의 데이터 타입3
     ..............
); 

테이블을 생성을 하는데 
테이블명 - ranger 
컬럼     ranger_no NUMBER 
        ranger_nm VARCHAR2(50) , 
        reg_dt DATE

테이블 생성하기 

CREATE TABLE ranger( 
        ranger_no NUMBER ,
        ranger_nm VARCHAR2(50) , 
        reg_dt DATE ) ;




INSERT INTO ranger ( ranger_no , ranger_nm ) values ( 20, '바보' ) 
INSERT INTO ranger values ( 1, 'brown' , SYSDATE) 

DROP TABLE ranger; 

--삭제하기 
--

SELECT *
FROM ranger;

DESC ranger ; 
--


주로 사용하는 데이터 타입 

1. 숫자 : NUMBER ( p, s ) p : 전체 자리수의미 . s : 소수점 자리수라고 생각하자 (생각하면힘듬 그냥 
        NUMBER 를 쓰는걸 추천 ) 
         NUMBER 라고만 써도 숫자가 표현할 수 있는 최대 범위로 표현 
2. 문자 : VARCHAR2(사이즈 - 기본으로는 BYTE를 의미) , CHAR( 안씀 )
         VARCHAR2 의 최대 사이즈 4000 BYTE
         VARCHAR2 (2000) : 최대 2000바이트짜리 문자를 담을 수 있는 문자 타입 
         java - 2byte , oracle xe 11g 은 3byte  한글한자한자크기 

         CHAR(1~2000 byte ) , 고정길이 문자열
         CHAR(5) 'test' 
         test 는 4 byte 고 char(5) 5 type 이기 때문에
         남은 데이터 공간에 공백 문자를 삽입함 
         'test' == 'test ' 

3. 날짜 : DATE  - 7 byte 고정
            일자, 시간( 시, 분, 초 ) 정보 저장 

        varchar2 로 날짜 관리 : YYYYMMDD -> '20200918' 숫자기때문에 8바이트 그러나 
         DATE는 7바이트다. 
         시스템에서 문자형식으로 많이 사용한다면 문자 타입으로 사용도 고려 

4.  Large OBJECT 
     4.1 CLOB : 문자열을 저장할 수 있는 타입, 사이즈 : 4GB 
     4.2 BLOB : 바이너리 데이터 , 사이즈 : 4GB 
         - CMS 월 자동이체 하는 애들은 고객이 동의를 한것 -> 중요한것 -> BLOB을 사용 
          CLOB을 외우면 된다. ~~~~!!!! 

제약 조건 : 데이터에 이상한 값이 들어가지 않도록 강제하는 설정 

          ex)  emp 테이블에 empno 컬럼의 값이 없는 상태로 들어가는 것을 방지
               emp 테이블에 deptno 컬럼의 값이 dept 테이블에 존재하지 않는
               데이터를 입력하는 것을 방지 
               emp 테이블에 empno(사번) 컬럼의 값이 중복되지 않도록 방지
               
               
               
제약조건은 4가지가 존재, 그 중에 한가지의 일부를 별도의 키워드로 제공 
ORACLE 에서 만들 수 있는 제약조건 5가지 



1. NOT NULL : 컬럼에 반드시 값이 들어가게 하는 제약조건 
2. UNIQUE : 해당 컬럼에 중복된 값이 들어오는 것을 방지하는 제약조건  ( 유니크만하면 값이 NULL값이 들어가는 것이 가능해 ) 
3. PRIMARY KEY : UNIQUE + NOT NULL 
4. FOREIGN KEY : 해당 컬럼이 참조하는 다른 테이블의 컬럼에 값이 존재해야 하는 제약조건 
             emp.deptno ==> dept.deptno 
5. CHECK : 컬럼에 들어갈 수 있는 값을 제한하는 제약조건 
           EX ) 성별이라는 컬럼 가장 : 남 M, 여 F   .. 여기에 T라는값이 들어가면 모호해짐 
           입력자체를 거부할 수 있다. 
           NOT NULL은 CHECK 제약조건의 특수한 것 
           
 제약조건을 생성하는 방법 3가지 
 1. 테이블을 생성하면서 컬럼 레벨에 제약조건을 생성 
 --문제 : 제약조건을 결합 컬럼 ( 여러개의 컬럼을 합쳐서 ) 
 2. 테이블을 생성하면서 테이블 레벨에 제약조건을 생성 (주요사용) 
 3. 이미 생성된 테이블에 제약조건을 추가하여 생성 
 
           
           
1. 테이블 생성시 컬럼 레벨로 제약조건 생성 


CREATE TABLE 테이블명 ( 
     컬럼1이름 컬럼1타입 [컬럼제약조건],
); 

CREATE TABLE dept_test ( 
       deptno NUMBER(2) PRIMARY KEY , 
       dname VARCHAR2(14) , 
       loc VARCHAR2(13) 
       ); --생성
       
PRIMARY KEY : UNIQUE ( 중복된 값이 발생할 수 없다 ) + NOT NULL ( NULL 값이 들어 갈 수 없다 )        


dept_test 테이블에 데이터가 없는 상태
INSERT INTO dept_test VALUES ( NULL , 'ddit' , 'daejeon' ) ;

--오류가 뜬다 cannot insert NULL into ("AURORA"."DEPT_TEST"."DEOTNO") 

deod ( 오류난거 dept임 ) 테이블에는 null 값이 들어갈 수 없다. 

INSERT INTO dept_test VALUES ( 90 , 'ddit' , 'daejeong' ) ; 
INSERT INTO dept_test VALUES ( 90 , 'ddit' , 'daejeong' ) ; 

--오류 : unique constraint (AURORA.SYS_C007097) violated 유니크 제약조건이 위배된것. 만들어줄때 deptno 는 primary key 조건을 해줬음 그래서
동일한 데이터가 들어가면 이렇게 오류가 나는것 


dept_test 테이블 생성
컬럼 : dept 테이블과 동일하게 
        deptno NUMBER (2) , dname VARCHAR2 ( 14) ,loc VARCHAR2 ( 13) 
제약조건 : deptno 컬럼을 primary key 제약조건으로 생성



비교 

dept 테이블에는 deptno 컬럼에 PRIMARY KEY 제약이 없는 상태 
따라서 동일한 데이터가 들어가는게 가능하다. 
INSERT INTO dept VALUES ( 90, 'ddit' , ' daejeon ' ) ; 
INSERT INTO dept VALUES ( 90, 'ddit' , ' daejeon ' ) ; 

SELECT * 
FROM dept 
WHERE deptno = '90' ; 


제약조건 생성시 이름을 부여 


명명 규칙 : PK_테이블명

CREATE TABLE dept_test ( 
       deptno NUMBER(2) CONSTRAINT 제약조건 이름 써주기 PRIMARY KEY , 
       dname VARCHAR2(14) , 
       loc VARCHAR2(13) 
       ); --생성

CREATE TABLE dept_test ( 
       deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY , 
       dname VARCHAR2(14) , 
       loc VARCHAR2(13) 
       ); --생성



INSERT INTO dept_test VALUES ( 90, 'ddit' , ' daejeon ' ) ; 
INSERT INTO dept_test VALUES ( 90, 'ddit' , ' daejeon ' ) ; 

오류 : unique constraint (AURORA.PK_DEPT_TEST) violated 저기 내가 부여해준 이름이 있음 


DROP TABLE dept_test; 

2, 테이블 생성시 테이블 레벨로 제약조건 생성 
 CREATE TABLE 테이블명 ( 
       컬럼 1 컬럼1의 데이터 타입, 
       컬럼 2 컬럼2의 데이터타입,   --여기 콤마가 꼭꼭 추가가 되어야 함 
       [TABLE LEVEL 제약조건 ]
       ); 
 
 
 
 DROP TABLE dept_test; 
 

 CREATE TABLE dept_test ( 
       deptno NUMBER(2)  , 
       dname VARCHAR2(14) , 
       loc VARCHAR2(13),
       CONSTRAINT PK_dept_test PRIMARY KEY (deptno, dname) -- ()여기에 중복개의 갯수인 컬럼이 올 수가 있다.  
       ); --생성
deptno 컬럼의 값은 90으로 같지만 dname 컬럼의 값이 다르므로 
PRIMARY KEY ( deptno, dname ) 설정에 따라 데이터가 입력될 수 있다. 
복합 컬럼에 대한 제약조건은 컬럼 레벨에서는 설명이 불가하고 
테이블 레벨, 혹은 테이블 생성 후 제약조건을 추가하는 형태에서만 가능하다. 


SELECT * 
FROM dept_test


INSERT INTO dept_test VALUES ( 90, 'DDIT' , 'DAEJEON' );  
INSERT INTO dept_test VALUES ( 90, 'DDIT2' , 'DAEJEON' ); 
INSERT INTO dept_test VALUES ( 90, 'DDIT' , 'DAEJEON' ) ; 얘는 안된다. 위에 두개 했으니까. 





NOT NULL 제약 조건 생성 

DROP TABLE dept_test; 

 CREATE TABLE dept_test ( 
       deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY   , 
       dname VARCHAR2(14) NOT NULL , 
       loc VARCHAR2(13)
       ); 
       
       INSERT INTO dept_test VALUES ( 90, 'DDIT' , 'DAEJEON' );  
       INSERT INTO dept_test VALUES ( 90, 'NULL' , '대전' );  
       
       UNIQUE 제약 조건 : 값의 중복이 없도록 방지하는 제약조건 , 단 NULL 은 허용한다. 
       
       
       
   DROP TABLE dept_test;     
       
       

    CREATE TABLE dept_test ( 
       deptno NUMBER(2) , 
       dname VARCHAR2(14) , 
       loc VARCHAR2(13),
       CONSTRAINT U_DEPT_TEST_DNAME UNIQUE (dname) ) ; 

INSERT INTO dept_test VALUES ( 90, 'DDIT' , 'DAEJEON' );  
INSERT INTO dept_test VALUES ( 90, NULL , 'DAEJEON' ); 
INSERT INTO dept_test VALUES ( 90, NULL , 'DAEJEON' ); 
--NULL 은 넣어질 수 있다. 
INSERT INTO dept_test VALUES ( 90, 'DDIT' , 'DAEJEON' ); 
--다른 데이터는 중복이 안된다 UNUIQUE 조건을 해놨기 때문 


-------------------------------------------------------------------------------------------------------------------------------

DDL 

FOREIGN KEY 제약조건 : 참조하는 테이블에 데이터만 입력가능하도록 제어 

다른 제약조건과 다르게 두개의 테이블간의 제약조건 설정 
1. dept_test ( 부모 테이블 생성 ) 
2. emp_test ( 자식 ) 테이블 생성
    2.1 참조 제약 조건을 같이 생성 
    
DROP TABLE dept_test;
    CREATE TABLE dept_test ( 
       deptno NUMBER(2) PRIMARY KEY , 
       dname VARCHAR2(14) , 
       loc VARCHAR2(13) )
  
INSERT INTO dept_test VALUES ( 90, 'ddit' , 'daejeon' );  

2. emp_test ( empno, ename, deptno ) 
DESC emp ; 

CREATE TABLE emp_test ( 
empno NUMBER (4), 
ename VARCHAR2(10), 
deptno NUMBER (2) REFERENCES dept_test (deptno) 
); 

참조 무결성 제약조건에 의해 emp_test 테이블의 deptno 컬럼의 값은 dept_test 테이블의 deptno 컬럼에 존재하는 값만 입력이 가능하다. 

현재는 dept_test 테이블에는 90번 부서만 존재,
그렇기 때문에 emp_test 에는 90번 이외의 값이 들어갈 수 가 없다. 

INSERT INTO emp_test VALUES ( 9000, brown ,  '90' ) ; 
INSERT INTO emp_test VALUES ( 9001, brown ,  10 ) ; 



SELECT * 
FROM emp_test

SELECT *
FROM dept_test



테이블 레벨 참조 무결성 제약조건 생성 

DROP TABLE emp_test ; 
FK_소스테이블_참조테이블

 CREATE TABLE emp_test ( 
       empno NUMBER(4), 
       ename VARCHAR2(10) , 
       deptno VARCHAR2(2),
       CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) 
       REFERENCES dept_test ( deptno )) ;
       
       참조무결성

----------완전 잘못함... 선생님꺼 배껴야해.. 


만약 dept_test 테이블에서 10번 부서를 삭제하게 된다면?? 
dept_test : 데이터가 미존재
emp_test : 90 번 부서를 참조하는 9000번 brown 이 존재 

DELETE dept_test 
WHERE deptno = 90 ; 
참조 무결성 조건 옵션 
1. defaul : 자식이 있는 부모 데이터를 삭제할 수 없다. 
2. 참조 무결성 생성시 OPTION - ON DELETE SET NULL 
삭제시 참조 하고 있는 자식테이블의 컬럼을 null로 만든다. 
3. 참조 무결성 생성시 OPTION - ON DELETE SET CASCADE 
삭제시 참조 하고 있는 자식테이블 데이터도 같이 삭제 

입력시 : 부모 -> 자식순으로 입력
삭제시 : 자식 -> 부모순으로 삭제 
--위험하다. 



2. 

DROP TABLE emp_test; 

 CREATE TABLE emp_test ( 
       empno NUMBER(4)  , 
       ename VARCHAR2(10) , 
       deptno number(2),
   CONSTRAINT FK_emp_test_dept_test FOREIGN KEY ( deptno ) 
   REFERENCES dept_test (deptno ) ON DELETE SET NULL 
) ; 
INSERT INTO emp_test VALUES ( 9000, 'brown' , 90 );

DELETE dept_test 
WHERE deptno = 90 ; 

90번에 속한 9000번 사원의  deptno 컬럼의 값이 null로 설정됨 





3. 
DROP TABLE emp_test; 

 CREATE TABLE emp_test ( 
       empno NUMBER(4)  , 
       ename VARCHAR2(10) , 
       deptno number(2),
   CONSTRAINT FK_emp_test_dept_test FOREIGN KEY ( deptno ) 
   REFERENCES dept_test (deptno )  ON DELETE CASCADE
) ; 
INSERT INTO dept_test VALUES ( 90, 'didt' , 'daejeon' ) ; 
INSERT INTO dept_test VALUES ( 9000, 'didt' , 'daejeon' ) ; 

INSERT INTO emp_test VALUES ( 9000, 'brown' , 90 );

DELETE dept_test 
WHERE deptno = 90 ; 

90번에 부서에 속한 9000번 사원의 데이터도 같이 삭제가 된다. 



체크 제약조건 : 컬럼의 값을 확인하여 입력을 허용 

DROP TABLE emp_test; 
CREATE TABLE emp_test (
    empno NUMBER(4) ,
    ename VARCHAR2(14), 
    sal NUMBER(7) CHECK (SAL > 0 ),
    gender VARCHAR2 (1) CHECK ( gender IN ( 'M' , 'F' ) )
);

INSERT INTO emp_test VALUES ( 9000, 'brown' , -5 , 'M' ) ; SAL 체크
INSERT INTO emp_test VALUES ( 9000, 'brown' , 100 , 'T' ) ; 성별체크
INSERT INTO emp_test VALUES ( 9000, 'brown' , 100 , 'M' ) ; 체크통과 





-----------------------------


DROP TABLE emp_test; 
CREATE TABLE emp_test (
    empno NUMBER(4) ,
    ename VARCHAR2(14), 
    sal NUMBER(7) CONSTRAINT C_sal CHECK (SAL > 0 ),
    gender VARCHAR2(1) CONSTRAINT C_gender CHECK ( gender IN ( 'M' , 'F' ) )
);

INSERT INTO emp_test VALUES ( 9000, 'brown' , -5 , 'M' ) ; SAL 체크
INSERT INTO emp_test VALUES ( 9000, 'brown' , 100 , 'T' ) ; 성별체크
INSERT INTO emp_test VALUES ( 9000, 'brown' , 100 , 'M' ) ; 체크통과 




------------------------------------------------------------------

DROP TABLE emp_test; 
CREATE TABLE emp_test (
    empno NUMBER(4) ,
    ename VARCHAR2(14), 
    sal NUMBER(7),
    gender VARCHAR2(1), 
     CONSTRAINT C_sal CHECK (SAL > 0 ),
     CONSTRAINT C_gender CHECK ( gender IN ( 'M' , 'F' ) )
);
--테이블 레벨에서 생성하는 방법 

INSERT INTO emp_test VALUES ( 9000, 'brown' , -5 , 'M' ) ; SAL 체크
INSERT INTO emp_test VALUES ( 9000, 'brown' , 100 , 'T' ) ; 성별체크
INSERT INTO emp_test VALUES ( 9000, 'brown' , 100 , 'M' ) ; 체크통과 


COMMIT ROLLBACK ; 


DDL 주의점 
1. DDL ROLLBACK  이 안된다. 
 DROP TABLE emp_test; 
 CREATE TABLE emp_test ( 
 empno NUMBER(4), 
 ename VARCHAR2(14) 
 ); 
ROLLBACKE ; 


SELECT *
FROM emp_test; 


ROLLBACK이 안된다. 





2. DDL은 AUTO COMMIT 이다. 
--조심해야한다. 

DROP TABLE emp_test; 
DROP TABLE dept_test;



CREATE TABLE emp_test ( 
    empno NUMBER(4) , 
    ename VARCHAR2 (14) 
    ) ; 
    
CREATE TABLE emp_test ( 
    deptno NUMBER(4) , 
    deptno VARCHAR2 (14) 
    ) ; 
    
    
    INSERT INTO emp_test VALUES(9000, 'brown' ) ; 
    
    롤백을 했는데도 데이터가 남아있다.
    DDL은 오토커밋이다. 
    다음부터는 새로운 트랜잭션이다. 
    DDL은 다른작업을 끝내놓고 해야 안전하다. 


------------------------------------------------------


-SELECT 결과를 이용하여 테이블 생성하기 


CREATE TABLE AS ==> CTAS 
1.  NOT NULL 제약조건을 제외한 나머지 제약조건을 복사하지는 않는다. 
2. 개발시 사용 
   테스트 데이터를 만들어놓고 실험을 해보고 싶을 때  
   개발자 수준의 데이터 백업
   CREATE TABLE emp_20200918 AS 
   SELECT * 
   FROM emp; 
   
   -- 백업을 위한 조치를 마련해 놓은것 
   

CREATE TABLE 테이블명 [ ( 컬럼, 컬럼2 ) } AS 
SELECT 쿼리 ; 

DROP TABLE dept_test; 
DROP TABLE emp_test; 


CREATE TABLE dept_test AS 
SELECT * 
FROM dept ; 


SELECT * 
FROM dept_test ; 


DROP TABLE dept_test; 
CREATE TABLE dept_test ( age, location, love ) AS 
SELECT * 
FROM dept ; 



데이터 없이 테이블 구조만 복사하고 싶을 때 

DROP TABLE dept_test; 
CREATE TABLE dept_test ( age, location, love ) AS 
SELECT * 
FROM dept 
WHERE 1 = 2;

SELECT * 
FROM dept_test 
 -> 데이터 없이 테이블구조만 생기게 됨




지금까지는 TABLE 생성, 삭제 


이제 변경을 해보자. 

1. 새로운 컬럼을 추가하는 작업
2. 기존에 존재하는 컬럼의 변경 (이름, 데이터 타입 ) 
 주의:  ** 데이터 타입의 경우는 이미 데이터가 존재하면 수정이 거의 불가능하다. 
 예외 : 동일한 데이터 타입으로 사이즈를 늘리는 경우는  상관 없음 
   ==> 설계시 고려를 충분히 하자 
3. 제약조건을 테이블 생성할때만 만드는 건 아니고 이미 생성된 시점에서 제약조건을 추가 
** 테이블변경으로 못하는 사항 
1.컬럼순서는 못바꾼다.
2.새로운 컬럼을 추가할때도 중간에 붙는게 아니라 마지막 컬럼 뒤에 순서가 부여된다. 


컬럼추가 


테이블 변경시.. 
ALTER TABLE 테이블명............ 

컬럼추가
DROP TABLE emp_test; 
CREATE TABLE emp_test ( 
    empno NUMBER(4), 
    ename VARCHAR2(14) 
) ; 

DESC emp_test;
2개의 컬럼만 있는데 
핸드폰 번호를 저장할 수 있는 새로운 hp 컬럼을 VARCHAR2 (15) 로 추가 

ALTER TABLE emp_test ADD ( hp VARCHAR2(15) ) ; 

DESC 를 하면 1개가 추가되었음을 볼 수 있다. 

hp 컬럼의 문자열 사이즈를 30으로 변경을 하기 
ALTER TABLE emp_test MODIFY ( hp VARCHAR2(30)) ; 


hp 컬럼의 문자열 타입을 NUMBER로 변경을 하기 
ALTER TABLE emp_test MODIFY ( hp NUMBER(10)) ; 

DESC emp_test;


*** 데이터 타입을 바꾸는 것은 데이터가 없을떄는 상관 없지만
데이터가 있을 경우는 사이즈를 늘리는 것을 제외하고는 부가능. 

컬럼명 변경( 데이터 타입 변경과 다르게 이름 변경은 자유롭다. 즉 안에 데이터가 있든 말든 상관이 없다. ) 

hp 컬럼을 phone 으로 컬럼명을 변경 
ALTER TABLE emp_test RENAME COLUMN hp TO phone; 


SELECT * 
FROM emp_test ; 

컬럼 삭제 

ALTER TABLE emp_test DROP ( phone ) ; 
DESC emp_test; 


** 조금 중요 
3. 테이블이 이미 생성된 시점에서 제약조건을 추가해보자. 

테이블이 생성된 시점에서 제약조건 추가, 삭제하기 

문법
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건타입
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명


DROP TABLE emp_test; 
DROP TABLE dept_test; 


 CREATE TABLE dept_test ( 
       deptno NUMBER(2)  , 
       dname VARCHAR2(14)  
       );
       
       
CREATE TABLE emp_test ( 
       emp NUMBER(2)  , 
       ename VARCHAR2(14) ,        
       deptno NUMBER(2) 
       );
1. dept_test 테이블의 deptno 컬럼에 PRIMARY KEY 제약조건 추가 
ALTER TABLE 

ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건타입;
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE dept_test ADD CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno) ;  --수업시간에 정해놓은 명명규칙 


2. emp_test 테이블의 empno 컬럼에 PRIMARY KEY 제약조건 추가 
ALTER TABLE emp_test ADD CONSTRAINT PK_EMP_TEST PRIMARY KEY ( empno); 


3. emp_test 테이블의 deptno 컬럼이 dept_test 컬럼의 deptno 컬럼을 참조하는 FOREIGN KEY 제약 조건 추가

ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test FOREIGN KEY ( deptno ) REFERENCES dept_test (deptno) ; 
자식테이블에 foreign key 를 만든다. ( 오라클은 그렇게 정해져잇음 ) 


SELECT * 
DESC emp_test



SELECT * 
DESC dept_test





