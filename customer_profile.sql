/*
This report creates a summary of the customer and its lifecycle, it provides easy acess to all the details.
It serves the following purpose:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
	3. Segments customers into categories (VIP, Regular, New) and age groups.
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
*/

-- Creates a view gold.customer_profile
IF OBJECT_ID('gold.customer_profile', 'V') IS NOT NULL
DROP VIEW gold.customer_profile --Drops View if It already exists.
GO

CREATE VIEW gold.customer_profile
AS

WITH parentcte AS  -- ParentCTE summarizes the basic details avilable about customer from different facts and dimensions.
(
	SELECT
		c.customer_key,
		CONCAT(c.firstname,' ', c.lastname) AS full_name, -- Concatenation of first and last name.
		c.country,
		c.gender,
		c.marital_status,
		c.birthdate,
		DATEDIFF(YEAR, c.birthdate, getdate()) AS age,		-- Calculates current age
		s.order_date,
		s.sales_amount,
		s.quantity
	FROM gold.dim_customers AS c
	LEFT JOIN gold.fact_sales AS s
		ON c.customer_key = s.customer_key
	WHERE s.order_date IS NOT NULL
	),

custdetails AS -- Aggregates details about the customer like total sales, avg_sales and other etrics using parentCTE
(
	SELECT
		customer_key,
		full_name,
		age,
		birthdate,
		gender,
		marital_status,
		DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) AS lifespan, --Creates life span using the first and last order date of customer in the system
		DATEDIFF(MONTH,MAX(order_date), GETDATE()) AS recency,   -- Calculates the time since the customer last placed an order
		SUM(sales_amount) AS total_sales,	--
		AVG(sales_amount) AS avg_sales,
		SUM(quantity) AS total_quantity
	FROM parentcte
	group by customer_key, full_name, age, birthdate, gender, marital_status
	),

segment AS  -- Segments the customers into different groups using the business logic
(
SELECT 
		customer_key,
		full_name,
		age,
		birthdate,
		gender,
		marital_status,
		total_sales,
		total_quantity,
		avg_sales,
		lifespan,
		recency,
		CASE					-- Calculation monthly average and handling the division by zero, in case lifespan is 0.
			WHEN lifespan = 0 THEN total_sales
			ELSE total_sales/lifespan 
			END 
		AS monthly_average,
		CASE					-- Segmentation using lifespan and sales value
			WHEN lifespan>12 AND total_sales>5000 THEN 'VIP'
			WHEN lifespan>12 AND total_sales>2000 THEN 'Regular'
			ELSE 'NEW CUSTOMER'
			END 
		AS segment,				-- Segmentation based on age.
		CASE 
			WHEN age>0 AND  age<18 THEN 'YOUNG'
			WHEN age>=18 AND  age<=50 THEN 'ADULT'
			WHEN age>50  THEN 'OLD'
			END 
		AS 'age_group'
	FROM custdetails
)

SELECT
*
FROM segment


/*  

--To run the script ordered by customer_key

SELECT
*
FROM gold.customer_profile
ORDER BY customer_key

*/