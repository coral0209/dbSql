START WITH : 계층쿼리의 시작 점 ( 행 ) , 여러개의 행을 조회하는 조건이 들어갈 수도 있다. 
        START with 절에 의해 선택된 행이 여러개이면, 순차적으로 진행한다. 
        
CONNECT BY : 행과 행을 연결할 조건을 기술 

PRIOR : 현재 읽은 행을 지칭

prior 키워드는 conncet by 바로 다음에 나오지 않아도 된다
CONNECT BY PRIOR deptcd = p_deptcd; 
CONNECT BY p_deptde = PRIOR deptcd; 

** 연결 조건이 두개 이상일 때 

CONNCET BY PRIOR p = q AND PRIOR a = b; 



이거랑
SELECT deptcd, LPAD(' ' , (LEVEL-1)*3) || deptnm deptnm 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd ; 

동일  

SELECT deptcd, LPAD(' ' , (LEVEL-1)*3) || deptnm deptnm 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;



실습 h_2 


SELECT LEVEL lv, deptcd, LPAD(' ' (LEVEL-1) * 3 || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY p_deptcd = PRIOR deptcd ; 

계층쿼리 - 상향식 
디자인팀 ( DEPT0_00_0 ) 에서 시작하여 자신의 상위 부서로 연결하는 쿼리이다. 


SELECT LEVEL lv , deptcd, LPAD(' ' , (LEVEL - 1 )*3) || deptnm deptnm , p_deptcd   
FROM dept_h 
START WITH deptcd = 'dept0_00_0' 
CONNECT BY deptcd = prior p_deptcd
-- 또는 CONNECT BY p_deptcd = PRIOR deptcd 



select * 
from H_SUM 

SELECT LPAD(' ' , (LEVEL -1)*3 )||S_ID S_ID, VALUE
FROM h_sum 
START WITH s_id = '0' 
connect by PS_ID = PRIOR S_ID 



PRUNING BRANCH : 가지치기 
SELECT 쿼리 처음 배울 때 설명해준 SQL 구문 실행 순서 
FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY 

SELECT 쿼리에 START WITH, CONNECT BY 절이 있을 경우
FROM -> START WITH , CONNECT BY -> WHERE .............

조건을 CONNCET BY 나 WHERE 절에서 기술할 수 있는데 
두개 써야 할 것들이 다름 

하향식 쿼리로 데이터 조회 


SELECT deptcd , LPAD(' ' , (LEVEL-1 ) + 3) || deptnm deptnm 
FROM dept_h 
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd AND deptcd != 'dept0_01' ; 




현재 읽은 행의 deptcd 값이 앞으로 읽을 행의 p_depcd 컬럼과 같고
앞으로 읽을 행의 dept_cd 컬럼값이 'dept01' 이 아닐때 연결 하겠다. 


CONNECT 부에 기술을 하면 : 정보시스템부랑 그 밑에있는 개발1팀, 개발 2팀 

행 제한 조건을 WHERE 절에 기술 했을 경우
SELECT deptcd, LPAD(' ' , (LEVEL-1)*3 ) || deptnm deptnm 
FROM dept_h 
WHERE deptcd != 'dept0_01' 
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd; 

FROM 이 실행되고 START WITH 가 실행되고 WHERE 절이 실행된다. 





SELECT * 
FROM dept_h

XX 회사밑에는 디자인부, 정보기획부, 정보시스템부 3개의 부가 있는데 그 중에서 정보기획부를 제외한 2개의 부에만 연결하겠다. 



계층쿼리 특수함수 (오라클 사용자에게는 중요한 함수) 

CONNECT_BY_ROOT(col) : 최상위 행의 컬럼 값 조회 

SYS_CONNECT_BY_PATH(col, 구분자 ) : 계층 순회 경로를 표현 
CONNECT_BY_ISLEAF : 해당 행이 leaf node ( 자식이 없는 노드)인지 여부를 반환 
                    (1: leaf node , 0 : NO leaf node )


SELECT deptcd, LPAD( ' ' , (LEVEL-1)*3 ) || deptnm deptnm , 
       CONNECT_BY_ROOT(deptnm) cbr , 
       SYS_CONNECT_BY_PATH(deptnm, '-' ) scbp 
FROM dept_h 
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd ; 







SELECT deptcd, LPAD( ' ' , (LEVEL-1)*3 ) || deptnm deptnm , 
       CONNECT_BY_ROOT(deptnm) cbr , 
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-' ), '-') scbp,
       CONNECT_BY_ISLEAF cbi 
       
FROM dept_h 
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd ; 




CONNECT BY LEVEL 계층 쿼리 : CROSS JOIN 과 유사   ( level 설명하는 부분이다. ) 
연결 가능한 모든 행에 대해 계층으로 연결 

SELECT dummy , LEVEL , SYS_CONNECT_BY_PATH(dummy, '-') , '-' scbp 
FROM dual 
CONNECT BY LEVEL <= 10 ; 

선생님 사진 찍은거 참고. 

SELECT LEVEL, deptno, LTRIM (SYS_CONNECT_BY_PATH ( deptno, '-') , '-') scbp 
FROM 
(SELECT deptno 
FROM dept 
WHERE deptno IN ( 10, 30 ) ) 
CONNECT BY LEVEL < 5 
ORDER BY LEVEL , deptno ; 




SELECT * 
FROM board_test; 

게시글번호가(seq) 큰게 나중에 쓴것. 
parent 는 자신의 부모가 있는것 . 
부모번호가 없으면 최초 부모라는것 

* 내가 이해한것 : 첫번째, 두번째, 네번째 


SELECT seq, LPAD( ' ' , (LEVEL-1)*3 ) || title title       
FROM board_test
START WITH PARENT_SEQ IS NULL 
CONNECT BY PRIOR  SEQ = PARENT_SEQ ; 

* 그냥 참고만해. !
* INDEX 구성컬럼이 PARENT_SEQ 하나일때 NULL값인 데이터는 안들어간다. 
-> INDEX 를 사용할 수 없다. 

무결성은 제껴놓고 인덱스에서 사용할 수 있게끔 원본글에 대해서 확인할 수 있는값 게시글은 + 양수니까
-1 이라던가 이렇게 그냥 넣는다. 



SELECT * 
FROM board_test



H7 번 문제 

SELECT seq, LPAD( ' ' , (LEVEL-1)*3 ) || title title       
FROM board_test
START WITH PARENT_SEQ IS NULL 
CONNECT BY PRIOR  SEQ = PARENT_SEQ  
ORDER BY seq desc ; 

-> 계층쿼리는 깨지지 않아야하는데 깨짐 문법 : ORDER SIBLINGS BY 로 사용한다. 



CONNECT_BY_ROOT 를 활용한 그룹번호 생성 
SELECT *
FROM 
(
SELECT seq, LPAD( ' ' , (LEVEL-1)*3 ) || title title , CONNECT_BY_ROOT(seq) gn  
FROM board_test
START WITH PARENT_SEQ IS NULL 
CONNECT BY PRIOR  SEQ = PARENT_SEQ  )
ORDER BY gn DESC, seq ASC;


SELECT 절이먼저 -> ORDER BY 가 그다음으로 그래서 SELECT 절에서 사용한 별칭을 사용할 수 있어 

2. gn ( NUMBER) 컬럼을 테이블에 추가 

ALTER TABLE board_test ADD (gn  NUMBER) ; 


SELECT * 
FROM board_test


UPDATE board_test SET gn= 1 
WHERE seq IN ( 1, 9) ; 

UPDATE board_test SET gn= 2 
WHERE seq NOT IN ( 1, 2, 3, 9) ; 


SELECT seq, LPAD( ' ' , (LEVEL-1)*3 ) || title title 
FROM board_test
START WITH PARENT_SEQ IS NULL 
CONNECT BY PRIOR  SEQ = PARENT_SEQ  
ORDER SIBLINGS BY gn DESC, seq ASC;

* 부모데이터에 다른 것을 넣어서 ( 예를들어 나머지는 다 0000인데 하나는 0 ) -> 포레인키를 지운것. 그리고 무결성을 
포기한것...//? 

그렇게 할 수 있다. 




조립도 
유지보수가 굉장히 용이하게 한다. 


분석함수, WINDOW 함수 

SELECT MAX(sal) 
FROM emp 

SELECT empno, ename , sal 
FROM emp 
WHERE sal = ( SELECT MAX(sal) 
              FROM emp )
            
SQL의 단점 : 행간 연산이 부족하다. => 보완 => 분석함수 ( 윈도우함수 ) 


실습 ANA0 ] 부서별 급여 랭크 

