-- the task is to find data for a customer named croma 
-- for fiscal year 2021.
-- by finding a table that contains
-- Month
-- Product Name
-- Variant
-- Sold Quantity
-- Gross Price per items
-- Gross Price Total

-- find customer named croma, to get customer_code
SELECT * FROM gdb0041.dim_customer
where customer = "croma"

-- copy customer_code
-- 90002002

-- find sold_quantity from customer_code no 90002002
SELECT * FROM gdb0041.fact_sales_monthly
	where customer_code = 90002002 
    
-- we want tabel for fiscal year 2021
SELECT * FROM gdb0041.fact_sales_monthly
	where customer_code = 90002002 and 
    year (date) = 2021
    order by date DESC

-- altiq use fiscal year from september
-- it mean the date start from september 2021 until august 2022 
-- the table show sold_quantity and month, which is the answer to the question above
SELECT * FROM gdb0041.fact_sales_monthly
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC

-- now we will find Product name and Variant
-- here we will use tabel dim_product
-- we are going to JOINT between 
-- fact_sales_monthly table with dim_product which only consist of
-- costomer_code number 90002002 (croma)

SELECT * 
FROM gdb0041.fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC
    
-- because the number of columns generated is too many, 
-- we sort the columns we want only
-- we want to display only the table 
-- date, product_code, product, variant, sold_quantity
-- we will replace the * sign with the desired column name 

SELECT s.date, s.product_code, p.product, p.variant,s.sold_quantity
FROM gdb0041.fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC

-- now all that remains is to find
-- Gross Price per items
-- Gross Price Total

-- let's analyse the table 
SELECT * FROM gdb0041.fact_gross_price;

-- the problem is fact_gross_price table using the fiscal_year
-- fact_sales_monthly using general date
-- we will joint fact_sales_monthly (s) table with fact_gross_price
-- with fiscal year
-- we will add 

SELECT s.date, s.product_code, p.product, p.variant,s.sold_quantity,
g.gross_price
FROM gdb0041.fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
join fact_gross_price g 
on g.product_code=s.product_code and
g.fiscal_year=2021
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC

-- the last one is to find Gross Price Total
-- is the multiplication of sold quantity with gross price column


SELECT s.date, s.product_code, p.product, p.variant,s.sold_quantity,
g.gross_price, g.gross_price*s.sold_quantity as gpt
FROM gdb0041.fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
join fact_gross_price g 
on g.product_code=s.product_code and
g.fiscal_year=2021
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC
    
    
