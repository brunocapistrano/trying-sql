-- Quantos produtos são de RPG?

SELECT DescCategoriaProduto, count(*) AS TotalProdutos 
FROM produtos
GROUP BY DescCategoriaProduto;