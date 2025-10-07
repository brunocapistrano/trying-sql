SELECT idCliente,
    --    QtdePontos, 
    --    QtdePontos + 10 AS QtdePontosMaisDez,
    --    qtdePontos * 2 AS QtdePontosDobrados,
       DtCriacao,
       datetime(DtCriacao),
       strftime('%w', datetime(DtCriacao)) AS DiaSemana
FROM clientes
