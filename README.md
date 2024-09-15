# Generate a report of individual product sales for Croma India customer for FY=2021

### Project Overview

This data analysis project aims to provide insights into generate a report of individual product sales for Croma India customer for FY=2021

The report should have the following fields
1. Month
2. Product Name
3. Variant
4. Sold Quantity
5. Gross Price Per Item
6. Gross Price Total

### Data Sources
data source is forbidden to display

### Tools

- Excel - Data Cleaning
- MSQL - Data Analysis
- MYSQL Workbench

### Results/Findings

The analysis result are summarized as follows :

1. Month and 2 Product name
```sql
SELECT * FROM gdb0041.fact_sales_monthly
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC
```
the result

![image](https://github.com/user-attachments/assets/83d39549-d481-48f6-9caf-b4963a53e32f)

3. Variant and 4. Sold Quantity
   
```sql
SELECT s.date, s.product_code, p.product, p.variant,s.sold_quantity
FROM gdb0041.fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
	where customer_code = 90002002 and 
    year (date_add(date, interval 4 month)) = 2021
    order by date DESC
```
the result 

![image](https://github.com/user-attachments/assets/24390a13-cfc8-4e1a-ad1b-f5ef7aa9c1d3)

5. Gross Price Per Item 

```sql
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
```
the result

![image](https://github.com/user-attachments/assets/35edc264-76f2-4831-8c9d-ad39fe685ec4)

and 6. Gross Price Total

```sql
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
```

the final result

![image](https://github.com/user-attachments/assets/d1b4d7fa-c8a8-469d-93f8-7358e6a66ade)


