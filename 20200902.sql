 | : or
{} : 여러개가 반복된다
[] : 옵션 - 있을 수도 있고 없을 수도 있다. 
==SELECT 퀘리 문법 ==
SELECT * | { colomn | expression [allias] }
FROM 테이블 이름;  


실습 select1. 

SELECT *
From lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;



SQL 실행 방법
1. 실행하려고 하는 sql을 선택후 ctrl + enter 
2. 실행하려는 sql 구문에 커서를 위치시키고 ctrl + enter;
    SELECT *  
    FROM emp; 
    
    SELECT *
    FROM DEPT;
    
SQL의 경우 KEY워드의 대소문자를 구분하지 않는다. (자바랑 다른부분이다) 

그래서 SQL은 정상적으로 실행된다. 


SELECT empno, ename

FROM emp;

coding rule이 회사마다 있다. 

select1 

SELECT ename, sal, sal + 100
FROM emp;

SELECT 쿼리는 테이블의 데이터에 영향을 주지 않는다. 

SELECT 쿼리를 잘못 작성 했다고 해서 데이터가 망가지지 않음. 

데이터 타입 
DESC 테이블명 (테이블 구조를 확인) 
구조를 확인 하고 싶으면

DESC emp;


SELECT * 
FROM emp;


숫자 + 숫자 = 숫자값 
5 + 6 = 11

문자 + 문자 = 문자 -> java에서는 문자열에 이은, 문자열 결합으로 처리 

날짜 + 숫자는? 
수학적으로 정의된 개념이 아님
오라클에서 정의한 개념
날짜에다가 숫자를 일수로 생각하여 더하고 뺀 일자가 결과로 된다 

날짜 + 숫자 = 날짜 

hiredate에서 365일 미래의 일자




SELECT ename, hiredate after_1year, hiredate + 365, hiredate - 365 before_1year
앞에 두개는 colone 뒤에는 expression ( hiredate + 365등 ) 
SELECT ename, hiredate after_1year, hiredate + 365, hiredate - 365 before_1year
FROM emp; 

별칭 : 컬럼, expression에 새로운 이름을 부여 
컬럼 | expression 뒤에 [AS] [컬럼명]
앞에 두개는 colone 뒤에는 expression ( hiredate + 365등 ) 
별칭을 부여할 때 주의점
1.공백이나, 특수문자가 있는 경우 더블 퀘데이션으로 감싸줘야 한다 
2. 별칭명은 기본적으로 대문자로 취급되지만 소문자로 지정하고 싶으면 더블 퀘테이션을 적용한다 
SELECT ename(공백이 문제) emp name -> "emp name"
FROM emp; 

SELECT ename "emp name", empno emp_no, empno "emp_no2"
FROM emp;

자바에서 문자열 : "Hello, world" 
SQL에서 문자열 : 'Hello, world'
==매우중요 * 
NULL : 아직 모르는 값 
숫자 타입 : 0이랑 NULL은 다르다 
문자 타입 : ''  공백문자랑 NULL은 다르다 

주의점 : NUL을 포함한 연산의 결과는 항상 NULL 
  5 * NULL = NULL 
  800 + NULL = NULL
  800 + 0 = 800 

emp 테이블 컬럼 정리 
1. empno : 사원번호
2. ename : 사원이름
3. job :(담당) 업무
4. mgr : 매니저 사번번호 
5. hiredate : 입사일자
6. sal : 급여 
7. comm : 커미션 
8. deptno : 부서번호 


EMP 테이블에서 NULL값 확인 


SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT ename, sal, comm, sal+comm AS total_sal
FROM emp;

SELECT *
FROM users;

SELECT userid, usernm, reg_dt, reg_dt + 5
FROM users;



SELECT prod_id "id", prod_name "name"
FROM prod;

SELECT lprod_gu "gu", lprod_nm "nm"
FROM lprod;

SELECT buyer_id 바이어아이디 , buyer_name 이름
FROM buyer;


