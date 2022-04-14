
//AGRUPANDO 


SELECT 
    B.COMP1,
    B.ESCOPO,
    B.LIB,
    CASE WHEN B.LIB = B.ESCOPO THEN 'SOLDADO' ELSE '-' END AS STATUS
    
FROM
    (SELECT 
        A.COMP1,
        SUM(A.QTD) AS ESCOPO,
        SUM(A.STATUS) AS LIB
    FROM
        (SELECT 
            COMP1,
            1 AS QTD, 
            CASE WHEN JID.STATUSRS='AP' THEN 1 ELSE 0 END AS 
            STATUS,
            JID.STATUSRS
        FROM VW_CADJUNTADF CDF
            INNER JOIN VW_JUNTAINSPECIONADA JID ON (CDF.COD_JUNTA = JID.COD_JUNTA)
        WHERE CDF.COD_JUNTA NOT LIKE '#%' )A
    GROUP BY A.COMP1 ) B 


-------------------------------------------------------------------------------------------
