날짜 관련된 함수 

TO_CHAR 날짜 --> 문자 
TO_DATE  문자 --> 날짜 

날짜 -> 문자 -> 날짜 
문자 -> 날짜 -> 문자 

sysdate (날짜) 를 이용하여 현재 월의 1일자 날짜로 변경 

null 관련 함수
1. NVL(exprl, expr2 ) 
    만약 exprl 이 null이면 expr2 를 출력하고
    null이 아니면 exprl 을 그대로 출력한다. 
    
    -- 1이 첫번째 자리를 나타내주고 2는 두번째 자리를 나타내줌 
내방식대로 쓰기 : 만약 1이 null이면 2 
               만약 1이 null이면 아니면 1 
               

    
NULL과 관련된 연산의 결과는 NULL이다. 

총 4가지 존재. 다 외우진 않아도 되지만 시험엔 나온다. 


오늘 수업 시작



NVL2(expr1, expr2, epxr3 ) 
  if(exprl != null) 
     System.out.println(expr2); 
  else
     System.out.println(expr3) ; 
     
     
comm 컬럼이 NULL일때 0으로 변경하여 SAL컬럼과 합계를 구한다 
SELECT empno, ename, sal, comm, 
      sal +  NVL(comm, 0 ) nvl_sum,
      sal +  NVL2(comm, comm, 0 ),
      NVL2(comm, sal+comm, sal) nvl2_sum2, 
      NULLIF(sal, sal) nullif, 
      NULLIF(sal, 5000 ) nullif_sal,
      sal + COALESCE(comm, 0 ) coalesce_sum
      
FROM emp; 


3. NULLIF(expr1, expr2) 
   if(expr1 == expr2) 
      System.out.println(NULL) ; 
   else
      System.out.println(expr1); 


4. coalesce(exprl, expr2, rxpr3 ....) coalesce의 인자중 가장 처음으로 등장하는 null이 
아닌 인자를 반환 
    if(exprl != NULL) 
          System.out.println(expr1) 
    else
          coalesce(expr2, expr3....) 
coalesce(null, null, 5, 4) 
   ==> coalesce(null, 5, 4)
       ===> coalesce(5,4) 
          ===> System.out.println(5); 


coalesce(mgr, 9999)
    ==>coalesce(9999)

-- 함수의 인자 개수가 정해지지 않고 유동적으로 변경이 가능한 인자 : 가변인자 


null 실습 f4 

SELECT empno, ename, mgr,  
       NVL(mgr, 9999) mgr_n , 
       NVL2(mgr, mgr, 9999 ) mgr_n_1 , 
       --항상 expr1과 expr2 이 동일할필요 없다. 
      coalesce(mgr, 9999) mgr_n_2
FROM emp;  


nvl ( expr1, expr 2 ) 내방식대로 쓰기 :
 만약 1이 null이면 2 
 만약 1이 null이 아니면 1 

nvl2 ( expr1, expr2, expr3 ) 

1이 null이 아니면 2 
1이 null이면 3 

coalesce 

 1 이 null이 아니면 1 
1이 null이면 

2 시작

2이 null이 아니면 2 
2 이 null이면 

3 시작 

SELECT userid, usernm, reg_dt, NVL( reg_dt , SYSDATE)  n_reg_dt
FROM users 
WHERE usernm != '브라운'
 -- 부정형과 부정형이 아닌것 -> 긍정형이 더 좋다. 시스템상/ 개발자측면에서는 간결한것좋다  


조건 : condition 

java 조건 체크 : if, switch 

if( 조건) 
    실행할 문장
else if(조건) 
    실행할 문장
else
    실행할 문장
    
SQL : CASE 절 
CASE 
    WHEN 조건 THEN 반환할 문장
    WHEN 조건2 THEN 반환할 문장
    ELSE 반환할 문장
END 


SQL 에서는 CASE 절 


CASE 

   WHEN 조건 THEN 반환할 문장
   WHEN 조건2 THEN 반환할 문장 

END 


emp 테이블에서 job 컬럼의 값이
' SALESMAN' 이면 sal 값에 5%를 인상한 급여를 반환 sal * 1.05 
' MANAGER' 이면 SAL 값에 10 % 를 인상한 급여를 반환 SAL * 1.10 
'FRESIDENT' 이면 SAL 값에 20 % 를 인상한 급여를 반환 SAL * 1.20
그 밖의 직군 ( 'CLERK', 'ANALYST')은 SAL값 그대로 반환 


SELECT ename, job, sal,    
       case 
           WHEN job = 'SALESMAN' THEN sal * 1.05 
           WHEN job = 'MANAGER' THEN sal * 1.10 
           WHEN job = 'PRESIDENT' THEN sal * 1.20
           ELSE sal 
      END sal_b 
