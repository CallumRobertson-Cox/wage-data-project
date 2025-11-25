-- First Create a Copy 
CREATE TABLE churn_modelling_copy AS
SELECT *
FROM churn_modelling;

-- Salary Ranges
ALTER TABLE churn_modelling_copy
ADD SalaryCategory INT;

-- adding category for salary
UPDATE churn_modelling_copy
SET SalaryCategory=
CASE
    WHEN EstimatedSalary BETWEEN 0 and 25000 THEN 0
    WHEN EstimatedSalary BETWEEN 25000 and 50000 THEN 1
    WHEN EstimatedSalary BETWEEN 50000 and 75000 THEN 2
    WHEN EstimatedSalary BETWEEN 75000 and 100000 THEN 3
    WHEN EstimatedSalary BETWEEN 100000 and 125000 THEN 4
    WHEN EstimatedSalary BETWEEN 125000 and 150000 THEN 5
    WHEN EstimatedSalary BETWEEN 150000 and 175000 THEN 6
    ELSE 7
END
WHERE RowNumber >0;

-- Testing Percentage
SELECT SalaryCategory,
Count(*) AS Amount,
SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) AS Churn_amount,
ROUND(100 * SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) / COUNT(*)) AS Churn_Percentage
FROM churn_modelling_copy
GROUP BY SalaryCategory
ORDER BY Churn_Percentage;

ALTER TABLE churn_modelling_copy
ADD CreditBand INT;

-- Adding Credit Category
UPDATE churn_modelling_copy
SET CreditBand=
CASE 
	WHEN CreditScore BETWEEN 350 and 450 THEN 0
    WHEN CreditScore BETWEEN 450 and 550 THEN 1
    WHEN CreditScore BETWEEN 550 and 650 THEN 2
    WHEN CreditScore BETWEEN 650 and 750 THEN 3
    ELSE 4
END;

-- Testing as a feature 
SELECT CreditBand,
Count(*) AS Amount,
SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) AS Churn_amount,
ROUND(100 * SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) / COUNT(*)) AS Churn_Percentage
FROM churn_modelling_copy
GROUP BY CreditBand
ORDER BY Churn_Percentage;

ALTER TABLE churn_modelling_copy
ADD AgeCat INT;

-- Adding age Category
UPDATE churn_modelling_copy
SET AgeCat=
CASE 
	WHEN age BETWEEN 18 AND 28 THEN 0
    WHEN age BETWEEN 28 AND 38 THEN 1
    WHEN age BETWEEN 38 AND 48 THEN 2
    WHEN age BETWEEN 48 AND 58 THEN 3
    WHEN age BETWEEN 58 AND 68 THEN 4
    WHEN age BETWEEN 68 AND 78 THEN 5
    ELSE 6
END;

-- Testing as a feature 
SELECT AgeCat,
Count(*) AS Amount,
SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) AS Churn_amount,
ROUND(100 * SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) / COUNT(*)) AS Churn_Percentage
FROM churn_modelling_copy
GROUP BY AgeCat
ORDER BY Churn_Percentage;

ALTER TABLE churn_modelling_copy
ADD BalanceCat INT;

UPDATE churn_modelling_copy
SET BalanceCat=
CASE
	WHEN Balance BETWEEN 0 AND 50000 THEN 0
    WHEN Balance BETWEEN 50000 AND 100000 THEN 1
    WHEN Balance BETWEEN 10000 AND 150000 THEN 2
    WHEN Balance BETWEEN 150000 AND 200000 THEN 3
    ELSE 4
END;


-- Testing as a feature 
SELECT BalanceCat,
Count(*) AS Amount,
SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) AS Churn_amount,
ROUND(100 * SUM(CASE WHEN EXITED = 1 THEN 1 ELSE 0 END) / COUNT(*)) AS Churn_Percentage
FROM churn_modelling_copy
GROUP BY BalanceCat
ORDER BY Churn_Percentage;


SELECT *
FROM churn_modelling_copy;