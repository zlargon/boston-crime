-- 1NF --

-- 1. Delete duplicated rows
select count(*) from crime;     -- before 277090
delete from crime where OFFENSE_CODE = '3115' and UCR_PART = '';
select count(*) from crime;     -- after 277086

-- 2. Trim STREET
select count(distinct STREET) from crime;   -- 4520
update crime set STREET = trim(STREET);
select count(distinct STREET) from crime;   -- 4515


-- 3. Merge Similar OFFENSE_CODE and DESCRIPTION (total 26)
--    Before 262
select count(*) from (
    select OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION from crime
    group by OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION
) as t;

-- 0724 to 00724
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '00724') as Target
    ON crime.OFFENSE_CODE = '0724'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 0727 to 00727 (simliar DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '00727') as Target
    ON crime.OFFENSE_CODE = '0727'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1102 to 01102 (simliar DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01102') as Target
    ON crime.OFFENSE_CODE = '1102'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1402 to 01402
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01402') as Target
    ON crime.OFFENSE_CODE = '1402'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1601 to 01601
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01601') as Target
    ON crime.OFFENSE_CODE = '1601'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1602 to 01602
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01602') as Target
    ON crime.OFFENSE_CODE = '1602'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1605 to 01605 (simliar DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01605') as Target
    ON crime.OFFENSE_CODE = '01605'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1841 to 01841
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01841') as Target
    ON crime.OFFENSE_CODE = '1841'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1842 to 01842
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01842') as Target
    ON crime.OFFENSE_CODE = '1842'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1849 to 01849
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01849') as Target
    ON crime.OFFENSE_CODE = '1849'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1874 to 01874
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01874') as Target
    ON crime.OFFENSE_CODE = '1874'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 2407 to 02407 (simliar DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '02407') as Target
    ON crime.OFFENSE_CODE = '2407'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 2610 to 02610
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '02610') as Target
    ON crime.OFFENSE_CODE = '2610'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 2616 to 02616
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '02616') as Target
    ON crime.OFFENSE_CODE = '2616'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 2632 to 02632
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '02632') as Target
    ON crime.OFFENSE_CODE = '2632'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 2647 to 02647
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '02647') as Target
    ON crime.OFFENSE_CODE = '2647'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 3109 to 03109
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '03109') as Target
    ON crime.OFFENSE_CODE = '3109'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 3114 to 03114
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '03114') as Target
    ON crime.OFFENSE_CODE = '3114'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 3115 to 03115
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '03115') as Target
    ON crime.OFFENSE_CODE = '3115'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 3125 to 03125
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '03125') as Target
    ON crime.OFFENSE_CODE = '3125'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 3130 to 03130
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '03130') as Target
    ON crime.OFFENSE_CODE = '3130'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 3201 to 03201
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '03201') as Target
    ON crime.OFFENSE_CODE = '3201'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1864 to 01848 (simliar DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01848') as Target
    ON crime.OFFENSE_CODE = '1864'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1866 to 01850 (simliar DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01850') as Target
    ON crime.OFFENSE_CODE = '1866'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 1848 to 01843 (same DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '01843') as Target
    ON crime.OFFENSE_CODE = '1848'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- 2910 to 02907 (same DESCRIPTION)
UPDATE crime
    JOIN (select * from crime where OFFENSE_CODE = '02907') as Target
    ON crime.OFFENSE_CODE = '2910'
SET crime.OFFENSE_CODE = Target.OFFENSE_CODE,
    crime.OFFENSE_CODE_GROUP = Target.OFFENSE_CODE_GROUP,
    crime.OFFENSE_DESCRIPTION = Target.OFFENSE_DESCRIPTION;

-- After 237
select count(*) from (
    select OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION from crime
    group by OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION
) as t;

-- 4. remove duplicated
select count(*) from crime;     -- before 277086

drop table if exists crime_tmp;
create table crime_tmp as (select * from crime);    -- copy crime to crime_tmp
drop table crime;

-- remove 26 duplicate rows
create table crime as
select
    INCIDENT_NUMBER,
    OFFENSE_CODE,
    OFFENSE_CODE_GROUP,
    OFFENSE_DESCRIPTION,
    DISTRICT,
    REPORTING_AREA,
    SHOOTING,
    OCCURRED_ON_DATE,
    YEAR,
    MONTH,
    DAY_OF_WEEK,
    HOUR,
    UCR_PART,
    STREET,
    Lat,
    `Long`,
    Location
from (select *, row_number() over (partition by INCIDENT_NUMBER, OFFENSE_CODE) as RN from crime_tmp) as t
where RN = 1;
drop table crime_tmp;
select count(*) from crime;     -- after 277060

-- 5. add the primary keys (INCIDENT_NUMBER, OFFENSE_CODE)
ALTER TABLE crime
CHANGE COLUMN `INCIDENT_NUMBER` `INCIDENT_NUMBER` VARCHAR(13) NOT NULL,
CHANGE COLUMN `OFFENSE_CODE` `OFFENSE_CODE` VARCHAR(5)  NOT NULL,
ADD PRIMARY KEY (`INCIDENT_NUMBER`, `OFFENSE_CODE`);

-- 6. Shooting
ALTER TABLE crime ADD COLUMN shooting_num int after SHOOTING;
update crime set shooting_num = 0;
update crime set shooting_num = 1 where SHOOTING = 'Y';
ALTER TABLE crime DROP COLUMN SHOOTING;
ALTER TABLE crime RENAME COLUMN shooting_num TO SHOOTING;
