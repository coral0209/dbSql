SELECT*

 FROM emp 

WHERE job = 'SALESMAN' 

OR hiredate >= TO_DATE ( ' 1981/06/01' , 'YYYY/MM/DD ') ; 


1


 
SELECT * 

FROM emp

WHERE job = 'SALESMAN' 

OR empno LIKE  '78%' ;


14번
SELECT *
FROM emp 
WHERE  job = 'SALESMAN' 
OR (hiredate >= TO_DATE ('1981/06/01' , 'YYYY/MM/DD')  
AND     empno LIKE '78%' )




13
DESC emp;
SELECT * 
FROM emp
WHERE job =   'SALESMAN' 
OR (empno BETWEEN 78 AND 78 
OR empno BETWEEN 780 AND 789
OR empno Between 7800 AND 7899); 









order by 


ORDER BY 실습 ( 내가 푸는것 )

SELECT *
FROM emp 
WHERE comm IS NOT NULL AND comm != 0
ORDER BY comm DESC , empno DESC







SELECT empno, ename
FROM emp








ROWNUM : 1부터 읽어야 한다. 
          select 절이 ORDER BY 절보다 먼저 실행된다
          ==> ROWNUM

가상 ROW칼럼 ROWNUM 실습1.   
          
  SELECT ROWNUM rn, empno, ename

FROM emp

WHERE ROWNUM BETWEEN 1 AND 10 
          
          
SELECT ROWNUM rn, empno, ename

FROM emp

WHERE ROWNUM <= 10 ;      
   
   






SELECT a.*

FROM 

             (SELECT  ROWNUM rn, empno, ename

             FROM  emp ) a

WHERE rn BETWEEN 11 AND 14;





 
 가상칼럼 rownum 실습 row2 
 
select a
FROM
    (SELECT ROWNUM rn , a.*  
        FROM 
                 (SELECT empno, ename
        
                  FROM emp ) a ) a
WHERE rn BETWEEN 11 AND 14 
    
 * FROM 절 다음 WHERE 절 다음 SELECT 절이 읽힌다. 
 그러니까 
          
SELECT ROWNUM rn , a.*  
        FROM 
                 (SELECT empno, ename
        
                  FROM emp ) a 
WHERE rn BETWEEN 11 AND 14 
* 요렇게 했을때 RN을 WHERE 절에서 인식을 못한다. 

답: 

SELECT a.*
FROM 
       (SELECT ROWNUM rn, empno, ename 
        FROM emp ) a
WHERE rn >= 11 AND rn <=20;  

ROWNUM 실습 ROW 3 


나


SELECT *
FROM
(SELECT ROWNUM rn, empno, ename
FROM
       (SELECT empno, ename
        FROM emp
        ORDER BY ename ASC ))
WHERE rn BETWEEN 11 AND 20;



SELECT *

FROM 

(SELECT ROWNUM rn,  a.*

        FROM

                  (SELECT empno, ename 

                    FROM emp

                     ORDER BY ename ASC ) a )

WHERE rn BETWEEN 11 AND 14 










함수 


function 



SELECT * 
FROM dual ; 


.
 ORACLE의 함수 분류
 
*** 1. SELECT ROW FUNCTION : 단일 행을 작업의 기준, 결과도 한건 반환 
 2. MULTI ROW ROW FUNCTION ; 여러행을 작업의 기준으로 하나의 행을 결과로 반환 

dual 테이블 

1.sys 계정에 존재하는 누구나 사용할 수 있는 테이블 
2. 테이블에는 하나의 컬럼, dummy 존재 값은 x 
3. 하나의 행만 존재 한다. 
            ***** single 
SELECT dummy 
FROM dual; 

SELECT *
FROM emp


empno, ename, LENGTH('hello') , LENGTH(ename)

FROM emp; 



SELECT LENGTH ('hello') 
FROM dual


WHERE 절에서도 사용 가능 

SELECT ename,LOWER(ename)
FROM emp;
WHERE ename = 'smith' ; 
---> 불가능 왜냐면 LOWER 로 소문자로 해줬기떄문에 


SELECT ename,LOWER(ename)
FROM emp;
WHERE  (LOWER)ename = UPPER('smith') ;
---> ename 을 lower 로 해주면 lower 를 ename을 전부 다 해줘야 하기 때문에 

* 좌변을 가공하지 말라->라는 뜻은  컬럼을 가공하지 말라.  , 치환시켜 상수부분을 가공하라. 
테이블 컬럼에 함수를 사용하지 말것. 
.함수 실행 횟수
.인덱스 사용관련 ( 추후에 ) 

SELECT ename, Lower(ename) 
FORM emp
WHERE ename = 'SMITH';


문자열 관련함수

SELECT CONCAT('Hello', ', world') concat,
       SUBSTR('Hello, world', 1, 5) substr 
From dual;

SUBSTR('Hello, world', 1, 5) substr  -> 1,5 는 hellow world 에서 1에서 5번째 까지만 
프린트됨 

