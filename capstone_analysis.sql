CREATE DATABASE FINANCIAL_PERFORMANCE_ANALYSIS;
USE FINANCIAL_PERFORMANCE_ANALYSIS;
SHOW TABLES;
SELECT COUNT(*) FROM FINANCIAL_TRANSACTION_CLEAN;
SELECT COUNT(*) FROM BUDGET_CLEAN;
SELECT COUNT(*) FROM VENDOR_CLEAN;
SELECT COUNT(*) FROM CUSTOMER_CLEAN;
SELECT COUNT(*) FROM HEADCOUNT_CLEAN; 

SELECT DISTINCT ACCOUNT_TYPE 
FROM FINANCIAL_TRANSACTION_CLEAN;
SELECT DISTINCT CATEGORY 
FROM FINANCIAL_TRANSACTION_CLEAN;
SELECT DISTINCT BUSINESS_UNIT 
FROM FINANCIAL_TRANSACTION_CLEAN;
SELECT DISTINCT REGION 
FROM FINANCIAL_TRANSACTION_CLEAN;

SELECT SUM(AMOUNT) AS TOTAL_REVENUE 
FROM FINANCIAL_TRANSACTION_CLEAN 
WHERE ACCOUNT_TYPE='REVENUE';

SELECT SUM(AMOUNT) AS TOTAL_EXPENSES
FROM FINANCIAL_TRANSACTION_CLEAN 
WHERE ACCOUNT_TYPE='EXPENSE';

SELECT
    SUM(CASE WHEN account_type = 'Revenue' THEN amount ELSE 0 END) AS Total_Revenue,

    SUM(CASE WHEN account_type = 'Expense' THEN amount ELSE 0 END) AS Total_Expense,

    SUM(CASE
            WHEN account_type IN ('Revenue','Expense')
            THEN amount
            ELSE 0
        END) AS Net_Profit
FROM Financial_Transaction_Clean;
SELECT
    SUM(amount) AS Grand_Total
FROM Financial_Transaction_Clean;
SELECT CATEGORY, MAX(AMOUNT) FROM Financial_Transaction_Clean GROUP BY CATEGORY ORDER BY CATEGORY;

SELECT CATEGORY,
	SUM(
		CASE 
			WHEN ACCOUNT_TYPE='REVENUE'
            THEN AMOUNT
            ELSE 0
            END
		) AS TOTAL_REVENUE,
	
    SUM(
		CASE
			WHEN ACCOUNT_TYPE='EXPENSE'
            THEN AMOUNT
            ELSE 0 
            END
		) AS TOTAL_EXPENSE
	
    FROM Financial_Transaction_Clean
    GROUP BY CATEGORY
    ORDER BY  TOTAL_REVENUE DESC;
    
SELECT 
    account_type, category, SUM(amount) AS Total_Amount
FROM
    Financial_Transaction_Clean
WHERE
    account_type IN ('Revenue' , 'Expense')
GROUP BY account_type, category
ORDER BY account_type , ABS(Total_Amount) desc;

