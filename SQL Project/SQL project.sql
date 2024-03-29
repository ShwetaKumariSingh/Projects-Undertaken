CREATE DATABASE AbleJobs;

create table Sales1(salesman_id  int not null unique, name varchar (20) not null,
city varchar (50) not null, commission decimal(5,2) not null);

insert into sales1(salesman_id, name, city, commission)
values(5001,'James Hong', 'New York','0.15'),
(5002,'Nail Knite', 'Paris','0.13'),
(5005,'Pit Alex', 'London', '0.11'),
(5006,'Mc Lyon', 'Paris','0.14'),
(5007,'Paul Adam','Rome', '0.13'),
(5003,'Lauson Hen','San Jose','0.12');
Select * from sales1;

create table sales2(customer_id int not null unique, Cust_name varchar(20) not null, City varchar(30) not null, Grade int not null, 
salesman_id int not null);



insert into sales2(customer_id, Cust_name, City, Grade, salesman_id)
values(3002,'Nick Rimando', 'New York','100',5001),
(3007,'Brad Davis', 'New York',200,5001),
(3005,'Graham Zusi', 'California', 200, 5002),
(3008,'Julian Green', 'London',300,5002),
(3004,'Fabian Johnson','Paris',300,5006),
(3009,'Geoff Cameron','Berlin',100,5003),
(3003,'Jozy Altidor','Moscow',200,5007);

Select * from sales2;

update sales1 
set commission = 0.22 where name = 'Pit Alex';

update sales1 
set city = 'Paris' where salesman_id = 5003;


update sales2
set grade = 300 where cust_name = 'Grahan Zusi';

update sales2
set city = 'London' where customer_id = 3009;

select * from sales2;

select salesman_id,
name,
city,
commission
from sales1
where city like 'Paris%'or city like 'Rome%';

select salesman_id,
name,
city,
commission
from sales1
where city not in('Paris', 'Rome');


select salesman_id,
name,
city,
commission
from sales1
where commission between 0.12 and 0.14;

select salesman_id,
name,
city,
commission
from sales1
where name between 'B' and 'K';

select customer_id,
 cust_name, city,
 grade,
 salesman_id
from sales2
where cust_name like 'B%';

select customer_id,
 cust_name, city,
 grade,
 salesman_id
from sales2
where cust_name like '%n';

select salesman_id,
name,
city,
commission
from sales1
where name like 'N_i%';

select* from sales1;

select* from nobel;


select YEAR,
SUBJECT, WINNER
from nobel
where 
YEAR in (1970, 1987) ;


SELECT WINNER FROM nobel WHERE 
YEAR = 1971 AND SUBJECT= 'Literature';

SELECT YEAR, SUBJECT FROM nobel WHERE WINNER = 'Dennis Gabor';
select winner from nobel where subject = 'Physics' and year>=1950;

select 
YEAR, 
SUBJECT, 
WINNER,
COUNTRY
FROM nobel WHERE SUBJECT = 'Chemistry'
and YEAR BETWEEN 1965 AND 1975;

SELECT
    *
FROM
   nobel
WHERE
    winner IN ('Menachem Begin', 'Yitzhak Rabin')
    AND year >= 1972;
    
 SELECT * FROM nobel WHERE WINNER LIKE 'Louis%';   
  SELECT * FROM nobel WHERE WINNER = 'Johannes Georg Bednorz';
  
 select * from orders;
 
 select sum(Purch_Amnt) from orders;
  select avg(Purch_Amnt)from orders;
  select count(DISTINCT salesman_id) AS Total_Salesperson from orders;
  select count(DISTINCT customer_id) AS Total_customer from orders;
  
  SELECT * FROM nobel WHERE SUBJECT = 'Physics' and YEAR = 1970 
  union all
SELECT * FROM nobel WHERE SUBJECT = 'Economics' and YEAR = 1971;

select sales1.name as salesman,
sales2.Cust_name as customer,
sales1.city from sales1
join sales2 on sales1.city=sales2.City;

select sales1.name as Salesperson,
sales2.Cust_name as customer,
sales1.city, sales1.commission 
from sales1 join sales2  on sales1.salesman_id=sales2.salesman_id ;

select name as salesperson from sales1 where commission>0.12;

SELECT
    sales2.Cust_name AS Customer_Name,
    sales2.city AS Customer_City,
    sales1.name AS Salesman,
    sales1.city AS Salesman_City,
    sales1.commission
FROM
    sales2
JOIN
   sales1 ON sales2.city <> sales1.city AND sales1.commission > 0.12;
   


-------------------------------------------------------------------------------SQL Query 2

create database Online_bookstore;
create table Customer_table(cust_id int not null, cust_name varchar(50) not null, City varchar(30) not null);
insert into customer_table(cust_id, cust_name, City)
values (1, 'John Smith', 'New York'),
(2,'Jane Doe','Los Angeles'),
(3, 'Bob Johnson','Chicago');
select * from customer_table;
  
create table Order_table(OrderID int not null, CustomerID int not null, Product varchar(20), Quantity int not null, Price int not null);  
insert into order_table(orderID, CustomerID, Product, Quantity, Price)
values (1, 1, 'Laptop',2,340),
(2,1,'Printer',	1,240),
(3,2,'Smartphone',3,70),
(4,3,'Tablet',2,80);

select * from order_table;

select *
from customer_table
join order_table on customer_table.cust_id = order_table.CustomerID
where order_table.Price > 100;

select Product
from order_table
join customer_table on customer_table.cust_id = order_table.CustomerID
where customer_table.City = (select city where cust_name = 'John Smith');


select OrderID, Product, sum(Quantity*Price) as total_order_amnt
from order_table
join customer_table on customer_table.cust_id = order_table.CustomerID
where Quantity > 2
group by OrderID, Product;




--------------------------------------------------------------SQL Query 3



create database text1;

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL
);

CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE
);


-- Insert sample data into the teams table
INSERT INTO teams (team_name) VALUES
('Team A'),
('Team B'),
('Team C'),
('Team D');

-- Insert matches where each team plays with every other team
INSERT INTO matches (team1_id, team2_id, match_date)
SELECT teams.team_id, matches.match_id, CURRENT_DATE
FROM teams
JOIN  matches ON teams.team_id < matches.match_id;



