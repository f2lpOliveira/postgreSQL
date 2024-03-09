-- https://www.beecrowd.com.br/judge/pt/problems/view/2609

SELECT c.name AS categorie, SUM(p.amount) AS sun
FROM categories c
LEFT JOIN products p ON c.id = p.id_categories
GROUP BY c.name;