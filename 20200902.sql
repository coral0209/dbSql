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


                
        
        

