create database dataset;
select * FROM clean_data;

update clean_data
set order_date = concat(substring(order_date, 7, 4 ),'-', substring(order_date, 4, 2 ),'-', substring(order_date, 1, 2 ))
where order_date like '__-__-____';

select * FROM clean_data;

#--finding duplicates
select order_id, count(*) from clean_data 
group by order_id having count(*)>1;

#--order numbers and total sales from 2009 to 2012 which order status is finished
## to extract the year we create a new column Years:

alter table clean_data
add column Years numeric;

update clean_data
set Years = extract(YEAR FROM order_date);

select * FROM clean_data;

select Years,
sum(sales),
count(order_status)
from clean_data
where order_status = 'Order Finished'
group by Years
order by Years;


#---Total sales for each sub-category of product on 2011 and 2012
select * from clean_data;

select Years,
product_sub_category,
sum(sales) as total_sales
 from clean_data 
 where Years in (2011,2012)
 group by product_sub_category,
 Years ;
 
 #---•	number of customers each year 
 
 select Years,
 count(distinct customer) as number_of_customers
 from clean_data
 group by Years
 order by Years desc;

#-- top 10 customers
select customer, count(*) as no_of_occurance from clean_data 
group by customer having count(*)> 20 limit 10;

select * from clean_data;

select count( order_id) from clean_data;

select Years,
sum(sales) as total_sales_revenue from clean_data
group by Years;

select count(distinct customer)
from clean_data;

select * from clean_data;
select order_status,
count(*) as counts
from clean_data
group by order_status
order by counts desc
limit 1;

select order_status,
count(*) as counts
from clean_data
where order_status = 'Order Cancelled';

select product_category,
sum(sales) as total_revenue
from clean_data
group by product_category
order by total_revenue desc;

select distinct product_sub_category from clean_data;

select product_sub_category,
sum(sales) as total_sales
from clean_data
group by product_sub_category
order by total_sales desc
limit 5;

#--    Calculate the average order quantity for each product sub-category:
select product_sub_category,
avg(order_quantity) as avg_product_sub_category
from clean_data
group by product_sub_category;

#--    Retrieve the number of orders placed by each customer:
select * from clean_data;

select customer,
count(order_id) as number_orders
from clean_data
group by customer
order by number_orders desc;

#---Find the total discount amount given for each product category:
select product_category,
sum(discount_value) as  total_discount_amount
from clean_data
group by product_category
order by total_discount_amount desc;

#---Calculate the total sales revenue for each month in the dataset:
alter table clean_data
add column Months text;

update clean_data
set Months = null;

update clean_data
set Months = monthname(order_date) ;

alter table clean_data
add column mm_yyyy text;

update clean_data
set mm_yyyy = concat(Months, '-', Years);

select * from clean_data;

#---Calculate the total sales revenue for each month in the dataset:
select 
mm_yyyy,
sum(sales)
from clean_data
group by mm_yyyy
order by mm_yyyy;

#---Identify the top 10 customers who spent the most in total:
select customer,
sum(sales) as total_spent
from clean_data
group by customer 
order by total_spent desc
limit 10;

#---Determine the average discount percentage for each product category:

select product_category,
avg(discount * 100) as discount_percentage
from clean_data
group by product_category;

#--Retrieve the orders placed in a specific year (e.g., 2012):
select *
from clean_data
where Years = 2012;

#---Find the average order quantity for each month:
select year(order_date) as Years,
monthname(order_date) as months,
avg(order_quantity) as average
from clean_data
group by year(order_date), monthname(order_date);

#--Determine the percentage of orders with a discount applied:
select count(case when discount >0 then order_id end)* 100 / count(order_id) as percentage_orders
from clean_data;

#--Calculate the total discount value for each product sub-category:
select product_sub_category,
sum(discount_value) as total_discount_value
from clean_data
group by product_sub_category;

#--Find the number of orders placed on weekends (Saturday and Sunday):
select count(order_id)
from clean_data
where dayofweek(order_date) in (1,7);

#-- Identify the top 5 best-selling products based on sales revenue:
select * from clean_data;
select product_category
product_sub_category,
sum(sales) as total_revenue
from clean_data
group by product_category, product_sub_category
order by total_revenue desc
limit 5;

#---Determine the average discount value for each year:
select Years, 
avg(discount_value) as average
from clean_data
group by Years 
order by Years;

#--- Calculate the total sales revenue for each product category, excluding orders with order status - "Order Returned":
select product_category,
sum(sales) as revenue
from clean_data
where order_status != 'Order Returned'
group by product_category; 

#--- Find the month with the highest total sales revenue:
select mm_yyyy,
sum(sales)as Highest_total_sales
from clean_data
group by mm_yyyy
order by Highest_total_sales desc
limit 1;

#----Identify the top 10 customers who placed the most orders:
select customer, 
count(order_id) as order_count
from clean_data
group by customer
order by order_count desc
limit 10;

#--- Determine the total discount value given for orders placed on weekdays:
select sum(discount_value) as total_discount_value
from clean_data
where dayofweek(order_id) between 2 and 6;