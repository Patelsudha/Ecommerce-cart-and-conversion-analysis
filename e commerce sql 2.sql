create database ecommerce 

select * from[dbo].[Customers]
select * from [dbo].[Delivery]
select * from [dbo].[products]
select * from [dbo].[Returns]
select * from [dbo].[Sessions]
select * from [dbo].[Orders]

-----Business questions SQL

---- [Funnel]
      Visitors
        ↓
    Product Views
        ↓
    Add to Cart
        ↓
     Checkout
        ↓
      Payment
        ↓
     Purchase

--1. What is the overall conversion rate?

SELECT COUNT(DISTINCT 
CASE WHEN [Purchase] = 'Yes' THEN [Session_ID]
    END) * 100.0
    / NULLIF(COUNT(DISTINCT[Session_ID] ), 0) AS Conversion_Rate
FROM [dbo].[Sessions];

---2. Where is the largest customer drop-off?
-- ans : the largest customer drop-off occurs between [Product View → Cart] stage.

--1.Product View → Cart
SELECT (Product_Views - Add_To_Cart_Count) * 100.0
    / NULLIF(Product_Views, 0) AS View_To_Cart_Dropoff
FROM (SELECT 
SUM([Product_Views]) AS Product_Views,
COUNT(CASE WHEN [Add_To_Cart] = 'Yes' THEN 1 END) AS Add_To_Cart_Count
FROM[dbo].[Sessions] ) AS A;

--2.Cart → Checkout

select (Cart_Count - Checkout_count) *100.0 /
nullif(Cart_Count , 0) as Cart_to_Checkout_dropoff
from (select 
count(case when [Add_To_Cart] = 'Yes' then 1 end) as Cart_Count,
COUNT(CASE WHEN [Checkout_Started] = 'Yes' THEN 1 END) AS Checkout_count
from [dbo].[Sessions]) B;

--3.Checkout → Payment

select ( Checkout_count - Payment_count) *100.0 /
nullif(Checkout_count , 0) as Checkout_to_Payment_dropoff
from (select 
count(case when [Checkout_Started] = 'Yes' then 1 end) as Checkout_count,
COUNT(CASE WHEN [Payment_Attempt] = 'Yes' THEN 1 END) AS Payment_count
from [dbo].[Sessions]) B;

--4.Payment → Purchase

select ( Payment_count - purchase_count) *100.0 /
nullif(Payment_count , 0) as Payment_to_purchase_dropoff
from (select 
count(case when [Payment_Attempt] = 'Yes' then 1 end) as Payment_count,
COUNT(CASE WHEN [Purchase] = 'Yes' THEN 1 END) AS purchase_count
from [dbo].[Sessions]) B;

---3. What is the cart abandonment rate?

SELECT COUNT(CASE WHEN Add_To_Cart = 'Yes'
         AND Purchase = 'No' THEN 1 END) * 100.0
/ NULLIF(COUNT(CASE WHEN Add_To_Cart = 'Yes' THEN 1 END),0 ) AS Cart_Abandonment_Rate
FROM Sessions;


---4. What is the checkout abandonment rate?

SELECT COUNT(CASE WHEN [Checkout_Started] = 'Yes'
         AND Purchase = 'No' THEN 1 END) * 100.0
/ NULLIF(COUNT(CASE WHEN [Checkout_Started] = 'Yes' THEN 1 END),0 ) AS Checkout_Abandonment_Rate
FROM Sessions;

---5. What is the payment failure rate?

SELECT COUNT(CASE WHEN [Payment_Success] = 'NO' THEN 1 END) * 100.0
/ NULLIF(COUNT(*), 0) AS Payment_Failure_Rate
FROM [dbo].[Sessions];

----[Customer]

---6. What is the cart abandonment rate for new vs returning customers?

