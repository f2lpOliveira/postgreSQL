-- https://www.beecrowd.com.br/judge/pt/problems/view/2738

SELECT c.name,
ROUND((s.math * 0.2 + s.specific * 0.3 + s.project_plan * 0.5), 2) AS avg
FROM candidate c
JOIN score s ON c.id = s.candidate_id
ORDER BY avg DESC;