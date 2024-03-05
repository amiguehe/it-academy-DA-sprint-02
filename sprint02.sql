#ex1

select company.country, company.id, company_name, transaction.amount from company
join transaction on company_id = company.id
and company.country ="Germany"
group by company.country, company.id, company_name, transaction.amount
order by amount desc;

#ex2
select avg(amount) from transaction;
	#avg total amount = 256,735520
select company.company_name, company.id, company.country, transaction.amount from company
inner join transaction on transaction.company_id = company.id
where amount > (select avg(amount) from transaction)
order by amount desc;

#ex 3
select company.id, company_name, phone, email, country, website, transaction.amount, date(timestamp) as order_date from company
join transaction on company.id = company_id
and company_name LIKE "C%"
order by transaction.amount desc;

#ex4
SELECT distinct company_name FROM company
  WHERE not EXISTS (SELECT * FROM transaction
                    WHERE company.id = company_id);
                    

#ex2.1 (senar institute es non institute)
select * from company
where company_name = "non institute";
	#country = united kingdom
select distinct company_name, country, transaction.amount, date(timestamp) from company
join transaction
where company_id = company.id
and country = "united kingdom"
order by company_name asc;

#ex2.2
select company_name, transaction.amount from company
inner join transaction 
where transaction.company_id = company.id
order by amount desc limit 1;

#ex3.1
select country, avg(amount) from company
inner join transaction
on transaction.company_id = company.id
where amount > (select avg(amount) from transaction)
group by country
order by avg(amount) desc;

#ex3.2
select company_name, count(transaction.company_id) as num_of_orders, 
if(count(transaction.company_id) >=4, "más de cuatro pedidos", "menos de cuatro pedidos") as mas_o_menos
from company
inner join transaction
on transaction.company_id = company.id
group by company_name
order by num_of_orders desc;