litteral 새로운 개념 

literal : 값 자체 

literal 표기법  : 값을 표현하는 방법 

숫자 10 이라는 숫자 값을 

java : int a = 10;
sql : SELECT empno, 10 
      FROM emp; 
      
문자 
java : String str = "Hello, world";
컬렁 별칭, expression 별칭 가능 ""은 별칭을 가리키는 말 

sql : SELECT empno e, 'hello, world' h, "Hello, World"
         * | { column | expression [alias] 
 
 컬럼인지 expression인지 잘 구분을 해줘야 한다. 
 
      FROM emp;


날짜는 ? 
2020년 9월 2일이라는 날짜 값을
java : primitive type 8개 int, byte, short,long, float, double,
                            문자열 => string class 
                            날짜 ==> Date class 
sql : 

리터럴 값 자체 



문자열 연산 

java 에서 + 는 결합 연산 
    "Hello" + "World" ==> Hello World 
    "Hello" - "World" : 연산자가 정의되어 있지 않다. 
    "Hello" * "World" : 연산자가 정의되어 있지 않다 
    
    Python 
      "Hello," * 3 ===> "Hello, Hello, Hello,"
      sql ||, CONCAT 함수 ==> 결합연산
      EMP 테이블의 ename, job 컬럼이 문자열
      
      ename ' ' || job
      SELECT ename || ' ' || job 
      FROM emp; 
    
    CONCAT (문자열1, 문자열2) : 문자열1과 문자열2를 합쳐서 만들어진 새로운 문자열을 반환해준다 
    
       
  SELECT ename || ' ' || job,  
        CONCAT (CONCAT(ename, ' '), job)  
        FROM emp; 
        
    CONCAT(ename, job)

USER_TABLES : 오라클에서 관리하는 테이블(뷰)
              접속한 사용자가 보유하고 있는 테이블 정보를 관리 
        
SELECT *
FROM USER_TABLES;

원래 

SELECT table_name
FROM user_tables;


SELECT 'select * FROM ' || table_name || ';' AS "QUERRY"

FROM user_tables;

문자열 결합연산자, 

                SELECT COLONE 명. 
                
                'SELECT' 는 문자열. 
colone명 뒤에 별칭. 

''는 문자 ""는 별칭 

행 여러개 위에 제목한개는 colone  

,는 colone을 구분하는 것. 


                
                
            9월 3일 
            
            1. 로컬 저장소에 두개의 커밋을 생성했음
            --> 원격 저장소와 로컬 저장소를 연결. 
            2. 2-1 github에 새로운 저장소를 생성 ( github 사이트에서 new 왼쪽 버튼 ) 
               2-2 local 컴퓨터에서 local 저장소와 2-1에서 만든 원격저장소를 연결 
                   
                   추가하는 작업 : git remote add origin 201에서 생성한 원격저장소 주소. 
               2-3 local 저장소의 내역을 원격저장소에 반경 ( push 명령어로 했음
               맨처음: git push -u origin master 
               그 다음부터 이후 : git push
               
               확인할 때 : git hub홈페이지에 가면 업로드된 파일이 있는지 확인할 것. 
            
            9월 3일 본격적 수업. 
        
        nm, 'nm, "nm"
        
        
        select 뒤에 나온것 들 * | colum | expression [별칭] -> 세가지를 잘 비교해 놔야 한다. 
        
        SELECT nm, 
        FROM eno;
        Desc emp; 로 확인함. 
        '' -> 고정된 문자열 의미.  따라서 EXPRESsION
        
       SELECT empno "test"     
                     test
                     
                     어떤 위치에서 사용하느냐에 따라 잘 사용해야함. 
            테이블의 구조    
        
        9월 3일 본격적 수업. 
        
        nm, 'nm, "nm"
        
        
        select 뒤에 나온것 들 * | colum | expression [별칭] -> 세가지를 잘 비교해 놔야 한다. 
        
        SELECT nm, 
        FROM eno;
        Desc emp; 로 확인함. 
        '' -> 고정된 문자열 의미.  따라서 EXPRESsION
        
       SELECT empno "test"     
                     test
                     
                     어떤 위치에서 사용하느냐에 따라 잘 사용해야함. 
                     
            9.3
            
            테이블의 구조 ( 컬럼명, 데이터타입) 확인하는 방법
            1. desc 테이블명 : describe 
            2. 컬럼 이름만 알 수 있는 방법 (데이터 타입은 유추 )
                SELECT *
                FROM 테이블명;
                툴에서 제공한 메뉴이용
                접속정보 -> 테이블 -> 확인하고자하는 테이블 클릭 
            
          매우매우매우매우 중요.   
            WHERE 절 : 조건에 만족하는 행들만 조회되도록 제한. (행을 제한) 
                    : ex) sal 컬럼의 값이 1500보다 큰 사람들만 조회 -> 7명 
                    
                    그러면 select절은 컬럼을 제한한것. 
                    
                    
                    조건 연산자
     동등 비교 ( equal )
             java에서 int a = 5;
             a == 5
             sql에서는 한개. ex) sal = 1500 
              자바에서는
              object : "+".equals("-")      
              sql에서는 
              sql : sal = 1500 
              
    not equal 
       java : !=
       sql : !=, <>
       
       대입연산자
       java 에서는= 
       pl/sql 에서는   :=
       
       
       users 테이블에는 총 5명의 캐릭터가 등록이 되어 있는데
       그 중에서 userid 컬럼의 값이 ' brown' 인 행만 조회되도록 
       where 절에 조건을 기술 
       
