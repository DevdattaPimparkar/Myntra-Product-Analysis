create database myntra;
use myntra;
create table myntra_data
(uniq_id varchar(100),
crawl_timestamp	datetime,
product_id	int,
size varchar(50),
brand varchar(100),	
dominant_material varchar(50),	
title varchar(200),	
actual_color varchar(50),	
dominant_color varchar(50),	
product_type varchar(100),	
variant_price int,	
variant_compare_at_price int,	
ideal_for varchar(50),	
is_in_stock varchar(50));

select * from myntra_data limit 100;

/*all the distinguished things myntra has*/
select count(distinct product_id) as TotalProducts, count(distinct size) as Totalsizes, count(distinct brand) as total_brands,
count(distinct dominant_material) as total_materials, 
count(distinct dominant_color) as TotalColors, count(distinct actual_color) as Total_a_color,
count(distinct product_type) as TotalProduct_types,
count(distinct ideal_for) as ideal_for, count(distinct is_in_stock) as Stockinfo
from myntra_data;


/*variety of attributes*/
select distinct size from myntra_data;
select distinct brand from myntra_data order by brand;
select distinct dominant_material from myntra_data order by dominant_material;
select distinct product_type from myntra_data order by product_type;
select distinct dominant_color from myntra_data order by dominant_color;
select distinct ideal_for from myntra_data order by ideal_for;

/*top 1000 costly products*/
create view top_1000 as
select brand,product_type,variant_price, variant_compare_at_price
from myntra_data
order by variant_compare_at_price desc
limit 1000;

select brand,product_type,variant_price, variant_compare_at_price
from myntra_data
order by variant_compare_at_price desc
limit 1000;

/*top 10 brands based on price*/
select distinct(brand)
from top_1000
limit 10;

/*top 10 product types based on price*/
select distinct(product_type)
from top_1000
limit 10;

/*color mentioned by myntra and actual color of product matches*/
select count(distinct product_id) as same_color_products, (count(distinct product_id)/12858)*100 as Percent
from myntra_data
where actual_color=dominant_color;

/*Products having same price as MRP*/
select count(distinct product_id) as SamePrice_as_MRP  , (count(distinct product_id)/12858)*100 as percent
from myntra_data 
where variant_price=variant_compare_at_price;

/*Gender wise product count*/
select ideal_for,count(distinct product_id) as NoOfProducts,
(count(distinct product_id)/12858)*100  as Percentage_contribution
from myntra_data
group by ideal_for;

/*count of stocked items*/
select is_in_stock, count(distinct product_id) as NoOfProducts,
(count(distinct product_id)/12858)*100  as Percentage
from myntra_data
group by is_in_stock;

/*gender wise out of stock products*/
select ideal_for, count(distinct product_id) as NoOfProducts,
(count(distinct product_id)/6492)*100  as Percentage
from myntra_data
where is_in_stock= "out of stock"
group by ideal_for
order by count(distinct product_id) desc;

/*out of stock products for women */
select distinct product_id, brand, product_type, variant_price
from myntra_data
where ideal_for= "women" and is_in_stock= "out of stock"
order by variant_price desc;

/*out of stock products price range (women)*/
select min(variant_price), max(variant_price)
from myntra_data
where ideal_for= "women" and is_in_stock= "out of stock";

/*avg price of products based on gender, material, brands and product types*/
select dominant_material, avg(variant_compare_at_price)
from myntra_data
group by dominant_material
order by avg(variant_compare_at_price) desc;

select product_type, avg(variant_compare_at_price)
from myntra_data
group by product_type
order by avg(variant_compare_at_price) desc;

select ideal_for, avg(variant_compare_at_price)
from myntra_data
group by ideal_for
order by avg(variant_compare_at_price) desc;

select brand, avg(variant_compare_at_price)
from myntra_data
group by brand
order by avg(variant_compare_at_price) desc;
























 
 
















  