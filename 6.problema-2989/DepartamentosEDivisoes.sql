-- https://judge.beecrowd.com/pt/problems/view/2989

SELECT
    d.nome AS nome_departamento,
    div.nome AS nome_divisao,
    ROUND(AVG(COALESCE(s.salario, 0)), 2) AS media_salarial,
    MAX(COALESCE(s.salario, 0)) AS maior_salario
FROM
    departamento d
        JOIN
            divisao div ON d.cod_dep = div.cod_dep
    LEFT JOIN
    (
        SELECT
            e.lotacao_div,
            COALESCE(base.valor, 0) - COALESCE(desconto.valor, 0) AS salario
        FROM
            empregado e
        LEFT JOIN
        (
            SELECT
                emp_venc.matr,
                SUM(vencimento.valor) AS valor
            FROM
                emp_venc
            JOIN
                vencimento ON vencimento.cod_venc = emp_venc.cod_venc
            GROUP BY
                emp_venc.matr
        ) AS base ON base.matr = e.matr
        LEFT JOIN
        (
            SELECT
                emp_desc.matr,
                SUM(desconto.valor) AS valor
            FROM
                emp_desc
            JOIN
                desconto ON desconto.cod_desc = emp_desc.cod_desc
            GROUP BY
                emp_desc.matr
        ) AS desconto ON desconto.matr = e.matr
    ) AS s ON s.lotacao_div = div.cod_divisao
GROUP BY
    d.nome, div.nome
ORDER BY
    media_salarial DESC;
