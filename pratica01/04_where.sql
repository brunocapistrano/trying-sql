-- Selecione produtos que possuem 'churn' no nome

SELECT *
FROM produtos

-- WHERE DescNomeProduto = 'Churn_10pp'
-- OR DescNomeProduto = 'Churn_5pp'
-- OR DescNomeProduto = 'Churn_2pp'

-- WHERE DescNomeProduto IN ('Churn_10pp', 'Churn_5pp', 'Churn_2pp')

-- WHERE DescNomeProduto LIKE '%churn%'

WHERE DescCategoriaProduto = 'churn_model'