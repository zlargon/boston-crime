-- need to create database at first
-- mysql -u root -p crime < import_from_csv.sql

-- create table
drop table if exists crime;
create table crime (
    `INCIDENT_NUMBER`         char(10)
    , `OFFENSE_CODE`          int
    , `OFFENSE_CODE_GROUP`    varchar(100)
    , `OFFENSE_DESCRIPTION`   varchar(100)
    , `DISTRICT`              char(3)
    , `REPORTING_AREA`        int
    , `SHOOTING`              char(1)
    , `OCCURRED_ON_DATE`      datetime
    , `YEAR`                  int
    , `MONTH`                 int
    , `DAY_OF_WEEK`           varchar(9)
    , `HOUR`                  int
    , `UCR_PART`              varchar(20)
    , `STREET`                varchar(100)
    , `Lat`                   double
    , `Long`                  double
    , `Location`              varchar(100)
);

-- enable local_infile
SET GLOBAL local_infile = true;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- insert data from csv
LOAD DATA LOCAL INFILE '/Users/zlargon/boston-crime/dataset/crime.csv'   -- add CSV file absolate path
INTO TABLE crime
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
