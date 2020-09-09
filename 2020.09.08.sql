날짜
2020.09.08 (날짜정보)
 
dd-mm-yyyy (내가 원하는 문자열 ) 

형변환 ( 


날짜 데이터 : emp.hiredate
        SYSDATE
SELECT 

TO_CHAR(날짜타입, '변경할 문자열 포맷' ) 
현재 설정된 NLS DATE FORMET : YYYY/MM/DD HH24:MI:SS
TO_DATE('날짜문자열 ', '첫번쨰 인자의 날짜 포맷')
TO_CHAR, TO_DATE 첫번째 인자 값을 넣을때 문자열인지, 날짜인지 구분 . 




SELECT SYSDATE
FROM dual; 


SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD-MM-YYYY'), 
     TO_CHAR(SYSDATE, 'D') 
     
FROM dual; 


SELECT SYSDATE, TO_CHAR(SYSDATE, 'IW') 
FROM dual; 

* function(date) format 정리해놓으기 


날짜 : 일자 + 시분초

SELECT ename ,
       hiredate, TO_CHAR(hiredate , 'YYYY/MM/DD hh24:mi:ss') h1,
       To_CHAR(hiredate + 1 , 'YYYY/MM/DD HH24:mi:ss') h2,
       To_CHAR(hiredate + 1/24 , 'yyyy/MM/DD HH24 : mi : ss') h3,
       TO_CHAR(TO_DATE('20200908', 'YYYYMMDD'), 'YYYY/MM/DD' ) h4 
FROM emp;

date 실습 fn2 


SELECT TO_CHAR( SYSDATE , 'YYYY-MM-DD') DT_DASH , TO_CHAR ( SYSDATE , 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME ,
       TO_CHAR (SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;




날짜 조작 함수


MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월수를 반환
                             : 두 날짜의 일정보가 틀리면 소수점이 나오기 때문에 잘 사용하지는 않는다 

***ADD_MONTHS(DATE, NUMBER) : 주어진 날짜에 개월수를 더하거나 뺀 날짜를 반환 
AND_MONTHS(SYSDATE, 5) : 오늘 날짜로부터 5개월 뒤의 날짜는 몇일인가 

******LAST DAY(DATE) : 주어진 날짜가 속한 월의 마지막 일자를 날짜로 반환 
LAST DAY(SYSDATE) : SYSDATE
// SYSDATE(2020/09/08) 가 속한 9월에 마지막 날짜 : 2020/09/30  

// 월마다 마지막 일짜가 다르기 때문에 해당 함수를 통해서 편하게 마지막 일자를 구할 수 있다. 

** NEXT_DAY(DATE, NUMBER (주간요일 : 1-7 ) ) ; 
-> 데이트 이후에 등장하는 첫번째 주간요일을 갖는 날짜\에 쓰인다. 
ex) NEXT_DAY(SYSDATE, 6) : SYSDATE 이후에 등장하는 첫번째 금요일에 해당하는 날짜  

SELECT MONTHS_BETWEEN( TO_DATE('20200915' , 'YYYYMMDD' ), TO_DATE('20200808', 'YYYYMMDD' ) ),
       ADD_MONTHS(SYSDATE, 5),
      NEXT_DAY(SYSDATE, 6), 
      LAST_DAY(SYSDATE),
      TRUNC(SYSDATE, 'MM')
FROM dual;

해당월의 가장 첫 날짜를 변환하는 함수는 없어 모든 월의 첫 날짜 1일이다. 



SYSDATE가 속한 월의 첫날짜 구하기 


SELECT TO_CHAR(sysdate, 'YYYYMM')
FROM dual; 



9월 8일 --> 마지막날짜 로 가서 -> 1달 전으로가서 -> + 1을 해버린다. 

LAST DAY(SYSDATE) : SYSDATE
SYSDATE(2020/09/08) 가 속한 9월에 마지막 날짜 : 2020/09/30  

SELECT ADD_MONTHS(   LAST_DAY(SYSDATE) , -1 ) + 1 
FROM dual; 


SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD'), 


date 종합 실습 fn3 


SELECT : '202002'
FROM dual; 


주어진것 : 년월 문자열 --> 날짜로변경 --> 해당월의 마지막 날짜로 변경 
SELECT TO_CHAR (LAST_DAY (TO_DATE(: YYYYMM , 'YYYYMM')) , 'DD') 
FROM dual; 



형변환 함수 
명시적 형변환
TO_DATE ( 문자로 바꾸는것 
TO_CHAR ( 날짜로 바꾸는거 
TO_NUMBER 

묵시적 형변환 
....ORACLE DBMS 가 상황에 맞게 알아서 해주는것 

두가지 가능한 경우

1. empno(숫자) 를 문자로 묵시적 형변환
2. 7369(문자)를 숫자로 묵시적 형변환

실행계획 : 오라클에서 요청받은 SQL을 처리하기 위한 절차를 수립한 것 
실행계획 보는 방법

1. EXPLAIN PLAN FOR 
   실행계획을 분석할 SQL; 
2. SELECT * 
FROM TABLE(dbms_xplan.display); 

EXPLAIN PLAN FOR 
SELECT * 
FROM emp
WHERE empno = '7369';

-----> 
TABLE 함수 : PL/SQL 의 테이블 타입 자료형을 테이블로 변환 
SELECT * 
FROM TABLE(dbms_xplan.display); 

--- 
실행계획의 OPERFATION을 해석하는 방법
1. 위에서 아래로
2. 단 자식노드(들여쓰기가 된 노드) 있을 경우 자식부터 실행하고 
   본인 노드를 실행  










SELECT *
FROM emp
WHERE empno LIKE '78%' ; 
--78은 숫자인데 마치 문자인것처럼 썼음 



EXPLAIN PLAN FOR 
SELECT * 
FROM emp 
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE (dbms_xplan.display); 

1600 (숫자 ) -> 1,600 (컴마가 들어가는 순간 얘는 문자가 된다. ) 

숫자를 문자로 포맷팅  : DB보다는 국제화 ( I18N) internationalization 에서 더 많이 활용 
                                    
SELECT empno, ename, sal, TO_CHAR(sal, '009,999L')
FROM emp; 




정리

함수 
 문자열
 날짜
 숫자
 null 과 관련된 함수 4가지 : 다못외워도 괜찮음 , 한가지만 주로 사용 
 
 NULL 의 의미 ? : 아직 모르는 값, 할당되지 않은 값 
                  0과 ' '  문자와는 다르다
 NULL의 특징 : NULL을 포함하는 연산의 결과는 항상 NULL이다. 
 
 
 sal 컬럼에는 null이 없지만 comm에는 4개 제외 10개의 행이 null 
 SELECT ename, sal, comm, sal+comm
 FROM emp;
      
    NULL과 관련된 함수 
1. NVL(COLUMN || EXPRESSION , COLUMN || EXPRESSION ) 
   NVL(exprl, expr2) -- 뜻 : exprl 이 null이면 expr2를 반환 아니면 exprl 을 반환 
   
   자바에서
   if(exprl == null){
       System.out.println(expr2); 
   else 
   System.out.println(expt1); 
   
SELECT empno, comm, sal + comm, sal + NVL(comm, 0) 
FROM emp; 
 --sal + NVL (comm, 0 ) 이 이제는 null이 안나온다. 
 
 
                
    
 
 
 
 
 







