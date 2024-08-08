-- 혜정 쿼리

show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

create user final_orauser3 identified by gclass default tablespace users; 
-- User FINAL_ORAUSER3이(가) 생성되었습니다.

grant connect, resource, create view, unlimited tablespace to FINAL_ORAUSER3;
-- Grant을(를) 성공했습니다.

-----------------------------------------------------------------------------------
-- 테이블 확인 --
select *
from tab;

-- 테이블 주석 확인 --
select *
from user_tab_comments;

-- 테이블 안 주석 확인 --
select column_name, comments
from user_col_comments
where table_name = '테이블명';
-- LOGINLOG, MEDIA, MEDIQ, RESERVECODE, RESERVE, MEMBER, MEMBERIDX, CLASSCODE, HOSPITAL, NOTICE, KOREAAREA, HOLIDAY, CLASSCODE
-- CLASSCODEMET, SEARCHLOG, BOOKMARK, SUGGESTION, Comment, ADDQNA, COMMUFILES, COMMU


-- 생성된 시퀀스 조회 --
select sequence_name
from user_sequences;
    
-- 생성된 함수 조회 --
SELECT object_name
FROM all_objects
WHERE object_type = 'FUNCTION';

----------------------------------------------------------------------------------------
-- === 활동중인 의료종사자인 회원의 수 === --
select count(*)
from member
where midx = 2;

-- === 회원가입된 병원 리스트 가져오기(전체) === --
SELECT H.hidx, hpname, hpaddr, hptel, classcode
FROM
(
    select hidx
    from member
    where midx = 2
) M
JOIN
(
    select *
    from hospital
) H
ON M.hidx = H.hidx;

-- === 시/도, 시/군구, 진료과목, 병원명 으로 검색한 병원리스트 가져오기 === --
SELECT HC.hidx, hpname, hpaddr, hptel, classcode
FROM
(
    select hidx
    from member
    where midx = 2
) M
JOIN
(
    SELECT hidx, hpname, hpaddr, hptel, H.classcode
    FROM
    (
        select hidx, hpname, hpaddr, hptel, classcode
        from hospital
        where 1=1
        and hpaddr like '%' || '인천광역시' || '%' || '서구' || '%'
            and hpname like '%' || '의' || '%' and classcode = 'D001'
    ) H
    JOIN
    (
        select classcode, classname
        from classcode
    ) C
    ON H.classcode = C.classcode
) HC
ON M.hidx = HC.hidx;

-- === 페이징 처리한 시/도, 시/군구, 진료과목, 병원명 으로 검색한 병원리스트 가져오기 === --
SELECT hidx, hpname, hpaddr, hptel, classcode
FROM
(
    SELECT row_number() over(order by HC.hidx desc) AS rno
        , HC.hidx as hidx, hpname, hpaddr, hptel, classcode
    FROM
    (
        select hidx
        from member
        where midx = 2
    ) M
    JOIN
    (
        SELECT hidx, hpname, hpaddr, hptel, H.classcode
        FROM
        (
            select hidx, hpname, hpaddr, hptel, classcode
            from hospital
            where 1=1
            and hpaddr like '%' || '인천광역시' || '%' || '서구' || '%'
                and hpname like '%' || '의' || '%' and classcode = 'D001'
        ) H
        JOIN
        (
            select classcode, classname
            from classcode
        ) C
        ON H.classcode = C.classcode
    ) HC
    ON M.hidx = HC.hidx
    order by hidx
)
WHERE rno BETWEEN 1 AND 10;

-- === 검색결과를 포함한 병원 수 === --
SELECT HC.hidx as hidx, hpname, hpaddr, hptel, classcode
FROM
(
    select hidx
    from member
    where midx = 2
) M
JOIN
(
    SELECT hidx, hpname, hpaddr, hptel, H.classcode
    FROM
    (
        select hidx, hpname, hpaddr, hptel, classcode
        from hospital
        where 1=1
        and hpaddr like '%' || '인천광역시' || '%' || '서구' || '%'
            and hpname like '%' || '의' || '%' and classcode = 'D001'
    ) H
    JOIN
    (
        select classcode, classname
        from classcode
    ) C
    ON H.classcode = C.classcode
) HC
ON M.hidx = HC.hidx;

