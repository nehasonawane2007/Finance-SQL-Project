# SQL Project Overview: Financial Transactions Analysis:
Project Description:
This SQL project involves managing and analyzing financial transactions of multiple account holders across various currencies, transaction modes, and branch locations.
The dataset is structured in a single table, Financial_Transactions, which records deposits and withdrawals.


# Database Design:
The Financial_Transactions table contains the following fields:
Transaction_ID (Primary Key),
Transaction_Date,
Account_Holder,
Transaction_Type (Deposit/Withdrawal),
Amount,
Currency (USD, AED, INR, etc.),
Balance (After transaction),
Transaction_Mode (Bank Transfer, UPI, Cash, Credit Card, etc.),
Branch_Location,
Remarks (Description of transaction)


# Use Case & Business Insights:
Banking & Financial Analytics: Helps in tracking financial trends and identifying spending patterns.
Fraud Detection: Identifies unusual transaction behavior like frequent high withdrawals.
Customer Segmentation: Understands user preferences for different transaction modes and branch locations.
Currency Exchange Analysis: Monitors deposits and withdrawals across different currencies.
