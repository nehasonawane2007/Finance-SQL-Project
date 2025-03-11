/# Q.1 Find the Running Balance for Each Account Holder Over Time? #/

SELECT 
    Transaction_ID, 
    Transaction_Date, 
    Account_Holder, 
    Transaction_Type, 
    Amount, 
    Currency, 
    SUM(CASE 
            WHEN Transaction_Type = 'Deposit' THEN Amount 
            ELSE -Amount 
        END) OVER (
            PARTITION BY Account_Holder, Currency 
            ORDER BY Transaction_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Running_Balance
FROM Financial_Transactions;

/#  Q.2 Find Account Holders with the Highest Total Deposits in Each Currency? #/

WITH Currency_Deposits AS (
    SELECT 
        Account_Holder, 
        Currency, 
        SUM(Amount) AS Total_Deposit
    FROM Financial_Transactions
    WHERE Transaction_Type = 'Deposit'
    GROUP BY Account_Holder, Currency
), Max_Deposits AS (
    SELECT 
        Currency, 
        MAX(Total_Deposit) AS Max_Deposit
    FROM Currency_Deposits
    GROUP BY Currency
)
SELECT 
    c.Account_Holder, 
    c.Currency, 
    c.Total_Deposit
FROM Currency_Deposits c
JOIN Max_Deposits m 
ON c.Currency = m.Currency AND c.Total_Deposit = m.Max_Deposit;


/#  Q.3 Identify Accounts with More Withdrawals than Deposits? #/

SELECT 
    Account_Holder, 
    Currency, 
    SUM(CASE WHEN Transaction_Type = 'Deposit' THEN Amount ELSE 0 END) AS Total_Deposits,
    SUM(CASE WHEN Transaction_Type = 'Withdrawal' THEN Amount ELSE 0 END) AS Total_Withdrawals
FROM Financial_Transactions
GROUP BY Account_Holder, Currency
HAVING SUM(CASE WHEN Transaction_Type = 'Withdrawal' THEN Amount ELSE 0 END) > 
       SUM(CASE WHEN Transaction_Type = 'Deposit' THEN Amount ELSE 0 END);


/#  Q.4 Find the Most Common Transaction Mode per Currency? #/

SELECT Currency, Transaction_Mode, Transaction_Count
FROM (
    SELECT 
        Currency, 
        Transaction_Mode, 
        COUNT(*) AS Transaction_Count,
        RANK() OVER (PARTITION BY Currency ORDER BY COUNT(*) DESC) AS rnk
    FROM Financial_Transactions
    GROUP BY Currency, Transaction_Mode
) AS RankedData
WHERE rnk = 1;


/# Q.5 Find Users Who Made Transactions in Multiple Branch Locations? #/

SELECT Account_Holder, COUNT(DISTINCT Branch_Location) AS Unique_Locations
FROM Financial_Transactions
GROUP BY Account_Holder
HAVING COUNT(DISTINCT Branch_Location) > 1;