 DELETE emp_test; 

DELETE emp_test2; 

COMMIT;





unconditional insert 

conditional insert 

ALL : 조건에 만족하는 모든 구문의 INSERT 실행 

FIRST : 조건에 만족하는 첫번째 구문의 INSERT  만 실행



INSERT FIRST --만족하는 조건을 하나만 찾으면 그것만 실행이된다. 

    WHEN eno >= 9500 THEN 

        INTO emp_test VALUES (eno, enm ) 

    WHEN eno >= 9000 THEN

        INTO emp_test2 VALUES (eno, enm )  

SELECT 9000 eno, 'brown' enm FROM dual UNION ALL

SELECT 9500, 'sally' FROM dual ; 



SELECT * 

FROM emp_test 









SELECT * 

FROM emp_test; 



SELECT * 

FROM emp_test2; 



동일한 구조 (컬럼) 의 테이블을 여러개 생성 했을 확률이 높음 

행을 잘라서 서로 다른 테이블에 분산 

: 테이블의 건수가 줄어들므로 table full access  속도가 빨라진다. 



실적 테이블 : 20190101 ~ 20191231 실적데이터 => SALES_2019 테이블에 저장

            20200101 ~ 20191231 실적데이터 => SALES_2020 테이블에 저장을 할수가 있다. 

            

            2019 테이블이랑 2020 테이블을 같이 조회할때 :

            * 개별년도 계산은 상관없으나 19, 20 년도 데이터를 동시에 보기 위해서는 UNION ALL 혹은 쿼리를 두번 사용해야한다.



오라클 파티션 기능 (오라클 공식버전에서만 지원 , XE버전에서는 지원안함)

테이블을 생성하고 입력되는 값에 따라서 오라클 내부적으로 별도의 영역에 저장을 한다. 

                                        SALES

            SALES_ 2019           SALES_ 2020            SALES_ 2021

                                        

*데이터를 크게 다룰때 







MERGE 



특정 테이블에 입력하려고 하는 데이터가 없으면 입력하고, 있으면 업데이트를 한다. 

9000, 'brown' 데이터를 emp_test 넣으려고 하는데

emp_test 테이블에 9000번 사번을 갖고 있는 사원 있으면 이름을 업데이트하고

사원이 없으면 신규로 입력 



merge 구문을 사용하지 않고 위 시나리오 대로 개발을 하려면 적어도 2개의 sql을 실행 해야함

1.SELECT 'X'

  FROM emp_test 

  WHERE empno = 9000;

  



2-1. 1번에서 조회된 데이터가 없을 경우

    INSERT INTO emp_test VALUES (9000, 'brown' ); 

2-2. 2번에서 조회된 데이터가 있을 경우

    UPDATE emp_test SET ename = 'brown' 

    WHERE empno = 9000; 

    

merge 구문을 이용하게 되면 한번의 SQL로 실행이 가능하다. 



구문



MERGE INTO 변경/ 신규입력할 테이블 

    USING 테이블 | 뷰 | 인라인뷰 

    ON ( INTO 절과 USING 절에 기술한 테이블의 연결 조건 ) 

WHEN MATCHED THEN 

    UPDATE SET A컬럼 = 값 , 컬럼 = 값........ 

WHEN NOT MATCHED THEN 

    INSERT [(컬럼1, 컬럼2....)] VALUES ( 값1, 값2 ......) 

    

    

9000, 'brown'    

MERGE INTO emp_test    

    USING (SELECT 9000 eno, 'moon' enm 

        FROM dual ) a 

    ON (emp_test.empno = a.eno ) 

WHEN MATCHED THEN

    UPDATE SET ename = a.enm 

WHEN NOT MATCHED THEN 

    INSERT VALUES (a.eno, a.enm);

    

    

SELECT * 

FROM emp_test

    

    

SELECT * 

FROM emp_test, ( SELECT 9000 eno, 'brown' enm 

                FROM dual ) a 

WHERE emp_test.empno = a.eno ;            



