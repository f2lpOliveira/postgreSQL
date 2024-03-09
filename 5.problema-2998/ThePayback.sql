-- https://www.beecrowd.com.br/judge/pt/problems/view/2998

WITH CumulativeProfit AS (
    SELECT
        c.name,
        c.investment,
        o.month,
        SUM(o.profit) OVER (PARTITION BY c.id ORDER BY o.month) AS cumulative_profit
    FROM clients c
             INNER JOIN operations o ON o.client_id = c.id
),
     PaybackMonth AS (
         SELECT
             name,
             investment,
             month,
             cumulative_profit,
             ROW_NUMBER() OVER (PARTITION BY name ORDER BY month) AS row_num
         FROM CumulativeProfit
         WHERE cumulative_profit >= investment
     )
SELECT
    name,
    investment,
    month AS month_of_payback,
    cumulative_profit - investment AS return
FROM PaybackMonth
WHERE row_num = 1
ORDER BY return DESC;