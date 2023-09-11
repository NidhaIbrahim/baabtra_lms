CREATE DATABASE sample;
CREATE DATABASE

CREATE TABLE student (
    student_id SERIAL PRIMARY KEY ,
    student_name VARCHAR(50) NOT NULL,
    class VARCHAR(50) NOT NULL,
    section VARCHAR(50) NOT NULL
);
CREATE TABLE
Time: 31.595 ms

 \timing
Timing is on.

INSERT INTO student(student_name,class,section) VALUES
('Fida','X','A'),
('Hafi','XI','B'),
('Ashwin','X','C'),
('Harsh','XI','B');
INSERT 0 4
Time: 9.634 ms

 SELECT * FROM student;
 student_id | student_name | class | section
------------+--------------+-------+---------
          1 | Fida         | X     | A
          2 | Hafi         | XI    | B
          3 | Ashwin       | X     | C
          4 | Harsh        | XI    | B
(4 rows)


Time: 0.558 ms

CREATE TABLE student_grade(
    id SERIAL PRIMARY KEY,
    fk_student_id INT,
    subject VARCHAR(100) NOT NULL,
    grade VARCHAR(5) NOT NULL,
    mark FLOAT NOT NULL
    );
    CREATE TABLE
Time: 13.352 ms


INSERT INTO student_grade(fk_student_id,subject,grade,mark) VALUES
(1,'Physics','A','95'),
(1,'English','B','83'),
(2,'English','C','79'),
(3,'Physics','F','45'),
(2,'Physics','D','64'),
(4,'English','A','93'),
(4,'Physics','B','89'),
(3,'English','C','77')
;
INSERT 0 8
Time: 6.952 ms

ALTER TABLE student_grade
ADD CONSTRAINT fk_student_id_constraint
FOREIGN KEY(fk_student_id) REFERENCES student(student_id)
ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE

SELECT * FROM student_grade WHERE grade = 'A' AND subject = 'Physics';

SELECT student_name, class, grade 
FROM student s
INNER JOIN student_grade sg
ON s.student_id = sg.fk_student_id
WHERE grade = 'C' AND subject = 'English';
student_name | class | grade
--------------+-------+-------
 Hafi         | XI    | C
 Ashwin       | X     | C
(2 rows)

CREATE VIEW English_gradeC AS
SELECT student_name, class, grade 
FROM student s
INNER JOIN student_grade sg
ON s.student_id = sg.fk_student_id
WHERE grade = 'C' AND subject = 'English';
Time: 9.715 ms
sample=# SELECT * FROM English_gradeC;
 student_name | class | grade
--------------+-------+-------
 Hafi         | XI    | C
 Ashwin       | X     | C
(2 rows)

SELECT table_name
FROM information_schema.views
WHERE table_schema = 'public';

CREATE VIEW failed_students AS
SELECT student_name, class, subject 
FROM student s 
INNER JOIN student_grade sg
ON s.student_id = sg.fk_student_id
WHERE grade = 'F';
CREATE VIEW

SELECT * FROM failed_students;
 student_name | class | subject
--------------+-------+---------
 Ashwin       | X     | Physics
(1 row)

CREATE TABLE sample_table(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
CREATE TABLE

DO $$
BEGIN
    FOR i IN 1..10000 LOOP
        INSERT INTO sample_table(name, age) VALUES('Name-'||i, i);
    END LOOP;
END $$;
DO

SELECT COUNT(*) FROM sample_table;
 count
-------
 10000
(1 row)

SELECT * FROM sample_table WHERE age = 40;
 id |  name   | age
----+---------+-----
 40 | Name-40 |  40
(1 row)


sample=# CREATE INDEX sample_table_age_idx ON sample_table(age);
CREATE INDEX
Time: 19.713 ms

sample=# SELECT * FROM sample_table WHERE age = 40;
 id |  name   | age
----+---------+-----
 40 | Name-40 |  40
(1 row)


sample=# SELECT name FROM sample_table WHERE name = 'Name-40';
  name
---------
 Name-40
(1 row)


sample=# \timing
Timing is on.
sample=# SELECT name FROM sample_table WHERE name = 'Name-40';
  name
---------
 Name-40
(1 row)
Time: 2.294 ms

CREATE INDEX sample_table_name_idx ON sample_table(name);
CREATE INDEX
Time: 104.236 ms

sample=# SELECT name FROM sample_table WHERE name = 'Name-40';
  name
---------
 Name-40
(1 row)
Time: 0.833 ms

SELECT indexname AS index_name, 
indexdef AS index_definition
FROM pg_indexes
WHERE schemaname = 'public';
  index_name       |                                index_definition
-----------------------+---------------------------------------------------------------------------------
 student_pkey          | CREATE UNIQUE INDEX student_pkey ON public.student USING btree (student_id)
 student_grade_pkey    | CREATE UNIQUE INDEX student_grade_pkey ON public.student_grade USING btree (id)
 sample_table_pkey     | CREATE UNIQUE INDEX sample_table_pkey ON public.sample_table USING btree (id)
 sample_table_age_idx  | CREATE INDEX sample_table_age_idx ON public.sample_table USING btree (age)
 sample_table_name_idx | CREATE INDEX sample_table_name_idx ON public.sample_table USING btree (name)
(5 rows)

CREATE [OR REPLACE] PROCEDURE procedure_name
(argument_mode(IN\OUT) parameters data type, ..)
LANGUAGE 'plpgsql'
AS 
$$
BEGIN
    -- sql statements
END;
$$;


CALL procedure_name(parameter_value);

CREATE OR REPLACE PROCEDURE insert_student
(
    IN p_student_name VARCHAR(50), 
    IN p_class VARCHAR(50),
    IN p_section VARCHAR(50)
)
LANGUAGE 'plpgsql'
AS 
$$
BEGIN
    INSERT INTO student(student_name, class, section) 
    VALUES(p_student_name, p_class, p_section);
END;
$$;
CREATE PROCEDURE


CALL insert_student('Rifna','X','D');
CALL
Time: 7.642 ms

SELECT proname 
FROM  pg_proc
WHERE pronamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public'); 
    proname
----------------
 insert_student
(1 row)


Time: 4.771 ms


