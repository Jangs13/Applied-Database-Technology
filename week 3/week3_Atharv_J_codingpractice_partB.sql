#Listing 3-1: Character data types in action

CREATE TABLE char_data_types (
    varchar_column varchar(10),
    char_column char(10),
    text_column text
);

INSERT INTO char_data_types
  VALUES
      ('abc', 'abc', 'abc'),
      ('defghi', 'defghi', 'defghi');
      
SELECT * FROM char_data_types;

#
CREATE TABLE people (
    id serial,
    person_name varchar(100)
);

INSERT INTO people(person_name)
  VALUES
      ('mike'),
      ('sony');

SELECT * from people;

#Listing 3-2: Number data types in action

CREATE TABLE number_data_types (
    numeric_column numeric(20,5),
      real_column float,
      double_column double
  );
  
INSERT INTO number_data_types
  VALUES
      (.7, .7, .7),
      (2.13579, 2.13579, 2.13579),
      (2.1357987654, 2.1357987654, 2.1357987654);
	
SELECT
    numeric_column * 10000000 AS "Fixed",
    real_column * 10000000 AS "Float"
FROM number_data_types
WHERE numeric_column = .7;

CREATE TABLE date_time_types (
    timestamp_column timestamp,
    interval_column time
);

INSERT INTO date_time_types
VALUES
    ('2018-12-31 01:00:00','48:00:00'),
    ('2018-12-31 01:00:00','72:00:00'),
    ('2018-12-31 01:00:00','96:00:00'),
    (now(),'120:00:00');

SELECT * FROM date_time_types;



