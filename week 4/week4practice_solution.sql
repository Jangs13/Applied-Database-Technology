# Chapter 5 (examples)
# Make sure to select sakila as default schema

#5.1 Listing Tables in a Schema

select *
from information_schema.tables
where table_schema = 'sakila';


##5.2 Listing a Table’s Columns

select column_name, data_type, ordinal_position
from information_schema.columns
where table_schema = 'sakila'
and table_name   = 'actor';

#5.3 Listing Indexed Columns for a Table

show index from actor;

##5.4 Listing Constraints on a Table
## table will show all the foreign key and primary key constraint 
SELECT a.table_name,
       a.constraint_name,
       b.column_name,
       a.constraint_type
FROM information_schema.table_constraints AS a,
     information_schema.key_column_usage AS b
WHERE a.table_name = 'address'
AND a.table_schema = 'sakila'
and a.table_name = b.table_name
AND a.table_schema = b.table_schema
AND a.constraint_name = b.constraint_name;

#5.5 Listing Foreign Keys Without Corresponding Indexes


SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'address';

SHOW INDEX FROM sakila.address;

# we can see that there is an index present on the foreign key on the column city_id

## In MySQL, when you define a foreign key constraint, an index on the columns involved is automatically created if it does not exist. 


#5.6 Using SQL to Generate SQL 
SELECT CONCAT('SELECT COUNT(*) FROM ', table_schema, '.', table_name, ';') 
FROM information_schema.tables 
WHERE table_schema = 'sakila';

SELECT CONCAT('ALTER TABLE ', table_name,' DROP FOREIGN KEY ', constraint_name, ';') 
FROM information_schema.KEY_COLUMN_USAGE 
WHERE table_schema = 'sakila' AND REFERENCED_TABLE_NAME IS NOT NULL;

SELECT CONCAT('ALTER TABLE ', table_name, ' ADD CONSTRAINT ', constraint_name, ' FOREIGN KEY (', column_name, ') REFERENCES ', referenced_table_name, '(', referenced_column_name, ');') 
FROM information_schema.KEY_COLUMN_USAGE 
WHERE table_schema = 'sakila' AND REFERENCED_TABLE_NAME IS NOT NULL;

## you check the foreign key constraints are added back to all the tables in the database
SELECT 
  table_name,
  column_name,
  constraint_name,
  referenced_table_name,
  referenced_column_name
FROM
  information_schema.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'sakila'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

# inserting values
SELECT CONCAT('INSERT INTO actor(actor_id, first_name, last_name) VALUES(', actor_id, ', "', first_name, '", "', last_name, '");') 
FROM actor 
WHERE actor_id = 10;

#5.7 Describing the Data Dictionary Views 
#Query the view named DICTIONARY to list data dictionary views and their purposes:

SELECT table_name, table_comment 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'sakila';


#Query DICT_COLUMNS to describe the columns in a given data dictionary view:

SELECT COLUMN_NAME, COLUMN_COMMENT 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'actor';


############################
# Chapter 6 skip 6.1-6.3 
#6.4 Removing Unwanted Characters from a String
select last_name,
         replace(
         replace(
        replace(
         replace(
         replace(last_name,'A',''),'E',''),'I',''),'O',''),'U','')
         as stripped1
          from actor;
          
#6.5 Separating Numeric and Character Data

select * from actor;

select * from payment;

select * from address;

ALTER TABLE address ADD COLUMN address_postal_together VARCHAR(255);

UPDATE address SET address_postal_together = CONCAT(address, ' ', postal_code)
where district= 'Texas';
#6.6 Determining Whether a String Is Alphanumeric

## For chapter 6, we will use the emp and dept csv files
## MAKE SURE TO CHANGE THE DATABASE 
## If you do not have the database that was created for lab02,
###Create a new db, click on table data import wizard, select the emp and dept files 
##Remember to change the Field Type of MGR to text instead of the default int

#6.6 Determining Whether a String Is Alphanumeric

create view V as
    select ename as data
      from emp
     where deptno=10
     union all
    select concat(ename,', $',sal,'.00') as data
      from emp
     where deptno=20
     union all
    select concat(ename,deptno) as data
      from emp
     where deptno=30;
     
select data from V where data regexp '[^0-9a-zA-Z]' = 0;

#6.7 Extracting Initials from a Name
select * from emp;

select case
when cnt = 2 then
  trim(trailing '.' from
       concat_ws('.',
        substr(substring_index(name,' ',1),1,1),
        substr(name,
               length(substring_index(name,' ',1))+2,1),
        substr(substring_index(name,' ',-1),1,1),
        '.'))
        else
        trim(trailing '.' from
            concat_ws('.',
            substr(substring_index(name,' ',1),1,1),
            substr(substring_index(name,' ',-1),1,1)
            ))
		end as initials
from (
select name, length(name)-length(replace(name,' ','')) as cnt
 from(
 select replace('Stewie Griffin','.','') as name
)y
)x;

select substr(substring_index(name, ' ',1),1,1) as a,
           substr(substring_index(name,' ',-1),1,1) as b
      from (select 'Stewie Griffin' as name ) x;

# 6.8 Ordering by Parts of a String

select ename from emp order by substr(ename,length(ename)-1,2);


#6.9 Ordering by a Number in a String
# MySQL does not provide the TRANSLATE function

#6.10 Creating a Delimited List from Table Rows

select deptno, group_concat(ename order by empno separator ',') as emps from emp group by deptno;