FROM emp;


가변인자 : 
DECODE (COL|exprl, 
                   search1, return1, 
                   search2, return2,
                   search3, return3,
                   default )
첫번째 컬럼이 두번째 컬럼(search1) 과 같으면 세번째 컬럼(return1)을 리턴 
첫번째 컬럼이 네번째 컬럼(search2) 과 같으면 다섯번째 컬럼(return2)을 리턴 
첫번째 컬럼이 여섯번째 컬럼(search3)과 같으면 일곱번째 컬럼(return3)을 리턴
일치하는 값이 없을때는 default리턴 default가 없으면 그냥 null을 반영한다. 

SELECT ename, job, sal,    
       case 
           WHEN job = 'SALESMAN' THEN sal * 1.05 
           WHEN job = 'MANAGER' THEN sal * 1.10 
           WHEN job = 'PRESIDENT' THEN sal * 1.20
           ELSE sal 
      END sal_b, 
      DECODE ( job, 
                    'SALESMAN' , sal * 1.05, 
                    'MANAGER' , sal * 1.20, 
                    sal) sal_decode
FROM emp;

차이점  DECODE의 경우 값비교가 = (equal ) 에 대해서만 가능
       복수조건은 DECODE를 중첩하여 표현 
       CASE는 부등호 사용가능, 복수개의 조건 사용가능 
          (CASE
               WHEN sal > 3000 AND job = 'MANAGER' ) 
               
               
실습 


SELECT * 
FROM emp; 

SELECT empno, ename,
   case 
    WHEN  deptno = 10 THEN  'ACCOUNTING' 
    WHEN  deptno = 20 THEN  'RESERCH' 
    WHEN  deptno = 30 THEN  'sales' 
    WHEN  deptno = 20 THEN  'operations' 
    ELSE  'DDIT'
END dname  
FROM emp; 







(
SELECT empno, ename, birthday, year, 
     CASE
     WHEN MOD(year_1 , 2 ) = 0 THEN ' 0 ' 
     ELSE '1' 
     END lan 
FROM 
(SELECT empno, ename, birthday, 
      CASE 
      WHEN MOD ( birthday , 2 ) = 0  THEN '0' 
      ELSE '1'
      END YEAR ,  
      TO_CHAR(SYSDATE, 'YY' ) year_1 
FROM 
(SELECT empno, ename, hiredate, TO_CHAR(HIREDATE , 'YY')  birthday       
FROM emp)); 

           
           
           
           
                 


DECODE (COL|exprl, 
                   search1, return1, 
                   search2, return2,
                   search3, return3,
                   default )



선생님의 답 

건강검진 대상 여부 : 출생년도의 짝수 구분과, 건강검진 실사년도 ( 올해) 의 짝수 구분이 같을때 
ex : 1983년생은 홀수년도 출생이므로 2020년도 ( 짝수년도) 에는 건강검진 비대상
1983년 생은 홀수년도 출생이므로 2021년도 ( 홀수년도) 에는 건강검진 대상 

어떤 정수 
어떤 양의 정수 x가 짝수인지 홀수인지 구별법? 
짝수는 2로 나눴을때 나머지가 0 
홀수는 2로 나눴을때 나머지가 1 

나머지는 나누는 수보다 항상 작다 
나머지는 항상 0 or 1 이다. 
나머지 연산이 java에서는 % dlrh sql에서는 mod 함수 


SELECT empno, ename, hiredate, 
        CASE 
        WHEN MOD (TO_CHAR(hiredate, 'YYYY' ), 2 ) =  MOD (TO_CHAR(SYSDATE, 'YYYY' ), 2 ) THEN '건강검진 대상자' 
ELSE ' 건강검진 비대상자'
END contact_to_daoctor

FROM emp; 



과제 

SELECT userid, usernm, reg_dt, 
       CASE
       WHEN MOD(TO_CHAR(reg_dt, 'yyyy') , 2 ) =  MOD ( TO_CHAR(SYSDATE, 'yyyy' ) , 2 ) THEN ' 건강검진 대상자' 
       ELSE ' 건강검진 비대상자' 
       END contact_to_doctor ,
       DECODE(MOD(TO_CHAR(reg_dt, 'yyyy'), 2 ), 
                         MOD(TO_CHAR(SYSDATE, 'yyyy'), 2 ), '건강검진 대상자',
                         '건강검진 비댕상자') contact_to_doctor2 
FROM users
WHERE reg_dt IS NOT NULL ; 


SELECT * 
FROM emp
ORDER BY deptno ; 


group function 













