-- Star Schema --

-- 1. OFFENSE table
create table OFFENSE as
select distinct
    OFFENSE_CODE,
    OFFENSE_CODE_GROUP,
    OFFENSE_DESCRIPTION,
    UCR_PART
from crime;

alter table OFFENSE
add primary key(OFFENSE_CODE);

-- 2. REPORTING_AREA table
create table REPORTING_AREA as
select  @row_index := @row_index + 1 as REPORTING_AREA_ID,
        t.REPORTING_AREA             as REPORTING_AREA_CODE
from    (select distinct REPORTING_AREA from crime) as t
join    (select @row_index := 0) as i
order by REPORTING_AREA_CODE;

alter table REPORTING_AREA
change column REPORTING_AREA_ID REPORTING_AREA_ID int not null,
add primary key(REPORTING_AREA_ID);


-- 3. OCCURRED_TIME
create table OCCURRED_TIME as
select  @row_index := @row_index + 1 as TIME_ID,
        crime.YEAR,
        crime.MONTH,
        DAY(crime.OCCURRED_ON_DATE) as DATE,
        crime.HOUR,
        crime.DAY_OF_WEEK
from    crime
join    (select @row_index := 0) as i;

alter table OCCURRED_TIME
change column TIME_ID TIME_ID int not null,
add primary key(TIME_ID);

-- 4. REGION
create table REGION as
select  @row_index := @row_index + 1 as REGION_ID,
        crime.STREET,
        crime.DISTRICT,
        crime.Lat as LATITUDE,
        crime.Long as LONGITUDE
from    crime
join    (select @row_index := 0) as i;

alter table REGION
change column REGION_ID REGION_ID int not null,
add primary key(REGION_ID);

-- 5. INCIDENT
create table INCIDENT as
select  crime.INCIDENT_NUMBER,
        crime.OFFENSE_CODE,
        @row_index := @row_index + 1 as TIME_ID,
        @row_index as REGION_ID,
        REPORTING_AREA.REPORTING_AREA_ID,
        crime.SHOOTING
from    crime
join    (select @row_index := 0) as i
inner join REPORTING_AREA on crime.REPORTING_AREA = REPORTING_AREA.REPORTING_AREA_CODE;

alter table INCIDENT
add primary key(INCIDENT_NUMBER, OFFENSE_CODE);
