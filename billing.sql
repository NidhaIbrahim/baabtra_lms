postgres=# CREATE DATABASE billing;
CREATE DATABASE

postgres=# \c billing
You are now connected to database "billing" as user "postgres".

billing=# CREATE TABLE employees(
billing(#     pk_emp_id SERIAL PRIMARY KEY,
billing(#     emp_type VARCHAR(100),
billing(#     first_name VARCHAR(200),
billing(#     last_name VARCHAR(200),
billing(#     email VARCHAR(200),
billing(#     phone VARCHAR(100),
billing(#     gender VARCHAR(20),
billing(#     dob DATE
billing(# );
CREATE TABLE

billing=# CREATE TABLE category(
billing(#     pk_category_id SERIAL PRIMARY KEY,
billing(#     category_name VARCHAR(200),
billing(#     description VARCHAR(400)
billing(# );
CREATE TABLE

billing=# CREATE TABLE products(
billing(#     pk_product_id SERIAL PRIMARY KEY,
billing(#     product_name VARCHAR(200),
billing(#     fk_category_id INT,
billing(#     description VARCHAR(400),
billing(#     price FLOAT,
billing(#     added_date DATE,
billing(#     FOREIGN KEY(fk_category_id) REFERENCES category(pk_category_id)
billing(#     ON DELETE CASCADE ON UPDATE CASCADE
billing(# );
CREATE TABLE

billing=# CREATE TABLE bills(
billing(#     pk_bill_id SERIAL PRIMARY KEY,
billing(#     customer_name VARCHAR(100),
billing(#     customer_phone VARCHAR(50),
billing(#     bill_date DATE
billing(# );
CREATE TABLE

billing=# ALTER TABLE products
billing-# ADD COLUMN product_brand VARCHAR(200);
ALTER TABLE

billing=#  ALTER TABLE products
billing-# DROP COLUMN price;
ALTER TABLE

billing=#  ALTER TABLE products
billing-# ADD COLUMN price INT;
ALTER TABLE

billing=# ALTER TABLE products
billing-# ALTER COLUMN price TYPE FLOAT;
ALTER TABLE

billing=# ALTER TABLE products
billing-# RENAME COLUMN price TO cost;
ALTER TABLE

billing=# ALTER TABLE products
billing-# RENAME TO items;
ALTER TABLE

billing=#  ALTER TABLE items
billing-# RENAME TO products;
ALTER TABLE

billing=# ALTER TABLE employees
billing-# ADD COLUMN salary FLOAT;
ALTER TABLE

billing-# \d employees
                                         Table "public.employees"
   Column   |          Type          | Collation | Nullable |                   Default
------------+------------------------+-----------+----------+----------------------------------------------
 pk_emp_id  | integer                |           | not null | nextval('employees_pk_emp_id_seq'::regclass)
 emp_type   | character varying(100) |           |          |
 first_name | character varying(200) |           |          |
 last_name  | character varying(200) |           |          |
 email      | character varying(200) |           |          |
 phone      | character varying(100) |           |          |
 gender     | character varying(20)  |           |          |
 dob        | date                   |           |          |
 salary     | double precision       |           |          |
Indexes:
    "employees_pkey" PRIMARY KEY, btree (pk_emp_id)


billing-# \d products
                                             Table "public.products"
     Column     |          Type          | Collation | Nullable |                     Default
----------------+------------------------+-----------+----------+-------------------------------------------------
 pk_product_id  | integer                |           | not null | nextval('products_pk_product_id_seq'::regclass)
 product_name   | character varying(200) |           |          |
 fk_category_id | integer                |           |          |
 description    | character varying(400) |           |          |
 added_date     | date                   |           |          |
 product_brand  | character varying(200) |           |          |
 cost           | double precision       |           |          |
Indexes:
    "products_pkey" PRIMARY KEY, btree (pk_product_id)
Foreign-key constraints:
    "products_fk_category_id_fkey" FOREIGN KEY (fk_category_id) REFERENCES category(pk_category_id) ON UPDATE CASCADE ON DELETE CASCADE


billing-# \d category
                                              Table "public.category"
     Column     |          Type          | Collation | Nullable |                     Default
----------------+------------------------+-----------+----------+--------------------------------------------------
 pk_category_id | integer                |           | not null | nextval('category_pk_category_id_seq'::regclass)
 category_name  | character varying(200) |           |          |
 description    | character varying(400) |           |          |
Indexes:
    "category_pkey" PRIMARY KEY, btree (pk_category_id)
Referenced by:
    TABLE "products" CONSTRAINT "products_fk_category_id_fkey" FOREIGN KEY (fk_category_id) REFERENCES category(pk_category_id) ON UPDATE CASCADE ON DELETE CASCADE


billing-# \d bills
                                            Table "public.bills"
     Column     |          Type          | Collation | Nullable |                  Default
----------------+------------------------+-----------+----------+-------------------------------------------
 pk_bill_id     | integer                |           | not null | nextval('bills_pk_bill_id_seq'::regclass)
 customer_name  | character varying(100) |           |          |
 customer_phone | character varying(50)  |           |          |
 bill_date      | date                   |           |          |
Indexes:
    "bills_pkey" PRIMARY KEY, btree (pk_bill_id)


billing=# INSERT INTO employees VALUES(
billing(#     1,
billing(#     'staff',
billing(#     'Arun',
billing(#     'Mathew',
billing(#     'arun@gmail.com',
billing(#     '9098344578',
billing(#     'Male',
billing(#     '2000-06-12'
billing(# );
INSERT 0 1

billing=# INSERT INTO employees VALUES
billing-# (2, 'staff', 'Drishya', 'K', 'drishyak@gmail.com', '9091245578', 'Female', '2000-07-21'),
billing-# (3, 'staff', 'Sheethal', 'Dev', 'sheethaldev@gmail.com', '9123444578', 'Female', '2001-12-30'),
billing-# (4, 'staff', 'Aman', 'P', 'aman@gmail.com', '9056788578', 'Male', '2003-10-11'),
billing-# (5, 'staff', 'Fathima', 'Fidha', 'fidha@gmail.com', '9009876578', 'Female', '2002-07-16')
billing-# ;
INSERT 0 4

billing=# INSERT INTO category VALUES
billing-# (1, 'Grocery', 'food and grains, daily needs, spices, forozen items, packet foods'),
billing-# (2, 'Stationery', 'Includes books, pens, school items, sheets');
INSERT 0 2

billing-# INSERT INTO products VALUES
billing-# (1, 'Notebook', 2,'200 pages, 40x40 cm, lined notebook','2020-06-09','Classmate',45),
billing-# (2, 'eyeliner', 3,'Black color, water proof','2020-06-09','Maybelline',380);
ERROR:  insert or update on table "products" violates foreign key constraint "products_fk_category_id_fkey"
DETAIL:  Key (fk_category_id)=(3) is not present in table "category".

billing=# INSERT INTO category VALUES
billing-# (2, 'Fancy', 'Beauty and personal care');
ERROR:  duplicate key value violates unique constraint "category_pkey"
DETAIL:  Key (pk_category_id)=(2) already exists.

billing=# INSERT INTO category VALUES
billing-# (3, 'Fancy', 'Beauty and personal care');
INSERT 0 1

billing=# INSERT INTO products VALUES
billing-# (1, 'Notebook', 2,'200 pages, 40x40 cm, lined notebook','2020-06-09','Classmate',45),
billing-# (2, 'eyeliner', 3,'Black color, water proof','2020-06-09','Maybelline',380);
INSERT 0 2

billing=# INSERT INTO category VALUES
billing-# (4, 'Electronics', 'Gadgets, house needs');
INSERT 0 1

billing=# SELECT * from employees;
 pk_emp_id | emp_type | first_name | last_name |         email         |   phone    | gender |    dob     | salary
-----------+----------+------------+-----------+-----------------------+------------+--------+------------+--------
         1 | staff    | Arun       | Mathew    | arun@gmail.com        | 9098344578 | Male   | 2000-06-12 |
         2 | staff    | Drishya    | K         | drishyak@gmail.com    | 9091245578 | Female | 2000-07-21 |
         3 | staff    | Sheethal   | Dev       | sheethaldev@gmail.com | 9123444578 | Female | 2001-12-30 |
         4 | staff    | Aman       | P         | aman@gmail.com        | 9056788578 | Male   | 2003-10-11 |
         5 | staff    | Fathima    | Fidha     | fidha@gmail.com       | 9009876578 | Female | 2002-07-16 |
(5 rows)


billing=# SELECT * from products;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost
---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45
             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380
(2 rows)


billing=# SELECT * from category;
 pk_category_id | category_name |                            description
----------------+---------------+-------------------------------------------------------------------
              1 | Grocery       | food and grains, daily needs, spices, forozen items, packet foods
              2 | Stationery    | Includes books, pens, school items, sheets
              3 | Fancy         | Beauty and personal care
              4 | Electronics   | Gadgets, house needs
(4 rows)


billing=# SELECT * FROM employees WHERE gender = 'Female';
 pk_emp_id | emp_type | first_name | last_name |         email         |   phone    | gender |    dob     | salary
-----------+----------+------------+-----------+-----------------------+------------+--------+------------+--------
         2 | staff    | Drishya    | K         | drishyak@gmail.com    | 9091245578 | Female | 2000-07-21 |
         3 | staff    | Sheethal   | Dev       | sheethaldev@gmail.com | 9123444578 | Female | 2001-12-30 |
         5 | staff    | Fathima    | Fidha     | fidha@gmail.com       | 9009876578 | Female | 2002-07-16 |
(3 rows)


billing=# SELECT product_name, cost FROM products;
 product_name | cost
--------------+------
 Notebook     |   45
 eyeliner     |  380
(2 rows)


billing=# SELECT * FROM products WHERE added_date = '2020-06-09';
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost
---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45
             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380
(2 rows)

billing=# SELECT * FROM products WHERE cost < 1000;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost
---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45
             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380
(2 rows)

billing=# SELECT product_name, fk_category_id FROM products WHERE cost BETWEEN 50 AND 300;
 product_name | fk_category_id
--------------+----------------
(0 rows)


billing=# SELECT product_name, fk_category_id FROM products WHERE cost BETWEEN 40 AND 300;
 product_name | fk_category_id
--------------+----------------
 Notebook     |              2
(1 row)


billing=# SELECT * FROM products LIMIT 5;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost
---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45
             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380
(2 rows)


billing=# SELECT * FROM products LIMIT 1;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost
---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45
(1 row)


billing=# SELECT * FROM category WHERE description LIKE '%books%';
 pk_category_id | category_name |                description
----------------+---------------+--------------------------------------------
              2 | Stationery    | Includes books, pens, school items, sheets
(1 row)


billing=# SELECT * FROM products WHERE product_name LIKE '_y%';
 pk_product_id | product_name | fk_category_id |       description        | added_date | product_brand | cost
---------------+--------------+----------------+--------------------------+------------+---------------+------
             2 | eyeliner     |              3 | Black color, water proof | 2020-06-09 | Maybelline    |  380
(1 row)

billing=# UPDATE employees SET phone = '9876543210', email = 'drishyak@gmail.com' WHERE first_name = 'Drishya' AND last_name = 'K';
UPDATE 1

billing=# DELETE FROM employees WHERE first_name = 'Drishya' AND phone = '9876543210';
DELETE 1

billing=# SELECT * FROM employees;
 pk_emp_id | emp_type | first_name | last_name |         email         |   phone    | gender |    dob     | salary
-----------+----------+------------+-----------+-----------------------+------------+--------+------------+--------
         1 | staff    | Arun       | Mathew    | arun@gmail.com        | 9098344578 | Male   | 2000-06-12 |
         3 | staff    | Sheethal   | Dev       | sheethaldev@gmail.com | 9123444578 | Female | 2001-12-30 |
         4 | staff    | Aman       | P         | aman@gmail.com        | 9056788578 | Male   | 2003-10-11 |
         5 | staff    | Fathima    | Fidha     | fidha@gmail.com       | 9009876578 | Female | 2002-07-16 |
(4 rows)


-- GROUP BY used with aggrigate functions

postgres=# \c billing
You are now connected to database "billing" as user "postgres".
billing=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | bills     | table | postgres
 public | category  | table | postgres
 public | employees | table | postgres
 public | products  | table | postgres
(4 rows)


billing=# SELECT added_date, COUNT(*) AS number_of_products_added FROM products GROUP BY added_date;
 added_date | number_of_products_added
------------+--------------------------
 2020-06-09 |                        2
(1 row)


billing=# SELECT * FROM products;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost

---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380(2 rows)



billing=# INSERT INTO bills VALUES
billing-# (1,'Athira','9896546732','2020-10-01'),
billing-# (2,'Krishna','7898678945','2020-10-02'),
billing-# (3,'Vishnu','9456738218','2020-11-22'),
billing-# (4,'Amir','9946321456','2020-11-22');
INSERT 0 4

billing=# CREATE TABLE bill_items (
billing(#  pk_item_id SERIAL PRIMARY KEY,
billing(#  fk_product_id INT,
billing(#  item_price FLOAT,
billing(#  item_quantity INT,
billing(#  fk_bill_id INT,
billing(#  FOREIGN KEY(fk_product_id) REFERENCES products(pk_product_id)
billing(#  ON DELETE CASCADE ON UPDATE CASCADE ,
billing(#  FOREIGN KEY(fk_bill_id) REFERENCES bills(pk_bill_id)
billing(#  ON DELETE CASCADE ON UPDATE CASCADE 
billing(#  );
CREATE TABLE

billing=# INSERT INTO bill_items VALUES
billing-# (1,1,45,2,1),
billing-# (2,3,30,3,1),
billing-# (3,4,10,1,1),
billing-# (4,4,10,4,2),
billing-# (5,2,380,2,3);
INSERT 0 5

SELECT pk_bill_id, bill_date, customer_name, 
SUM(item_price * item_quantity) AS total_bill 
FROM bill_items INNER JOIN bills
ON bills.pk_bill_id = bill_items.fk_bill_id
GROUP BY pk_bill_id;

 pk_bill_id | bill_date  | customer_name | total_bill
------------+------------+---------------+------------
          3 | 2020-11-22 | Vishnu        |        760
          2 | 2020-10-02 | Krishna       |         40
          1 | 2020-10-01 | Athira        |        190
(3 rows)

billing=# SELECT pk_bill_id, bill_date, customer_name,
billing-# SUM(item_price * item_quantity) AS total_bill
billing-# FROM bill_items INNER JOIN bills
billing-# ON bills.pk_bill_id = bill_items.fk_bill_id
billing-# GROUP BY pk_bill_id;
 pk_bill_id | bill_date  | customer_name | total_bill
------------+------------+---------------+------------
          3 | 2020-11-22 | Vishnu        |        760
          2 | 2020-10-02 | Krishna       |         40
          1 | 2020-10-01 | Athira        |        190
(3 rows)


billing=# SELECT pk_bill_id, bill_date, customer_name,
billing-# SUM(item_price * item_quantity) AS total_bill
billing-# FROM bill_items INNER JOIN bills
billing-# ON bills.pk_bill_id = bill_items.fk_bill_id
billing-# GROUP BY pk_bill_id
billing-# ORDER BY pk_bill_id;

 pk_bill_id | bill_date  | customer_name | total_bill
------------+------------+---------------+------------
          1 | 2020-10-01 | Athira        |        190
          2 | 2020-10-02 | Krishna       |         40
          3 | 2020-11-22 | Vishnu        |        760
(3 rows)


SELECT pk_bill_id, bill_date, customer_name,
SUM(item_price * item_quantity) AS total_bill
FROM bill_items INNER JOIN bills
ON bills.pk_bill_id = bill_items.fk_bill_id
GROUP BY pk_bill_id
ORDER BY pk_bill_id ASC;

 pk_bill_id | bill_date  | customer_name | total_bill
------------+------------+---------------+------------
          1 | 2020-10-01 | Athira        |        190
          2 | 2020-10-02 | Krishna       |         40
          3 | 2020-11-22 | Vishnu        |        760
(3 rows)


SELECT pk_bill_id, bill_date, customer_name,
SUM(item_price * item_quantity) AS total_bill
FROM bill_items INNER JOIN bills
ON bills.pk_bill_id = bill_items.fk_bill_id
GROUP BY pk_bill_id
ORDER BY pk_bill_id DESC;

 pk_bill_id | bill_date  | customer_name | total_bill
------------+------------+---------------+------------
          3 | 2020-11-22 | Vishnu        |        760
          2 | 2020-10-02 | Krishna       |         40
          1 | 2020-10-01 | Athira        |        190
(3 rows)

CREATE TABLE stock (
    pk_stock_id SERIAL PRIMARY KEY,
    fk_product_id INT,
    stock_quantity INT,
    FOREIGN KEY(fk_product_id) REFERENCES products(pk_product_id)
    ON UPDATE CASCADE ON DELETE CASCADE 
);
CREATE TABLE

INSERT INTO stock VALUES
(1,1,300),
(2,2,50),
(3,3,200);
INSERT 0 3

billing=# SELECT product_name, stock_quantity
billing-# FROM products LEFT JOIN stock
billing-# ON products.pk_product_id = stock.fk_product_id;

 product_name | stock_quantity
--------------+----------------
 Notebook     |            300
 eyeliner     |             50
 Pencil       |            200
 Pen          |
 Mouse        |
 Ring         |
(6 rows)


billing=# SELECT product_name, category_name FROM
billing-# products RIGHT JOIN category
billing-# ON products.fk_category_id = category.pk_category_id;
 product_name | category_name
--------------+---------------
 Notebook     | Stationery
 eyeliner     | Fancy
 Pencil       | Stationery
 Ring         | Fancy
 Pen          | Stationery
 Mouse        | Electronics
              | Grocery
(7 rows)

SELECT * FROM products WHERE fk_category_id IN 
(SELECT pk_category_id FROM category WHERE category_name = 'Stationery');
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost
---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45
             3 | Pencil       |              2 | used to write                       | 2023-08-23 | apsara        |    8
             5 | Pen          |              2 | for super smooth and neat writing   | 2021-09-30 | Pin Point     |   10
(3 rows)



