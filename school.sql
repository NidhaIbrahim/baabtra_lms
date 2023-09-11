postgres=# CREATE DATABASE school
ERROR:  database "school" already exists

postgres=# \c school
You are now connected to database "school" as user "postgres".

school=# CREATE TABLE classes(
school(# pk_class_id SERIAL PRIMARY KEY,
school(# class_name VARCHAR(200)
school(# );
CREATE TABLE
school=#

school=# CREATE TABLE subjects(
school(#     pk_subject_id SERIAL PRIMARY KEY,
school(#     subject_name VARCHAR(200)
school(# );
CREATE TABLE

school=# CREATE TABLE students(
school(#     pk_student_id SERIAL PRIMARY KEY,
school(#     student_name VARCHAR(200),
school(#     date_of_birth DATE,
school(#     contact_number VARCHAR(15),
school(#     name_of_guardian VARCHAR(100),
school(#     fk_class_id INT,
school(#     FOREIGN KEY(fk_class_id) REFERENCES classes(pk_class_id)
school(#     ON DELETE CASCADE ON UPDATE CASCADE
school(# );
CREATE TABLE

school=# CREATE TABLE teachers(
school(#     pk_teacher_id SERIAL PRIMARY KEY,
school(#     teacher_name VARCHAR(200),
school(#     fk_subject_id INT,
school(#     FOREIGN KEY(fk_subject_id) REFERENCES subjects(pk_subject_id)
school(#     ON DELETE CASCADE ON UPDATE CASCADE
school(# );
CREATE TABLE

school=# CREATE TABLE examinations(
school(#     pk_exam_id SERIAL PRIMARY KEY,
school(#     exam_name VARCHAR(200),
school(#     date_of_exam DATE,
school(#     fk_subject_id INT,
school(#     FOREIGN KEY(fk_subject_id) REFERENCES subjects(pk_subject_id)
school(#     ON DELETE CASCADE ON UPDATE CASCADE
school(# );
CREATE TABLE

school=# INSERT INTO classes VALUES
school=# (1,'twelfth grade'),
school=# (2,'eleventh grade'),
school=# (3,'tenth grade'),
school=# (4,'nineth grade');
INSERT 0 4

school=# INSERT INTO subjects VALUES
school-# (1, 'MATHS'),
school-# (2, 'ENGLISH'),
school-# (3, 'COMPUTER SCIENCE'),
school-# (4, 'LANGUAGE'),
school-# (5, 'ELECTRONICS');
INSERT 0 5

school=# INSERT INTO students VALUES
school-# (1, 'Fathima Fida', '2002-06-23','0987654321', 'Fadil', 1),
school-# (2, 'Ashwin', '2000-09-15','9897656321', 'Chandran', 4),
school-# (3, 'Afi', '2001-10-31','9897656341', 'Rahman', 3),
school-# (4, 'Harsh', '2000-01-21','9845656341', 'Muhammed', 4),
school-# (5, 'Fayik', '2002-03-12','9987622121', 'Ahmed', 2),
school-# (6, 'Nidha', '2002-07-16','7987123421', 'Ibrahim', 1);
INSERT 0 6

school=# INSERT INTO teachers VALUES
school-# (1, 'Athira',1),
school-# (2, 'Rifad',2),
school-# (3, 'Suvarna',3),
school-# (4, 'Rishan',4),
school-# (5, 'Anupama',5),
school-# (6,'Rasha',2);
INSERT 0 6

school=# INSERT INTO examinations VALUES
school-# (1, 'mid term','2020-06-30',1),
school-# (2, 'mid term','2020-07-03',2),
school-# (3, 'mid term','2020-07-07',3),
school-# (4, 'mid term','2020-07-09',4),
school-# (5, 'mid term','2020-07-11',5),
school-# (6, 'final','2021-03-05',1),
school-# (7, 'final','2021-03-07',2),
school-# (8, 'final','2021-03-09',3),
school-# (9, 'final','2021-03-11',4),
school-# (10, 'final','2021-03-13',5);
INSERT 0 10

school=# SELECT * FROM students WHERE fk_class_id = '2';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
(1 row)


school=# SELECT * FROM students WHERE fk_class_id = '4';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
(2 rows)


school=# SELECT * FROM students WHERE fk_class_id = '1';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             6 | Nidha        | 2002-07-16    | 7987123421     | Ibrahim          |           1
(2 rows)

school=# SELECT * FROM examinations WHERE fk_subject_id = 2;
 pk_exam_id | exam_name | date_of_exam | fk_subject_id
------------+-----------+--------------+---------------
          2 | mid term  | 2020-07-03   |             2
          7 | final     | 2021-03-07   |             2
(2 rows)

school=# SELECT * FROM teachers WHERE fk_subject_id = 2;
 pk_teacher_id | teacher_name | fk_subject_id
---------------+--------------+---------------
             2 | Rifad        |             2
             6 | Rasha        |             2
(2 rows)

school=# SELECT * FROM students WHERE date_of_birth < '2002-04-12';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
(4 rows)

school=# SELECT * FROM examinations WHERE date_of_exam > '2020-07-11';
 pk_exam_id | exam_name | date_of_exam | fk_subject_id
------------+-----------+--------------+---------------
          6 | final     | 2021-03-05   |             1
          7 | final     | 2021-03-07   |             2
          8 | final     | 2021-03-09   |             3
          9 | final     | 2021-03-11   |             4
         10 | final     | 2021-03-13   |             5
(5 rows)

SELECT * FROM students LIMIT 3;school=# SELECT * FROM students LIMIT 3;
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
(3 rows)

school=# SELECT DISTINCT fk_subject_id FROM examinations;
 fk_subject_id
---------------
             3
             5
             4
             2
             1
(5 rows)

school=# SELECT * FROM students WHERE name_of_guardian LIKE 'A%';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
(1 row)

school=# SELECT * FROM students WHERE contact_number LIKE '98________';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
(3 rows)

school=# SELECT * FROM students WHERE student_name LIKE '%a';
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             6 | Nidha        | 2002-07-16    | 7987123421     | Ibrahim          |           1
(2 rows)

school=# SELECT * FROM teachers WHERE teacher_name LIKE '%a%';
 pk_teacher_id | teacher_name | fk_subject_id
---------------+--------------+---------------
             1 | Athira       |             1
             2 | Rifad        |             2
             3 | Suvarna      |             3
             4 | Rishan       |             4
             5 | Anupama      |             5
             6 | Rasha        |             2
(6 rows)


school=# SELECT * FROM teachers WHERE teacher_name LIKE '%pa%';
 pk_teacher_id | teacher_name | fk_subject_id
---------------+--------------+---------------
             5 | Anupama      |             5
(1 row)

school=# SELECT * FROM examinations WHERE exam_name LIKE 'f%';
 pk_exam_id | exam_name | date_of_exam | fk_subject_id
------------+-----------+--------------+---------------
          6 | final     | 2021-03-05   |             1
          7 | final     | 2021-03-07   |             2
          8 | final     | 2021-03-09   |             3
          9 | final     | 2021-03-11   |             4
         10 | final     | 2021-03-13   |             5
(5 rows)


school=# SELECT name_of_guardian FROM students WHERE name_of_guardian LIKE '______';
 name_of_guardian
------------------
 Rahman
(1 row)

school=# SELECT * FROM subjects WHERE subject_name LIKE 'M%S';
 pk_subject_id | subject_name
---------------+--------------
             1 | MATHS
(1 row)



-- table marks


school=# CREATE TABLE marks(
school(#     pk_mark_id SERIAL PRIMARY KEY,
school(#     fk_student_id INT,
school(#     fk_exam_id INT,
school(#     marks_obtained BIGINT
school(# );
CREATE TABLE

school=# INSERT INTO marks VALUES
school-# (1,1,1,95),
school-# (2,1,2,80),
school-# (3,2,3,99),
school-# (4,2,4,85),
school-# (5,3,9,69),
school-# (6,5,7,67),
school-# (7,6,7,89),
school-# (8,4,9,93),
school-# (9,4,3,89),
school-# (10,3,4,80)
school-# ;
INSERT 0 10


school=# SELECT SUM(marks_obtained) AS Total_marks FROM marks GROUP BY fk_student_id;
 total_marks
-------------
         149
          67
         182
          89
         184
         175
(6 rows)


school=# SELECT AVG(marks_obtained) AS Average_marks FROM marks GROUP BY fk_exam_id;
    average_marks
---------------------
 81.0000000000000000
 94.0000000000000000
 82.5000000000000000
 80.0000000000000000
 78.0000000000000000
 95.0000000000000000
(6 rows)

school=# SELECT COUNT(*) FROM students GROUP BY fk_class_id;
 count
-------
     2
     1
     1
     2
(4 rows)

school=# SELECT SUM(marks_obtained) AS Total_marks FROM marks GROUP BY fk_student_id;
 total_marks
-------------
         149
          67
         182
          89
         184
         175
(6 rows) 

school=# SELECT SUM(marks_obtained) AS Total_marks FROM marks GROUP BY fk_student_id HAVING SUM(marks_obtained) > 100;
 total_marks
-------------
         149
         182
         184
         175
(4 rows)


school=# SELECT SUM(marks_obtained) AS Total_marks FROM marks GROUP BY fk_exam_id;
 total_marks
-------------
         162
         188
         165
          80
         156
          95
(6 rows)

school=# ALTER TABLE marks ADD CONSTRAINT fk_student_id_constraint
school-#  FOREIGN KEY(fk_student_id) REFERENCES students(pk_student_id)
school-#   ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE
school=# \d marks
                                    Table "public.marks"
     Column     |  Type   | Collation | Nullable |                  Default
----------------+---------+-----------+----------+-------------------------------------------
 pk_mark_id     | integer |           | not null | nextval('marks_pk_mark_id_seq'::regclass)
 fk_student_id  | integer |           |          |
 fk_exam_id     | integer |           |          |
 marks_obtained | bigint  |           |          |
Indexes:
    "marks_pkey" PRIMARY KEY, btree (pk_mark_id)
Foreign-key constraints:
    "fk_student_id_constraint" FOREIGN KEY (fk_student_id) REFERENCES students(pk_student_id) ON UPDATE CASCADE ON DELETE CASCADE

    school=# ALTER TABLE marks ADD CONSTRAINT fk_exam_id_constraint
school-# FOREIGN KEY(fk_exam_id) REFERENCES examinations(pk_exam_id)
school-#  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE
school=# \d marks
                                    Table "public.marks"
     Column     |  Type   | Collation | Nullable |                  Default
----------------+---------+-----------+----------+-------------------------------------------
 pk_mark_id     | integer |           | not null | nextval('marks_pk_mark_id_seq'::regclass)
 fk_student_id  | integer |           |          |
 fk_exam_id     | integer |           |          |
 marks_obtained | bigint  |           |          |
Indexes:
    "marks_pkey" PRIMARY KEY, btree (pk_mark_id)
Foreign-key constraints:
    "fk_exam_id_constraint" FOREIGN KEY (fk_exam_id) REFERENCES examinations(pk_exam_id) ON UPDATE CASCADE ON DELETE CASCADE
    "fk_student_id_constraint" FOREIGN KEY (fk_student_id) REFERENCES students(pk_student_id) ON UPDATE CASCADE ON DELETE CASCADE



    -- Retrieve Student Names and Their Respective Class Names:

school=# SELECT * FROM students;
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
             6 | Nidha        | 2002-07-16    | 7987123421     | Ibrahim          |           1
(6 rows)


school=# SELECT * FROM classes;
 pk_class_id |   class_name
-------------+----------------
           1 | twelfth grade
           2 | eleventh grade
           3 | tenth grade
           4 | nineth grade
(4 rows)


school=# SELECT student_name, class_name 
FROM students 
INNER JOIN classes 
ON classes.pk_class_id = students.fk_class_id;
student_name |   class_name
--------------+----------------
 Fathima Fida | twelfth grade
 Ashwin       | nineth grade
 Afi          | tenth grade
 Harsh        | nineth grade
 Fayik        | eleventh grade
 Nidha        | twelfth grade
(6 rows)

school=# SELECT stu.student_name, c.class_name 
FROM students stu 
INNER JOIN classes c
ON c.pk_class_id = stu.fk_class_id;
 student_name |   class_name
--------------+----------------
 Fathima Fida | twelfth grade
 Ashwin       | nineth grade
 Afi          | tenth grade
 Harsh        | nineth grade
 Fayik        | eleventh grade
 Nidha        | twelfth grade
(6 rows)

 


-- Retrieve Teachers' Names and Their Respective Subject Names:

school=# SELECT * FROM subjects;
 pk_subject_id |   subject_name
---------------+------------------
             1 | MATHS
             2 | ENGLISH
             3 | COMPUTER SCIENCE
             4 | LANGUAGE
             5 | ELECTRONICS
(5 rows)

school=# SELECT * FROM teachers;
 pk_teacher_id | teacher_name | fk_subject_id
---------------+--------------+---------------
             1 | Athira       |             1
             2 | Rifad        |             2
             3 | Suvarna      |             3
             4 | Rishan       |             4
             5 | Anupama      |             5
             6 | Rasha        |             2
(6 rows)

SELECT t.teacher_name, sub.subject_name 
FROM teachers t 
INNER JOIN subjects sub
ON t.fk_subject_id = sub.pk_subject_id;

 teacher_name |   subject_name
--------------+------------------
 Athira       | MATHS
 Rifad        | ENGLISH
 Suvarna      | COMPUTER SCIENCE
 Rishan       | LANGUAGE
 Anupama      | ELECTRONICS
 Rasha        | ENGLISH
(6 rows)

-- Retrieve Students and Their Marks in a Specific Exam:
school=# SELECT * FROM students;
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
             6 | Nidha        | 2002-07-16    | 7987123421     | Ibrahim          |           1
(6 rows)

school=# SELECT * FROM marks;
 pk_mark_id | fk_student_id | fk_exam_id | marks_obtained
------------+---------------+------------+----------------
          1 |             1 |          1 |             95
          2 |             1 |          2 |             80
          3 |             2 |          3 |             99
          4 |             2 |          4 |             85
          5 |             3 |          9 |             69
          6 |             5 |          7 |             67
          7 |             6 |          7 |             89
          8 |             4 |          9 |             93
          9 |             4 |          3 |             89
         10 |             3 |          4 |             80
(10 rows)

SELECT stu.student_name, m.marks_obtained 
FROM students stu 
INNER JOIN marks m
ON stu.pk_student_id = m.fk_student_id 
WHERE m.fk_exam_id = 7;
 student_name | marks_obtained
--------------+----------------
 Fayik        |             67
 Nidha        |             89
(2 rows)

-- Retrieve Teachers Who Are Not Teaching Any Subjects

INSERT INTO marks VALUES(11, 6, 7);
INSERT 0 1
school=#  SELECT * FROM marks;
 pk_mark_id | fk_student_id | fk_exam_id | marks_obtained
------------+---------------+------------+----------------
          1 |             1 |          1 |             95
          2 |             1 |          2 |             80
          3 |             2 |          3 |             99
          4 |             2 |          4 |             85
          5 |             3 |          9 |             69
          6 |             5 |          7 |             67
          7 |             6 |          7 |             89
          8 |             4 |          9 |             93
          9 |             4 |          3 |             89
         10 |             3 |          4 |             80
         11 |             6 |          7 |
(11 rows)

INSERT INTO teachers VALUES(7, Khadeeja);
INSERT 0 1
school=# SELECT * FROM teachers;
 pk_teacher_id | teacher_name | fk_subject_id
---------------+--------------+---------------
             1 | Athira       |             1
             2 | Rifad        |             2
             3 | Suvarna      |             3
             4 | Rishan       |             4
             5 | Anupama      |             5
             6 | Rasha        |             2
             7 | Khadeeja     |
(7 rows)

school=# SELECT teacher_name FROM teachers WHERE fk_subject_id IS NULL;
 teacher_name
--------------
 Khadeeja
(1 row)

school=# SELECT fk_student_id FROM marks WHERE marks_obtained IS NULL;
 fk_student_id
---------------
             6
(1 row)


school=# SELECT * FROM marks WHERE marks_obtained IS NULL;
 pk_mark_id | fk_student_id | fk_exam_id | marks_obtained
------------+---------------+------------+----------------
         11 |             6 |          7 |
(1 row)
 

-- Retrieve Students Who Scored Higher Than the Class Average:

school=# SELECT * FROM students;
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
             6 | Nidha        | 2002-07-16    | 7987123421     | Ibrahim          |           1
(6 rows)

school=#  SELECT * FROM marks;
 pk_mark_id | fk_student_id | fk_exam_id | marks_obtained
------------+---------------+------------+----------------
          1 |             1 |          1 |             95
          2 |             1 |          2 |             80
          3 |             2 |          3 |             99
          4 |             2 |          4 |             85
          5 |             3 |          9 |             69
          6 |             5 |          7 |             67
          7 |             6 |          7 |             89
          8 |             4 |          9 |             93
          9 |             4 |          3 |             89
         10 |             3 |          4 |             80
         11 |             6 |          7 |
(11 rows)


school=# SELECT * FROM examinations;
 pk_exam_id | exam_name | date_of_exam | fk_subject_id
------------+-----------+--------------+---------------
          1 | mid term  | 2020-06-30   |             1
          2 | mid term  | 2020-07-03   |             2
          3 | mid term  | 2020-07-07   |             3
          4 | mid term  | 2020-07-09   |             4
          5 | mid term  | 2020-07-11   |             5
          6 | final     | 2021-03-05   |             1
          7 | final     | 2021-03-07   |             2
          8 | final     | 2021-03-09   |             3
          9 | final     | 2021-03-11   |             4
         10 | final     | 2021-03-13   |             5
(10 rows)

SELECT st.student_name, m.marks_obtained 
FROM students st
INNER JOIN marks m
ON st.pk_student_id = m.fk_student_id
WHERE m.marks_obtained > (SELECT avg(marks_obtained) FROM marks);

 student_name | marks_obtained
--------------+----------------
 Fathima Fida |             95
 Ashwin       |             99
 Ashwin       |             85
 Nidha        |             89
 Harsh        |             93
 Harsh        |             89
(6 rows)

SELECT e.exam_name, AVG(m.marks_obtained) AS average_marks
FROM examinations e
INNER JOIN marks m
ON e.pk_exam_id = m.fk_exam_id
GROUP BY e.pk_exam_id, e.exam_name
HAVING AVG(m.marks_obtained) > 80;



SELECT s.student_name 
FROM students s 
WHERE s.pk_student_id NOT IN
(SELECT DISTINCT m.fk_student_id 
FROM marks m 
INNER JOIN examinations e
ON m.fk_exam_id = e.pk_exam_id
WHERE e.fk_subject_id = 2);

school=# SELECT * FROM students;
 pk_student_id | student_name | date_of_birth | contact_number | name_of_guardian | fk_class_id
---------------+--------------+---------------+----------------+------------------+-------------
             1 | Fathima Fida | 2002-06-23    | 0987654321     | Fadil            |           1
             2 | Ashwin       | 2000-09-15    | 9897656321     | Chandran         |           4
             3 | Afi          | 2001-10-31    | 9897656341     | Rahman           |           3
             4 | Harsh        | 2000-01-21    | 9845656341     | Muhammed         |           4
             5 | Fayik        | 2002-03-12    | 9987622121     | Ahmed            |           2
             6 | Nidha        | 2002-07-16    | 7987123421     | Ibrahim          |           1
(6 rows)

school=# SELECT * FROM examinations;
 pk_exam_id | exam_name | date_of_exam | fk_subject_id
------------+-----------+--------------+---------------
          1 | mid term  | 2020-06-30   |             1
          2 | mid term  | 2020-07-03   |             2
          3 | mid term  | 2020-07-07   |             3
          4 | mid term  | 2020-07-09   |             4
          5 | mid term  | 2020-07-11   |             5
          6 | final     | 2021-03-05   |             1
          7 | final     | 2021-03-07   |             2
          8 | final     | 2021-03-09   |             3
          9 | final     | 2021-03-11   |             4
         10 | final     | 2021-03-13   |             5
(10 rows)

school=# SELECT * FROM marks;
 pk_mark_id | fk_student_id | fk_exam_id | marks_obtained
------------+---------------+------------+----------------
          1 |             1 |          1 |             95
          2 |             1 |          2 |             80
          3 |             2 |          3 |             99
          4 |             2 |          4 |             85
          5 |             3 |          9 |             69
          6 |             5 |          7 |             67
          7 |             6 |          7 |             89
          8 |             4 |          9 |             93
          9 |             4 |          3 |             89
         10 |             3 |          4 |             80
         11 |             6 |          7 |
(11 rows)


