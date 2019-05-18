-- create table
drop table if exists crime;
create table crime (
    `INCIDENT_NUMBER`       varchar(13),   -- 142052550, I152044642-00, I152028570-01, I140300475-02, I030217815-08, ...
    `OFFENSE_CODE`          varchar(5),    -- 0724, 00724, ...
    `OFFENSE_CODE_GROUP`    varchar(100),
    `OFFENSE_DESCRIPTION`   varchar(100),
    `DISTRICT`              varchar(3),    -- "", A1, A7, A15, B2, B3, C6, C11, D4, D14, E5, E13, E18
    `REPORTING_AREA`        varchar(3),    -- "", 000, ...
    `SHOOTING`              char(1),       -- "", Y
    `OCCURRED_ON_DATE`      datetime,
    `YEAR`                  int,           -- 2015 ~ 2018
    `MONTH`                 int,           -- 1 ~ 12
    `DAY_OF_WEEK`           varchar(9),    -- Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    `HOUR`                  int,           -- 0 ~ 23
    `UCR_PART`              char(10),      -- "", Part One, Part Two, Part Three, Other
    `STREET`                varchar(100),
    `Lat`                   double,        -- -1, ...
    `Long`                  double,        -- -1, ...
    `Location`              varchar(100)   -- "(-1,-1)", ...
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
