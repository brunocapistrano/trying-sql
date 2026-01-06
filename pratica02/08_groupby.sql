-- qual o produto mais transacionado?

SELECT  IdProduto, 
        COUNT(IdProduto) AS TotalProdutos

FROM transacao_produto

GROUP BY IdProduto
ORDER BY 2 DESC
LIMIT 1;



SELECT  IdProduto,
        SUM(QtdeProduto) AS TotalProdutos
FROM transacao_produto
GROUP BY IdProduto
ORDER BY 2 DESC
LIMIT 1;