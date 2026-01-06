-- Qual o produto com mais pontos transacionados?

SELECT IdProduto, SUM(vlProduto)

FROM transacao_produto
GROUP BY IdProduto
ORDER BY 2 DESC