-- === 검색결과를 포함한 페이징 처리 === --
SELECT hidx, hpname, hpaddr, hptel, classcode
FROM
(
SELECT row_number() over(order by HC.hidx desc) AS rno
    , HC.hidx as hidx, hpname, hpaddr, hptel, classcode
FROM
(
    select hidx
    from member
    where midx = 2
) M
JOIN
(
    SELECT hidx, hpname, hpaddr, hptel, H.classcode
    FROM
    (
        select hidx, hpname, hpaddr, hptel, classcode
        from hospital
        where 1=1
        and hpaddr like '%' || '인천광역시' || '%' || '서구' || '%'
            and hpname like '%' || '의' || '%' and classcode = 'D002'
    ) H
    JOIN
    (
        select classcode, classname
        from classcode
    ) C
    ON H.classcode = C.classcode
) HC
ON M.hidx = HC.hidx
ORDER BY HIDX
)
WHERE rno BETWEEN 1 AND 10;

-----------------------------------------------------------------------------------------
-- === 시퀀스 생성(reserve) === --
create sequence seq_ridx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_RIDX이(가) 생성되었습니다.

-------------------------------------------------------------------------------------------
-- 날짜가 공휴일인지 체크
select count(*)
from holiday
where holiday_date = '2020-01-01'

-- 현재시간 이후, 선택한 날짜의 예약이 가득 찬 경우 확인
select count(*)
from reserve
where hidx = 1
    and to_date(checkin,'yyyy-mm-dd hh24:mi:ss') > to_char(to_date(sysdate,'yyyy-mm-dd hh24:mi:ss'))

-- 병원의 오픈시간과 마감시간 파악
select hidx, 
        nvl(starttime1, ' ') as starttime1, nvl(starttime2, ' ') as starttime2, nvl(starttime3, ' ') as starttime3
        , nvl(starttime4, ' ') as starttime4, nvl(starttime5, ' ') as starttime5, nvl(starttime6, ' ') as starttime6
        , nvl(starttime7, ' ') as starttime7, nvl(starttime8,' ') as starttime8
        , nvl(endtime1, ' ') as endtime1, nvl(endtime2, ' ') as endtime2, nvl(endtime3, ' ') as endtime3
        , nvl(endtime4, ' ') as endtime4, nvl(endtime5, ' ') as endtime5, nvl(endtime6, ' ') as endtime6
        , nvl(endtime7, ' ') as endtime7, nvl(endtime8, ' ') as endtime8
from hospital
where hidx = '1';

-- 현재시간 이후, 선택한 날짜와 예약일이 같은 경우
select ridx, userid, reportday, checkin, symptom, rcode, hidx
from reserve
where hidx = 1
    and to_date(checkin,'yyyy-mm-dd hh24:mi:ss') > to_char(to_date(sysdate,'yyyy-mm-dd hh24:mi:ss'))
    and checkin = '2024-07-08 15:00:00'

