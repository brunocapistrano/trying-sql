-- Em 2024 quantas transações de lovers tivemos?

SELECT  COUNT(DISTINCT t1.IdTransacao) AS TotalTransacoes,
        t3.DescCategoriaProduto
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DtCriacao >= '2024-01-01'
    AND DtCriacao < '2025-01-01'
    AND DescCategoriaProduto = 'lovers'

GROUP BY DescCategoriaProduto;