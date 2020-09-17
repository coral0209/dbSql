도시발전지수 :  (버거킹 + 맥도날드 + kfc ) / 롯데리아



 
순위   시도   시군구 도시발전지수    
1    서울시 서초구   3.5 
;

SELECT b.sido , b.sigungu , ROUND((ab+cd+ef)/gh  ,2 ) develop
FROM 
(SELECT sido, sigungu , count(gb) ab
FROM fastfood
WHERE gb = '버거킹' 
GROUP BY sido , sigungu) b
,
(SELECT sido, sigungu , count(gb) cd
FROM fastfood
WHERE gb = '맥도날드' 
GROUP BY sido , sigungu) m 
,
(SELECT sido, sigungu , count(gb) ef
FROM fastfood
WHERE gb = 'KFC' 
GROUP BY sido , sigungu) k 
,
(SELECT sido, sigungu , count(gb) gh
FROM fastfood
WHERE gb = '롯데리아' 
GROUP BY sido , sigungu) l
WHERE b.sido = m.sido 
AND m.sido = k.sido 
AND k.sido = l.sido 
AND b.sigungu = m.sigungu 
AND m.sigungu = k.sigungu 
AND k.sigungu = l.sigungu 
ORDER BY develop DESC ; 




----------------------------------------------------------------------------



선생님 설명. 

분자값이랑 분모값으로 나눠서 유실될 것을 줄일 수 있다. 


SELECT a.sido, a.sigungu , a.cnt , b.cnt , a.cnt/b.cnt di 
FROM
(SELECT sido, sigungu , COUNT(*) cnt 
FROM fastfood 
WHERE gb IN ( 'KFC' , '맥도날드' , '버거킹') 
GROUP BY sido, sigungu ) a ,
(SELECT sido, sigungu, COUNT(*) cnt 
FROM fastfood 
WHERE gb = '롯데리아' 
GROUP BY sido , sigungu ) b 
WHERE gb IN ( 'KFC' , '맥도날드', '버거킹' ) 
AND a.sigungu = b.sigungu 




1개로 만들기 


SELECT sido, sigungu, ROUND(sal/people) p_sal 
FROM tax
ORDER BY p_sal DESC


도시발전지수 1- 세금 1 위  


* 행을 컬럼으로 바꾸는것. 








SELECT *
FROM 
(SELECT sido, sigungu , count(gb) ab
FROM fastfood
WHERE gb = '버거킹' 
GROUP BY sido , sigungu) b
,
(SELECT sido, sigungu , count(gb) cd
FROM fastfood
WHERE gb = '맥도날드' 
GROUP BY sido , sigungu) m 
,
(SELECT sido, sigungu , count(gb) ef
FROM fastfood
WHERE gb = 'KFC' 
GROUP BY sido , sigungu) k 
,
(SELECT sido, sigungu , count(gb) gh
FROM fastfood
WHERE gb = '롯데리아' 
GROUP BY sido , sigungu) l
WHERE b.sido = m.sido 
AND m.sido = k.sido 
AND k.sido = l.sido 
AND b.sigungu = m.sigungu 
AND m.sigungu = k.sigungu 
AND k.sigungu = l.sigungu 
ORDER BY develop DESC ; 






----링크




SELECT sido, sigungu, 
        ROUND((NVL(SUM(DECODE(gb, 'KFC', cnt)), 0) +       
        NVL(SUM(DECODE(gb, '버거킹', cnt)), 0) +
        NVL(SUM(DECODE(gb, '맥도날드', cnt)), 0) ) /        
        NVL(SUM(DECODE(gb, '롯데리아', cnt)), 1), 2) di 
FROM 
(SELECT sido, sigungu, gb, COUNT(*) cnt
 FROM fastfood
 WHERE gb IN ('KFC', '롯데리아', '버거킹', '맥도날드')
 GROUP BY sido, sigungu, gb)
GROUP BY sido, sigungu 
ORDER BY di DESC;







SELECT sido, sigungu, ROUND(sal/people) p_sal 
FROM tax
ORDER BY p_sal DESC



------------------본격 수업 내용

DML :   Data Manipulate Language 
1. SELECT ***************
2. INSERT : 테이블에 새로운 데이터를 입력하는 명령
3. UPDATE : 테이블에 존재하는 데이터의 컬럼을 변경하는 명령
4. DELETE : 테이블에 존재하는 데이터(행)를 삭제하는 명령 


INSERT 3가지. 

1.테이블의 특정 컬럼에만 데이터를 입력할 때 ( 입력되지 않은 컬럼은 NULL 로 설정 된다 ) 
INSERT INTO 테이블명 ( 컬럼1, 컬럼2.....) VALUES (컬럼 1의 값1, 컬럼2의 값2 .... ) ; 
DESC emp; 

INSERT INTO emp ( empno, ename ) VALUES (9999, 'brown') ; 

SELECT * 
FROM emp 
WHERE empno = 9999; 


empno 컬럼의 설정이 NOT NULL이기 때문에 EMPNO 컬럼에 NULL값이 들어갈 수 없어서 에러가 발생 . 

DESC emp ; 


empno 를 보면 not null 못쓴다고 써이ㅉ지? 그건 empno 는 항상 써야한다는거야 


INSERT INTO emp (ename) VALUES ('sally' ) ; 


--학생정보를 파일에다가 기록을 할 때, empno 라는 것을 입력을 안하고 이름만 쓰면 

