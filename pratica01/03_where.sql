-- Selecione todos os clientes que possuem mais de 500 pontos.

SELECT idCliente, qtdePontos
FROM clientes
WHERE qtdePontos >= 500