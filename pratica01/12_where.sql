-- Lista de transacoes com produtos "Resgatar Ponei"

-- Para descobrir o IdProduto do produto "Resgatar Ponei"
SELECT * FROM produtos
where DescNomeProduto LIKE '%Ponei%';
-- Resultado: IdProduto = 15


SELECT *  
FROM transacao_produto
WHERE IdProduto = 15;