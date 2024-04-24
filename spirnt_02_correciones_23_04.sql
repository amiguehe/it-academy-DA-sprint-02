USE transactions;
#ex1

SELECT
 company_name,
 country,
  (
    SELECT COUNT(amount)
    FROM transaction
    WHERE company.id = company_id
  ) AS total_orders
FROM company
WHERE country = "germany"
order by total_orders desc;


#ex 2 
SELECT 
    company_id, SUM(amount)
FROM
    transaction
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            transaction)
        AND company_id IN (SELECT 
            company.id
        FROM
            company)
GROUP BY company_id
ORDER BY SUM(amount) DESC; 

#ex 3

SELECT
 *,
  (
    SELECT company_name 
    FROM company
    WHERE company_name LIKE "C%"
    AND company.id = company_id
  ) as company
  FROM transaction
where   (
    SELECT company_name 
    FROM company
    WHERE company_name LIKE "C%"
    AND company.id = company_id
  ) is not null;
  
  #ex4
  
SELECT DISTINCT
    company_name, company.id
FROM
    company
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            transaction
        WHERE
            company.id = company_id);
            
#ex 2.1

#70 resultados

SELECT
 *,
  (
    SELECT company_name 
    FROM company
    WHERE company.id = company_id
    AND country = (SELECT country FROM company WHERE company_name ="Non institute")
    AND company_name not in ("non institute")
  ) as results
FROM transaction
where (
    SELECT company_name 
    FROM company
    WHERE company.id = company_id
    AND country = (SELECT country FROM company WHERE company_name ="Non institute")
    AND company_name not in ("non institute")
  ) is not null;
  
# 100 resultados

SELECT
 *,
  (
    SELECT company_name 
    FROM company
    WHERE company.id = company_id
    AND country = (SELECT country FROM company WHERE company_name ="Non institute")
  ) as results
FROM transaction
where (
    SELECT company_name 
    FROM company
    WHERE company.id = company_id
    AND country = (SELECT country FROM company WHERE company_name ="Non institute")
  ) is not null;


  #ex 2.2

SELECT
 amount,
  (
    SELECT company_name 
    FROM company
    WHERE company.id = company_id
  ) AS company
FROM transaction
WHERE amount = (SELECT MAX(amount) FROM transaction);