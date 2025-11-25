SELECT * FROM churn_modelling;

ALTER TABLE churn_modelling
DROP COLUMN RowNumber;

ALTER TABLE churn_modelling
DROP COLUMN CustomerId;

ALTER TABLE churn_modelling
DROP COLUMN Surname;

SET SQL_SAFE_UPDATES=0;


-- Categorising male and female 
UPDATE churn_modelling
SET Gender=1
WHERE Gender='Female';

UPDATE churn_modelling
SET Gender = 0
WHERE Gender='Male';

SELECT DISTINCT Gender
FROM churn_modelling;

-- Categorising Geography
UPDATE churn_modelling
SET Geography =
CASE 
	WHEN Geography='France' THEN 1
    WHEN Geography='Spain' THEN 0
    WHEN Geography='Germany' THEN 2
END;

SELECT DISTINCT Geography 
From churn_modelling;

-- Checking for null Values
SELECT COUNT(*) AS Missing
FROM churn_modelling
WHERE CreditScore IS NULL OR
Geography IS NULL OR
Gender IS NULL OR
Age IS NULL OR
Tenure IS NULL OR
Balance IS NULL OR
NumOfProducts IS NULL OR
HasCrCard IS NULL OR
IsActiveMember IS NULL OR
EstimatedSalary IS NULL OR
Exited IS NULL;
