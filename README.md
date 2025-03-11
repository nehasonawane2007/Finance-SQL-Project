# SQL Project Overview: Financial Transactions Analysis:
Project Description:
This SQL project involves managing and analyzing financial transactions of multiple account holders across various currencies, transaction modes, and branch locations.
The dataset is structured in a single table, Financial_Transactions, which records deposits and withdrawals.


# Database Design:
The Financial_Transactions table contains the following fields:
Transaction_ID (Primary Key)
Transaction_Date
Account_Holder
Transaction_Type (Deposit/Withdrawal)
Amount
Currency (USD, AED, INR, etc.)
Balance (After transaction)
Transaction_Mode (Bank Transfer, UPI, Cash, Credit Card, etc.)
Branch_Location
Remarks (Description of transaction)


# Use Case & Business Insights:
Banking & Financial Analytics: Helps in tracking financial trends and identifying spending patterns.
Fraud Detection: Identifies unusual transaction behavior like frequent high withdrawals.
Customer Segmentation: Understands user preferences for different transaction modes and branch locations.
Currency Exchange Analysis: Monitors deposits and withdrawals across different currencies.


# Created Table

CREATE TABLE Financial_Transactions (
    Transaction_ID INT PRIMARY KEY,
    Transaction_Date DATE,
    Account_Holder VARCHAR(50),
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(10,2),
    Currency VARCHAR(10),
    Balance DECIMAL(12,2),
    Transaction_Mode VARCHAR(30),
    Branch_Location VARCHAR(50),
    Remarks VARCHAR(100)
);


# Inserted Data into Table

INSERT INTO Financial_Transactions 
(Transaction_ID, Transaction_Date, Account_Holder, Transaction_Type, Amount, Currency, Balance, Transaction_Mode, Branch_Location, Remarks) 
VALUES
(1, '2024-01-05', 'Alice Smith', 'Deposit', 5000, 'USD', 10000, 'Bank Transfer', 'New York', 'Salary Deposit'),
(2, '2024-01-07', 'Bob Johnson', 'Withdrawal', 2000, 'AED', 6000, 'Cash', 'Dubai', 'ATM Withdrawal'),
(3, '2024-01-10', 'Charlie Brown', 'Deposit', 8000, 'INR', 15000, 'UPI', 'Mumbai', 'Business Income'),
(4, '2024-01-12', 'Alice Smith', 'Withdrawal', 3000, 'USD', 7000, 'Credit Card', 'Los Angeles', 'Shopping Expense'),
(5, '2024-01-15', 'David White', 'Deposit', 10000, 'AED', 20000, 'Bank Transfer', 'Abu Dhabi', 'Investment Return'),
(6, '2024-01-17', 'Bob Johnson', 'Deposit', 3000, 'INR', 9000, 'UPI', 'Bangalore', 'Freelance Payment'),
(7, '2024-01-20', 'Charlie Brown', 'Withdrawal', 5000, 'USD', 10000, 'Cash', 'San Francisco', 'Rent Payment'),
(8, '2024-01-23', 'Alice Smith', 'Deposit', 2000, 'AED', 9000, 'Credit Card', 'Dubai', 'Cashback Bonus'),
(9, '2024-01-25', 'David White', 'Withdrawal', 4000, 'INR', 16000, 'Bank Transfer', 'Delhi', 'Loan EMI Payment'),
(10, '2024-01-27', 'Bob Johnson', 'Deposit', 7000, 'USD', 16000, 'UPI', 'Chicago', 'Freelance Payment'),
(11, '2024-01-30', 'Charlie Brown', 'Deposit', 6000, 'AED', 16000, 'Bank Transfer', 'Sharjah', 'Business Income'),
(12, '2024-02-02', 'Alice Smith', 'Withdrawal', 1500, 'INR', 7500, 'Cash', 'Houston', 'ATM Withdrawal'),
(13, '2024-02-05', 'David White', 'Deposit', 5000, 'USD', 21000, 'Credit Card', 'Washington DC', 'Salary Deposit'),
(14, '2024-02-08', 'Bob Johnson', 'Withdrawal', 1000, 'AED', 15000, 'Bank Transfer', 'Doha', 'Utility Bill'),
(15, '2024-02-10', 'Charlie Brown', 'Deposit', 2500, 'INR', 18500, 'UPI', 'Kolkata', 'Cashback Bonus'),
(16, '2024-02-12', 'Alice Smith', 'Withdrawal', 1200, 'USD', 6300, 'Cash', 'Boston', 'Groceries Expense'),
(17, '2024-02-15', 'David White', 'Deposit', 6000, 'AED', 27000, 'Bank Transfer', 'Riyadh', 'Business Investment'),
(18, '2024-02-17', 'Bob Johnson', 'Withdrawal', 3500, 'INR', 11500, 'Credit Card', 'Pune', 'Shopping'),
(19, '2024-02-20', 'Charlie Brown', 'Deposit', 4500, 'USD', 23000, 'UPI', 'Miami', 'Online Sale'),
(20, '2024-02-22', 'Alice Smith', 'Deposit', 3000, 'AED', 9300, 'Bank Transfer', 'Abu Dhabi', 'Savings Deposit');


# Q.1 Find the Running Balance for Each Account Holder Over Time?

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


# Q.2 Find Account Holders with the Highest Total Deposits in Each Currency?

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


# Q.3 Identify Accounts with More Withdrawals than Deposits?

SELECT 
    Account_Holder, 
    Currency, 
    SUM(CASE WHEN Transaction_Type = 'Deposit' THEN Amount ELSE 0 END) AS Total_Deposits,
    SUM(CASE WHEN Transaction_Type = 'Withdrawal' THEN Amount ELSE 0 END) AS Total_Withdrawals
FROM Financial_Transactions
GROUP BY Account_Holder, Currency
HAVING SUM(CASE WHEN Transaction_Type = 'Withdrawal' THEN Amount ELSE 0 END) > 
       SUM(CASE WHEN Transaction_Type = 'Deposit' THEN Amount ELSE 0 END);


# Q.4 Find the Most Common Transaction Mode per Currency?

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


# Q.5 Find Users Who Made Transactions in Multiple Branch Locations?

SELECT Account_Holder, COUNT(DISTINCT Branch_Location) AS Unique_Locations
FROM Financial_Transactions
GROUP BY Account_Holder
HAVING COUNT(DISTINCT Branch_Location) > 1;