MERGE INTO emp_test    

    USING  dual a 

    ON (emp_test.empno = 9000 ) 

WHEN MATCHED THEN

    UPDATE SET ename = 'brown' 

WHEN NOT MATCHED THEN 

    INSERT VALUES (9000, 'brown');



COMMIT;





emp -> emp_test 데이터 두건 복사



INSERT INTO emp_test

SELECT empno, ename

FROM emp 

WHERE empno IN ( 7369, 7499); 

commit;





SELECT *

FROM emp_test;



emp 테이블 이용하여 emp 테이블 존재하고 emp_test 에는 없는 사원에 대해서는 emp_test 테이블에 신규로 입력하고



emp, emp_test 양쪽에 존재하는 사원은 이름을 이름 || '_M'







MERGE INTO emp_test    

    USING emp 

    ON (emp.empno = emp_test.empno  ) 

WHEN MATCHED THEN

    UPDATE SET ename = emp_test.ename || '_m' 

WHEN NOT MATCHED THEN 

    INSERT VALUES (emp.empno, emp.ename);



DESC emp; 



SELECT * 

FROM emp_test, emp 

WHERE emp.empno  = emp_test.empno;



매칭 2건에 , 매칭안되는게 12건 

---> merge 실행시 update 2건에 insert 12건 



SELECT *

FROM emp_test;





DELETE emp 

WHERE empno = '7' 

rollback;





GROUP FUNCTION 







SELECT * 

FROM emp



부서별 급여 합계 (deptno, 급여합)

전체 사원의 급여합

첫번째.

SELECT deptno, sum(sal)  

FROM emp 

GROUP BY deptno



union all -- (union 만 써도 괜찮음... 왜냐면 교집합이 없으니까 ) 



두번째.

SELECT NULL , SUM(SAL)

FROM emp 



위의 커리를 report group function을 적용하면



SELECT deptno , SUM (sal) 

FROM emp 

GROUP BY ROLLUP(deptno); 



원리 : 오른쪽 컬럼을 하나씩 제거하며 groupb by 를 한다. 



GROUP BY ROLLUP(deptno ) 은

1. 처음 : group by deptno 가 먼저 실행이 되고

2. 두번째 group by 전체가 된다. 즉 group by 전체는 group by 를 안쓴거랑 같다.  

GROUP BY ==> 전체 



그 다음 . 

GROUP BY ROLLUP(deptno, job ) 를 보면 

순서가. 

1.

GROUP BY deptno, job 



UNION ALL

2.

GROUP BY deptno



UNION ALL

3.

GROUP BY  --전체  



순서를 보면 원래애는 이거: 

SELECT job, deptno, SUM(sal + NVL(comm, 0) ) sal 

FROM emp 

GROUP BY ROLLUP(job, deptno ) ; 



--1. 

SELECT job, deptno, SUM(sal + NVL(comm, 0) ) sal 

FROM emp  

GROUP BY job, deptno 



UNION ALL 

--2.

SELECT job, NULL, SUM(sal + NVL(comm, 0) ) sal 

FROM emp

GROUP BY job 



UNION ALL

--3.

SELECT NULL, NULL, SUM(sal + NVL(comm, 0) ) sal 

FROM emp 





3개를 다 union all을 한거다. 3개가 그냥 다 합쳐서 나오게 된다. 





*** 내 이해에서 : 중요한것은 job으로 하나로 group by 를 했을때는 job이 동일한애가 한개만 생기지만

job으로 그룹을 묶고 deptno 로 또 묶으면 job이 동일한애가 여러개 생겨도 job과 deptno 가 

동일한 애는 유일하다. 

또한 GROUP BY ROLLUP 할때 같은 컬럼의 갯수를 가지고 있어야 한다. 그래서 세개로 나눠서 1번쨰 2번째 3번째 이렇게 

한 애중에 NULL값을 SELECT 에 써준 이유는 1번째가 DEPTNO 를 조회하기 때문에 그부분을 컬럼을 맞춰주기 위해 

** UNION ALL 할때 이름은 별칭등은 UNION 에 있는 첫번째를 따라주는것. 









