SELECT *

FROM transacao_produto AS t1

WHERE t1.IdProduto = (

    SELECT IdProduto

    FROM produtos

    WHERE DescNomeProduto = 'Resgatar Ponei'

);