

9월 4일
하나의 컬럼 - 별칭
SELECT empno


별칭 기술 : 텍스트, "텍스트" / '텍스트
SELECT empno "ename" -> 알리아스로



'문자열 표현' 

WHERE 절 : 스프레드시트에서 filter같은 역할 : 전체 데이터중에서 내가 원하는 행만 나오도록 

비교연산 < , >, =, !=, <>, <=, >=

     BETWEEN AND 
    IN 

연산자를 배울 때 ( 복습할 때 ) 기억할 부분은 해당연산자 X항 연산자 인지하자 

1      +       5
피연산자 연산자  피연산자


JAVA에서 a++-> 단항연산자

int a = b > 5 ? a : b --> 자바에서 삼항연산자 

BETWEEN AND : 비교대상 BETWEEN 시작값 AND 종료값
IN : 비교대상 IN ( 값1, 값2...) 
LIKE : 비교대상 LIKE '매칭문자열 % _ '




SELECT *
FROM emp
where 10 BETWEEN 10 AND 50 ;



동영상 내용 -> 개발자에 대한 오해와 진실 



NULL 비교 

NULL값은 =, != 등의 비교연산으로 비교가 불가능
EX : EMP 테이블에는 comm컬럼의 값이 null인 데이터가 존재
comm이 NULL인 데이터를 조회하기 위해 다음과 같이 실행할 경우
정상적으로 동작하지 않음 
SELECT *
FROM emp 
WHERE comm IS NULL;

-> comm이 null인것 
 IS 는 연산자
 
 -> comm 컬럼의 값이 NULL이 아닐때 
 
 =, != <>
 
 SELECT *
FROM emp 
WHERE comm IS NOT NULL;


IN <==> NOT IN 
사원중 소속 부서가 10번이 아닌 사원 조회 
SELECT *
FROM emp
WHERE deptno NOT IN (10);


SELECT *
FROM emp
WHERE mgr IS NULL;

논리 연산 : AND, OR, NOT 

AND, OR : 조건을 결합 

AND : 조건 1 AND 조건2 : 조건1과 조건2 동시에 만족하는 행만 조회가되도록 제한
OR : 조건1 OR 조건2 : 조건1 혹은 조건 2를 만족하는 행만 조회 되도록 제한


조건1 조건2    조건1 AND 조건2     조건1 OR 조건2
T     T           T                  T
T     F           F                  T
E     F           F                  T
F     F           F                  F


WHERE 절에 AND 조건을 사용하게 되면 : 보통은 행이 줄어든다. 

WHERE 절에 OR 조건을 사용하게 되면 : 보통은 행이 더 많다. 

NOT : 부정 연산
다른 연산자와 함께 사용되며 부정형 표현으로 사용됨 

NOT IN (값1, 값2....) 
IS NOT NULL 


mgr가 7698 사번을 갖으면서 급여가 1000보다 큰 사원들을 조회하기 

SELECT *
FROM emp
where mgr = 7698
AND sal > 1000;

mgr가 7698 사번을 갖거나 급여가 1000보다 큰 사원들을 조회하기

SELECT *
FROM emp
where mgr = 7698
OR sal > 1000;

emp 테이블의 사원중에 mgr 가 7698, 7839가 아닌 직원

SELECT *
FROM emp
where mgr != 7968
AND   mgr != 7839; 


SELECT *
FROM EMP
where mgr NOT IN ( 7698, 7839 );

IN 은 OR 연산자로 대체하는게 가능

!OR 는 AND로 

SELECT *
FROM emp 
WHERE mgr IN (7698, 7839);

---> OR로 

SELECT *
FROM emp 
WHERE mgr = 7698 
OR mgr = 7839

WHERE mgr NOT IN (7698, 7839);  
==> mgr != 7698 AND mgr != 7839


NULL 

IN 연산자 사용시 NULL 데이터 유의점 

요구사항 : mgr 가 7698, 7839, Null 이 아닌 사원만 조회 


SELECT *
FROM emp
WHERE mgr IN ( 7698, 7839, NULL );

NULL비교는 IS로하는데 오라클이 IS로 해석을 못함. 


mgr = 7698 이거나 mgr = 7839이거나 mgr = null이거나 

문제는 : null 비교 : is 특수연산자를 이용 



SELECT *
FROM emp
WHERE mgr NOT IN ( 7698, 7839, NULL );
해석 : mgr != 7698 AND != 7839 AND mgr != null

