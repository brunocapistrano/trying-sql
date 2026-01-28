-- Dos clientes de Janeiro/2025, quandos assistiram o curso de SQL?

WITH tb_clientes_jan AS (

    SELECT DISTINCT IdCliente

    FROM transacoes

    WHERE DtCriacao >= '2025-01-01'
      AND DtCriacao < '2025-02-01'
)

SELECT  count(DISTINCT t1.IdCliente) AS QtdeClientesSQL,
        count(DISTINCT t2.IdCliente) AS QtdeClientesTotais

FROM tb_clientes_jan AS t1

LEFT JOIN transacoes AS t2
    ON t1.IdCliente = t2.IdCliente
    AND t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30';
