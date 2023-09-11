billing=# SELECT AVG(cost) FROM products;
  avg
-------
 212.5
(1 row)


billing=# SELECT * FROM products;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost

---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380(2 rows)


billing=# SELECT SUM(cost) FROM products;
 sum
-----
 425
(1 row)

billing=# SELECT MAX(cost) AS most_expensive_product_cost FROM products;
 most_expensive_product_cost
-----------------------------
                         380
(1 row)

billing=# SELECT MIN(cost) AS cheapest_product_cost FROM products;
 cheapest_product_cost
-----------------------
                    45
(1 row)

billing=# SELECT COUNT(pk_product_id) AS total_products FROM products;
 total_products
----------------
              2
(1 row)

billing=# SELECT COUNT(*) AS total_products FROM products;
 total_products
----------------
              2
(1 row)

SELECT date_part('year',added_date) FROM products;


-- where cannot be used with aggregate functions so HAVING

billing=# SELECT added_date, COUNT(*) AS number_of_products_added FROM products GROUP BY added_date HAVING added_date < '2020-06-10';
 added_date | number_of_products_added
------------+--------------------------
 2020-06-09 |                        2
(1 row)


billing=# SELECT dob, COUNT(*) AS number_of_employees FROM employees GROUP BY dob;
    dob     | number_of_employees
------------+---------------------
 2003-10-11 |                   1
 2000-06-12 |                   1
 2002-07-16 |                   1
 2001-12-30 |                   1
(4 rows)

billing=# SELECT dob, COUNT(*) AS number_of_employees FROM employees GROUP BY dob HAVING dob < '2001-12-20';
    dob     | number_of_employees
------------+---------------------
 2000-06-12 |                   1
(1 row)



billing=#  SELECT * FROM products;
 pk_product_id | product_name | fk_category_id |             description             | added_date | product_brand | cost

---------------+--------------+----------------+-------------------------------------+------------+---------------+------
             1 | Notebook     |              2 | 200 pages, 40x40 cm, lined notebook | 2020-06-09 | Classmate     |   45       
             2 | eyeliner     |              3 | Black color, water proof            | 2020-06-09 | Maybelline    |  380
             
            (2 rows)


billing=#  SELECT * FROM category;
 pk_category_id | category_name |                            description
----------------+---------------+-------------------------------------------------------------------
              1 | Grocery       | food and grains, daily needs, spices, forozen items, packet foods
              2 | Stationery    | Includes books, pens, school items, sheets
              3 | Fancy         | Beauty and personal care
              4 | Electronics   | Gadgets, house needs
(4 rows)


billing=# \d products
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


billing=# INSERT INTO products VALUES
billing-# (3,'Pencil',2,'used to write','2023-08-23','apsara',8),
billing-# (4,'Ring',3,'worn on finger for beauty','2022-05-12','Malabar Golds',20000),
billing-# (5,'Pen',2,'for super smooth and neat writing','2021-09-30','Pin Point',10),
billing-# (6,'Mouse',4,'for relaxed hand and better glide','2019-07-15','Lenovo',1000);
INSERT 0 4

-- DISTINCT keyword

billing=# SELECT fk_category_id FROM products;
 fk_category_id
----------------
              2
              3
              2
              3
              2
              4
(6 rows)


billing=# SELECT DISTINCT fk_category_id FROM products;
 fk_category_id
----------------
              4
              3
              2
(3 rows)

