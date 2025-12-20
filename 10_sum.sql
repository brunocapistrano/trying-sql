SELECT  IdTransacao,
        sum(QtdePontos),
        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos END),
        count(CASE WHEN QtdePontos < 0 THEN QtdePontos END)
FROM transacoes

WHERE DtCriacao >= '2025-07-01'
  AND DtCriacao < '2025-08-01'