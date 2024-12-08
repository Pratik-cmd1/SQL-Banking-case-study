CREATE DATABASE BANK;
USE BANK;
-- sequence of creating tables  1] Customers 2] Branches 3] Accounts 4] Transactions 5] Loans 6] CreditCards

-- 1] first table Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female'),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50)
);

INSERT INTO Customers (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, Address, City, State, PostalCode, Country)
VALUES 
('John', 'Doe', '1980-05-15', 'Male', 'john.doe@example.com', '555-1234', '123 Main St.', 'New York', 'NY', '10001', 'USA'),
('Jane', 'Smith', '1975-09-23', 'Female', 'jane.smith@example.com', '555-5678', '456 Oak St.', 'Los Angeles', 'CA', '90001', 'USA'),
('Mike', 'Johnson', '1988-11-12', 'Male', 'mike.johnson@example.com', '555-8765', '789 Pine St.', 'Chicago', 'IL', '60601', 'USA'),
('Emily', 'Davis', '1992-03-02', 'Female', 'emily.davis@example.com', '555-4321', '321 Elm St.', 'Houston', 'TX', '77001', 'USA'),
('Robert', 'Brown', '1970-07-07', 'Male', 'robert.brown@example.com', '555-9876', '654 Maple St.', 'Phoenix', 'AZ', '85001', 'USA');


-- 2] second table Branches
CREATE TABLE Branches (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    ManagerName VARCHAR(100),
    PhoneNumber VARCHAR(15)
);


INSERT INTO Branches (BranchName, City, State, Country, ManagerName, PhoneNumber)
VALUES 
('Downtown Branch', 'New York', 'NY', 'USA', 'Linda Williams', '555-1212'),
('Westside Branch', 'Los Angeles', 'CA', 'USA', 'Kevin Johnson', '555-3434'),
('Uptown Branch', 'Chicago', 'IL', 'USA', 'Rachel Adams', '555-5656');

-- 3] third table accounts 
CREATE TABLE Accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BranchID INT,
    AccountType ENUM('Savings', 'Checking'),
    Balance DECIMAL(15, 2),
    DateOpened DATE,
    Status ENUM('Active', 'Inactive', 'Closed'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

INSERT INTO Accounts (CustomerID, BranchID, AccountType, Balance, DateOpened, Status)
VALUES 
(1, 1, 'Savings', 15000.00, '2015-01-15', 'Active'),
(2, 2, 'Checking', 1200.00, '2016-03-20', 'Active'),
(3, 1, 'Savings', 8500.00, '2017-07-22', 'Active'),
(4, 3, 'Checking', 3100.00, '2018-11-10', 'Active'),
(5, 1, 'Savings', 4700.00, '2019-05-15', 'Closed');


-- 4] fourth table Transactions

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT,
    TransactionType ENUM('Deposit', 'Withdrawal', 'Transfer'),
    Amount DECIMAL(15, 2),
    Date DATE,
    Description VARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
INSERT INTO Transactions (AccountID, TransactionType, Amount, Date, Description)
VALUES 
(1, 'Deposit', 5000.00, '2023-01-05', 'Payroll Deposit'),
(2, 'Withdrawal', 200.00, '2023-01-10', 'ATM Withdrawal'),
(3, 'Transfer', 1500.00, '2023-01-12', 'Transfer to Checking Account'),
(4, 'Deposit', 1000.00, '2023-01-15', 'Check Deposit'),
(1, 'Withdrawal', 800.00, '2023-01-18', 'Bill Payment - Electricity'),
(3, 'Deposit', 1200.00, '2023-01-20', 'Interest Credit'),
(5, 'Deposit', 700.00, '2023-01-22', 'Refund');


-- 5] fifth table Loans

CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BranchID INT,
    LoanType ENUM('Home Loan', 'Personal Loan', 'Car Loan', 'Education Loan'),
    LoanAmount DECIMAL(15, 2),
    InterestRate DECIMAL(5, 2),
    StartDate DATE,
    EndDate DATE,
    Status ENUM('Active', 'Closed'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);


