USE atharv;

DESCRIBE runs;
# Create 

CREATE TABLE route_dim (
    route_id INTEGER NOT NULL AUTO_INCREMENT,
    park_name VARCHAR(160) NOT NULL,
    city_name VARCHAR(160) NOT NULL,
    distance_km FLOAT NOT NULL,
    route_name VARCHAR(160) NOT NULL,
    PRIMARY KEY(route_id)
);

CREATE TABLE week_dim (
    week_id INTEGER NOT NULL AUTO_INCREMENT,
    week INTEGER NOT NULL,
    month VARCHAR(160) NOT NULL,
   year INTEGER NOT NULL,
    PRIMARY KEY(week_id)
);

CREATE TABLE runs_fact (
route_id INTEGER,
week_id INTEGER,
duration_mins FLOAT NOT NULL,
FOREIGN KEY (route_id)
    REFERENCES route_dim(route_id),
FOREIGN KEY (week_id)
    REFERENCES week_dim(week_id)
);


# INSERT

INSERT INTO route_dim (park_name, city_name, route_name, distance_km)  
SELECT DISTINCT park_name, city_name, route_name, distance_km
FROM runs;

INSERT INTO week_dim (week, month, year)
SELECT DISTINCT week, month, year
FROM runs;

INSERT INTO runs_fact (route_id, week_id, duration_mins)
SELECT route_id, week_id, duration_mins
FROM runs AS r
LEFT JOIN week_dim AS w
ON r.week = w.week AND r.month=w.month AND r.year = w.year
LEFT JOIN route_dim as t
ON r.park_name = t.park_name AND r.city_name=t.city_name
AND r.route_name = t.route_name AND r.distance_km = t.distance_km;

#CHECKLIST

select count(*) from runs_fact;
select count(*) from week_dim;
select count(*) from route_dim;

# Exercise 1: Calculate the total of all runs

SELECT
-- Get the total duration of all runs
SUM(duration_mins)
FROM
runs_fact;

# Exercise 2: Find the average running duration time in Central park NY.
# Note - if you copy and paste from Canvas, your single quotes are more likely wrong
# (due to Canvas formatting) - make sure to double-check it if you are getting errors.

SELECT AVG(duration_mins) 
FROM runs_fact
INNER JOIN route_dim ON runs_fact.route_id = route_dim.route_id
WHERE park_name LIKE 'Central Park' AND city_name LIKE 'New York City';

#Exercise 3: Calculate the duration total in May 2019
SELECT
    SUM(duration_mins)
FROM 
    runs_fact
INNER JOIN week_dim ON runs_fact.week_id = week_dim.week_id
WHERE month = 'May' and year = '2019';  

#Exercise 4: print the schema views for runs database. 
#Replace the database name with the name of your database if you chose a different name. 
#You should just see the schema columns.
SELECT * FROM information_schema.views
WHERE table_schema IN ('week4');


