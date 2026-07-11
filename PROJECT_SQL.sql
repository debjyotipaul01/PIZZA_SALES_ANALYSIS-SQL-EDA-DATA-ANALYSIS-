 USE PROJECT_SQL ;

-- 1. Total number of orders placed--------------------------------------------------------------------
SELECT COUNT(order_id) AS total_orders FROM orders ;

-- 2. Total revenue generated from pizza sales.---------------------------------------------------------
    
SELECT SUM(order_details.quantity * pizzas.price) AS Total_REVENUE
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
SELECT SUM(quantity) AS Total_quantity 
FROM order_details;
   
SELECT SUM(price) AS total_price FROM pizzas;
  -- 3. Top 5 Highest Priced Pizza.---------------------------------------------------------------------------------------------
  
SELECT pizza_id,price,pizza_types.name
FROM pizzas JOIN pizza_types ON 
pizza_types.pizza_type_id =pizzas.pizza_type_id 
ORDER BY price DESC LIMIT 5 ;
  
  -- 4. Most Common Pizza Size Ordered.------------------------------------------------------------------------------------------
   SELECT size, 
   COUNT(order_details.order_details_id) AS ORDER_COUNT
   FROM pizzas 
   JOIN order_details ON pizzas.pizza_id = order_details.pizza_id 
   GROUP BY size
   ORDER BY ORDER_COUNT DESC;
    
-- 5. Top 5 Most Ordered Pizza Types Along With Their Quantities------------------------------------------------------------------

SELECT pizza_types.name,
SUM(order_details.quantity) AS order_type_count
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id=pizzas.pizza_id
GROUP BY  pizza_types.name 
ORDER BY order_type_count LIMIT 5 ;

-- 6. Total Quantity Of Each Pizza Category Ordered.------------------------------------------------------------------------------------
SELECT category , 
SUM(quantity) AS PIZZA_COUNT 
FROM pizza_types
JOIN pizzas ON  pizzas.pizza_type_id= pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY  category
ORDER BY PIZZA_COUNT DESC ; 

-- ---7.Distribution Of Orders By Hour Of The Day.-----------------------------------------------------------------------------
SELECT 
    HOUR(time) AS Order_Hour, COUNT(order_id) AS order_count
FROM orders 
GROUP BY time;

--  8.  Category Wise Distribution Of Pizzas.-----------------------------------------------------------------------------------
SELECT category,COUNT(name) 
FROM pizza_types 
GROUP BY category;

 -- 9. Grouping Of Orders By Date And Calculating Average Number Of Pizzas Ordered Per Day.------------------------------------------
SELECT 
   date, AVG(order_id) AS avg_orders_perday
FROM orders 
GROUP BY date ;
--  10. Top 5 Most Ordered Pizza Based On Revenue------------------------------------------------------------------------------------
SELECT name,SUM(price*quantity) AS REVENUE
FROM pizza_types
JOIN pizzas ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id=pizzas.pizza_id
GROUP BY name 
ORDER BY REVENUE DESC LIMIT 5;

-- 11. Percentage Contribution Of Each Pizza Type To Total Revenue.-------------------------------------------------------------------------
SELECT  category ,SUM(price*quantity) AS REVENUE,
SUM(SUM(price*quantity)) OVER (ORDER BY category ) AS QUMULATIVE_REVENUE,
ROUND(SUM(price*quantity)*100/SUM(SUM(price*quantity)) OVER (),2) AS REVENUE_PERSENTAGE
FROM pizza_types pt
JOIN pizzas p ON p.pizza_type_id=pt.pizza_type_id
JOIN order_details od ON p.pizza_id=od.pizza_id
GROUP BY category
ORDER BY REVENUE;

SELECT * FROM category_revenue_percentage;











   
   
   
   
  