mgr ! = null은 항상 false 



SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('1981/06/01' , 'YYYY/MM/DD');



데이터는 대소문자를 가린다. 
date 타입에 대한 표현 잘 알아놓기 TO_DATE('1982/01/01', 'YYYY/MM/DD')

두가지 조건을 논리 연산자로 묶는 방법 (AND)

8. emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이
조회하세요 (IN , NOT IN 연산자 사용금지 ) 


SELECT *
FROM emp
WHERE  deptno != 10 
AND hiredate >= TO_DATE('1981/06/01 ' , 'YYYY/MM/DD');


10번 

SELECT *
FROM emp
WHERE  deptno IN (20, 30) 
AND hiredate >= TO_DATE('1981/06/01 ' , 'YYYY/MM/DD');

SELECT * 


11번 12번 13번 과제 

SQL 연산자 우선순위

1. 산술연산자 ( *,/,+,-)
2.



조건1 OR 조건2 AND 조건3 
-> 조건 1이거나 (조건2이면서 조건3)
---> 괄호로 표현하면 조건1 OR (조건2 AND 조건3)
그래서 조건 1 OR 조건2 얘를 먼저 해주고 싶으면 괄호로 묶어주기. 



14번 

SELECT *
FROM emp
WHERE job

RDBMS는 집합에서 많은 부분을 차용했다. 

집합의 특징 : 1. 순서가 없다. 
            2. 중복을 허용하지 않는다. 
            
{ 1, 5, 10 } == { 5, 1, 10} 집합에는 순서가 없다. 

{1, 5, 5, 10} ==> { 1. 5, 10 } (집합은 중복을 허용하지 않는다.)


SELECT *
FROM emp;

아래 sql의 실행결과, 데이터의 조회 순서는 보장되지 않는다. 
지금은 7369, 7499..... 조회가 되지만
내일 동일한 sql을 실행 하더라도 오늘 순서가 보장되지 않는다 ( 바뀔 수 있다. ) 

*데이터는 보편적으로 데이터를 입력한 순서대로 나온다 ( 보장은 아님 )
테이블에는 순서가 없다.

 
시스템을 만들다 보면 데이터의 정렬이 중요한 경우가 많다. 

게시판 글 리스트 : 가장 최신글이 가장위로 

매우 중요함
** 즉 SELECT 결과 행의 순서를 조정할 수 있어야 한다. 
==> ORDER BY 구문 

문법










SELECT * 
FROM 테이블명 
[WHERE]
[ORDER BY 컬럼1, 컬럼2 ]
컬럼 1로 정렬이 됬는데 두개가 같을때는 컬럼 2 로 정렬이 된다. 

오름차순 (ASC) : 값이 작은 데이터부터 큰 데이터 순으로 나열

내림차순, (DESC) : 값이 큰 데이터부터 작은 데이터 순으로 나열

ORACLE에서는 기본적으로 오름차순이 기본 값으로 적용됨. 

내림차순으로 정렬을 원할경우 정렬 기준 컬럼 뒤에 DESC를 붙여주기. 

EX)

job 컬럼으로 오른차순으로 정렬하고 같은 job을 갖는 행끼리는 empno로 내림차순 정렬

SELECT *
FROM emp
ORDER BY job, empno ;




SELECT *
FROM emp
ORDER BY job, empno DESC;

참고, 중요하지 않음

1, ORDER BY 절에 별칭 사용 가능
SELECT empno eno, ename enm 
FROM emp
ORDER BY enm; 

2. ORDER BY 절에 SELECT 절의 컬럼 순서 번호 

SELECT empno, ename 
FROM emp
ORDER 2;  ->> 의미 ORDER BY ename 


3. EXPRESSION 도 가능하다

SELECT empno, enma, sal * 500  
FROM emp
ORDER BY sal * 500

sal * 500을 SELECT에서 별칭으로 놓고 ORDER BY 에 별칭으로 넣어도 된다. 

실습 데이터정렬 (ORDER BY 실습 ORDERBY1) 


문제1)

SELECT *
FROM dept

ORDER BY dname ASC;
* ASC는 생략가능 

문제 2) 

SELECT *
FROM dept
ORDER BY loc DESC;



ORDER BY 실습 orderby 2 

SELECT *
FROM emp 
WHERE comm IS NOT NULL AND comm !=0
ORDER BY comm DESC , empno DESC;

NULL은 알아서 제거될 수 있다. 비교연산으로 할수는 없다. -> != NULL 사용할 수 없음. 


