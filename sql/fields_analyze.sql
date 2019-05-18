-- 1. COUNT
select count(*) from crime;  -- 277090

-- 2-1. INCIDENT_NUMBER
select count(distinct INCIDENT_NUMBER) from crime;  -- 245665

-- length of INCIDENT_NUMBER
select distinct length(INCIDENT_NUMBER) from crime;     -- 9, 10, 13
select * from crime where length(INCIDENT_NUMBER) = 9;  -- '142052550' (only has one 9-digit INCIDENT_NUMBER)

-- 13-digit INCIDENT_NUMBER
select * from crime where length(INCIDENT_NUMBER) = 13; -- I152044642-00, I152028570-01, I140300475-02, I030217815-08, ... (total 347)

-- no repeated 10-digit INCIDENT_NUMBER
select count(distinct INCIDENT_NUMBER) from crime where length(INCIDENT_NUMBER) = 10;  -- 245533

-- no repeated non-10-digit INCIDENT_NUMBER
select count(distinct INCIDENT_NUMBER) from crime where length(INCIDENT_NUMBER) != 10; -- 132

-- 245533 + 132 = 245665
select count(*)
from (
    select distinct left(INCIDENT_NUMBER, 10) from crime where length(INCIDENT_NUMBER) != 10
    union
    select distinct INCIDENT_NUMBER from crime where length(INCIDENT_NUMBER) = 10
) as t; -- 245665

-- CONCLUTION:
-- there are no I152044642-00 and I152044642 in the columns
-- it is ok to set the CHAR(10) for INCIDENT_NUMBER

-- TEST:
select count(INCIDENT_NUMBER) from crime where length(INCIDENT_NUMBER) != 10;
select count(distinct INCIDENT_NUMBER) from crime;
-- TEST RESULT:
-- CHAR(10)     = 1, 245665
-- VARCHAR(100) = 348, 245665

-- 2-2. duplicated INCIDENT_NUMBER
select distinct RN, INCIDENT_NUMBER
from (
    select
        INCIDENT_NUMBER,
        row_number() over(partition by INCIDENT_NUMBER) as RN
    from crime
) as t
where RN > 1 order by RN; -- 2 ~ 13 (total 31425)

-- 3. OFFENSE_CODE
select distinct length(OFFENSE_CODE) from crime;    -- 4, 5
select count(distinct OFFENSE_CODE) from crime where length(OFFENSE_CODE) = 4;  -- 73
select count(distinct OFFENSE_CODE) from crime where length(OFFENSE_CODE) = 5;  -- 189