2. 테이블의 모든 컬럼에 모든 데이터를 입력할 떄 
***단 값을 나열하는 순서는 테이블의 정의된 컬럼 순서대로 기술 해야한다.
    테이블 컬럼 순서확인 방법 : DESC 테이블명 
INSERT INTO 테이블명 VALUES (컬럼 1의 값1, 컬럼2의 값2 .... ) ; 



 DESC dept; 
 
 INSERT INTO dept VALUES ( 98, '대덕' , '대전 ' ) ; 
 SELECT * 
 FROM dept; 
 
 컬럼을 기술하지 않았기 떄문에 테이블에 정의된 모든 컬럼에 대한 값을 기술해야 한 
 3개중에 2개만 기술하여 에러발생
 
 INSERT INTO dept VALUES ( 97, 'DDIT') ; 

3. SELECT 결과를 ( 여러 행일 수도 있다 ) 테이블에 입력

INSERT INTO 테이블명 [(cool,....) ] 
SELECT 구문; 





INSERT INTO emp (empno , ename ) --values 는 없어. 
SELECT 9997, 'cony' FROM dual 
UNION ALL 
SELECT 9996, 'moon' FROM dual ; 
--동시에 2개 데이타를 삽입함 



SELECT * 
FROM emp ; 



날짜 컬럼 값 입력하기 

-- EMP 쿼리에 넣기 위해서 
INSERT INTO emp VALUES ( 9996, 'JAMES' , 'CLERK' , NULL , SYSDATE, 3000, NULL, NULL ) ; 
INSERT INTO emp VALUES ( 9996, 'JAMES' , 'CLERK' , NULL , TO_DATE ( ' 2020/09/01' , 'YYYY/MM/DD ' ) ,
                          3000, NULL, NULL ) ; 


//제약조건을 걸어야 
SELECT * 
FROM emp ; 


--------------------UPDATE 개념 
UPDATE : 테이블에 존재하는 데이터를 수정할때 
        1. 어떤 데이터를 수정할지 데이터를 한정 (WHERE) 
        2. 어떤 컬럼에 어떤 값을 넣을지 기술 
        
UPDATE 테이블명 SET 변경할 컬럼명 = 수정할 값 [ , 변경할 컬럼명 = 수정할 값 .... ] 
[WHERE] 


dept 테이블의 deptno 컬럼의 값이 99번인 데이터의 dname 컬럼을 대문자 ddit 로, loc 를 한글 ' 영민'으로 변경 

SELECT * 
FROM dept; 
      
UPDATE dept SET dname = 'ACCOUNTING' , loc = 'NEW YORK' 
WHERE deptno = 10

ROLLBACK; 

업데이트 쿼리는 

2. 서브쿼리를 활용한 데이터 변경 ( *** 추후 MERGE 구문을 배우면 더 효율적으로 작성할 수 있다. 

테스트 데이터 입력 
INSERT INTO emp ( empno, ename, job) VALUES (9000, 'brown' , NULL ) ; 

9000번 사번의 deptno, job 컬럼의 값을 SMITH 사원의 DEPTNO , JOB 컬럼으로 
동일하게 변경 . 

UPDATE emp SET deptno = 값1, job = 값1 
WHERE empno = 9000 ; -- where 절을 잊어버리면 안됨. 잊어버리면 전체가 다 바뀜 내가 
실수한 것처럼


SELECT deptno
FROM emp 
WHERE ename = 'SMITH' ; 




SELECT job 
FROM emp 
WHERE ename = 'SMITH' ; 



UPDATE emp SET deptno = (SELECT deptno
                          FROM emp 
                          WHERE ename = 'SMITH' ),
                  job =  (SELECT job 
                         FROM emp 
                          WHERE ename = 'SMITH' )
                             WHERE empno = 9000;





3. DELETE : 테이블에 존재하는 데이터를 삭제 ( 행 전체를 삭제 ) 
**** emp 테이블에서 9000번 사번의 deptno 컬럼을 지우고 싶을때 (NULL ) ?? 
 --> DEPTNO 컬럼을 NULL 업데이트 한다. 
 DELETE [FROM ] 테이블명 
 [WHERE .....] 
 
 
 예시 
 emp 테이블에서 9000번 사번의 데이터(행)를 완전히 삭제 
 DELETE dept
 WHERE deptno = 98 ; 
 
 SELECT * 
 FROM emp; 


 UPDATE , DELETE 절을 실행하기 전에 
 WHERE 절에 기술한 조건으로 SELECT 를 먼저 실행하여 , 변경, 삭제되는 행을 눈으로 확인해보자 
 
 
 DELETE emp ;;; 쓰지마.... 큰일나 
 WHERE empno = 7369; 
 
 SELECT * 
 FROM emp 
 WHERE empno = 7369; 
 
 
 ROLLBACK ; 
 
 DELETE dept
 WHERE deptno = 98 ; 
 
 
 
  SELECT * 
 FROM dept


delete 절도 논리적으로 표현할 수 있다. 



;;쓰지마 delete emp ; 
;;쓰지마  TRUNCATE TABLE emp ; 

delete는 기록을 남기는데 두번째거는 기록을 남기지 않는다. 

DML 구문 실행시 
DBMS는 복구를 위해 로그를 남긴다
즉 데이터 변경 작업 + alpah 의 작업량이 필요

하지만 개발 환경에서는 데이터를 복구할 필요가 없기때문에
삭제 속도를 빠르게 하는 것이 개발 효율성에 좋음 

로그없이 테이블의 모든 데이터를 삭제하는 방법 : TRUNCATE TABLE 테이블명; 