-- Qual a cadetogria de produto mais vendida?

SELECT 
        t2.DescCategoriaProduto,
        SUM(t1.QtdeProduto) AS TotalVendido

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

GROUP BY DescCategoriaProduto

ORDER BY TotalVendido DESC