select LEN, OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION, AMOUNT
from (
    select
        LEN,
        lag(OFFENSE_CODE)  over (partition by OFFENSE_CODE order by OFFENSE_CODE) as PREV_OFFENSE_CODE,
        OFFENSE_CODE,
        lead(OFFENSE_CODE) over (partition by OFFENSE_CODE order by OFFENSE_CODE) as NEXT_OFFENSE_CODE,
        OFFENSE_CODE_GROUP,
        OFFENSE_DESCRIPTION,
        AMOUNT
    from (
        select
            concat('0', OFFENSE_CODE) as OFFENSE_CODE,
            OFFENSE_CODE_GROUP,
            OFFENSE_DESCRIPTION,
            length(OFFENSE_CODE) as LEN,
            count(*) as AMOUNT
        from crime
        where length(OFFENSE_CODE) = 4
        group by OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION
        union all
        select
            OFFENSE_CODE,
            OFFENSE_CODE_GROUP,
            OFFENSE_DESCRIPTION,
            length(OFFENSE_CODE) as LEN,
            count(*) as AMOUNT
        from crime
        where length(OFFENSE_CODE) = 5
        group by OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION
    ) as t
) as t
where OFFENSE_CODE = PREV_OFFENSE_CODE or OFFENSE_CODE = NEXT_OFFENSE_CODE;
-- SIMILAR: (22)
-- 0724     Auto Theft              AUTO THEFT                              1
-- 00724    Auto Theft              AUTO THEFT                              3164
-- 0727     Auto Theft              AUTO THEFT LEASE/RENT VEHICLE           1
-- 00727    Auto Theft              AUTO THEFT - LEASED/RENTED VEHICLE      352
-- 1102     Fraud                   FRAUD - FALSE PRETENSE                  1
-- 01102    Fraud                   FRAUD - FALSE PRETENSE / SCHEME         3660
-- 1402     Vandalism               VANDALISM                               2
-- 01402    Vandalism               VANDALISM                               13387
-- 1601     Prostitution            PROSTITUTION                            2
-- 01601    Prostitution            PROSTITUTION                            28
-- 1602     Prostitution            PROSTITUTION - SOLICITING               2
-- 01602    Prostitution            PROSTITUTION - SOLICITING               155
-- 1605     Prostitution            PROSTITUTE - COMMON NIGHTWALKER         1
-- 01605    Prostitution            PROSTITUTION - COMMON NIGHTWALKER       11
-- 1841     Drug Violation          DRUGS - POSS CLASS A - INTENT TO MFR DIST DISP      7
-- 01841    Drug Violation          DRUGS - POSS CLASS A - INTENT TO MFR DIST DISP      1157
-- 1842     Drug Violation          DRUGS - POSS CLASS A - HEROIN, ETC.     5
-- 01842    Drug Violation          DRUGS - POSS CLASS A - HEROIN, ETC.     1317
-- 1849     Drug Violation          DRUGS - POSS CLASS B - COCAINE, ETC.    6
-- 01849    Drug Violation          DRUGS - POSS CLASS B - COCAINE, ETC.    2233
-- 1874     Drug Violation          DRUGS - OTHER                           3
-- 01874    Drug Violation          DRUGS - OTHER                           1163
-- 2407     Disorderly Conduct      ANNOYING AND ACCOSTIN                   1
-- 02407    Disorderly Conduct      ANNOYING AND ACCOSTING                  112
-- 2610     Other                   TRESPASSING                             9
-- 02610    Other                   TRESPASSING                             2871
-- 2616     Other                   POSSESSION OF BURGLARIOUS TOOLS         2
-- 02616    Other                   POSSESSION OF BURGLARIOUS TOOLS         188
-- 2632     Evading Fare            EVADING FARE                            1
-- 02632    Evading Fare            EVADING FARE                            355
-- 2647     Other                   THREATS TO DO BODILY HARM               3
-- 02647    Other                   THREATS TO DO BODILY HARM               7768
-- 3109     Police Service Incidents        SERVICE TO OTHER PD INSIDE OF MA.       1
-- 03109    Police Service Incidents        SERVICE TO OTHER PD INSIDE OF MA.       2137
-- 3114     Investigate Property    NVESTIGATE PROPERTY                     1
-- 03114    Investigate Property    INVESTIGATE PROPERTY                    9512
-- 3115     INVESTIGATE PERSON      INVESTIGATE PERSON                      8
-- 03115    Investigate Person      INVESTIGATE PERSON                      16387
-- 3125     Warrant Arrests         WARRANT ARREST                          18
-- 03125    Warrant Arrests         WARRANT ARREST                          7275
-- 3130     Search Warrants         SEARCH WARRANT                          4
-- 03130    Search Warrants         SEARCH WARRANT                          873
-- 3201     Property Lost           PROPERTY - LOST                         1
-- 03201    Property Lost           PROPERTY - LOST                         7553

-- SIMILAR OFFENSE_CODE and DESCRIPTION (TODO: merge the fields)
-- 0724, 0727, 1102, 1402, 1601, 1602, 1605, 1841, 1842, 1849,
-- 1874, 2407, 2610, 2616, 2632, 2647, 3109, 3114, 3115, 3125, 3130, 3201