그룹함수를 사용하면서 일반 select 절에서 컬럼 사용하는것이 가능해짐 


SELECT ename, sal, deptno , 
       RANK() OVER (PARTITION BY deptno ORDER BY sal desc ) sal_rank   
FROM emp ; 

내부적으로는 group by 같은 

분석함수를 사용하지 않고도 위와 동일한 결과를 만들어 내는 것이 가능 분석함수가 모든 DBMS 에서 제공을 하지는 않음


(SELECT  deptno, count(*) cnt  
FROM emp 
ORDER BY deptno ) a 



------------------------

랭크를 짜는것. 부서중에서 부서를 동일하게 여겨야 할거같아.

선생님 쿼리 : 

SELECT *
FROM 
(SELECT ename, sal, deptno, ROWNUM rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC) ) a,

(SELECT deptno, lv, ROWNUM rn
FROM 
    (SELECT a.deptno, b.lv
    FROM 
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) a, 
    (SELECT LEVEL lv
     FROM dual
     CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp) ) b
    WHERE a.cnt >= b.lv
    ORDER BY a.deptno, b.lv )) b
WHERE a.rn = b.rn;



----> 윈도우 커리로 
SELECT ename, sal, deptno , 
       RANK() OVER (PARTITION BY deptno ORDER BY sal desc ) sal_rank   