SELECT REGION ,CATEGORY, AMOUNT, ACCOUNT_TYPE
FROM Financial_Transaction_Clean
;
SELECT REGION,
		SUM(CASE
				WHEN ACCOUNT_TYPE = 'REVENUE'
                THEN AMOUNT 
                ELSE 0
                END
			) AS TOTAL_REVENUE,
		
		SUM(CASE
				WHEN ACCOUNT_TYPE = 'EXPENSE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_EXPENSE,
            
		SUM(CASE
				WHEN ACCOUNT_TYPE IN ('REVENUE','EXPENSE')
                THEN AMOUNT
                ELSE 0
                END
			) AS NET_PROFIT
	FROM Financial_Transaction_Clean
    GROUP BY REGION
    ORDER BY NET_PROFIT DESC;
    
SELECT BUSINESS_UNIT, 
				SUM(CASE 
						WHEN ACCOUNT_TYPE = 'revenue'
                        THEN AMOUNT 
                        ELSE 0
                        END
					) AS TOTAL_REVENUE,
				SUM(CASE
						WHEN ACCOUNT_TYPE = 'EXPENSE'
                        THEN AMOUNT
                        ELSE 0
                        END
					) AS TOTAL_EXPENSE,
				SUM(CASE 
						WHEN ACCOUNT_TYPE IN ('REVENUE','EXPENSE')
                        THEN AMOUNT
                        ELSE 0
                        END
					) AS  NET_PROFIT
FROM Financial_Transaction_Clean
GROUP BY BUSINESS_UNIT
ORDER BY NET_PROFIT DESC;

SELECT TRANSACTION_DATE FROM Financial_Transaction_Clean LIMIT 20;
SELECT 
YEAR(TRANSACTION_DATE) AS YEAR,
MONTH(TRANSACTION_DATE) AS MONTH
FROM Financial_Transaction_Clean
LIMIT 10;

SELECT 
YEAR(TRANSACTION_DATE) AS YEAR,
MONTH(TRANSACTION_DATE) AS MONTH,
		SUM(CASE 
				WHEN ACCOUNT_TYPE = 'REVENUE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_REVENUE,
		SUM(CASE 
				WHEN ACCOUNT_TYPE ='EXPENSE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_EXPENSE
FROM Financial_Transaction_Clean
GROUP BY 
YEAR(TRANSACTION_DATE),
MONTH(TRANSACTION_DATE)
ORDER BY 
YEAR,
MONTH;

SELECT
    transaction_date,
    DATE_FORMAT(transaction_date, '%b') AS Month_Name
FROM Financial_Transaction_Clean
LIMIT 10;

SELECT
    DATE_FORMAT(transaction_date, '%Y-%b') AS Month_Name
FROM Financial_Transaction_Clean
GROUP BY MONTH_NAME
;

SELECT 
	YEAR(transaction_date),
    MONTH(transaction_date),
    SUM(CASE 
			WHEN ACCOUNT_TYPE='REVENUE'
            THEN AMOUNT
            ELSE 0
            END
		) AS TOTAL_REVENUE,
        SUM(CASE 
				WHEN ACCOUNT_TYPE='EXPENSE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_EXPENSE
FROM Financial_Transaction_Clean
GROUP BY 
		MONTH(transaction_date),
        YEAR(transaction_date)
ORDER BY 
		MONTH(transaction_date),
        YEAR(transaction_date);
        
DESCRIBE Budget_Clean;

SELECT * FROM BUDGET_CLEAN limit 10;
SELECT 
		YEAR,
		month,
        COUNT(*) AS TOTAL_ROWS
FROM BUDGET_CLEAN
GROUP BY 
        MONTH;
        
SELECT
    YEAR(transaction_date) AS Year,
    MONTH(transaction_date) AS Month,
    business_unit,

    SUM(
        CASE
            WHEN account_type = 'Revenue'
            THEN amount
            ELSE 0
        END
    ) AS Actual_Revenue,

    SUM(
        CASE
            WHEN account_type = 'Expense'
            THEN amount
            ELSE 0
        END
    ) AS Actual_Expense

FROM Financial_Transaction_Clean

GROUP BY
    YEAR(transaction_date),
    MONTH(transaction_date),
    business_unit

ORDER BY
    Year,
    Month,
    business_unit;
    
SELECT 
		YEAR(F.transaction_date) AS YEAR,
        MONTH(F.transaction_date) AS MONTH,
        F.BUSINESS_UNIT,
        SUM(CASE
				WHEN F.ACCOUNT_TYPE='REVENUE'
                THEN F.AMOUNT 
                ELSE 0
                END
			) AS TOTAL_REVENUE,
		SUM(CASE 
				WHEN F.ACCOUNT_TYPE='EXPENSE'
				THEN F.AMOUNT
				ELSE 0
				END
			) AS TOTAL_EXPENSE
		
FROM Financial_Transaction_Clean F
INNER JOIN BUDGET_CLEAN B 
	ON YEAR(F.transaction_date)=B.YEAR
    AND MONTH(F.transaction_date)=B.MONTH
    AND F.BUSINESS_UNIT=B.BUSINESS_UNIT
GROUP BY 
	YEAR,
    MONTH,
    F.BUSINESS_UNIT,
    B.BUDGETED_REVENUE
ORDER BY 
	YEAR,
    MONTH,
    F.	BUSINESS_UNIT;
SELECT
    YEAR(f.transaction_date) AS Year,
    MONTH(f.transaction_date) AS Month,
    f.business_unit,

    SUM(
        CASE
            WHEN f.account_type = 'Revenue'
            THEN f.amount
            ELSE 0
        END
    ) AS Actual_Revenue,

    b.budgeted_revenue,

    SUM(
        CASE
            WHEN f.account_type = 'Revenue'
            THEN f.amount
            ELSE 0
        END
    ) - b.budgeted_revenue AS Revenue_Variance

FROM Financial_Transaction_Clean f

INNER JOIN Budget_Clean b
ON YEAR(f.transaction_date) = b.year
AND MONTH(f.transaction_date) = b.month
AND f.business_unit = b.business_unit

GROUP BY
    YEAR(f.transaction_date),
    MONTH(f.transaction_date),
    f.business_unit,
    b.budgeted_revenue

ORDER BY
    Year,
    Month,
    f.business_unit;
SELECT 
	COUNT(*) AS BUDGTED_ROWS
FROM BUDGET_CLEAN;
SELECT 
	COUNT(*) AS FT_ROWS
FROM Financial_Transaction_Clean;
SELECT
    COUNT(*)
FROM (
    SELECT
        YEAR(transaction_date),
        MONTH(transaction_date),
        business_unit
    FROM Financial_Transaction_Clean
    GROUP BY
        YEAR(transaction_date),
        MONTH(transaction_date),
        business_unit
) t;

SELECT 
		CUSTOMER_ID,
		SUM(CASE 
				WHEN ACCOUNT_TYPE='REVENUE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_REVENUE
FROM Financial_Transaction_Clean
GROUP BY 
		CUSTOMER_ID
ORDER BY
		TOTAL_REVENUE DESC;
        
SELECT 
		CUSTOMER_ID,
		SUM(CASE 
				WHEN ACCOUNT_TYPE='REVENUE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_REVENUE,
		SUM(CASE 
				WHEN ACCOUNT_TYPE='EXPENSE'
                THEN AMOUNT
                ELSE 0
                END
			) AS TOTAL_EXPENSE,
		SUM(CASE
				WHEN ACCOUNT_TYPE IN ('REVENUE','EXPENSE')
                THEN AMOUNT
                ELSE 0
                END
			) AS NET_TOTAL
FROM Financial_Transaction_Clean
GROUP BY 
		CUSTOMER_ID
ORDER BY
		NET_TOTAL DESC;

SELECT 
		CUSTOMER_ID,
        SUM(CASE
				WHEN ACCOUNT_TYPE='REVENUE'
                THEN AMOUNT
                ELSE 0
                END
			)AS TOTAL_REVENUE,
		ROUND(
				(SUM(CASE 
						WHEN ACCOUNT_TYPE='REVENUE'
                        THEN AMOUNT
                        ELSE 0 
                        END
					) *100)
				/
                (SELECT SUM(AMOUNT)
                FROM Financial_Transaction_Clean
                WHERE ACCOUNT_TYPE='REVENUE'
                ),2
                ) AS CUSTOMER_CONTRIBUTION_PERCENTAGE
FROM Financial_Transaction_Clean
WHERE CUSTOMER_ID IS NOT NULL
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_REVENUE DESC
LIMIT 10;
                
SELECT 
		VENDOR_ID,
        round(ABS(SUM(CASE
				WHEN ACCOUNT_TYPE='EXPENSE'
                THEN AMOUNT
                ELSE 0
                END
			)),2)AS TOTAL_PAYMENT
FROM Financial_Transaction_Clean
WHERE VENDOR_ID IS NOT NULL
GROUP BY VENDOR_ID
ORDER BY TOTAL_PAYMENT DESC
LIMIT 10;
        
        
SELECT
    VENDOR_ID,
    ROUND(ABS(SUM(CASE
        WHEN ACCOUNT_TYPE = 'EXPENSE'
        THEN AMOUNT
        ELSE 0
    END)), 2) AS TOTAL_PAYMENT
FROM Financial_Transaction_Clean
WHERE VENDOR_ID IS NOT NULL
GROUP BY VENDOR_ID
ORDER BY TOTAL_PAYMENT DESC
LIMIT 10;
                
                
SELECT 
		YEAR(F.transaction_date) AS YEAR,
        MONTH(F.transaction_date) AS MONTH,
        F.BUSINESS_UNIT,
        B.BUDGETED_EXPENSE,
        ROUND(ABS(SUM(CASE
				WHEN F.ACCOUNT_TYPE='EXPENSE'
                THEN F.AMOUNT
                ELSE 0
                END
			)),2) AS TOTAL_EXPENSE,
		ROUND(ABS(SUM(CASE
				WHEN ACCOUNT_TYPE='EXPENSE'
                THEN AMOUNT
                ELSE 0
                END
			)),2)- BUDGETED_EXPENSE AS EXPENSE_SAVING
FROM Financial_Transaction_Clean F
INNER JOIN BUDGET_CLEAN B
ON
	YEAR(F.transaction_date)=B.YEAR
	AND MONTH(F.transaction_date)=B.MONTH
	AND F.BUSINESS_UNIT=B.BUSINESS_UNIT
GROUP BY 
	YEAR(F.transaction_date),
	MONTH(F.transaction_date),
	F.BUSINESS_UNIT,
	B.BUDGETED_EXPENSE
ORDER BY 
	YEAR,
    MONTH,
    F.BUSINESS_UNIT;
		
 SELECT
    YEAR(f.transaction_date) AS Year,
    MONTH(f.transaction_date) AS Month,
    f.business_unit,

    SUM(
        CASE
            WHEN f.account_type='REVENUE'
            THEN f.amount
            ELSE 0
        END
    ) AS Actual_Revenue,

    b.budgeted_revenue,

    SUM(
        CASE
            WHEN f.account_type='REVENUE'
            THEN f.amount
            ELSE 0
        END
    ) - b.budgeted_revenue
    AS Revenue_Variance,

    ROUND(
    (
    (
    SUM(
    CASE
    WHEN f.account_type='REVENUE'
    THEN f.amount
    ELSE 0
    END
    )
    -
    b.budgeted_revenue
    )
    /
    b.budgeted_revenue
    )*100,2
    ) AS Revenue_Variance_Percentage

FROM Financial_Transaction_Clean f

INNER JOIN Budget_Clean b
ON YEAR(f.transaction_date)=b.year
AND MONTH(f.transaction_date)=b.month
AND f.business_unit=b.business_unit

GROUP BY
YEAR(f.transaction_date),
MONTH(f.transaction_date),
f.business_unit,
b.budgeted_revenue

ORDER BY
Year,
Month,
f.business_unit;       

SELECT
    YEAR(f.transaction_date) AS Year,
    MONTH(f.transaction_date) AS Month,
    f.business_unit,

    ROUND(
        ABS(
            SUM(
                CASE
                    WHEN f.account_type = 'EXPENSE'
                    THEN f.amount
                    ELSE 0
                END
            )
        ),2
    ) AS Actual_Expense,

    b.budgeted_expense,

    ROUND(
        ABS(
            SUM(
                CASE
                    WHEN f.account_type = 'EXPENSE'
                    THEN f.amount
                    ELSE 0
                END
            )
        ) - b.budgeted_expense,
        2
    ) AS Expense_Variance,

    ROUND(
        (
            (
                ABS(
                    SUM(
                        CASE
                            WHEN f.account_type = 'EXPENSE'
                            THEN f.amount
                            ELSE 0
                        END
                    )
                ) - b.budgeted_expense
            )
            / b.budgeted_expense
        ) * 100,
        2
    ) AS Expense_Variance_Percentage

FROM Financial_Transaction_Clean f

INNER JOIN Budget_Clean b
ON YEAR(f.transaction_date) = b.year
AND MONTH(f.transaction_date) = b.month
AND f.business_unit = b.business_unit

GROUP BY
    YEAR(f.transaction_date),
    MONTH(f.transaction_date),
    f.business_unit,
    b.budgeted_expense

ORDER BY
    Year,
    Month,
    f.business_unit;
		
		
WITH CustomerRevenue AS
(
SELECT
    customer_id,
    SUM(
        CASE
            WHEN account_type='REVENUE'
            THEN amount
            ELSE 0
        END
    ) AS Customer_Revenue

FROM Financial_Transaction_Clean

WHERE customer_id IS NOT NULL

GROUP BY customer_id
)

SELECT
    customer_id,
    Customer_Revenue,

    SUM(Customer_Revenue)
    OVER(
        ORDER BY Customer_Revenue DESC
    ) AS Running_Revenue

FROM CustomerRevenue;		
		
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(
            CASE
                WHEN account_type = 'REVENUE'
                THEN amount
                ELSE 0
            END
        ) AS Customer_Revenue

    FROM Financial_Transaction_Clean

    WHERE customer_id IS NOT NULL

    GROUP BY customer_id
)

SELECT
    customer_id,
    ROUND(Customer_Revenue,2) AS Customer_Revenue,

    ROUND(
        SUM(Customer_Revenue)
        OVER(
            ORDER BY Customer_Revenue DESC
        ),
        2
    ) AS Running_Revenue,

    ROUND(
        (
            SUM(Customer_Revenue)
            OVER(
                ORDER BY Customer_Revenue DESC
            )
            /
            SUM(Customer_Revenue)
            OVER()
        ) * 100,
        2
    ) AS Cumulative_Percentage

FROM CustomerRevenue
ORDER BY Customer_Revenue DESC;
SELECT
ROUND(
    SUM(CASE
            WHEN account_type = 'Revenue'
            THEN amount
            ELSE 0
        END),2
) AS Total_Revenue
FROM Financial_Transaction_Clean;        