-- 선택한 날의 예약 개수 파악 
select count(*)
from reserve
where to_char(to_date(checkin,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') = to_char(to_date('2024-07-15 22:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')
    and hidx = 20395

-- 현재시간 이후, 병원과 요일 파악하여 진료예약 불가능한 업무시간 파악하기
select ridx, userid, reportday, checkin, rcode, hidx
		from reserve
		where hidx = 318
			and to_date(checkin,'yyyy-mm-dd hh24:mi:ss') > to_char(to_date(sysdate,'yyyy-mm-dd hh24:mi:ss'))
		    and checkin = '2024-07-11 16:00:00'

-----------------------------------------------------------------------------------------------------------------

SELECT H.hidx, starttime1, starttime2, starttime3, starttime4, starttime5, starttime6, starttime7, starttime8
    , endtime1, endtime2, endtime3, endtime4, endtime5, endtime6, endtime7, endtime8
FROM
(
    select ridx, checkin, hidx
    from reserve
    where hidx = 1
        and to_date(checkin,'yyyy-mm-dd hh24:mi:ss') > to_char(to_date('2024-07-06 20:00:00','yyyy-mm-dd hh24:mi:ss'))   -- 오늘날짜
) R
JOIN
(
    select hidx, 
        starttime1, starttime2, starttime3, starttime4, starttime5, starttime6, starttime7, starttime8
        , endtime1, endtime2, endtime3, endtime4, endtime5, endtime6, endtime7, endtime8
    from hospital
) H
ON R.hidx = H.hidx

----------------------------------------------------------------------------------------------------------------------
-- === 진료예약 === --
insert into reserve(ridx, userid, checkin, hidx)
values (seq_ridx.nextval, #{userid}, to_char(to_date(#{day}, 'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss'), #{hidx});


---------------------------------------------------------------------------

-- === 아이디를 통해 병원인덱스 값 찾기 === --
SELECT distinct hidx
FROM
(
    select userid
    from member
) M
JOIN
(
    select userid, hidx
    from classcodemet
) C
ON M.userid = C.userid
WHERE M.userid = 'md20395'

-- === hidx 의 현재 예약리스트 가져오기 === --
select ridx, userid, reportday, checkin, rcode, hidx
from reserve
where hidx = '318'
order by checkin desc

-- === 예약된 환자의 아이디 값을 가지고 이름과 전화번호 알아오기 === --
select *
from member
where userid = 'hemint0520_kakao';

-- === hidx 의 현재 예약리스트 가져오기(검색포함) === --
-- sclist => 환자명, 진료현황
SELECT ridx, userid, reportday, checkin, rcode, hidx

FROM
(
    SELECT row_number() over(order by ridx desc) as rno 
        , ridx, RM.userid, reportday, checkin, RM.rcode, hidx
    FROM
    (
        SELECT ridx, M.userid, reportday, checkin, rcode, hidx
        FROM
        (
            select ridx, userid, reportday, checkin, rcode, hidx
            from reserve
            where hidx = '318'  -- 병원인덱스
            order by checkin desc
        )R
        JOIN
        (
            select userid, name
            from member
            where name like '%' || '' || '%' -- 환자명
        )M
        ON R.userid = M.userid
    ) RM
    JOIN
    (
        select rcode, rstatus
        from reservecode
        --where rstatus = '접수신청'     -- 접수현황
    ) RC
    ON RM.rcode = RC.rcode
)
WHERE rno between 1 and 10


-- === ridx 를 통해 예약 정보 가져오기 === --
SELECT ridx, reportday, checkin, name, mobile, rstatus
FROM
(
    SELECT ridx, reportday, checkin, rcode, name, mobile
    FROM
    (
        select ridx, userid, reportday, checkin, rcode
        from reserve
        where ridx = '1'
    )R
    JOIN
    (
        select userid, name, mobile
        from member
    )M
    ON R.userid = M.userid
) RM
JOIN
(
    select rcode, rstatus
    from reservecode    
) RC
ON RM.rcode = RC.rcode

-- === 선택한 진료현황의 예약코드 가져오기 === --
select rcode
from reservecode 
where rstatus = '접수완료'

-- === 진료현황 변경해주기 === --
update reserve set rcode = 2
where ridx = 1;

---------------------------------------------------------
-- === (일반회원- 진료예약 열람) userid 의 현재 예약리스트 가져오기(병원명 검색) === --
SELECT ridx, userid, reportday, checkin, rcode, hidx
FROM
(
    SELECT row_number() over(order by ridx desc) as rno 
        , ridx, userid, reportday, checkin, rcode, H.hidx as hidx
    FROM
    (
        SELECT ridx, RM.userid, reportday, checkin, RM.rcode, hidx, rstatus
        FROM
        (
            SELECT ridx, R.userid, reportday, checkin, rcode, hidx
            FROM
            (
                select ridx, userid, reportday, checkin, rcode, hidx
                from reserve
            ) R
            JOIN
            (
                select userid
                from member
                where userid = 'hemint0520_kakao'
            )M
            ON R.userid = M.userid
        )RM
        JOIN
        (
            select rcode, rstatus
            from reservecode
        )RC
        ON RM.rcode = RC.rcode
    ) RMC
    JOIN
    (
        select hidx, hpname, hptel
        from hospital
        where hpname like '%' || '창원한마음병원' || '%'
    ) H
    ON RMC.hidx = H.hidx
)
WHERE rno between 1 and 10

-- === (일반회원- 진료예약 열람) userid 의 현재 예약리스트 가져오기(진료현황 검색) === --
SELECT ridx, userid, reportday, checkin, rcode, hidx
FROM
(
    SELECT row_number() over(order by ridx desc) as rno 
        , ridx, userid, reportday, checkin, rcode, hidx as hidx
    FROM
    (
        SELECT ridx, RM.userid, reportday, checkin, RM.rcode, hidx, rstatus
        FROM
        (
            SELECT ridx, R.userid, reportday, checkin, rcode, hidx
            FROM
            (
                select ridx, userid, reportday, checkin, rcode, hidx
                from reserve
            ) R
            JOIN
            (
                select userid
                from member
                where userid = 'hemint0520_kakao'
            )M
            ON R.userid = M.userid
        )RM
        JOIN
        (
            select rcode, rstatus
            from reservecode
            where rstatus = '접수신청'
        )RC
        ON RM.rcode = RC.rcode
    ) RMC
)
WHERE rno between 1 and 10

-- === (일반회원- 진료예약 열람) userid 의 현재 예약리스트 가져오기(진료예약일시, 예약신청일 검색) === --
SELECT ridx, userid, reportday, checkin, rcode, hidx
FROM
(
    SELECT row_number() over(order by ridx desc) as rno 
        , ridx, userid, reportday, checkin, rcode, hidx as hidx
    FROM
    (
        SELECT ridx, RM.userid, reportday, checkin, RM.rcode, hidx, rstatus
        FROM
        (
            SELECT ridx, R.userid, reportday, checkin, rcode, hidx
            FROM
            (
                select ridx, userid, reportday, checkin, rcode, hidx
                from reserve
                where (to_char(to_date(checkin,'yyyy-mm-dd hh24:mi:ss'),'yyyymmdd') = '20240714'
                		or to_char(to_date(reportday,'yyyy-mm-dd hh24:mi:ss'),'yyyymmdd') = '20240714')
            ) R
            JOIN
            (
                select userid
                from member
                where userid = 'hemint0520_kakao'
            )M
            ON R.userid = M.userid
        )RM
        JOIN
        (
            select rcode, rstatus
            from reservecode
        )RC
        ON RM.rcode = RC.rcode
    ) RMC
)
WHERE rno between 1 and 10

-- === (일반회원- 진료예약 열람) userid 의 현재 예약리스트 가져오기(병원명, 진료현황) === --
SELECT ridx, userid, reportday, checkin, rcode, hidx
FROM
(
    SELECT row_number() over(order by ridx desc) as rno 
        , ridx, userid, reportday, checkin, rcode, H.hidx as hidx
    FROM
    (
        SELECT ridx, RM.userid, reportday, checkin, RM.rcode, hidx, rstatus
        FROM
        (
            SELECT ridx, R.userid, reportday, checkin, rcode, hidx
            FROM
            (
                select ridx, userid, reportday, checkin, rcode, hidx
                from reserve
            ) R
            JOIN
            (
                select userid
                from member
                where userid = 'hemint0520_kakao'
            )M
            ON R.userid = M.userid
        )RM
        JOIN
        (
            select rcode, rstatus
            from reservecode
            where rstatus = '접수신청'
            
        )RC
        ON RM.rcode = RC.rcode
    ) RMC
    JOIN
    (
        select hidx, hpname, hptel
        from hospital
        where hpname like '%' || '창원한마음병원' || '%'
    ) H
    ON RMC.hidx = H.hidx
)
WHERE rno between 1 and 10

-- === (일반회원- 진료예약 열람) 예약된 병원의 아이디 값을 가지고 이름과 전화번호 알아오기 === --
select name, mobile
FROM
(
    select userid
    from classcodemet
    where hidx = '20395'
) C
JOIN
(
    select userid, name, mobile
    from member
) M
ON C.userid = M.userid

select *
from reserve
where userid = 'hemint'

-- === (의료인- 진료 일정관리) checkin 를 통해 환자 userid 가져오기 === --
select userid
from reserve
where checkin = to_char(to_date('2024-07-15 08:30','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss')

-------------------------------------------------------------------------------------------------------------

-- === 만나이 구하기 === --
SELECT userid
    , case when this_year_birthday > to_date(to_char(sysdate,'yyyymmdd'),'yyyymmdd')
            then extract(year from sysdate) - birthyear - 1 
            else extract(year from sysdate) - birthyear
            end as age
FROM
(
    select userid, to_date(to_char(sysdate,'yyyy') || substr(birthday,5,4),'yyyymmdd') as this_year_birthday
        , substr(birthday,0,4) as birthyear
    from member
    where midx = 1 and userid != 'Anonymous'
)

-- === (일반회원용) 만나이 구하는 함수 생성 === --
create or replace function func_age
(p_birthday in varchar2)
return varchar2
is
    v_age    varchar2(6);
begin
    v_age :=  case when to_date(to_char(sysdate, 'yyyy') || substr(p_birthday, 5, 4), 'yyyymmdd') - to_date(to_char(sysdate,'yyyymmdd'), 'yyyymmdd') > 0 
                    then extract(year from sysdate) - ( to_number(substr(p_birthday,0,4)) ) - 1 
                    else extract(year from sysdate) - ( to_number(substr(p_birthday,0,4)) )
                    end;
    return v_age;
end func_age;
-- Function FUNC_AGE이(가) 컴파일되었습니다.

-- === (의료서비스율 통계) 생년월일을 가지고 만나이 파악 === --
select func_age(birthday) as age
from member
where (midx = 1 and userid != 'Anonymous')
    and userid = #{userid};

-- === 최신 예약 정보(일반) === --
select ridx, userid, reportday, checkin, rcode, hidx
from reserve
where userid = 'hemint'
    and checkin =
        (
            select min(checkin)
            from reserve
            where userid = 'hemint'
                and to_date(checkin,'yyyy-mm-dd hh24:mi:ss') > sysdate
        );
        
-- === 위의 해당하는 병원이름 === --
select hpname
from hospital
where hidx = '#{hidx}'

-- === 최신 예약 정보(의료) === --
select ridx, userid, reportday, checkin, rcode, hidx
from
(
    select ridx, userid, reportday, checkin, rcode, hidx
    from reserve
    where hidx =
        (
            select hidx
            from classcodemet
            where userid = 'md20395'
            group by hidx
        )
        and to_date(checkin,'yyyy-mm-dd hh24:mi:ss') > sysdate
        order by to_date(checkin,'yyyy-mm-dd hh24:mi:ss')
)
where rownum =1

-- === 메인 공지사항 인덱스 === --
select nidx,userid,TITLE,CONTENT,VIEWCNT,WRITEDAY
from (
    select rownum AS rno,nidx,userid,TITLE,CONTENT,VIEWCNT,WRITEDAY
    from NOTICE
    order by NIDX desc
) where rno between 1 and 3

select *
from tab;

-- === 휴지통 테이블 삭제 === --
PURGE TABLE "BIN$8e7sX8kZQ4SPOZ+O5VNgtg==$0";

-- === 휴지통 비우기 === --
PURGE RECYCLEBIN;