-- 4. OFFENSE_CODE_GROUP
select count(distinct OFFENSE_CODE_GROUP) from crime;   -- 66
select count(*), OFFENSE_CODE_GROUP
from crime
group by OFFENSE_CODE_GROUP
order by OFFENSE_CODE_GROUP;    -- NO SIMILAR DATA

-- 5. OFFENSE_DESCRIPTION
select count(distinct OFFENSE_DESCRIPTION) from crime;  -- 242
select count(*), OFFENSE_DESCRIPTION
from crime
group by OFFENSE_DESCRIPTION
order by OFFENSE_DESCRIPTION;

-- SIMILAR OFFENSE_DESCRIPTION
-- 2407    Disorderly Conduct  ANNOYING AND ACCOSTIN                            1
-- 02407   Disorderly Conduct  ANNOYING AND ACCOSTING                           112
-- 0727    Auto Theft          AUTO THEFT LEASE/RENT VEHICLE                    1
-- 00727   Auto Theft          AUTO THEFT - LEASED/RENTED VEHICLE               352
-- 1864    Drug Violation      DRUGS - POSS CLASS D - INTENT MFR DIST DISP      1
-- 01848   Drug Violation      DRUGS - POSS CLASS D - INTENT TO MFR DIST DISP   742
-- 1866    Drug Violation      DRUGS - POSS CLASS E INTENT TO MF DIST DISP      2
-- 01850   Drug Violation      DRUGS - POSS CLASS E - INTENT TO MFR DIST DISP   138
-- 1102    Fraud               FRAUD - FALSE PRETENSE                           1
-- 01102   Fraud               FRAUD - FALSE PRETENSE / SCHEME                  3660
-- 1605    Prostitution        PROSTITUTE - COMMON NIGHTWALKER                  1
-- 01605   Prostitution        PROSTITUTION - COMMON NIGHTWALKER                11

-- SAME OFFENSE_DESCRIPTION
-- 1848    Drug Violation       DRUGS - POSS CLASS B - INTENT TO MFR DIST DISP  8
-- 01843   Drug Violation       DRUGS - POSS CLASS B - INTENT TO MFR DIST DISP  1779
-- 2910    Violations           VAL - OPERATING AFTER REV/SUSP.                 2
-- 02907   Violations           VAL - OPERATING AFTER REV/SUSP.                 2306

-- TODO: merge OFFENSE
-- 2407 to 02407
-- 0727 to 00727
-- 1864 to 01848
-- 1866 to 01850
-- 1102 to 01102
-- 1605 to 01605
-- 1848 to 01843
-- 2910 to 02907

-- 6. DISTRICT
select count(distinct DISTRICT) from crime;  -- 13

-- "", A1, A7, A15, B2, B3, C6, C11, D4, D14, E5, E13, E18
select count(*), DISTRICT from crime group by DISTRICT order by DISTRICT;
select count(*) from crime where DISTRICT = ""; -- 1457

-- 7. REPORTING_AREA
select count(distinct REPORTING_AREA) from crime;   -- 879
select count(*), REPORTING_AREA from crime group by REPORTING_AREA order by REPORTING_AREA; -- 0 ~ 962  (0 = 17385 MOST)


-- 8. SHOOTING
select count(*), SHOOTING from crime group by SHOOTING order by SHOOTING;  -- "", "Y"  (276198, 892)

-- 9. OCCURRED_ON_DATE
select count(*) from crime where OCCURRED_ON_DATE is null;  -- 0

-- 10. YEAR
select count(*), YEAR from crime group by YEAR order by YEAR;  -- 2015 ~ 2018
select YEAR, YEAR(OCCURRED_ON_DATE) from crime where YEAR != YEAR(OCCURRED_ON_DATE);  -- none

-- 11. MONTH
select count(*), MONTH from crime group by MONTH order by MONTH;  -- 1 ~ 12
select MONTH, MONTH(OCCURRED_ON_DATE) from crime where MONTH != MONTH(OCCURRED_ON_DATE);  -- none

