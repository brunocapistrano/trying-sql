-- Quais clientes juntaram mais pontos em 2025-05?

SELECT IdCliente,
       SUM(QtdePontos) AS TotalPontos
FROM Transacoes
WHERE DtCriacao LIKE '2025-05%'
GROUP BY IdCliente
ORDER BY TotalPontos DESC;