SELECT c.[Customer_Type],
COUNT(CASE
WHEN s.[Add_To_Cart] = 'Yes'
AND s.[Purchase] = 'No'
THEN 1
END) * 100.0 / NULLIF(COUNT(CASE WHEN s.[Add_To_Cart] = 'Yes' THEN 1 END), 0) AS Cart_Abandonment_Rate
FROM [dbo].[Sessions]as s
JOIN [dbo].[Customers] as c
ON s.[Customer_ID] = c.[Customer_ID]
GROUP BY c.[Customer_Type]
ORDER BY Cart_Abandonment_Rate DESC;

---7. Which customer segment has the highest conversion?

SELECT c.[Customer_Type],
COUNT(DISTINCT s.[Session_ID]) AS Total_Sessions,
COUNT(DISTINCT CASE WHEN s.[Purchase] = 'Yes' THEN s.[Session_ID] END) AS Purchases,
COUNT(DISTINCT CASE WHEN s.[Purchase] = 'Yes' THEN s.[Session_ID] END) * 100.0
/ NULLIF(COUNT(DISTINCT s.[Session_ID]), 0) AS Conversion_Rate
FROM [dbo].[Sessions] as s
JOIN [dbo].[Customers] as c
ON s.[Customer_ID] = c.[Customer_ID]
GROUP BY c.[Customer_Type]
ORDER BY Conversion_Rate DESC;
-- ans:  the highest conversion occurs in [New customer type(15.21)].

---8. Which customers generate the most revenue?

SELECT top 10
c.[Customer_ID],
SUM(o.[Revenue]) AS Total_Revenue,
COUNT(DISTINCT o.[Order_ID]) AS Total_Orders
FROM [dbo].[Customers] as c
join [dbo].[Orders] as o
ON c.[Customer_ID] = o.[Customer_ID]
GROUP BY
c.[Customer_ID]
ORDER BY Total_Revenue DESC;


----[Product]

---9. Which categories have the highest abandonment?

SELECT p.[Category],
COUNT(CASE WHEN s.[Add_To_Cart] = 'Yes' AND s.[Purchase] = 'No' THEN 1 END) * 100.0
/NULLIF( COUNT(CASE WHEN s.[Add_To_Cart] = 'Yes' THEN 1 END), 0) AS Cart_Abandonment_Rate
FROM [dbo].[Sessions] as s
JOIN [dbo].[products] as p
ON s.[Product_ID] = p.[Product_ID]
GROUP BY p.[Category]
ORDER BY Cart_Abandonment_Rate DESC;

---10. Which products have high views but low purchases?

SELECT p.[Product_ID],p.[Product_Name],
sum(s.[Product_Views]) AS total_views,
COUNT(CASE WHEN s.[Purchase] = 'Yes' THEN 1 END) AS total_Purchase,
COUNT(CASE WHEN s.[Purchase] = 'Yes' THEN 1 END) * 100.0
/ NULLIF(SUM(s.[Product_Views]), 0) AS Conversion_Rate
FROM [dbo].[Sessions] as s
JOIN [dbo].[products] as p
ON s.[Product_ID] = p.[Product_ID]
GROUP BY
p.[Product_ID],p.[Product_Name]
ORDER BY
total_views DESC,    
Conversion_Rate ASC;


---11.What is the conversion rate for sessions/orders with discounts vs without discounts?

SELECT
case when [Discount_Percent] > 0 then 'With Discount'
else 'Without Discount'
end as Discount_Type,
COUNT(DISTINCT [Session_ID]) AS Total_Sessions,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) AS Purchases,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) * 100.0
/ NULLIF(COUNT(DISTINCT [Session_ID]), 0) AS Conversion_Rate
FROM [dbo].[Sessions]
GROUP BY case when [Discount_Percent] > 0 then 'With Discount'
else 'Without Discount' end
ORDER BY Conversion_Rate DESC;

----[Device]

---12. Is mobile conversion lower than desktop?

SELECT [Device],
COUNT(DISTINCT [Session_ID]) AS Total_Sessions,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) AS Purchases,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) * 100.0
/ NULLIF(COUNT(DISTINCT [Session_ID]), 0) AS Conversion_Rate
FROM [dbo].[Sessions]
GROUP BY [Device]
ORDER BY Conversion_Rate DESC;

