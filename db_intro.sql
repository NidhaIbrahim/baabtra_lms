postgres=# CREATE DATABASE school;
CREATE DATABASE

postgres=# \c school
You are now connected to database "school" as user "postgres".

school=# CREATE TABLE student_data(
school(#     id INT,
school(#     name VARCHAR(50),
school(#     age INT,
school(#     phone VARCHAR(15),
school(#     email VARCHAR(50)
school(# );
CREATE TABLE

school=# \dt
            List of relations
 Schema |     Name     | Type  |  Owner
--------+--------------+-------+----------
 public | student_data | table | postgres
(1 row)

school=# \d student_data
                   Table "public.student_data"
 Column |         Type          | Collation | Nullable | Default
--------+-----------------------+-----------+----------+---------
 id     | integer               |           |          |
 name   | character varying(50) |           |          |
 age    | integer               |           |          |
 phone  | character varying(15) |           |          |
 email  | character varying(50) |           |          |

school=# SELECT * FROM student_data;
 id | name | age | phone | email
----+------+-----+-------+-------
(0 rows)

school=# SELECT * FROM student_data;
 id | name | age | phone | email
----+------+-----+-------+-------
(0 rows)


school=# INSERT INTO student_data VALUES(001,'Fathima',19,'+91 9009923321','example@gmail.com');
INSERT 0 1

school=# SELECT * FROM student_data;
 id |  name   | age |     phone      |       email
----+---------+-----+----------------+-------------------
  1 | Fathima |  19 | +91 9009923321 | example@gmail.com
(1 row)


school=# INSERT INTO student_data VALUES(002,'Aysha',20,'+91 9008923321','example1@gmail.com'),
school-# (003,'khadeeja',29,'+91 9001234321','example2@gmail.com');
INSERT 0 2

school=# INSERT INTO student_data VALUES(004,'Maryam',21,'+91 9123456781','example3@gmail.com');
INSERT 0 1

school=#  SELECT * FROM student_data;
 id |   name   | age |     phone      |       email
----+----------+-----+----------------+--------------------
  1 | Fathima  |  19 | +91 9009923321 | example@gmail.com
  2 | Aysha    |  20 | +91 9008923321 | example1@gmail.com
  3 | khadeeja |  29 | +91 9001234321 | example2@gmail.com
  4 | Maryam   |  21 | +91 9123456781 | example3@gmail.com
(4 rows)
