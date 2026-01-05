-- Quantos clientes tem email cadastrado?

SELECT COUNT(*) AS QtdeClientesComEmail
FROM Clientes
WHERE flEmail = 1;

SELECT SUM(flEmail) AS QtdeClientesComEmail
FROM Clientes;