ROLLUP : GROUP BY 를 확장한 구문

서브 그룹을 자동적으로 생성

GROUP BY ROLLUP( 컬럼1, 컬럼 2..... ) 

ROLLUP 절에 기술한 컬럼을 오른쪽에서부터 하나씩 제거해 가며 서브그룹을 생성한다. 

생성된 서브그룹을 하나의 결과로 합쳐준다. 







SELECT count(deptno), job

FROM emp 

GROUP BY deptno, job 



** 이해할때 동일한 DEPTNO + JOB 을 가진애가 1개가 나온다 그래서 DEPTNO 나 JOB 하나만 동일한데이터는 같은

컬럼에 있지. 



null값이 아닌 GROUPING 함수를 통해 레이블을 달아준 이유

NULL값이 실제 데이터의 NULL인지 GROUP BY 에 의해 NULL이 표현 된것인지는 GROUPING 함수를 통해서만 알 수 있다. 

-------------------------------------------

GROUPING  함수 : ROLLUP  이나 CUBE 절을 사용한 SQL 에서만 사용이 가능한 함수  

                인자 COL은 GROUP BY 절에 기술된 컬럼만 사용가능

                1, 0 을반환 

                1 : 해당 컬럼이 소계 계산에 사용된 경우 

                0 : 해당 컬럼이 소계 계산에 사용되지 않은 경우

요거 어려웠어. 

1일때랑 0 일때의 차이를 구분해보자. 

24 P 에 있다. 

JOB           MGR

PRSEIDENT  NULL 

이렇게 원래 행이 하나 존재했잖아 ( UNION 으로 합치든 GROUP BY ROLLUP 

으로 합치든 ) 근데 이거는 JOB, MGR 두개로 그루핑을 해준(첫번째 UNION 전에) 것에도 그냥 데이터가 원래 존재했던것이고

JOB 으로만 GROUP BY 를 해줬을때도 우리가 MGR 에 NULL을 설정을 하기 때문에 그때도 나온다. 

그값의 서로의 차이는 GROUPING 함수를 보면 아는데 

JOB 으로만 GROUP BY 를 해주면 grouping (mgr )에 1이 생겨 

왜냐면 job 으로 그룹을 해주면 job 과 mgr 두개로 그룹바이를 했을때랑 다르게 ( 이건 고유한 1개의 데이터로 들어감)  

원래 있던 mgr 에 있던 여러개의 (직업이  president인) 데이터가 job president 라는 그룹아래에 합쳐짐. 그래서 mgr 을 그룹핑한 함수 GROUPING(mgr) 이 1이라는게 생김. 











SELECT job, deptno , 

       GROUPING(job), GROUPING(deptno), SUM(sal + NVL(comm, 0 )) sal

       FROM emp 

       GROUP BY ROLLUP ( job, deptno ) ; 



SELECT job, deptno , SUM(sal+NVL(comm, 0 )) sal 

FROM emp 

GROUP BY job, deptno 



UNION ALL 



SELECT job , NULL ,  SUM(sal+NVL(comm, 0 )) sal 

FROM emp 

GROUP BY job  



UNION ALL 



SELECT NULL, NULL, SUM(sal+NVL(comm, 0 )) sal 

FROM emp 





----------------------------------------------

24p 



grouping function 

: null로 대체할 경우 문제 발생가능 



SELECT job, mgr, GROUPING (job) , GROUPING(mgr), SUM(sal) 

FROM emp 

GROUP BY rollup(job, mgr ) ; 





SELECT * 

FROM emp



25P 실습  (GROUP_AD2 ) 





SELECT DECODE (job , NULL, '총계' , job ) --뒤에있는 job 애는 default 값으로 null이아니면 나오는것. 컬럼 or expression 들어감  

, deptno , sum(sal)  

FROM emp 

GROUP BY ROLLUP (job, deptno);





26p 실습 group_ad2-1 





답 : DECODE를 CASE 절로 바꿀 수도 있다. 