FROM emp ;  


분석함수 / 윈도우 함수 문법

SELECT 윈도우 함수 이름 ([인자]) OVER 
      ([PARTITION BY column ] [ORDER BY COLUMN] [WINDOWING] ) 
PARTITION BY : 영역설정
ORDER BY : 영역내에서 순서 설정 ( RANK , ROW_NUMBER ) 
WINDOWING : 파티션 내에서 범위설정 *나중에 다시 이야기 한다. 


부서별 급여 순위 

순위관련 분석함수 - 동일 값에 대한 순위처리에 따라 3가지 함수를 제공한다. 
RANK : 동일값에 대해서 동일 순위를 부여한다. 
        후순위 : 1등이 2명이면 그 다음 순위가 3위다. ( 1, 1, 3) 
DENSE_RANK : 동일값에 대해 동일 순위를 부여하는데 
             후순위 : 1등이 2명이면 그 다음순위가 2위 ( 1, 1, 2 ) 
ROW_NUMBER : 동일값이라도 다른 순위를 부여한다. ( 1, 2, 3) 


SELECT ename, sal, deptno ,  
RANK() OVER (PARTITION BY deptno ORDER BY sal DESC ) sal_rank ,
DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC ) sal_dense_lank,
ROW_NUMBER() OVER ( PARTITION BY deptno ORDER BY sal DESC ) sal_row_number 
FROM emp ; 

SELECT ename, sal, 
RANK() OVER ( ORDER BY sal DESC ) rank, 
DENSE_RANK() OVER ( ORDER BY sal DESC ) dense_rank, 
ROW_NUMBER() OVER ( ORDER BY sal DESC ) row_number
FROM emp ;

분석함수 - 집계함수 

SUM(col1), MIN(col1), MAX(col1), COUNT(col1*), AVG(col) 
사원번호, 사원이름, 소속부서번호, 소속된 부서의 사원 수 

SELECT empno, ename, deptno , COUNT(*) OVER (PARTITION BY deptno) cnt -- 정렬이되든 안되든 숫자는 세줄필요가없다. 즉 orderby 필요없다. 
FROM emp ; 


ana 2 ] 
SELECT  empno, ename, sal, deptno , 
ROUND(AVG(sal) OVER (PARTITION BY deptno ) ,2 ) avg_sal 
FROM emp


SELECT empno, ename, sal, deptno , ( SELECT ROUND(AVG( SAL ) , 2) avg_sal  
                                    FROM emp a
                                    WHERE a.deptno = b.deptno ) 
                                    
FROM emp b


SELECT empno, ename , sal , emp.deptno, a.avg_sal 
FROM emp, 
     (SELECT deptno, ROUND(AVG(sal), 2 ) avg_sal 
      FROM emp 
    GROUP BY deptno ) a 
WHERE emp.deptno = a.deptno ; 







