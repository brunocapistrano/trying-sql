-- SELECT IdProduto,count(*) FROM transacao_produto
-- GROUP BY IdProduto 

SELECT  IdCliente, 
        SUM(QtdePontos) AS TotalPontos, 
        COUNT(IdTransacao) AS TotalTransacoes
    FROM transacoes
WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao < '2025-08-01'
GROUP BY IdCliente
ORDER BY SUM(QtdePontos) DESC