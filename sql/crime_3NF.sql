-- 3NF --

-- 1. OFFENSE Table

-- 1-1. UCR (5)
create table UCR as
select  @row_index := @row_index + 1 as UCR_ID,
        t.UCR_PART
from    (select distinct UCR_PART from crime) as t
join    (select @row_index := 0) as i
order by t.UCR_PART;

alter table UCR
change column UCR_ID UCR_ID int not null,
add primary key(UCR_ID);

-- 1-2. OFFENSE_GROUP (66)
create table OFFENSE_GROUP as
select  @row_index := @row_index + 1 as OFFENSE_GROUP_ID,
        t.OFFENSE_CODE_GROUP
from    (select distinct OFFENSE_CODE_GROUP from crime) as t
join    (select @row_index := 0) as i
order by t.OFFENSE_CODE_GROUP;

alter table OFFENSE_GROUP
change column OFFENSE_GROUP_ID OFFENSE_GROUP_ID int not null,
add primary key(OFFENSE_GROUP_ID);

-- 1-3. OFFENSE (234)
create table OFFENSE as
select distinct
    crime.OFFENSE_CODE,
    UCR.UCR_ID,
    OFFENSE_GROUP.OFFENSE_GROUP_ID,
    OFFENSE_DESCRIPTION
from crime
inner join UCR           on crime.UCR_PART = UCR.UCR_PART
inner join OFFENSE_GROUP on crime.OFFENSE_CODE_GROUP = OFFENSE_GROUP.OFFENSE_CODE_GROUP
order by crime.OFFENSE_CODE;

alter table OFFENSE
add primary key(OFFENSE_CODE);

-- 2. REPORTING_AREA Table (879)
create table REPORTING_AREA as
select  @row_index := @row_index + 1 as REPORTING_AREA_ID,
        t.REPORTING_AREA             as REPORTING_AREA_CODE
from    (select distinct REPORTING_AREA from crime) as t
join    (select @row_index := 0) as i
order by REPORTING_AREA_CODE;

alter table REPORTING_AREA
change column REPORTING_AREA_ID REPORTING_AREA_ID int not null,
add primary key(REPORTING_AREA_ID);

-- 3. REGION Table

-- 3-1. GPS (277060)
create table GPS as
select  @row_index := @row_index + 1 as GPS_ID,
        crime.Lat  as LATITUDE,
        crime.Long as LONGITUDE
from crime
join (select @row_index := 0) as i;

alter table GPS
change column GPS_ID GPS_ID int not null,
add primary key(GPS_ID);

-- 3-2. STREET (4515)
create table STREET as
select  @row_index := @row_index + 1 as STREET_ID,
        t.STREET as STREET_NAME
from    (select distinct STREET from crime) as t
join    (select @row_index := 0) as i;

alter table STREET
change column STREET_ID STREET_ID int not null,
add primary key(STREET_ID);

-- 3-3. DISTRICT (13)
create table DISTRICT as
select  @row_index := @row_index + 1 as DISTRICT_ID,
        t.DISTRICT as DISTRICT_CODE
from    (select distinct DISTRICT from crime) as t
join    (select @row_index := 0) as i;

alter table DISTRICT
change column DISTRICT_ID DISTRICT_ID int not null,
add primary key(DISTRICT_ID);

-- 3-4. REGION (277060)
create table REGION as
select  @row_index := @row_index + 1 as REGION_ID,
        @row_index as GSP_ID,
        -- STREET.STREET_ID,    -- TODO: too many street
        DISTRICT.DISTRICT_ID
from    crime
join    (select @row_index := 0) as i
-- left join STREET   on STREET.STREET_NAME = crime.STREET
left join DISTRICT on DISTRICT.DISTRICT_CODE = crime.DISTRICT;

alter table REGION
change column REGION_ID REGION_ID int not null,
add primary key(REGION_ID);

-- 4. INCIDENT Table (277060)
create table INCIDENT as
select  crime.INCIDENT_NUMBER,
        crime.OFFENSE_CODE,
        @row_index := @row_index + 1 as REGION_ID,
        REPORTING_AREA.REPORTING_AREA_ID,
        crime.OCCURRED_ON_DATE,
        crime.SHOOTING
from    crime
join    (select @row_index := 0) as i
left join REPORTING_AREA on crime.REPORTING_AREA = REPORTING_AREA.REPORTING_AREA_CODE;

alter table INCIDENT
add primary key(INCIDENT_NUMBER, OFFENSE_CODE);

-- 5. DROP TABLES:
-- drop table if exists DISTRICT;
-- drop table if exists GPS;
-- drop table if exists INCIDENT;
-- drop table if exists OFFENSE;
-- drop table if exists OFFENSE_GROUP;
-- drop table if exists REGION;
-- drop table if exists REPORTING_AREA;
-- drop table if exists STREET;
-- drop table if exists UCR;
