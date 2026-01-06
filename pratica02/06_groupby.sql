-- Qual o valor médio de pontos positivos por dia?

SELECT  AVG(QtdePontos) AS MediaPontos,
        substr(DtCriacao, 1, 10) AS Data
FROM transacoes
WHERE QtdePontos > 0
GROUP BY substr(DtCriacao, 1, 10);