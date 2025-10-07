-- Lista de Clientes com 100 a 200 pontos (inclusive ambos)

SELECT idCliente,
       QtdePontos
FROM clientes
-- ou BETWEEN 100 AND 200 (é a mesma coisa)
WHERE QtdePontos >= 100
  AND QtdePontos <= 200