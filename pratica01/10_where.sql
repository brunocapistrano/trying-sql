-- Lista de produtos que terminam com "Lover"

SELECT IdProduto, DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE '%Lover'