SELECT userid, usernm, alias, reg_dg
FROM users;
WHERE userid = 'brown'; 

SQL은 대소문자를 가리지 않는다. : 키워드, 테이블명, 컬럼명 

데이터는 대소문자를 가린다.

SELECT userid, usernm, alias, reg_dg
FROM users;
WHERE userid = 'BROWN'; 
---> 대문자 브라운은 없음. 




WHERE 절에 기술된 조건을 참(TRUE)으로 만족하는 행둘만 조회가 된다.
SELECT userid, usernm, alias, reg_dt

From users  

WHERE 1 = 1; 

(5행

WHERE 1 = 2; 
-> 데이터는 안나옴아무것도 


emp 테이블에서 부서번호가 (deptno)가 30보다 크거나 같은 사원들만 조회 
컬럼은 모든 컬럼 조회' 


SELECT *
FROM emp
WHERE deptno >= 30; 


날짜 비교 

1982년 1월 1일 이후에 입사한 사람들만 조회  (이름, 입사일자 ) 

SELECT ename, hiredate 
FROM emp
WHERE hiredate >= '82/01/01';
                        

//문자 리터럴 표기법 : '문자열'
숫자 리터럴 표기법 : 숫자 

날짜 리터럴 표기법 : 항상 정해진 표기법이 아니다. 
서버 설정마다 다르게 
yy/mm/dd -> 한국의 표기 

서양권 mm/ dd / yy 처럼 다 다르다. 
환경설정에서 찾아보면 된다.

날짜 리터럴 결론 : 문자열 형태로 표현하는 것이 가능하나 서버 설정마다 다르게 해석할 수 있기 때문에 서버 설정과 관계 없이 동일하게 해석할 수 있는 방법으로 사용 
TO_DATE('날짜문자열 ',' 날짜문자열형식')
: 문자열 ==> 날짜 타입으로 변경 

SELECT ename, hiredate 
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');



이 문자가 어떤 포멧으로 이루어졌는지 알려줘야함. 

BETWEEN AND 연산자 : 

WHERE 비교대상 BEYWEEN 시작값 AND 종료값;
비교대상의 값이 시작값과 종료값 사이에 있을 때 참 ( TRUE )으로 인식 
(시작값과 종료값을 포함 그러니까 이상과 이하인 의미 


emp 테이블에서 sal 컬럼의 값이 1000이상 2000이하인 사원들의 모든 컬럼을 조회 

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

비교 연산자를 이용한 풀이 

SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <= 2000; 


문제 : 조건에 맞는 데이터 조회하기 

SELECT *
FROM EMP

TO_DATE('1982/01/01', 'YYYY/MM/DD')


select ename, hiredate 
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');


연산자는 비교연산자. 

select ename, hiredate 
FROM emp
WHERE  TO_DATE('1982/01/01', 'YYYY/MM/DD') <= hiredate 
AND hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');

날짜를 나올때 TO_DATE() 형식으로 꼭 쓰기 



IN 연산자  
특정값이 집합(여러개의 값을 포함 )에 포함되어 있는지 여부를 확인 

OR 연산자로 대체하는 것이 가능하다. 


WHERE 비교대상 IN ( 값1, 값2 ....) 
===> 비교대상이 값1 이거나 (=)
     비교대상이 값2 이거나 (=) 

EMP 테이블에서 사원이 10 번 부서 혹은 30 번 부서에 속한 사원들 정보를 조회 ( 모든 컬럼 ) 

SELECT *
FROM emp 
WHERE deptno IN ( 10, 30); 



SELECT *
FROM emp 
WHERE deptno = 10
   OR deptno = 30;          

위에 두개가 동일하다. 

WHERE 비교대상 = 값1
OR 비교대상 = 값2 
AND ==> 그리고 
OR ==> 또는

조건1 AND 조건 2 ==> 조건1과 조건 2를 동시에 만족 
조건1 OR 조건 2 ==>  조건1을 만족하거나, 조건2를 만족하거나
                   조건1과 조건2를 동시에 만족하거나 
                  
3. 문제

SELECT userid 아이디, usernm 이름, alias 별명 //userid 를 아이디로 usernm 이름으로 alias 별명으로 as가 생략되어 있음. 
FROM users
WHERE userid IN ('brown', 'cony', 'sally');
-> 작은 따옴표를 없이 하면 COLON으로 인식한다는 뜻. 근데 brown, cony , sally 는 데이타이긴하지만 colon에는 없음. 문자열임. 

where 

SELECT userid 아이디, usernm 이름, alias 별명 
FROM users
WHERE userid = 'brown' 
OR userid = 'cony'
OR userid = 'sally';




알리아스가 위치하는곳에는 큰 따옴표를 붙이거나 아얘 안붙이거나 userid 아이디 , 처럼 

alias colon 


// 작은따옴표는 문자열  , 큰따옴표 : 별칭붙일때 소문자로 나타내고 싶은데, 항상 대문자로 나와서 소문자로 나오고 싶을떄 ""
공백유지해주고 싶을때 
colone 

SELECT userid, usernm, alias
FROM users


비교연산자. 

LIKE  연산자 : 문자열 매칭 

WHERE userid ='brown'
userid가 b로 시작하는 캐릭터만 조회 

% 문자열   : 문자가 없거나 여러개의 문자열 
_ 문자열  : 하나의 임의의 문자 

SELECT *
FROM emp
WHERE ename LIKE 'W___';

WHERE ename LIKE 'W___';  ename이 w로 시작하고 이어서 3개의 글자가 있는 사원 

WHERE ename LIKE 'W___';

문제 : MEMBER 테이블에서 회원의 성이 신 씨인 사람의 MEM_ID,

SELECT mem_id, mem_name 
FROM member
WHERE mem_name LIKE '신%'; 

SELECT *
FROM member


5. member 테이블에서 회원의 이름에 글자 이 가 들어가는 모든 사람의 mem_id, mem_name 을 조회하는 퀴리를 작성

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '이%' 
OR mem_name LIKE '%이%'; 

개이득

SELECT mem_id, mem_name
FROM member
WHERE mem_name IN ( "이%", "%이") ;





