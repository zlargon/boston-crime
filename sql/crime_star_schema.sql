-- Star Schema --

-- OFFENSE table
create table OFFENSE as
select distinct
    OFFENSE_CODE,
    OFFENSE_CODE_GROUP,
    OFFENSE_DESCRIPTION,
    UCR_PART
from crime;

-- OCCURRED_TIME
create table OCCURRED_TIME as
select  @row_index := @row_index + 1 as TIME_ID,
        crime.YEAR,
        crime.MONTH,
        DAY(crime.OCCURRED_ON_DATE) as DATE,
        crime.HOUR,
        crime.DAY_OF_WEEK
from    crime
join    (select @row_index := 0) as i;

-- REGION
create table REGION as
select  @row_index := @row_index + 1 as REGION_ID,
        crime.STREET,
        crime.DISTRICT,
        crime.REPORTING_AREA,
        crime.Lat as LATITUDE,
        crime.Long as LONGITUDE
from    crime
join    (select @row_index := 0) as i;

-- INCIDENT
create table INCIDENT as
select  crime.INCIDENT_NUMBER,
        crime.OFFENSE_CODE,
        @row_index := @row_index + 1 as TIME_ID,
        @row_index as REGION_ID,
        crime.SHOOTING
from    crime
join    (select @row_index := 0) as i;
