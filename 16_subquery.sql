SELECT *

FROM (
    SELECT *
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) >= '2025-01-01'
)

WHERE substr(DtCriacao, 1, 10) < '2025-07-01';