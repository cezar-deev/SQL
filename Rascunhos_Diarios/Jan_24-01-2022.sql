// Lista de Baixas de CQ // LBH-CQ

select 
inp.nome as nome,
inp.cod_inspetor as cod_Insp,
ens.cod_ensaio as relatorios,
jnt.cod_junta,
ens.data_descarregamento as data_Desc,
ens.data as Data_Laudo,
case when ens.laudo='1' then 'A' else 'R' end  as Laudo
        from 
        ensensaio ens 
        left join tretrecho tre on ens.ptretrecho = tre.bold_id
        left join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        left join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
                where
                cast(ens.data_descarregamento as date) = CURRENT_DATE
                     order by 1,3,4




                         
// Lista de Baixas de VA // LBH-VA

select 
inp.nome as nome,
inp.cod_inspetor as cod_Insp,
ens.cod_ensaio,
ens.data_descarregamento as data_Desc,
ens.data as Data_Laudo,
case when ens.laudo='1' then 'A' else 'R' end  as Laudo
        from 
        ensensaio ens 
        left join tretrecho tre on ens.ptretrecho = tre.bold_id
        left join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        left join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
                where
                cod_ensaio like 'VA%' and  
                cast(ens.data_descarregamento as date) = CURRENT_DATE
                     order by 1 


// Lista de Baixas de VS // LBH-VS

select 
inp.nome as nome,
inp.cod_inspetor as cod_Insp,
ens.cod_ensaio,
ens.data_descarregamento as data_Desc,
ens.data as Data_Laudo,
case when ens.laudo='1' then 'A' else 'R' end  as Laudo
        from 
        ensensaio ens 
        left join tretrecho tre on ens.ptretrecho = tre.bold_id
        left join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        left join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
                where
                cod_ensaio like 'VS%' and  
                cast(ens.data_descarregamento as date) = CURRENT_DATE
                     order by 1 


// Lista de Baixas de PM // LBH-PM


select 
inp.nome as nome,
inp.cod_inspetor as cod_Insp,
ens.cod_ensaio,
ens.data_descarregamento as data_Desc,
ens.data as Data_Laudo,
case when ens.laudo='1' then 'A' else 'R' end  as Laudo,
isi.lote_pm,
isi.percent_pm,
jnt.status_junta
        from 
        ensensaio ens 
        left join tretrecho tre on ens.ptretrecho = tre.bold_id
        left join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        left join inpinspetor inp on inp.bold_id = ens.pinpinspetor
        left join vw_isireport_juntainspecionada isi on jnt.cod_junta = isi.cod_junta           
                where
                cod_ensaio like 'PM%' and  
                cast(ens.data_descarregamento as date) = CURRENT_DATE
                     order by 1 


// Lista de Baixas de US // LBH-US

select 
inp.nome as nome,
inp.cod_inspetor as cod_Insp,
ens.cod_ensaio,
ens.data_descarregamento as data_Desc,
ens.data as Data_Laudo,
case when ens.laudo='1' then 'A' else 'R' end  as Laudo,
isi.lote_us,
isi.percent_us,
jnt.status_junta
        from 
        ensensaio ens 
        left join tretrecho tre on ens.ptretrecho = tre.bold_id
        left join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        left join inpinspetor inp on inp.bold_id = ens.pinpinspetor
        left join vw_isireport_juntainspecionada isi on jnt.cod_junta = isi.cod_junta           
                where
                cod_ensaio like 'PM%' and  
                cast(ens.data_descarregamento as date) = CURRENT_DATE
                     order by 1 




//-----------------------------------

//SOLDADORES QUALIFICADOS COM DATAS DE ENTRADA,SAIDA,QUALIFICAÇÕES E DESQUALIFICAÇÕES //


SELECT A.AREA,
A.EMPRESA,
A.SINETE,
A.DTENTRADA,
A.DT_QUALIFICACAO,
A.DT_DESQUALI,
A.DT_REQUALIFICACAO,
A.DT_ULTIMASOLDA
        FROM
        (SELECT
        SOL.AREA, 
        SOL.EMPRESA,
        SOL.SINETE,
        SOL.DTENTRADA,
        CASE WHEN SOQ.DTQUALI = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTQUALI AS DATE ) END AS DT_QUALIFICACAO,
        CASE WHEN SOQ.DTDESQUALI = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTDESQUALI AS DATE ) END AS DT_DESQUALI,
        CASE WHEN SOQ.DTREQUALI2 = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTREQUALI2 AS DATE ) END AS DT_REQUALIFICACAO,
        CASE WHEN SOQ.ULTIMASOLDA = '30.12.1899' THEN ' ' ELSE CAST(SOQ.ULTIMASOLDA AS DATE ) END AS DT_ULTIMASOLDA,
        CASE WHEN SOQ.ULTIMOENSAIO = '30.12.1899' THEN ' ' ELSE CAST(SOQ.ULTIMOENSAIO AS DATE ) END AS DT_ULTIMOENSAIO,
        CASE WHEN SOL.DTSAIDA = '30.12.1899' THEN ' ' ELSE CAST(SOL.DTSAIDA AS DATE ) END AS DATASAIDA

        FROM SOLSOLDADOR SOL
        LEFT JOIN SOQSOL_QUALIFICACAO SOQ ON ( SOL.BOLD_ID = SOQ.PSOLSOLDADOR )
        LEFT JOIN HDQHISTORICO_DTQUALI HDQ ON ( HDQ.PSOQQUALI = SOQ.BOLD_ID ) 
                WHERE SOL.AREA = 'JURONG' AND SOL.DTSAIDA = '30.12.1899'
                                ORDER BY 2,1 ) A