-- 12. DAY_OF_WEEK
select count(*), DAY_OF_WEEK from crime group by DAY_OF_WEEK order by DAY_OF_WEEK;  -- Sunday, Monday,  Tuesday, Wednesday, Thursday, Friday, Saturday
select DAY_OF_WEEK, DAYNAME(OCCURRED_ON_DATE) from crime where DAY_OF_WEEK != DAYNAME(OCCURRED_ON_DATE);  -- none

-- 13. HOUR
select count(*), HOUR from crime group by HOUR order by HOUR;   -- 0 ~ 23
select HOUR, HOUR(OCCURRED_ON_DATE) from crime where HOUR != HOUR(OCCURRED_ON_DATE);  -- none

-- 14. UCR_PART
select count(distinct UCR_PART) from crime;   -- 5
select count(*), UCR_PART from crime group by UCR_PART order by UCR_PART; -- "", Part One, Part Two, Part Three, Other

-- 14-2. OFFENSE_CODE_GROUP with empty OFFENSE_CODE_GROUP
select OFFENSE_CODE_GROUP, count(*) from crime
where UCR_PART = ""
group by OFFENSE_CODE_GROUP;
-- HOME INVASION
-- INVESTIGATE PERSON
-- HUMAN TRAFFICKING
-- HUMAN TRAFFICKING - INVOLUNTARY SERVITUDE

-- 15. STREET
select count(distinct STREET) from crime;   -- 4520
select count(*), STREET from crime group by STREET order by STREET;

-- SIMILAR:
-- 152   ABBOT ST
-- 1     ABBOT ST 3
-- 1     ABBOT ST BSTN
-- 42    ALBANY ST
-- 2     ALBANY
-- 1233  ALBANY ST
-- ...

-- non-trim data
select count(*) , STREET from crime where STREET like '%ALBANY ST%' group by STREET;                -- 1233, 42
select count(*) , trim(STREET) from crime where STREET like '%ALBANY ST%' group by trim(STREET);    -- 1275

-- Not Trim
-- 42    ALBANY ST
-- 8       BLUE HILL AVE
-- 2       COLUMBUS AVE
-- 10      COMMONWEALTH AVE
-- 27      MASSACHUSETTS AVE

-- CONCLUSION: STREET NEED TO BE TRIM


-- 16. Lat
select count(Lat) from crime where Lat = -1;          -- 581

-- 17. Long
select count(`Long`) from crime where `Long` = -1;    -- 581

-- 18. Location
select count(Location) from crime where Location = '(-1.00000000, -1.00000000)';  -- 581

-- Lat=-1 union Long=-1 union Location='(-1,-1)'
select count(*) from (
    select * from crime where Lat = -1
    union
    select * from crime where `Long` = -1
    union
    select * from crime where Location = '(-1.00000000, -1.00000000)'
) as t;
-- RESULT = 581. All the Lat=-1, Long=-1, Location='(-1,-1)' can be NULL


-- 19. PRIMARY KEY
select count(*)
from(
    select OFFENSE_CODE, INCIDENT_NUMBER
    from crime
    group by OFFENSE_CODE, INCIDENT_NUMBER
) as t; -- 277086 (4 repeated data)

-- repeated data (one have UCR_PART but the other don't)
select INCIDENT_NUMBER, OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION, count(*)
from crime
group by INCIDENT_NUMBER, OFFENSE_CODE, OFFENSE_CODE_GROUP, OFFENSE_DESCRIPTION
having count(*) > 1;
-- I172090479      3115        INVESTIGATE PERSON      INVESTIGATE PERSON      2
-- I152026775-00   3115        Investigate Person      INVESTIGATE PERSON      2
-- I130194606-00   3115        INVESTIGATE PERSON      INVESTIGATE PERSON      2
-- I110694557-00   3115        INVESTIGATE PERSON      INVESTIGATE PERSON      2


-- CONCLUSION
delete from crime where OFFENSE_CODE = '3115' and UCR_PART = '';
