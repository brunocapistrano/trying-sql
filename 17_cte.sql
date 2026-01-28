WITH tb_cliente_primeiro_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'

), 

tb_cliente_ultimo_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-29'

)

SELECT * 

FROM tb_cliente_primeiro_dia AS t1

    INNER JOIN tb_cliente_ultimo_dia AS t2
    ON t1.IdCliente = t2.IdCliente;