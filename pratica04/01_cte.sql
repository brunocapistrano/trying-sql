-- Como foi a curva de Churn do curso de sql?

-- SELECT  count(DISTINCT IdCliente) AS QtDeClientes,
--         DtCriacao,
--         substr(DtCriacao, 1, 10) as Data

-- FROM transacoes

-- WHERE DtCriacao >= '2025-08-25' 
-- AND DtCriacao < '2025-08-30'

-- GROUP BY Data


WITH tb_clientes_d1 AS (

    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25' 
    AND DtCriacao < '2025-08-26'

)

SELECT   substr(t2.DtCriacao,1,10) AS DataDaTransacao,
         COUNT(DISTINCT t1.IdCliente) AS QtDeTransacoesNoPeriodo

FROM tb_clientes_d1 AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

WHERE t2.DtCriacao >= '2025-08-25' 
AND t2.DtCriacao < '2025-08-30'

GROUP BY DataDaTransacao