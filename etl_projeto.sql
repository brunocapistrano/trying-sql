WITH tb_transacoes AS (
    SELECT IdTransacao,
           IdCliente,
           QtdePontos,
           datetime(substr(DtCriacao,1,19)) AS DtCriacao,
           julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate,
           CAST(strftime('%H', substr(DtCriacao,1,19)) AS INTEGER) AS DtHora

    FROM transacoes
),
tb_clientes AS (
    SELECT IdCliente,
           datetime(substr(DtCriacao,1,19)) AS DtCriacao,
           julianday('now') - julianday(substr(DtCriacao,1,10)) AS IdadeBase
    FROM clientes
),
tb_sumario_transacoes AS (
    SELECT  IdCliente,
            COUNT(IdTransacao) AS TotalTransacoesVida,
            COUNT(CASE WHEN diffDate <= 300 THEN IdTransacao END) AS IdTransacaoUltimas8Semanas,
            MIN(diffDate) AS DiasDesdeUltimaTransacao,
            SUM(QtdePontos) AS TotalPontosVida,
            SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS QtdePontosPosVida,
            SUM(CASE WHEN QtdePontos > 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS QtdePontosPos56,
            SUM(CASE WHEN QtdePontos > 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS QtdePontosPos28,
            SUM(CASE WHEN QtdePontos > 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS QtdePontosPos14,
            SUM(CASE WHEN QtdePontos > 0 AND diffDate <= 7 THEN QtdePontos ELSE 0 END) AS QtdePontosPos7,
            
            SUM(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) AS QtdePontosNegVida,
            SUM(CASE WHEN QtdePontos < 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg56,
            SUM(CASE WHEN QtdePontos < 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg28,
            SUM(CASE WHEN QtdePontos < 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg14,
            SUM(CASE WHEN QtdePontos < 0 AND diffDate <= 7 THEN QtdePontos ELSE 0 END) AS QtdePontosNeg7

    FROM tb_transacoes
    GROUP BY IdCliente
),
tb_transacao_produto AS (

    SELECT  t1.*,
            t3.DescNomeProduto,
            t3.DescCategoriaProduto
            

    FROM tb_transacoes AS t1

    LEFT JOIN transacao_produto AS t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos AS t3
    ON t2.IdProduto = t3.IdProduto
),
 tb_cliente_produto AS (
    SELECT  IdCliente,
            DescNomeProduto,
            COUNT(*) AS QtdeVida,
            COUNT(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS Qtde56,
            COUNT(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS Qtde28,
            COUNT(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS Qtde14,
            COUNT(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS Qtde7  

    FROM tb_transacao_produto

    GROUP BY IdCliente, DescNomeProduto

),
tb_cliente_produto_rnk AS (
    SELECT  *,
            row_number() OVER (PARTITION BY IdCliente ORDER BY QtdeVida DESC) AS RnkVida,
            row_number() OVER (PARTITION BY IdCliente ORDER BY Qtde56 DESC) AS Rnk56,
            row_number() OVER (PARTITION BY IdCliente ORDER BY Qtde28 DESC) AS Rnk28,
            row_number() OVER (PARTITION BY IdCliente ORDER BY Qtde14 DESC) AS Rnk14,
            row_number() OVER (PARTITION BY IdCliente ORDER BY Qtde7 DESC) AS Rnk7
    FROM tb_cliente_produto
),
tb_cliente_dia AS (

    SELECT  IdCliente,
            strftime('%w', DtCriacao) AS DtDia,
            COUNT(*) AS QtdeTransacoes

    FROM tb_transacoes

    WHERE diffDate <= 300

    GROUP BY IdCliente, DtDia
),

tb_cliente_dia_rnk AS (

    SELECT *,
            row_number() OVER (PARTITION BY IdCliente ORDER BY QtdeTransacoes DESC) AS RnkDia

    FROM tb_cliente_dia

),

tb_cliente_periodo AS (

    SELECT  IdTransacao,
            IdCliente,
            DtCriacao,
            CASE WHEN DtHora BETWEEN 7 AND 12 THEN 'Manha'
                WHEN DtHora BETWEEN 13 AND 18 THEN 'Tarde'
                WHEN DtHora BETWEEN 19 AND 23 THEN 'Noite'
                ELSE 'Madrugada' END AS PeriodoDia,
            COUNT(*) AS QtdeTransacoes

    FROM tb_transacoes

    WHERE diffDate <= 300

    GROUP BY 1,2 

),

tb_cliente_periodo_rnk AS (

    SELECT  *,
            row_number() OVER (PARTITION BY IdCliente ORDER BY QtdeTransacoes DESC) AS RnkPeriodoDia

    FROM tb_cliente_periodo

), 

tb_join AS (

    SELECT  t1.*, 
            t2.IdadeBase,
            t3.DescNomeProduto AS ProdutoVida,
            t4.DescNomeProduto AS Produto56,
            t5.DescNomeProduto AS Produto28,
            t6.DescNomeProduto AS Produto14,
            t7.DescNomeProduto AS Produto7,
            COALESCE(t8.DtDia, -1) AS dtDia,
            COALESCE(t9.PeriodoDia, 'Sem Informacao') AS PeriodoDiaMaisFrequente

    FROM tb_sumario_transacoes AS t1

    LEFT JOIN tb_clientes AS t2
    ON t1.IdCliente = t2.IdCliente

    LEFT JOIN tb_cliente_produto_rnk AS t3
    ON t1.IdCliente = t3.IdCliente AND t3.RnkVida = 1

    LEFT JOIN tb_cliente_produto_rnk AS t4
    ON t1.IdCliente = t4.IdCliente AND t4.Rnk56 = 1

    LEFT JOIN tb_cliente_produto_rnk AS t5
    ON t1.IdCliente = t5.IdCliente AND t5.Rnk28 = 1

    LEFT JOIN tb_cliente_produto_rnk AS t6
    ON t1.IdCliente = t6.IdCliente AND t6.Rnk14 = 1

    LEFT JOIN tb_cliente_produto_rnk AS t7
    ON t1.IdCliente = t7.IdCliente AND t7.Rnk7 = 1

    LEFT JOIN tb_cliente_dia_rnk AS t8
    ON t1.IdCliente = t8.IdCliente AND t8.RnkDia = 1

    LEFT JOIN tb_cliente_periodo_rnk AS t9
    ON t1.IdCliente = t9.IdCliente AND t9.RnkPeriodoDia = 1

)

SELECT  *,
        

FROM tb_join