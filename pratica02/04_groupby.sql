-- Qual cliente fez mais transações em 2024?

SELECT  IdCliente,
        COUNT(IdTransacao) AS QtdeTransacoes
FROM Transacoes
WHERE DtCriacao LIKE '2024%'
GROUP BY IdCliente
ORDER BY QtdeTransacoes DESC
LIMIT 1

