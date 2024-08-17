DROP TABLE IF EXISTS Retail_sales;
CREATE TABLE Retail_sales(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age INT,
				category VARCHAR(20),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT

)
SELECT * FROM Retail_sales
LIMIT 10

SELECT COUNT(*) FROM Retail_sales

SELECT * FROM Retail_sales
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time	IS NULL
OR
customer_id	IS NULL
OR
gender	IS NULL
OR
age	IS NULL
OR
category	IS NULL
OR
quantity	IS NULL
OR
price_per_unit	IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL

--DELETE NULL ROWS
DELETE FROM Retail_sales
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time	IS NULL
OR
customer_id	IS NULL
OR
gender	IS NULL
OR
age	IS NULL
OR
category	IS NULL
OR
quantity	IS NULL
OR
price_per_unit	IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL
SELECT COUNT(*) FROM Retail_sales

--Number of unique customers
SELECT COUNT( DISTINCT customer_id) as total_customers FROM Retail_sales
--Number of unique categories
SELECT DISTINCT category FROM Retail_sales
--Write a SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM Retail_sales
WHERE sale_date = '2022-11-05' 
--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 or more in the month of Nov-2022:
SELECT * FROM Retail_sales
WHERE category = 'Clothing'
AND 
TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
AND
quantity >= 4
--Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category,SUM(total_sale) as total_amount, COUNT(*) AS total_orders
FROM Retail_sales
GROUP BY 1
--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(age), 2) AS average_age FROM Retail_sales
WHERE category='Beauty'
--Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM Retail_sales
WHERE total_sale > 1000
--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, COUNT(*) AS total_number_of_transactions
FROM Retail_sales
GROUP BY category, gender
ORDER BY 1
--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,month, avg_monthly_sales
FROM (
	SELECT EXTRACT(YEAR FROM sale_date)AS year, 
	EXTRACT (MONTH FROM sale_date) AS month, 
	AVG(total_sale) AS avg_monthly_sales,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM Retail_sales
	GROUP BY 1,2
	) AS t1
WHERE rank=1
--Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sale
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM Retail_sales
GROUP BY 1
--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT (CASE 
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
END) AS Shifts, COUNT(*) AS total_orders
FROM Retail_sales
GROUP BY 1
