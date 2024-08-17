# Data Analysis Report: Retail Sales Analysis

## Dataset Overview

The dataset contains 2,000 records with the following columns:

- **transactions_id**: Unique identifier for each transaction.
- **sale_date**: Date of the sale.
- **sale_time**: Time of the sale.
- **customer_id**: Unique identifier for each customer.
- **gender**: Gender of the customer.
- **age**: Age of the customer.
- **category**: Product category (e.g., Clothing, Beauty).
- **quantity**: Number of units sold.
- **price_per_unit**: Price per unit of the product.
- **cogs**: Cost of goods sold.
- **total_sale**: Total sale amount.

### Data Quality Issues

- **Missing Values**: Some records have missing values in the age, quantity, price_per_unit, cogs, and total_sale columns.

DELETE FROM Retail_sales
<br>WHERE transactions_id IS NULL
<br>OR
<br>sale_date IS NULL
<br>OR
<br>sale_time	IS NULL
<br>OR
<br>customer_id	IS NULL
<br>OR
<br>gender	IS NULL
<br>OR
<br>age	IS NULL
<br>OR
<br>category	IS NULL
<br>OR
<br>quantity	IS NULL
<br>OR
<br>price_per_unit	IS NULL
<br>OR
<br>cogs IS NULL
<br>OR
<br>total_sale IS NULL

<br>13 records were deleted

## Data Exploration
155 unique customers. 
<br>3 unique Categories.

## Data Analysis Report: Retail Sales Analysis

### 1. SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM Retail_sales
<br>WHERE sale_date = '2022-11-05' 

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/1.png)

- **Key Insight**: The sales on November 5th were relatively balanced across different product categories, with a mix of Clothing, Beauty, and Electronics.

### 2. SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 or more in the month of Nov-2022:
SELECT * FROM Retail_sales
<br>WHERE category = 'Clothing' AND 
<br>TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
AND
<br>quantity >= 4

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/2.png)

- **Key Insight**: There were no instances where the quantity of Clothing sold exceeded 4 units in a single transaction during November 2022, indicating potential stocking issues or low demand for bulk purchases.

### 3. SQL query to calculate the total sales (total_sale) for each category:
SELECT category,SUM(total_sale) as total_amount, COUNT(*) AS total_orders
FROM Retail_sales
<br>GROUP BY 1

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/3.png)
- **Key Insight**: Clothing has the highest total sales, followed by Electronics and Beauty. The sales distribution indicates a relatively even demand across these three major categories.

### 4. SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT ROUND(AVG(age), 2) AS average_age FROM Retail_sales
<br>WHERE category='Beauty'

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/4.png)
- **Key Insight**: The average customer age for Beauty products is approximately 38 years, suggesting that middle-aged consumers are the primary buyers in this category.

### 5. SQL query to find all transactions where the total_sale is greater than 1000

SELECT *
FROM Retail_sales
<br>WHERE total_sale > 1000
![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/5.png)
- **Key Insight**: A significant number of high-value transactions involve Beauty and Clothing products, highlighting these categories as premium segments.

### 6. SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
SELECT category, gender, COUNT(*) AS total_number_of_transactions
FROM Retail_sales
<br>GROUP BY category, gender
<br>ORDER BY 1

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/6.png)
- **Key Insight**: The transaction count is relatively balanced between genders across all categories, with a slight preference for Clothing among males.

### 7. SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,month, avg_monthly_sales
<br>FROM (
	SELECT EXTRACT(YEAR FROM sale_date)AS year, 
	EXTRACT (MONTH FROM sale_date) AS month, 
	AVG(total_sale) AS avg_monthly_sales,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM Retail_sales
	GROUP BY 1,2
	) AS t1
<br>WHERE rank=1

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/7.png)

- **Key Insight**: July 2022 and February 2023 were the peak months in terms of average sales, possibly driven by seasonal promotions or holidays.

### 8. SQL query to find the top 5 customers based on the highest total sales:
SELECT customer_id, SUM(total_sale) AS total_sale
FROM Retail_sales
<br>GROUP BY 1
<br>ORDER BY 2 DESC
<br>LIMIT 5

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/8.png)
- **Key Insight**: A small number of customers contribute significantly to overall sales, highlighting the importance of targeting and retaining high-value customers.

### 9. SQL query to find the number of unique customers who purchased items from each category:
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM Retail_sales
<br>GROUP BY 1


![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/9.png)
 
- **Key Insight**: The number of unique customers is evenly distributed across categories, indicating broad and consistent customer engagement.

### 10. SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT (CASE 
  	<br>WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
  	<br>WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  	<br>ELSE 'Evening'
    <br>END) AS Shifts, COUNT(*) AS total_orders
  <br>FROM Retail_sales
  <br>GROUP BY 1

![Alt Text](https://github.com/Sus-31/Retail_Sales_Analysis/blob/main/10.png)

- **Key Insight**: The majority of orders occur in the evening, suggesting that marketing and promotional efforts should be intensified during this period to maximize sales.

## Recommendations:
1. **Focus on Evening Sales**: Since most orders are placed in the evening, consider launching targeted promotions or discounts during this time to boost sales.
2. **Target High-Value Customers**: Implement a loyalty program for top customers (e.g., those with sales > $30,000) to encourage repeat purchases.
3. **Increase Bulk Purchase Incentives**: Since there are no high-quantity sales for Clothing in November 2022, consider offering discounts or promotions for bulk purchases to stimulate demand in upcoming years.
4. **Expand the Beauty Category**: Given that the average customer age is around 40 years, tailor Beauty product offerings to appeal to this demographic, possibly introducing products that cater to middle-aged customers.
5. **Analyze Seasonal Trends**: Investigation required to know why July 2022 and February 2023 were peak months to replicate successful strategies in upcoming years.
