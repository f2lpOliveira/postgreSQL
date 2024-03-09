-- https://www.beecrowd.com.br/judge/pt/problems/view/2616

SELECT customers.id, customers.name
FROM customers
LEFT JOIN locations ON customers.id = locations.id_customers
WHERE locations.id_customers is NULL;