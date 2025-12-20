SELECT  COUNT(DISTINCT IdTransacao), 
        COUNT(*),
        COUNT(DISTINCT IdCliente)
FROM transacoes

WHERE DtCriacao >= '2025-07-01'
    AND DtCriacao < '2025-08-01'

ORDER BY DtCriacao;