INSERT INTO Loans (CustomerID, BranchID, LoanType, LoanAmount, InterestRate, StartDate, EndDate, Status)
VALUES 
(1, 1, 'Home Loan', 250000.00, 3.5, '2018-06-15', '2038-06-15', 'Active'),
(2, 2, 'Personal Loan', 15000.00, 7.0, '2019-01-10', '2024-01-10', 'Active'),
(4, 3, 'Car Loan', 30000.00, 5.0, '2020-11-05', '2025-11-05', 'Active'),
(3, 1, 'Education Loan', 20000.00, 6.5, '2021-07-01', '2026-07-01', 'Active'),
(5, 2, 'Personal Loan', 10000.00, 8.0, '2017-09-20', '2022-09-20', 'Closed');


-- 6] sixth table CreditCards

CREATE TABLE CreditCards (
    CardID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CardType ENUM('Visa', 'MasterCard', 'AmericanExp', 'Discover'),
    CardNumber VARCHAR(16),
    ExpiryDate DATE,
    CVV INT,
    CreditLimit DECIMAL(15, 2),
    OutstandingBalance DECIMAL(15, 2),
    Status ENUM('Active', 'Closed'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO CreditCards (CustomerID, CardType, CardNumber, ExpiryDate, CVV, CreditLimit, OutstandingBalance, Status)
VALUES 
(1, 'Visa', '4111111111111111', '2025-11-01', 123, 5000.00, 1500.00, 'Active'),
(2, 'MasterCard', '5500000000000004', '2024-09-01', 456, 3000.00, 1000.00, 'Active'),
(3, 'AmericanExp', '340000000000009', '2026-01-01', 789, 7000.00, 4500.00, 'Active'),
(4, 'Discover', '6011000000000004', '2025-03-01', 234, 6000.00, 1200.00, 'Active'),
(5, 'Visa', '4111111111111112', '2023-07-01', 345, 4000.00, 300.00, 'Closed');

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Branches;
SELECT * FROM CreditCards;




/*                                     **********Basic SQL Questions and Queries**********                                      */




-- 1] List all customers in the database.
SELECT * FROM Customers;

-- 2] Show the details of all savings accounts.
SELECT * FROM Accounts WHERE AccountType = 'Savings';

-- 3] Find all transactions greater than $1,000.
SELECT * FROM Transactions WHERE Amount > 1000;

-- 4] List all loans that are currently active.
SELECT * FROM Loans WHERE Status = 'Active';

-- 5] Get the details of all branches in New York.
SELECT * FROM Branches WHERE City = 'New York';

-- 6] Find all customers who have a checking account.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
WHERE a.AccountType = 'Checking';

-- 7] Display the total number of accounts.
SELECT COUNT(*) AS TotalAccounts FROM Accounts;

-- 8] Show all credit cards that are active.
SELECT * FROM CreditCards WHERE Status = 'Active';

-- 9] Find all loans with an interest rate greater than 5%.
SELECT * FROM Loans WHERE InterestRate > 5;

-- 10] Display the name and contact information for all customers.
SELECT FirstName, LastName, Email, PhoneNumber FROM Customers;





/*                                **********Intermediate SQL Questions and Queries**********                                     */




-- 1] Find the total number of transactions made by each customer.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(t.TransactionID) AS TotalTransactions
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY c.CustomerID;

-- 2] Calculate the total balance in savings accounts for each branch.
SELECT b.BranchID, b.BranchName, SUM(a.Balance) AS TotalSavingsBalance
FROM Branches b
JOIN Accounts a ON b.BranchID = a.BranchID
WHERE a.AccountType = 'Savings'
GROUP BY b.BranchID;

-- 3] List customers who have both a savings and a checking account.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Accounts a WHERE a.CustomerID = c.CustomerID AND a.AccountType = 'Savings'
) AND EXISTS (
    SELECT 1 FROM Accounts a WHERE a.CustomerID = c.CustomerID AND a.AccountType = 'Checking'
);

-- 4] Find the top 3 branches with the highest total loan amount.
SELECT b.BranchID, b.BranchName, SUM(l.LoanAmount) AS TotalLoanAmount
FROM Branches b
JOIN Loans l ON b.BranchID = l.BranchID
GROUP BY b.BranchID
ORDER BY TotalLoanAmount DESC
LIMIT 3;