#6.11 Converting Delimited Data into a Multivalued IN-List


select ename,sal,deptno
 from emp
 where empno in ( '7654,7698,7782,7788' );
# here, the IN LIST ( '7654,7698,7782,7788' ) is considered to be a string rather than a comma delimited list

select * from emp where empno= 7654;

CREATE TEMPORARY TABLE temp_numbers (id INT);
INSERT INTO temp_numbers (id) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

select empno, ename, sal, deptno 
from emp
where empno in
( select substring_index(
         substring_index(list.vals,',',iter.id),',',-1) empno
from temp_numbers as iter,
     (select '7654,7698,7782,7788' as vals
	  from (select 1) as dummy_table
      )list
where iter.id <=
     (length(list.vals)-length(replace(list.vals,',','')))+1
     );
     
#6.12 Alphabetizing a String

select ename, group_concat(c order by c separator '')
from (
 select ename, substr(a.ename,iter.id,1) c
from emp a, temp_numbers iter
WHERE iter.id <= LENGTH(a.ename)
) x
GROUP BY ename;

#6.13 Identifying Strings That Can Be Treated as Numbers

create view B as
    select replace(mixed,' ','') as mixed
      from (
    select substr(ename,1,2)||
           cast(deptno as char(4))||
           substr(ename,3,2) as mixed
      from emp
     where deptno = 10
     union all
    select cast(empno as char(4)) as mixed
      from emp
     where deptno = 20
     union all
    select ename as mixed
      from emp
where deptno = 30 )x;

select * from B;


create view P as
    select concat(
             substr(ename,1,2),
             replace(cast(deptno as char(4)),' ',''),
               substr(ename,3,2)
           ) as mixed
      from emp
     where deptno = 10
     union all
    select replace(cast(empno as char(4)), ' ', '')
      from emp where deptno = 20
     union all
    select ename from emp where deptno = 30;
    
select * from P;

    
    
select cast(group_concat(c order by pos separator '') as unsigned)
as MIXED1
from (
select P.mixed, iter.id AS pos, substr(P.mixed,iter.id,1) as c
from P,
temp_numbers as iter
 where iter.id <= length(P.mixed)
 and ascii(substr(P.mixed,iter.id,1)) between 48 and 57
)y
group by mixed
order by 1;


#6.14 Extracting the nth Delimited Substring
CREATE TABLE permanent_numbers (id INT PRIMARY KEY);

INSERT INTO permanent_numbers VALUES (1), (2), (3),(4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

CREATE VIEW C AS
SELECT 'mo,larry,curly' AS name
FROM permanent_numbers
UNION ALL
SELECT 'tina,gina,jaunita,regina,leena' AS name
FROM permanent_numbers;

select * from C;

select name
from (
select iter.id AS pos,
substring_index(
substring_index(src.name,',',iter.id),',',-1) AS name
from C src,
temp_numbers iter
where iter.id <=
length(src.name)-length(replace(src.name,',',''))
) x
where pos = 2;

select iter.id AS pos, src.name
from temp_numbers iter, C src
where iter.id <= length(src.name) - length(replace(src.name, ',', ''));

select iter.id AS pos, src.name AS name1,
       substring_index(src.name,',',iter.id) AS name2,
       substring_index(
        substring_index(src.name,',',iter.id),',',-1) AS name3
from temp_numbers iter,
     C src
where iter.id <= length(src.name) - length(replace(src.name,',',''));

#6.15 Parsing an IP Address

select substring_index(substring_index(y.ip,'.',1),'.',-1) a,
       substring_index(substring_index(y.ip,'.',2),'.',-1) b,
       substring_index(substring_index(y.ip,'.',3),'.',-1) c,
       substring_index(substring_index(y.ip,'.',4),'.',-1) d
from (select '92.111.0.2' as ip from temp_numbers ) y;

#6.16 Comparing Strings by Sound
CREATE TABLE author_names (
    a_name VARCHAR(50)
);

INSERT INTO author_names (a_name) VALUES
('Johnson'),
('Jonson'),
('Jonsen'),
('Jensen'),
('Johnsen'),
('Shakespeare'),
('Shakspear'),
('Shaekspir'),
('Shakespar');


select an1.a_name as name1, an2.a_name as name2,
SOUNDEX(an1.a_name) as Soundex_Name
from author_names an1
join author_names an2
on (SOUNDEX(an1.a_name)=SOUNDEX(an2.a_name)
and an1.a_name!=  an2.a_name);


#6.17 Finding Text Not Matching a Pattern
## this is a specific query for Oracle Database.




##############################################################
#7.1 Computing an average

select avg(sal) as avg_sal from emp;
select deptno, avg(sal) as avg_sal from emp group by deptno;

## remember, that avg ignores null values

#7.2 Finding the Min/Max Value in a Column
select min(sal) as min_sal, max(sal) as max_sal from emp;

select deptno, min(sal) as min_sal, max(sal) as max_sal from emp group by deptno;
# Remember, that min max ignores null values

#7.3 Summing the Values in a Column
select sum(sal) from emp;

select deptno, sum(sal) as total_for_dept from emp group by deptno;

# 7.4 Counting Rows in a Table
select count(*) from emp;

select deptno, count(*) from emp group by deptno;

#7.5 Counting Values in a Column

select count(comm) from emp;

# From 7.6, execute the queries in SQLite as MySQL workbench does not support Window functions








