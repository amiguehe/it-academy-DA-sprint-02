USE transactions;
#ex1

SELECT
company_name,
country,
sum(amount)
FROM
  company,
  LATERAL
  (SELECT amount, company_id
    FROM transaction
    WHERE transaction.company_id = company.id)
  AS ger_country
  WHERE country = "germany"
  GROUP BY company_name, country, amount
  ORDER BY amount DESC;

  SELECT
*
FROM
  transaction,
  LATERAL
  (SELECT company_name
    FROM company
    WHERE transaction.company_id = company.id
    and country = "germany"
    group by company_name)
  AS c_country
  group by transaction.id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined, company_name
  order by company_name desc;

SELECT DISTINCT
    (company_id), amount
FROM
    transaction
WHERE
    company_id IN (SELECT 
            company_id
        FROM
            transaction UNION ALL SELECT 
            id
        FROM
            company)
        AND amount > (SELECT 
            AVG(amount)
        FROM
            transaction)
GROUP BY company_id , amount
ORDER BY amount DESC;

  SELECT
*
FROM
  transaction,
  LATERAL
  (SELECT company_name, company.id
    FROM company
    WHERE transaction.company_id = company.id)
  AS avg_order
  WHERE amount > (SELECT avg(amount) from transaction)
  GROUP BY transaction.id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined
  ORDER BY amount DESC;

#ex 3


  SELECT
*
FROM
  transaction,
  LATERAL
  (SELECT company_name, company.id
    FROM company
    WHERE transaction.company_id = company.id
    AND company_name LIKE "C%")
  AS c_country
  GROUP BY transaction.id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined
  ORDER BY company_name DESC;
  
  
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

                    
#ex2.1 (senar institute es non institute)

  
  SELECT
*
FROM
  transaction,
  LATERAL
  (SELECT company_name, company.id, country
    FROM company
    WHERE transaction.company_id = company.id
    AND country = "united kingdom"
    AND company_name not in ("non institute"))
  AS c_country
  GROUP BY transaction.id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined
  ORDER BY company_name DESC;

SELECT 
    company_name, company.id
FROM
    company
WHERE
    (company.id) = (SELECT 
            company_id
        FROM
            transaction
        ORDER BY amount DESC
        LIMIT 1);

  
#ex3.1
SELECT
  DISTINCT(country),
  AVG(amount)
FROM
  company,
  LATERAL
  (SELECT amount, company_id
    FROM transaction
    WHERE transaction.company_id = company.id)
  AS max_sale
  WHERE amount > (SELECT AVG(amount) from transaction)
  GROUP BY country
  ORDER BY AVG(amount) DESC;
  
SELECT 
    company_id,
    SUM(amount),
    COUNT(*),
    IF(COUNT(*) >= 4,
        'más de cuatro pedidos',
        'menos de cuatro pedidos') AS mas_o_menos
FROM
    (SELECT 
        company_id, amount, user_id
    FROM
        transaction UNION SELECT 
        id, company_name, country
    FROM
        company) AS Allorders
GROUP BY company_id
ORDER BY COUNT(*) DESC;