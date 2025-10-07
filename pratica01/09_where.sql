-- Lista de produtos com nome que começa com "Venda de"

SELECT IdProduto, DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE 'Venda de%'