-- 5] Calculate the average loan amount for each loan type.
SELECT LoanType, AVG(LoanAmount) AS AverageLoanAmount
FROM Loans
GROUP BY LoanType;

-- 6] Find customers with an outstanding credit card balance greater than their savings account balance.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID AND a.AccountType = 'Savings'
JOIN CreditCards cc ON c.CustomerID = cc.CustomerID
WHERE cc.OutstandingBalance > a.Balance;


-- 7] List the total number of accounts for each customer and sort by the total number of accounts in descending order.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(a.AccountID) AS TotalAccounts
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalAccounts DESC;

-- 8] Find all customers whose loan repayment is overdue by more than 60 days.
 SELECT c.CustomerID, c.FirstName, c.LastName, l.LoanID
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID
WHERE DATEDIFF(CURDATE(), l.EndDate) > 60 AND l.Status = 'Active';

-- 9] Calculate the total revenue generated from loan interest for each branch.
SELECT b.BranchID, b.BranchName, SUM(l.LoanAmount * (l.InterestRate / 100)) AS TotalInterestRevenue
FROM Branches b
JOIN Loans l ON b.BranchID = l.BranchID
GROUP BY b.BranchID;

-- 10] Find customers who have made more than 5 transactions in the last month.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(t.TransactionID) AS TransactionsLastMonth
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.Date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.CustomerID
HAVING TransactionsLastMonth > 5;


-- 11] Find the total number of active credit cards and their average credit limit.
SELECT COUNT(*) AS TotalActiveCreditCards, AVG(CreditLimit) AS AverageCreditLimit
FROM CreditCards
WHERE Status = 'Active';


-- 12] Calculate the total loan amount for each customer and sort by the total loan amount in descending order.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(l.LoanAmount) AS TotalLoanAmount
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalLoanAmount DESC;

-- 13] Find all branches that have more than 10 active loans.
SELECT b.BranchID, b.BranchName, COUNT(l.LoanID) AS ActiveLoans
FROM Branches b
JOIN Loans l ON b.BranchID = l.BranchID
WHERE l.Status = 'Active'
GROUP BY b.BranchID
HAVING ActiveLoans > 10;

-- 14] List all customers who have no active accounts.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
WHERE a.Status IS NULL OR a.Status <> 'Active';

-- 15] Find the highest and lowest balance among all savings accounts.
SELECT MAX(Balance) AS HighestSavingsBalance, MIN(Balance) AS LowestSavingsBalance
FROM Accounts
WHERE AccountType = 'Savings';

-- 16] Calculate the total number of customers for each state.
SELECT State, COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY State;


-- 17] List all transactions along with customer names and account types.
SELECT t.TransactionID, t.TransactionType, t.Amount, c.FirstName, c.LastName, a.AccountType
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
JOIN Customers c ON a.CustomerID = c.CustomerID;


-- 18] Find the customer with the highest total loan amount.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(l.LoanAmount) AS TotalLoanAmount
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalLoanAmount DESC
LIMIT 1;

-- 19] Find all customers whose phone numbers are missing.
SELECT * FROM Customers WHERE PhoneNumber IS NULL;

-- 20] Calculate the total outstanding balance of all active credit cards.
SELECT SUM(OutstandingBalance) AS TotalOutstandingBalance
FROM CreditCards
WHERE Status = 'Active';


-- 21] Find the top 5 customers with the highest total account balance.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(a.Balance) AS TotalBalance
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalBalance DESC
LIMIT 5;


-- 22] Find all accounts that have been inactive for more than 1 year.
SELECT * FROM Accounts WHERE Status = 'Inactive' AND DATEDIFF(CURDATE(), DateOpened) > 365;


-- 23] Calculate the total number of deposits and withdrawals for each account.
SELECT AccountID, 
       SUM(CASE WHEN TransactionType = 'Deposit' THEN 1 ELSE 0 END) AS TotalDeposits,
       SUM(CASE WHEN TransactionType = 'Withdrawal' THEN 1 ELSE 0 END) AS TotalWithdrawals
