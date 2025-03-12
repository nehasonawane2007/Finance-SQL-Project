💰 Financial Transactions SQL Scripts

🚀 Overview
Welcome to the Financial Transactions SQL Scripts repository! This collection of SQL scripts is designed to help you efficiently manage, analyze, and extract insights from financial transaction data. 
The scripts cover database schema creation, data population, and powerful analytical queries to uncover financial trends and summaries.


📂 Files Included
📌 Create_Table_Insert_Data.sql – Defines the Financial_Transactions table and inserts sample records.

📌 Queries.sql – Contains advanced SQL queries for financial analysis and reporting.


🏦 Database Schema

The Financial_Transactions table stores transaction details with the following attributes:

Transaction_ID:     An integer that uniquely identifies each transaction (Primary Key).

Transaction_Date:  The date when the transaction occurred.

Account_Holder:    A string representing the name of the account holder.

Transaction_Type:  Specifies whether the transaction is a Deposit or Withdrawal.

Amount:            The monetary value of the transaction, stored as a decimal number.

Currency:          The type of currency used in the transaction (e.g., USD, EUR).

Balance: T         he account balance after the transaction.

Transaction_Mode:  The method of transaction execution, such as Online, Cash, etc.

Branch_Location:   The branch where the transaction was processed.

Remarks:           Additional details or comments related to the transaction.




📊 Analytical Queries & Insights

The Queries.sql file includes a collection of powerful analytical queries to help derive insights:

🔹 1️⃣ Running Balance Calculation

Computes the running balance for each account holder over time.

Helps track cash flow trends and account activity.

🔹 2️⃣ Monthly Transaction Summary

Aggregates total deposits and withdrawals per month.

Useful for financial trend analysis and budgeting.

🔹 3️⃣ Top 5 Highest Transactions

Identifies the top 5 highest-value transactions.

Helps in detecting major financial movements.

🔹 4️⃣ Account Holder Insights

Provides a detailed breakdown of transactions per account holder.

Useful for analyzing individual spending or saving behavior.


⚙️ How to Use

💾 Prerequisites

Ensure you have a SQL database engine installed, such as:
✅ MySQL
✅ PostgreSQL
✅ SQL Server

▶️ Execution Steps

1️⃣ Run Create_Table_Insert_Data.sql to create the table and populate it with sample data.
2️⃣ Run Queries.sql to generate insights and analyze transaction patterns.


* 👨‍💻 Author

📌 [Neha Sonawane] – Passionate about data analytics and financial insights.
🔍 Happy Querying! 🚀📊