SELECT DECODE(job,null,'총',job) job ,  

CASE

    WHEN GROUPING(deptno) = 1 AND  GROUPING(job) = 1 THEN '계'

    WHEN GROUPING(deptno) = 1 THEN '소계'

    ELSE TO_CHAR (deptno)   -- ** TO_CHAR 를 해줘야한다. 왜냐하면 위에있는 계, 소계들이 문자열이라서 같은종류로 써줘야함. 

    END deptno

, sum(sal) sal_sum 

FROM emp 

GROUP BY ROLLUP ( job, deptno );







기본 : 

SELECT job, deptno , GROUPING(job) , GROUPING(deptno), sum(sal) sal_sum 

FROM emp 

GROUP BY ROLLUP ( job, deptno );





실습 GROUP_AD3 





SELECT deptno, job , sum(sal) 

FROM emp 

GROUP BY ROLLUP (deptno, job )  



실습 GROUP_AD4 





SELECT dept.dname, emp.job , sum(emp.sal + NVL(comm , 0))sal

FROM emp , dept

WHERE emp.deptno = dept.deptno  

GROUP BY ROLLUP (dname, job ) ;  



SELECT dept.dname, a.job, a.sal

FROM

(SELECT deptno, job, SUM(sal + NVL(comm, 0)) sal

 FROM emp

 GROUP BY ROLLUP(deptno, job) ) a, dept

WHERE a.deptno = dept.deptno(+);











* 풀이한거 ( 3개의 쿼리로 나눈거. 



--첫번째

SELECT dname, job, sum(emp.sal + NVL(comm , 0))sal

FROM emp, dept 

WHERE dept.deptno = emp.deptno 

group by dname, job 



union all --두번째  

SELECT dname, null ,sum(emp.sal + NVL(comm , 0))sal

FROM emp, dept 

WHERE dept.deptno = emp.deptno 

group by dname



union all --세번째 

SELECT null, null , sum(emp.sal + NVL(comm , 0))sal

FROM emp, dept 

WHERE dept.deptno = emp.deptno 









-----------------------------------------------------------------------------------



GROUPING SETS

ROLLUP 의 단점 : 서브그룹을 기술된 오른쪽에서 부터 삭제해가며 결과를 만들기 때문에 

개발자가 중간에 필요없는 서브그룹을 제거할 수가 없다. 

 ROLLUP 절에 컬럼을 N개 기술하면 서브그룹은 총 N+1 개가 나온다. 

GROUPING SETS 는 개발자가 필요로 하는 서브그룹을 직접 나열하는 형태로 사용할 수 있다.



GROUPING SETS 은 ROLLUP 과 다르게 컬럼 순서에 영향이 없다. 



GROUP BY ROLLUP( col1, col2)

=> GROUP BY col1, col2)

      GROUP BY col1

      GROUP BY 전체 



GROUP BY GROUPING SETS(col1, col2) 

=> GROUP BY col1

     GROUP BY col2



GROUP BY GROUPING SETS (col1, col2, col3) 

=> GROUP BY col1 UNION ALL

   GROUP BY cola2 UNION ALL 

   GROUP BY col3 





GROUP BY GROUPING SELTS (col3, col1, col2) 

=> GROUP BY col3 UNION ALL

    GROUP BY col1 UNION ALL

    GROUP BY col2 



GROUP BY GROUPING STES (col3, col1, col2) 

=> GROUP BY col3 UNION ALL 

     GROUP BY col1 UNION ALL 

     GROUP BY col2 



GROUP BY GROUPING SETS((col1, col2), col1) 

=> GROUP BY col1, col2 

     GROUP BY col1 



다음 두 쿼리는 같은 결과인가 다른결과인가? 

GROUP BY GROUPING SETS (col1 , col2 ) 

GROUP BY GROUPING SETS (col2 , col1 ) 



ROLLUP 절과 다르게 컬럼의 순서가 데이터 집합 셋에 영향을 주지 않는다. 

(행의 정렬 순서는 다를 수 있지만 ) 