FROM Transactions
GROUP BY AccountID;


-- 24] Find all customers who have never taken a loan.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
LEFT JOIN Loans l ON c.CustomerID = l.CustomerID
WHERE l.LoanID IS NULL;


-- 25] Find the average outstanding balance on credit cards for each customer.
SELECT c.CustomerID, c.FirstName, c.LastName, AVG(cc.OutstandingBalance) AS AverageOutstandingBalance
FROM Customers c
JOIN CreditCards cc ON c.CustomerID = cc.CustomerID
GROUP BY c.CustomerID;


-- 26] Identify customers with more than two active loans.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(l.LoanID) AS ActiveLoans
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID
WHERE l.Status = 'Active'
GROUP BY c.CustomerID
HAVING ActiveLoans > 2;


-- 27] Find all transactions for customers in New York.
SELECT t.*
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE c.City = 'New York';


-- 28] Calculate the total interest paid by each customer.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(l.LoanAmount * (l.InterestRate / 100)) AS TotalInterestPaid
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID;


-- 29] Find all loans that have been closed in the last year.
SELECT * FROM Loans WHERE Status = 'Closed' AND EndDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);


-- 30] Find the customer with the lowest total outstanding balance across all credit cards.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(cc.OutstandingBalance) AS TotalOutstandingBalance
FROM Customers c
JOIN CreditCards cc ON c.CustomerID = cc.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalOutstandingBalance ASC
LIMIT 1;


-- 31] Identify customers with credit utilization above 80%.
SELECT c.CustomerID, c.FirstName, c.LastName, 
       (cc.OutstandingBalance / cc.CreditLimit) * 100 AS UtilizationRate
FROM Customers c
JOIN CreditCards cc ON c.CustomerID = cc.CustomerID
HAVING UtilizationRate > 80;


-- 32] Find all branches that have issued more than 50 credit cards.
SELECT b.BranchID, b.BranchName, COUNT(cc.CardID) AS TotalCreditCards
FROM Branches b
JOIN Customers c ON b.BranchID = c.BranchID
JOIN CreditCards cc ON c.CustomerID = cc.CustomerID
GROUP BY b.BranchID
HAVING TotalCreditCards > 50;


-- 33] Find all transactions where the description contains "Bill Payment".
SELECT * FROM Transactions WHERE Description LIKE '%Bill Payment%';


-- 34] Calculate the total balance of all inactive accounts.
SELECT SUM(Balance) AS TotalInactiveBalance FROM Accounts WHERE Status = 'Inactive';


-- 35] Find all customers who have more than one credit card.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(cc.CardID) AS TotalCreditCards
FROM Customers c
JOIN CreditCards cc ON c.CustomerID = cc.CustomerID
GROUP BY c.CustomerID
HAVING TotalCreditCards > 1;


-- 36] List the top 5 most recent transactions for a specific customer (CustomerID = 1).
SELECT * FROM Transactions
WHERE AccountID IN (SELECT AccountID FROM Accounts WHERE CustomerID = 1)
ORDER BY Date DESC
LIMIT 5;


-- 37] Find the average loan duration for each loan type.
SELECT LoanType, AVG(DATEDIFF(EndDate, StartDate)) AS AverageDuration
FROM Loans
GROUP BY LoanType;


-- 38] Identify branches with no active customers.
SELECT b.BranchID, b.BranchName
FROM Branches b
LEFT JOIN Accounts a ON b.BranchID = a.BranchID
WHERE a.Status IS NULL OR a.Status <> 'Active';


-- 39] Calculate the average transaction amount for deposits and withdrawals separately.
SELECT TransactionType, AVG(Amount) AS AverageAmount
FROM Transactions
GROUP BY TransactionType;


-- 40] List all customers who have both an active loan and an active credit card.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Loans l WHERE l.CustomerID = c.CustomerID AND l.Status = 'Active'
) AND EXISTS (
    SELECT 1 FROM CreditCards cc WHERE cc.CustomerID = c.CustomerID AND cc.Status = 'Active'
);
















