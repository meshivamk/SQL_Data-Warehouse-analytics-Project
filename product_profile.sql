/*
This report creates a summary of the product and its lifecycle, it provides easy acess to all the details.
It serves the following purpose:
    1. Gathers essential fields such as product key, product name, category and transaction details.
    2. Aggregates product-level metrics:
	   - total order value
	   - total sales
	   - total quantity 
	   - total unique customers
	   - lifespan (in months)
	3. Segments products into categories (High, Mid and low performer).
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order revenue
		- average monthly revenue
*/

IF OBJECT_ID('gold.product_profile', 'V') IS NOT NULL
DROP VIEW gold.product_profile --Drops View if It already exists.
GO

CREATE VIEW gold.product_profile
AS
WITH base_CTE AS		-- Base CTE to compile all the details from the fact and dimension tables.
(
	SELECT
		s.product_key,
		p.product_name,
		p.category,
		p.subcategory,
		p.cost,
		s.sales_amount,
		s.quantity,
		s.price,
		p.product_line,
		s.customer_key,
		s.order_date,
		s.order_number,
		p.start_date,
		p.maintenance
	FROM gold.fact_sales AS s
	LEFT JOIN gold.dim_products AS p
		ON s.product_key = p.product_key
	WHERE s.order_date IS NOT NULL
),

product_details AS		-- CTE for aggregating different metrices.
(
	SELECT			
		product_key,
		product_name,
		category,
		subcategory,
		cost,
		start_date,
		SUM(sales_amount) AS total_sales,
		COUNT(DISTINCT order_number)  AS total_orders,
		SUM(quantity) AS total_quantity,
		COUNT(DISTINCT customer_key) AS unique_customer,
		DATEDIFF(month,MIN(order_date), MAX(order_date)) AS lifespan,
		DATEDIFF(month, max(order_date), GETDATE()) AS recency
	FROM base_CTE
	GROUP BY product_key, product_key, product_name, category, subcategory, cost, start_date
)

SELECT			-- Final Segmentation of products
	*,
	CASE		-- Segmentation of products based on sales.
		WHEN total_sales > 50000 THEN 'High Performer'
		WHEN total_sales >= 10000 THEN 'Mid Performer'
		ELSE 'Low Performer'
	END AS product_segment,

	CASE		-- Average Order Revenue
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,

	CASE		-- Average Monthly Revenue
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue

FROM product_details