GROUP BY A.AREA,A.EMPRESA,A.SINETE,A.DTENTRADA,A.DT_QUALIFICACAO,A.DT_DESQUALI,A.DT_REQUALIFICACAO,A.DT_ULTIMASOLDA


// -----------------------------------------------------------

// SOLDADOR DESQULIFICADO //


SELECT A.AREA,
A.EMPRESA,
A.SINETE,
A.DTENTRADA,
A.DT_QUALIFICACAO,
A.DT_DESQUALI,
A.DT_REQUALIFICACAO,
A.DT_ULTIMASOLDA,
A.DATASAIDA

FROM
(SELECT
SOL.AREA, 
SOL.EMPRESA,
SOL.SINETE,
SOL.DTENTRADA,
CASE WHEN SOQ.DTQUALI = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTQUALI AS DATE ) END AS DT_QUALIFICACAO,
CASE WHEN SOQ.DTDESQUALI = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTDESQUALI AS DATE ) END AS DT_DESQUALI,
CASE WHEN SOQ.DTREQUALI2 = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTREQUALI2 AS DATE ) END AS DT_REQUALIFICACAO,
CASE WHEN SOQ.ULTIMASOLDA = '30.12.1899' THEN ' ' ELSE CAST(SOQ.ULTIMASOLDA AS DATE ) END AS DT_ULTIMASOLDA,
CASE WHEN SOQ.ULTIMOENSAIO = '30.12.1899' THEN ' ' ELSE CAST(SOQ.ULTIMOENSAIO AS DATE ) END AS DT_ULTIMOENSAIO,
CASE WHEN SOL.DTSAIDA = '30.12.1899' THEN ' ' ELSE CAST(SOL.DTSAIDA AS DATE ) END AS DATASAIDA

     FROM SOLSOLDADOR SOL
     LEFT JOIN SOQSOL_QUALIFICACAO SOQ ON ( SOL.BOLD_ID = SOQ.PSOLSOLDADOR )
     LEFT JOIN HDQHISTORICO_DTQUALI HDQ ON ( HDQ.PSOQQUALI = SOQ.BOLD_ID ) 
             WHERE SOL.AREA = 'JURONG' AND SOL.DTSAIDA = '30.12.1899' AND SOQ.DTDESQUALI<>'30.12.1899'
                          ORDER BY 2,1 ) A

GROUP BY A.AREA,A.EMPRESA,A.SINETE,A.DTENTRADA,A.DT_QUALIFICACAO,A.DT_DESQUALI,A.DT_REQUALIFICACAO,A.DT_ULTIMASOLDA,A.DATASAIDA

//----------------------------------------

SOL.SINETE,
SOL.DTENTRADA,
CASE WHEN SOQ.DTQUALI = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTQUALI AS DATE ) END AS DT_QUALIFICACAO,
CASE WHEN SOQ.DTDESQUALI = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTDESQUALI AS DATE ) END AS DT_DESQUALI,
CASE WHEN SOQ.DTREQUALI2 = '30.12.1899' THEN ' ' ELSE CAST(SOQ.DTREQUALI2 AS DATE ) END AS DT_REQUALIFICACAO,
CASE WHEN SOQ.ULTIMASOLDA = '30.12.1899' THEN ' ' ELSE CAST(SOQ.ULTIMASOLDA AS DATE ) END AS DT_ULTIMASOLDA,
CASE WHEN SOQ.ULTIMOENSAIO = '30.12.1899' THEN ' ' ELSE CAST(SOQ.ULTIMOENSAIO AS DATE ) END AS DT_ULTIMOENSAIO,
CASE WHEN SOL.DTSAIDA = '30.12.1899' THEN ' ' ELSE CAST(SOL.DTSAIDA AS DATE ) END AS DATASAIDA,
SOQ.UERELATORIO

     FROM SOLSOLDADOR SOL
     LEFT JOIN SOQSOL_QUALIFICACAO SOQ ON ( SOL.BOLD_ID = SOQ.PSOLSOLDADOR )
     LEFT JOIN HDQHISTORICO_DTQUALI HDQ ON ( HDQ.PSOQQUALI = SOQ.BOLD_ID ) 
             WHERE SOL.AREA = 'JURONG' AND SOL.DTSAIDA = '30.12.1899' AND SOL.SINETE = 'EJA-0065'
                          ORDER BY 2,1