ORDER BY 실습 orderby 3

SELECT *
FROM emp 
where mgr IS NOT NULL 
ORDER BY job, empno DESC;


!= NULL


ORDER BY 실습 orderby 4

SELECT *
FROM emp
WHERE (deptno 10 OR 30) 
AND sal > 1500
ORDER BY ename DESC;


SELECT *
FROM emp 
WHERE deptno IN (10, 30) 
  AND sal > 1500 
ORDER BY ename DESC;




문



*실무에서 매우 많이 사용 *
페이징처리를 위해서 ROWNUM을 어떻게 이용할 수 있을까? 
ROWNUM : 행의 번호를 부여해주는 가상 컬럼 
    ** 조회된 순서대로 번호를 부여 

1. where 절에 사용하는 것이 가능 . 

SELECT ROWNUM, empno, ename
FROM emp;
WHERE ROWNUM = 1;


1. WHERE 글번호 BETEWWN 46 AND 60;
   * WHERE ROWNUM = 1 ( = 동등비교연산의 경우 1만 가능) 

WHERE ROWNUM = 1; (= 동등 비교 연산의 경우 

WHERE ROWNUM은 1번부터 읽는것만 가능하다.
WHERE ROWNUM = 3; 3을 가져오라고 해도 오라클에서는 1, 2 부터 읽어야하기 때문에 안됨

WHERE ROWNUM <= 15 
WHERE ROWNUM BETWEEN 1 AND 15 

ROWNUM은 1번부터 순차적으로 데이터를 읽어 올 때만 사용 가능 


문제 : 메모리가 한정되어 있기 때문에, 한 화면에 다 보여주기가 쉽지 않다. (한화면에 많은 데이터
저장이 좋지 않다 -> 한페이지에 제한된 숫자만 보여주는것 -> 페이징처리 ) 


2. 2번째 특징 : 
ORDER BY 절은 SELECT 이후에 실행된다 

** SELECT 절에 ROWNUM을 사용하고 ORDER BY 절을 적용하게 되면 
원하는 결과를 얻지 못한다. 


1. SELECT * 
2. FROM emp
3. wherre deptno IN (10, 30 ) 
   AND sal > 1500
4. ORDER BY ename DESC;


2번부터 3번 1번 4번의 순서로 읽혀진다.  


SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename; 

-> select 절이 order 절보다 먼저 수행이 되기때문에 꼬여보이는것. 

정렬을 먼저 하고, 정렬된 결과에 ,ROWNUM을 적용해야 깔끔하게 보임. 
==> INLINE-VIEW 
   SELECT 결과를 하나의 테이블처럼 만들어주는 것
   
   
SELECT * 
FROM ( SELECT ROWNUM rn, 1.*
      FROM
        (SELECT empno, ename 
        FROM emp
        ORDER BY ename) a) 
WHERE RN BETWEEN 6 AND 10; 

가로쳐준게 emp가 되어 주는것 같아. 


사원정보를 페이징해준다. 

1.페이지에 5명씩 나온다. 
페이지 : 1~5 2페이지 : 6~ 10, 3페이지 : 11~ 15 

1페이지 5명씩 조회
1페이지 : 1~5,  (page-1)*pageSIZE + 1 ~ page * pageSize
2페이지 : 6~ 10,
3페이지 : 11~ 15

page = 1, pageSize = 5 

SELECT *
FROM
(SELECT ROWNUM rn, a.*
   FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ) 
WHERE rn BETWEEN (:PAGE - 1) * : pageSize + 1 AND : page * pageSize;    

SELECT ROWNUM, *
FROM emp;


WHERE ROWNUM BETWEEN 6 AND 10;

WHERE rn BETWEEN (:page -1) * : pageSize + 1 AND : page * :pageSize; 


SELECT 절에 * 사용했는데 ,를 통해 다른 특수 컬럼이나 expression을 사용 할 경우는 *앞에 해당 데이터가 어떤 테이블에서 왔는지 명시를 해줘야 한다.
(한정자)

별칭은 테이블에도 적용이 가능하다. 단 컬럼이랑 다르게  AS옵션은 없다.

SELECT ROWNUM, e.*
FROM emp e;

-> rownum과 oderby가 동시에 사용을 못한다. 동시에 사용하려면 순서가 꼬여버린다 

rownum a이라는 별칭을 주어서 컬럼을 만들어 놓음. 

