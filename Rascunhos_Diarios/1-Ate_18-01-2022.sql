select
a.inspetor,
sum(a.tj) as tj,
sum(a.tjva) as tjva,
sum(a.tjrs) as tjrs,
sum(a.tjvs) as tjvs,
sum(a.tjpm) as tjpm,
sum(a.tjus) as tjus,
a.data as data

from(select
            case when 
            inp.nome like '%Piol%' then 'Piol' when
            inp.nome like '%Gustavo%' then 'Gustavo' when
            inp.nome like '%Leandro%' then 'Leandro' when
            inp.nome like '%Sidney%' then 'Sidney' when
            inp.nome like '%Firmino%' then 'Firmino' when
            crs.nome like '%Pedro%' then 'Pedro' else inp.nome end as Inspetor,

            sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
            sum(case when sld.cod_solda like '%RS%' then 1 else 0 end)TJRS,
            sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)TJVA,
            sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)TJVS,
            sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)TJPM,
            sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)TJUS,
            sum(case when ens.cod_ensaio like '%US%' then jnt.extensao else 0 end)EXT_US,
            ens.data_descarregamento as data

            from ensensaio ens 
            inner join tretrecho tre on ens.ptretrecho = tre.bold_id
            inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
            inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor
            inner join sldsolda sld on sld.ptretrecho = tre.bold_id
            inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet

            where 
            cast(ens.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%') or 
            cast(sld.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')

            group by
            inp.nome,
            crs.nome,
            ens.data_descarregamento) a

group by
a.inspetor,
a.data

order by
a.data

//----------------------------------------------


select crs.nome,crs.cod_coletor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when sld.cod_solda like '%RS%' then 1 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VA%' then 0 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 0 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 0 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 0 else 0 end)TJUS,
sld.data_descarregamento as data_RS

from ensensaio ens 
inner join tretrecho tre on ens.ptretrecho = tre.bold_id
inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
inner join sldsolda sld on sld.ptretrecho = tre.bold_id
inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet

where 
cast(sld.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')

group by
crs.nome, 
cod,        
data_RS


union 


select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when sld.cod_solda like '%RS%' then 0 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)TJUS,
ens.data_descarregamento as data_Desc

from ensensaio ens 
inner join tretrecho tre on ens.ptretrecho = tre.bold_id
inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
inner join sldsolda sld on sld.ptretrecho = tre.bold_id
inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet

where 
ens.data_descarregamento='05.01.2022'  and (jnt.cod_junta not like '#%')

group by
nome, 
cod,        
data_Desc


// -----------------------------------------


select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when atd.cod_ensaio like '%DI%' then 1 else 0 end)TJPRE,
sum(case when ens.cod_ensaio like '%VA%' then 0 else 0 end)TJVA,
sum(case when sld.cod_solda like '%RS%' then 0 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VS%' then 0 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 0 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 0 else 0 end)TJUS,
atd.data_descarregamento as data_Desc

from ensensaio ens 
inner join tretrecho tre on ens.ptretrecho = tre.bold_id
inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
inner join sldsolda sld on sld.ptretrecho = tre.bold_id
inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
inner join atdatividade atd on atd.pinpinspetor = inp.bold_id

where 
atd.data_descarregamento='05.01.2022'  and (jnt.cod_junta not like '#%')

group by
nome, 
cod,        
data_Desc

//------------------------------


SELECT COD_TRECHO, STATUS_TRECHO, SUBSTRING( COD_TRECHO FROM (POSITION ( '/T' IN COD_TRECHO)+1) FOR 10)
    FROM TRETRECHO
       WHERE COD_TRECHO LIKE '%LP%'


// ---------------------------------


SELECT 
COD_TRECHO, 
STATUS_TRECHO,
POSITION ( '/T' IN COD_TRECHO),
SUBSTRING( COD_TRECHO FROM 1 FOR POSITION ( '/T' IN COD_TRECHO)-1) AS COD_JUNTA
       FROM TRETRECHO
             WHERE COD_TRECHO LIKE '%LP%'


// ---------------------------------------------------------------------

SELECT
SUBSTRING( COD_TRECHO FROM 1 FOR POSITION ( '/T' IN COD_TRECHO)-1) AS COD_JUNTA,
SUBSTRING( COD_TRECHO FROM (POSITION ( '/T' IN COD_TRECHO)+1) FOR 2) AS TT_TI,
SUBSTRING( COD_TRECHO FROM (POSITION ( '/T' IN COD_TRECHO)+4) FOR 2) AS ENSAIO,
CASE 
WHEN COD_TRECHO LIKE '%/R1/%' THEN 'R1'
WHEN COD_TRECHO LIKE '%/R2/%' THEN 'R2'
WHEN COD_TRECHO LIKE '%/R3/%' THEN 'R3' 
WHEN COD_TRECHO LIKE '%/R4/%' THEN 'R4' 
WHEN COD_TRECHO LIKE '%/R5/%' THEN 'R5' END AS REPARO,
STATUS_TRECHO,
CASE
WHEN STATUS_TRECHO LIKE '%0%' THEN 'PENDENTE' 
WHEN STATUS_TRECHO LIKE '%2%' THEN 'APROVADO' 
WHEN STATUSUS LIKE '3%' THEN 'REPROVADO'
WHEN STATUS_TRECHO LIKE '%4%' THEN 'LIBERADO POR LOTE' END AS STATUS,
SOLDADORES,
STATUSUS 

       FROM TRETRECHO
             WHERE COD_TRECHO LIKE 'FT%'
                   ORDER BY COD_JUNTA



// ---------------------------------------------------------------------------



SELECT 
JNT.COD_JUNTA,
TRE.STATUS_TRECHO,
TRE.STATUSUS,
DFT.EXECUCAO,
JNI.TIPO_JUNTA,
DFT.ESPESSURA,
DFT.COMPRIMENTO,
DFT.EXTENSAOINSP,
DFT.TIPO_DEFEITO,
DFT.LOCALIZACAO,
DFT.EXTENSAODEF,
DFT.PROF AS PROFUND_DEF,
DFT.DATA AS DATA_BAIXA,
JNT.STATUS_JUNTA,
TRE.SOLDADORES,
JNI.US_DATA

      FROM TRETRECHO TRE 
      INNER JOIN JNTJUNTA JNT ON TRE.PJNTJUNTA = JNT.BOLD_ID
      INNER JOIN VW_DEFEITOS DFT ON DFT.COD_TRECHO = TRE.COD_TRECHO 
      INNER JOIN VW_JUNTAINSPECIONADA JNI ON JNI.COD_JUNTA = JNT.COD_JUNTA 

           WHERE DFT.DATA>= '2022-01-01'
                ORDER BY DATA_BAIXA DESC


// ---------------------------------------------------------------------------


SELECT 
JNT.COD_JUNTA  AS JOINT,
SUBSTRING(TRE.SOLDADORES FROM 6 FOR 8) AS WELDER_ID_SIGNET,
SUBSTRING(TRE.SOLDADORES FROM 1 FOR 4) AS WELD_PROC,
'Ultrasonic Testing' AS INSPECTION,
'IE - Note 1' AS DEFECT_TYPE,
DFT.FILMESREPROVADOS AS QTY_FILM,
DFT.FILMESREPROVADOS AS REPROVED_FILM,
DFT.EXTENSAOINSP AS INSPECTED_LENGTH,
'VER LOCAL' AS DEFECT_LOCAL,
DFT.EXTENSAODEF AS DEFECT_LENGTH

      FROM TRETRECHO TRE 
      INNER JOIN JNTJUNTA JNT ON TRE.PJNTJUNTA = JNT.BOLD_ID
      INNER JOIN VW_DEFEITOS DFT ON DFT.COD_TRECHO = TRE.COD_TRECHO 
      INNER JOIN VW_JUNTAINSPECIONADA JNI ON JNI.COD_JUNTA = JNT.COD_JUNTA 

           WHERE DFT.DATA>= '2022-01-01'


//--------------------------------------


select ens.data_descarregamento, inp.cod_inspetor,inp.nome, ens.cod_ensaio
    from ensensaio ens
    left join inpinspetor inp on inp.bold_id = ens.pinpinspetor
            where cast(ens.data_descarregamento as date) = (CURRENT_DATE)


//----------------------------


                                                                                             //  18-01-2021 - TERÇA-FEIRA //


# LISTA DE JUNTAS DO TEMPORARIO // --------------------------------------------------------------------

SELECT
t.data_sincronizacao AS Data_Sincronizacao,
CASE 
WHEN t.tipo_ensaio = 0 THEN 'VA' 
WHEN t.tipo_ensaio = 1 THEN 'VS' 
WHEN t.tipo_ensaio = 2 THEN 'TT' 
WHEN t.tipo_ensaio = 3 THEN 'LP' 
WHEN t.tipo_ensaio = 4 THEN 'PM' 
WHEN t.tipo_ensaio = 5 THEN 'US' 
WHEN t.tipo_ensaio = 6 THEN 'RX' 
WHEN t.tipo_ensaio = 7 THEN 'DI' 
WHEN t.tipo_ensaio = 8 THEN 'PI' 
WHEN t.tipo_ensaio = 9 THEN 'ED' 
WHEN t.tipo_ensaio = 10 THEN 'RS'
WHEN t.tipo_ensaio = 11 THEN 'ES' 
WHEN t.tipo_ensaio = 12 THEN 'CR' 
WHEN t.tipo_ensaio = 13 THEN 'DU' 
WHEN t.tipo_ensaio = 14 THEN 'TH' 
WHEN t.tipo_ensaio = 15 THEN 'PN' 
WHEN t.tipo_ensaio = 16 THEN 'HD' 
WHEN t.tipo_ensaio = 17 THEN 'DS' 
WHEN t.tipo_ensaio = 18 THEN 'MacroGrafia' 
WHEN t.tipo_ensaio = 19 THEN 'Quebra' 
WHEN t.tipo_ensaio = 20 THEN 'Dobramento' 
WHEN t.tipo_ensaio = 21 THEN 'Certificadora' 
WHEN t.tipo_ensaio = 22 THEN 'UD' 
WHEN t.tipo_ensaio = 23 THEN 'RXC' 
WHEN t.tipo_ensaio = 24 THEN 'UP' 
WHEN t.tipo_ensaio = 25 THEN 'RXS'
WHEN t.tipo_ensaio = 26 THEN 'NA' 
WHEN t.tipo_ensaio = 27 THEN 'CO' END AS TipoEnsaio,
t.item AS Trecho,
t.inspetor AS Inspetor,
t.cabecalho AS Cabecalho,
t.mascara AS Mascara,
t.relatorio AS Relatorio, t.erro AS Erro 

      FROM TB_ITEM_NAO_PROCESSADO t 
          
            ORDER BY 1 DESC



 # LISTA DE JUNTAS DO TEMPORARIO // ---------------------------------------------------------

SELECT tt.trecho, 
CASE 
WHEN tt.tipo_ensaio = 0 THEN 'VA' 
WHEN tt.tipo_ensaio = 1 THEN 'VS' 
WHEN tt.tipo_ensaio = 2 THEN 'TT' 
WHEN tt.tipo_ensaio = 3 THEN 'LP' 
WHEN tt.tipo_ensaio = 4 THEN 'PM' 
WHEN tt.tipo_ensaio = 5 THEN 'US' 
WHEN tt.tipo_ensaio = 6 THEN 'RX' 
WHEN tt.tipo_ensaio = 7 THEN 'DI' 
WHEN tt.tipo_ensaio = 8 THEN 'PI' 
WHEN tt.tipo_ensaio = 9 THEN 'ED' 
WHEN tt.tipo_ensaio = 10 THEN 'RS' 
WHEN tt.tipo_ensaio = 11 THEN 'ES' 
WHEN tt.tipo_ensaio = 12 THEN 'CR' 
WHEN tt.tipo_ensaio = 13 THEN 'DU' 
WHEN tt.tipo_ensaio = 14 THEN 'TH' 
WHEN tt.tipo_ensaio = 15 THEN 'PN' 
WHEN tt.tipo_ensaio = 16 THEN 'HD' 
WHEN tt.tipo_ensaio = 17 THEN 'DS' 
WHEN tt.tipo_ensaio = 18 THEN 'MacroGrafia' 
WHEN tt.tipo_ensaio = 19 THEN 'Quebra' 
WHEN tt.tipo_ensaio = 20 THEN 'Dobramento' 
WHEN tt.tipo_ensaio = 21 THEN 'Certificadora' 
WHEN tt.tipo_ensaio = 22 THEN 'UD' 
WHEN tt.tipo_ensaio = 23 THEN 'RXC' 
WHEN tt.tipo_ensaio = 24 THEN 'UP' 
WHEN tt.tipo_ensaio = 25 THEN 'RXS' 
WHEN tt.tipo_ensaio = 26 THEN 'NA' 
WHEN tt.tipo_ensaio = 27 THEN 'CO' END AS TipoEnsaio, 
tt.inspetor, '' AS Cabecalho, '' AS Mascara, 
tt.data_sinc AS Data_Sincronizacao, 
tt.cod_relatorio AS Relatorio, 
tt.erro_processamento AS Erro 

     FROM TB_TEMP tt 


# LISTA DE RESOLD BAIXADOS NO DATA_BAIXA //-------------------------------------------------------

SELECT COD_JUNTA,TIPO_JUNTA,RS AS RS_REL,RS_DATA,STATUS_JUNTA
   FROM VW_JUNTAINSPECIONADA
       WHERE COD_JUNTA LIKE '%SMP283%' AND cast(RS_DATA as date) = CURRENT_DATE

       WHERE cast(PMG_DATA as date) = CURRENT_DATA



# LISTA DE SOLDAORES COMD ESQUALIFICAÇÃO // -----------------------------------------------


SELECT*
FROM SOQSOL_QUALIFICACAO


# LISTA DE SOLDAODRES COM HISTORICO DE QUALIDADE //----------------------------------------------


SELECT
solsoldador.sinete,
case
when soqsol_qualificacao.processo_soldagem = 0 then 'SMAW'
when soqsol_qualificacao.processo_soldagem = 1 then 'SAW'
when soqsol_qualificacao.processo_soldagem = 2 then 'FCAW'
when soqsol_qualificacao.processo_soldagem = 3 then 'GTAW'
when soqsol_qualificacao.processo_soldagem = 4 then 'GMAW'
when soqsol_qualificacao.processo_soldagem = 5 then 'N/A'
when soqsol_qualificacao.processo_soldagem = 6 then 'FCAW_GS'
when soqsol_qualificacao.processo_soldagem = 7 then 'ESW'
when soqsol_qualificacao.processo_soldagem = 8 then 'EGW'
when soqsol_qualificacao.processo_soldagem = 9 then 'SW'
end as Processo_Soldagem,
hdqhistorico_dtquali.data as data_Hist,
case
when hdqhistorico_dtquali.tipo = 0 then 'Desq'
when hdqhistorico_dtquali.tipo = 1 then 'Req'
else '' end as Tipo,
soqsol_qualificacao.cod_quali,
soqsol_qualificacao.dtquali,
soqsol_qualificacao.dtdesquali,
soqsol_qualificacao.dtrequali2 

    from hdqhistorico_dtquali
    inner join soqsol_qualificacao on (soqsol_qualificacao.bold_id = hdqhistorico_dtquali.psoqquali)
    inner join solsoldador on (solsoldador.bold_id = soqsol_qualificacao.psolsoldador)

         ORDER BY solsoldador.sinete, soqsol_qualificacao.processo_soldagem,  hdqhistorico_dtquali.data


  # CONSULTA DE 'PLAT-SMP283/FW5%'    // -------------------------------------------------------------------

  
SELECT COD_JUNTA,TIPO,STATUS_JUNTA
FROM VW_JUNTAINSPECIONADA
WHERE COD_JUNTA LIKE 'PLAT-SMP283/FW5%'


                                                                                             //  19-01-2021 - QUARTA-FEIRA