---13. Which device has the highest abandonment?

SELECT [Device],
COUNT(CASE WHEN [Add_To_Cart] = 'Yes' AND [Purchase] = 'No' THEN 1 END) AS Abandoned_Carts,
COUNT(CASE WHEN [Add_To_Cart] = 'Yes' THEN 1 END) AS Cart_sessions,
COUNT(CASE WHEN [Add_To_Cart] = 'Yes' AND [Purchase] = 'No' THEN 1 END) * 100.0
/NULLIF( COUNT(CASE WHEN [Add_To_Cart] = 'Yes' THEN 1 END), 0) AS Cart_Abandonment_Rate
FROM [dbo].[Sessions] 
GROUP BY [Device]
ORDER BY Cart_Abandonment_Rate DESC;


----[Marketing]

---14. Which traffic source generates the most customers?

SELECT [Traffic_Source],
COUNT(DISTINCT [Customer_ID]) AS Total_Customers
FROM [dbo].[Sessions]
GROUP BY [Traffic_Source]
ORDER BY Total_Customers DESC;

---15. Which traffic source generates the highest conversion?

SELECT [Traffic_Source],
COUNT(DISTINCT [Session_ID]) AS Total_Sessions,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) AS Purchases,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) * 100.0
/ NULLIF(COUNT(DISTINCT [Session_ID]), 0) AS Conversion_Rate
FROM [dbo].[Sessions]
GROUP BY [Traffic_Source]
ORDER BY Conversion_Rate DESC;


----[Delivery]

---16. How does conversion rate vary by estimated delivery time ?

SELECT
[Delivery_Estimated_Days],
COUNT(DISTINCT [Session_ID]) AS Total_Sessions,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) AS Purchases,
COUNT(DISTINCT CASE WHEN [Purchase] = 'Yes' THEN [Session_ID] END) * 100.0
/ NULLIF(COUNT(DISTINCT [Session_ID]), 0) AS Conversion_Rate
FROM [dbo].[Sessions]
GROUP BY [Delivery_Estimated_Days]
ORDER BY [Delivery_Estimated_Days];


---17. Which warehouse has the highest late-delivery rate?

select [Warehouse],
count([Order_ID]) as total_deliveries,
count(case when [Delivery_Status] = 'Late' then 1 end ) as Late_deliveries,
count (case when [Delivery_Status] = 'Late' then 1 end) * 100.0 / nullif(count([Order_ID]),0) as Late_deliveries_rate
from [dbo].[Delivery]
group by [Warehouse]
order by  Late_deliveries_rate desc;


----[Payment]

---18. Which percentage of payment attempts failure rate?

SELECT
COUNT(*) AS Total_payment_attempts,
sum(CASE
when [Payment_Success] = 'No' 
THEN 1 else 0 END) AS Failed_Transactions,

cast (sum(CASE when [Payment_Success] = 'No'  THEN 1 else 0 END) *100.0
/ NULLIF(count(*), 0)as decimal(10,2)) as Failure_Rate
FROM [dbo].[Sessions];


----[Returns]

---19. Which category has the highest return rate?

select p.[Category],
count(distinct o.[Order_ID]) as total_orders,
count(distinct r.[Return_ID]) as total_return_orders,
count(distinct r.[Return_ID]) *100.0/ nullif(count(distinct o.[Order_ID]),0) as return_rate
from [dbo].[Orders] as o
join Products p
on o.[Product_ID] = p.[Product_ID]
left join [dbo].[Returns] as r
on o.[Order_ID] = r.[Order_ID]
group by p.[Category]
order by return_rate desc;
--ans: fasion is the highest return rate (11.81%).

---20. What are the major return reasons?

SELECT [Return_Reason] ,
COUNT(*) AS Return_Count,
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Return_Percentage
FROM [dbo].[Returns]
GROUP BY [Return_Reason]
ORDER BY Return_Count DESC;


