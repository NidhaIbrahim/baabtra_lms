postgres=# CREATE DATABASE work;
CREATE DATABASE

postgres=# \c work
You are now connected to database "work" as user "postgres".

work=# CREATE TABLE staff(
work(#     employee_id INT PRIMARY KEY,
work(#     name VARCHAR(50),
work(#     age INT,
work(#     department VARCHAR(50)
work(# );
CREATE TABLE

work=# INSERT INTO staff (employee_id, name, age, department)
work-# VALUES
work-#     (1, 'John Doe', 30, 'Sales'),
work-#     (2, 'Jane Smith', 35, 'Marketing'),
work-#     (3, 'Bob Brown', 28, 'Sales'),
work-#     (4, 'Lisa Wang', 32, 'Sales'),
work-#     (5, 'Mike Adams', 40, 'Finance');
INSERT 0 5

work=# SELECT * FROM staff WHERE department = 'Sales';
 employee_id |   name    | age | department
-------------+-----------+-----+------------
           1 | John Doe  |  30 | Sales
           3 | Bob Brown |  28 | Sales
           4 | Lisa Wang |  32 | Sales
(3 rows)

work=# SELECT name, age FROM staff WHERE age < 30;
   name    | age
-----------+-----
 Bob Brown |  28
(1 row)

work=# SELECT name, department FROM staff WHERE name LIKE 'j%';
 name | department
------+------------
(0 rows)


work=# SELECT name, department FROM staff WHERE name LIKE 'J%';
    name    | department
------------+------------
 John Doe   | Sales
 Jane Smith | Marketing
(2 rows)

work=# SELECT name, age FROM staff WHERE age BETWEEN 30 AND 40;
    name    | age
------------+-----
 John Doe   |  30
 Jane Smith |  35
 Lisa Wang  |  32
 Mike Adams |  40
(4 rows)

work=# SELECT name, department FROM staff WHERE department != 'sales' || department != 'marketing';
ERROR:  syntax error at or near "!="
LINE 1: ...M staff WHERE department != 'sales' || department != 'market...'

work=# SELECT name, department FROM staff WHERE department = 'Finance';
    name    | department
------------+------------
 Mike Adams | Finance
(1 row)