SELECT CONCAT('Hello', ', world') concat,
       SUBSTR('Hello, world', 1, 5) substr, 
       SUBSTR('Hello, world', 5) substr, 
       LENGTH('Hello, world' ) length,
       INSTR('Hello, World', 'o') instr,
       INSTR('Hello, World', 'o', 6) instr2,
        INSTR('Hello, World', 'o', INSTR('Hello, World', 'o') + 1 ) instr3,
        LPAD('Hello, World', 15 , '*') lpad,    
        LPAD('Hello, World', 15 ) lpad2,
        RPAD('Hello, world', 15, '*') rpad,
        REPLACE('Hello, World', 'Hello', 'Hell') replace,
        TRIM('Hello, World') trim,
        TRIM('        Hello, World    ') trim2,
        TRIM( 'H' FROM 'Hello, World') trim3 
From dual;

  INSTR('Hello, World', 'W') instr -> w라는 애가 몇번째에 나오는지 
  중복되는 숫자가 있으면 먼저나오는 숫자의 것을 입력. 
   INSTR('Hello, World', 'o', 6 ( 5 + 1) 여기는 5가 첫번째o가 나오는거고 그뒤부터) instr2 -> 6번째 이후에 등장하는 o를 찾는다. 

-- 이거 주석..!!!!!!!!!! 


숫자관련 함수 

ROUND
TRUNC : 버림함수
====> 몇번째 자리에서 반올림, 버림을 할지? 
    두번째 인자가 0, 양수 : ROUND ( 숫자 , 반올림 결과 자리수 결과 나오는 값까지) 
    두번째 인자가 음수 : ROUND (숫자, 반올림을 해야하는 위치 ) 
MOD : 나머지를 구하는 함수 

SELECT ROUND(105.54, 1) round, 
       ROUND(105.55, 1) round2,
       ROUND(105.55, 0) round3,
       ROUND(105.55, -1) round4 -- 양수일때랑 음수일때랑은 달라 음수가 나올때는 
FROM dual; 
       
        105.54
        -3 -2 -1 0 1 2 자리 라고 하면 -> 소숫점 . 이 0자리 




TRUNC

--trunc 는 버린다. 
SELECT TRUNC(105.54, 1) trunc, 
       TRUNC(105.55, 1) trunc2,
       TRUNC(105.55, 0) trunc3,
       TRUNC(105.55, -1) trunc4 
       --양수일때랑 음수일때랑은 달라 음수가 나올때는 
FROM dual; 


mod 함수 : 나머지를 구하는 함수 
피제수 - 나눔을 당하는 수 , 제수 - 나누는 수 
a / 5 = c
a- 피제수 
b- 제수

SELECT mod(10, 3) -- -> 10을 3으로 나눈 나머지 
FROM dual; 

-- 10을 3으로 나눴을때의 몫 구하기 

SELECT TRUNC(10/3, 0) trunc
FROM dual; 


날짜 관련함수 
문자열 ==> 날짜타입으로 바꿔주는것 TO_DATE 
SYSDATE : 오라클 서버의 현재 날짜, 시간을 돌려주는 특수함수 
           함수의 인자가 없다 


-- SQL에서는 
LENGTH('Hello, World') 
SYSDATE ; 

SELECT SYSDATE , LENGTH('Hello, World') 
FROM dual; 

날짜 타입 +- 정수 : 일자를 더하고 뺀것. : 날짜에서 정수만큼 더한(뺀) 날짜 

emp hiredate + 5

SELECT SYSDATE, SYSDATE + 5 , SYSDATE - 5 ,
       SYSDATE + 1/24, SYSDATE + 1/24/60 
FROM dual; 

? 시간을 더하고 뺼 수는 없을까 ? 

하루 = 24

1= 24 
1시간 = 1/24

1분 = 1/24/60 

1초 = 1/24/60/60  

날짜 : TO_DATE --얘가 좋은 생각 , 포맷에 설정된 문자열 형식을 따르기 --> 얘는 예측하기 힘들어


SELECT TO_DATE(' 2019/12/31' , 'YYYY/MM/DD') lastday, TO_DATE( ' 2019/12/31' , 'YYYY/MM/DD') - 5 lastday_before5   ,
SYSDATE now, SYSDATE - 3 now_before3
FROM dual; 

SELECT lastday +5, lastday +10, lastday -5
FROM
(SELECT TO_DATE(' 2019/12/31' , 'YYYY/MM/DD') lastday
FROM emp);



s

EMPNO 와 같이 COLUMN 으로 갖으려면 



1. 첫번째 특징 WHERE 절에 사용하는 것이 가능 

SELECT ROWNUM, empno, ename
FROM emp; 

데이터 정렬 ( 가상컬럼 rownum) 


where 절에서도 사용이 가능하다. 단
다음의 형태만

SELECT *
FROM emp 
WHERE DEPTNO IN ( 10, 30 ) 















