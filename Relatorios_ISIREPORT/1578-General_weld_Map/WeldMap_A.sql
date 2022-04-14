

----------------   SQL WELMAP "A" ---------------

select
dfb.bold_id as pdfbdf,
jnt.datacadastro as dt_cad,
jnt.cod_junta,
jnt.observacoes as area,
jnt.desenhopetrobras as folha,
atd.cod_ensaio rel_predi,
jnt.statuspredi pre_fitup,
atd.data as dt_pre_fitup,
--jnt1.statusva,

---- SUB_BLOCO ----
case when mdl.nome_modulo is null then mdl1.nome_modulo 
else mdl.nome_modulo
end as SUB_BLOCO,

---- PAINEL ----
case when dmt.cod_dm is null then dmt1.cod_dm 
else dmt.cod_dm
end as PAINEL,

---- PESO ----
case when dfb.peso_total is null then dfb1.peso_total 
else dfb.peso_total 
end as peso,

---- Cod_DF_Cod_MP ----
case when dfb.Cod_df is null then MPR.COD_MP when MPR.COD_MP is null 
then dfb.Cod_df
else '' 
end as Cod_DF_Cod_MP,

---- PECA_1 ----
CASE
WHEN cmp1.Cod_componente is null then dfb1.cod_df else cmp1.cod_componente end ||case when cmp1.ppctpcorte > 0 then ' - ' || mpr1.COD_MP 
else '' 
end as PECA_1 ,

---- PECA_2 ----
case
WHEN cmp2.Cod_componente is null then dfb2.cod_df else cmp2.cod_componente end || case when cmp2.ppctpcorte > 0 then '- ' || mpr2.COD_MP 
else '' 
end as PECA_2 ,

JobCard,
jnt.nofim as Tanque,

---- TIPO ----
CASE
WHEN JNT.EXECUCAO = 0 THEN 'OFC'
WHEN JNT.EXECUCAO = 1 THEN 'MNT'
WHEN JNT.EXECUCAO = 2 THEN 'PMN'
WHEN JNT.EXECUCAO = 3 THEN 'EDF'
END AS TIPO,

jnt.nivel_inspecao,
decode(jnt.tipo_junta, 0, 'BUTT', 1, 'T / FP', 2, 'T / FW', 4, 'T / PP', 5, 'T / PP') as Tipo_Junta,
jnt.extensao, mat1.Codigo_mb as Material1, mat2.Codigo_mb as Material2,
jnt.espessura1, jnt.espessura2,
jnt.statusVA,

---- VA ----
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VA%'
group by jnt1.bold_id) as VA,

---- VA_INSP ----
(select max(inp.nome) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join inpinspetor inp on inp.bold_id = ens.pinpinspetor
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VA%'
group by jnt1.bold_id) va_insp,


---- VA_DATA ----
cast( cast((select max(ens.data) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VA%'
group by jnt1.bold_id) as date) as varchar(10)) as VA_DATA,

jnt.StatusRS,

---- RS ----
(select max(ens.cod_solda) from sldsolda ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_solda like 'RS%'
group by jnt1.bold_id) as RS,

---- STATUS_VSg ----
cast( cast(
(select max(ens.obsldazdata) from sldsolda ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_SOLDA like 'RS%'
group by jnt1.bold_id) as date) as varchar(10)) as RS_DATA,
jnt.statusvsg,

---- VSg ----
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.antestt = 2
and tre.classificacao = 1
and tre.tipo_ens = 4
and ens.cod_ensaio like 'VS%'
group by jnt1.bold_id
) as VSg,


---- VSg_DATA ----
cast( cast(
(select max(ens.data) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.antestt = 2
and tre.classificacao = 1
and (tre.tipo_ens = 4 or tre.tipo_ens = 3)
and (ens.cod_ensaio like 'PM%' or ens.cod_ensaio like 'LP%')
group by jnt1.bold_id
) as date) as varchar(10)) as VSg_DATA,

jnt.statusPMg,

---- PMg ----
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.antestt = 2
and tre.classificacao = 1
and tre.tipo_ens = 4
and ens.cod_ensaio like 'PM%'
group by jnt1.bold_id
) as PMg,

---- VS ----
cast( cast(
(select max(ens.data) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.antestt = 2
and tre.classificacao = 1
and (tre.tipo_ens = 4 or tre.tipo_ens = 3)
and (ens.cod_ensaio like 'PM%' or ens.cod_ensaio like 'LP%')
group by jnt1.bold_id
) as date) as varchar(10)) as PMg_DATA,
(select max(tre.soldadores) from tretrecho tre
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
group by jnt1.bold_id) as SOLDADORES,
jnt.statusVS,
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VS%'
group by jnt1.bold_id
) as VS,


---- VS_INSP ----
(select max(inp.nome) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
join inpinspetor inp on inp.bold_id = ens.pinpinspetor
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VS%'
group by jnt1.bold_id
) as VS_Insp,


---- VS_DATA ----
cast( cast(
(select max(ens.data) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VS%'
group by jnt1.bold_id
) as date) as varchar(10)) as VS_DATA,

jnt.statusLP,

---- LP ----
CASE
  when jnt.statuslp = 'AP' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'LP%'
     group by jnt1.bold_id)
  when jnt.statuslp = 'AL' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 3
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statuslp = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'LP%')
else ''
end as LP,

---- LP_INSP ----
CASE
  when jnt.statuslp = 'AP' then
    (select max(inp.nome) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     join inpinspetor inp on inp.bold_id = ens.pinpinspetor
     where
     jnt1.bold_id = jnt.bold_id
     and tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'LP%'
     group by jnt1.bold_id)
  when jnt.statuslp = 'AL' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 3
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statuslp = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'LP%')
else ''
end as LP_insp,


---- LP_DATA ----
CASE
  when jnt.statuslp = 'AP' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'LP%'
     group by jnt1.bold_id/*jnt1.cod_junta*/) as date) as varchar(10))
  when jnt.statuslp = 'AL' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 3
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statuslp = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'LP%') as date) as varchar(10))
else ''
end as LP_DATA,

CLS.ENSAIOLP AS Percent_LP,
jnt.statusPM,

---- PM ----
CASE
  when jnt.statuspm = 'AP' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'PM%'
     group by jnt1.bold_id)
  when jnt.statuspm = 'AL' then
    (select max(ens.cod_ensaio) from ensensaio ens
    join assjntltj ass on ass.fjntjunta = jnt.bold_id
    join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 4
    join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
    join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statuspm = 'AP'
    join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
    where
     tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'PM%')
else ''
end as PM,

---- PM_Insp ----
CASE
  when jnt.statuspm = 'AP' then
    (select max(inp.nome) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     join inpinspetor inp on inp.bold_id = ens.pinpinspetor
     where
     jnt1.bold_id = jnt.bold_id
     and tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'PM%'
     group by jnt1.bold_id)
  when jnt.statuspm = 'AL' then
    (select max(inp.nome) from ensensaio ens
    join assjntltj ass on ass.fjntjunta = jnt.bold_id
    join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 4
    join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
    join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statuspm = 'AP'
    join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
    join inpinspetor inp on inp.bold_id = ens.pinpinspetor
    where
     tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'PM%')
else ''
end PM_Insp,

---- STATUSRX ----
CASE
  when jnt.statuspm = 'AP' then
   cast( cast(
   (select max(ens.data) from ensensaio ens
   join tretrecho tre on tre.bold_id = ens.ptretrecho
   join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
   where
   jnt1.bold_id = jnt.bold_id
   and tre.classificacao = 1
   and tre.antesTT = 0
   and ens.cod_ensaio like 'PM%'
   group by jnt1.bold_id) as date) as varchar(10))
  when jnt.statuspm = 'AL' then
    cast( cast((select max(ens.data) from ensensaio ens
    join assjntltj ass on ass.fjntjunta = jnt.bold_id
    join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 4
    join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
    join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statuspm = 'AP'
    join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
    where
     tre.classificacao = 1
     and tre.antesTT = 0
     and ens.cod_ensaio like 'PM%') as date) as varchar(10))
else ''
end as PM_DATA,
CLS.ENSAIOPM AS Percent_PM,
jnt.statusRX,

---- RX ----
CASE
  when jnt.statusrx = 'AP' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'RX%'
     group by jnt1.bold_id)
  when jnt.statusrx = 'AL' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 6
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusrx = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
      (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
      and tre.antesTT = 0
      and ens.cod_ensaio like 'RX%')
else ''
end as RX,

---- RX_DATA ----
CASE
  when jnt.statusrx = 'AP' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'RX%'
     group by jnt1.bold_id) as date) as varchar(10))
  when jnt.statusrx = 'AL' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 6
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusrx = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'RX%') as date) as varchar(10))
else ''
end as RX_DATA,

CLS.ENSAIOER AS Percent_RX,
jnt.statusUS,


---- US ----
CASE
  when jnt.statusus = 'AP' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'US%'
     group by jnt1.bold_id)
     when jnt.statusus = 'RP' then
    (select max(ens.cod_ensaio) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 0))
     and tre.antesTT = 0
     and ens.cod_ensaio like '%U%'
     group by jnt1.bold_id)
  when jnt.statusus = 'AL' then
  (select max(ens.cod_ensaio) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 5
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusus = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'US%')
else ''
end as US,

---- US_INSP ----
CASE
  when jnt.statusus = 'AP' then
    (select max(inp.nome) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join inpinspetor inp on inp.bold_id = ens.pinpinspetor
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where jnt1.bold_id = jnt.bold_id and (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'US%'
     group by jnt1.bold_id)
     when jnt.statusus = 'RP' then
    (select max(inp.nome) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join inpinspetor inp on inp.bold_id = ens.pinpinspetor
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 0))
     and tre.antesTT = 0
     and ens.cod_ensaio like '%U%'
     group by jnt1.bold_id)
  when jnt.statusus = 'AL' then
  (select max(inp.nome) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 5
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusus = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     join inpinspetor inp on inp.bold_id = ens.pinpinspetor
     where
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'US%')
else ''
end as US_Insp,

----US_DATA----
CASE
  when jnt.statusus = 'AP' 
  then
    cast( cast(
    (select max(ens.data) from ensensaio ens
    join tretrecho tre on tre.bold_id = ens.ptretrecho
    join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
    where jnt1.bold_id = jnt.bold_id and (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1)) and tre.antesTT = 0 and ens.cod_ensaio like 'US%'
    group by jnt1.bold_id) as date)  as varchar(10))
  when jnt.statusus = 'AL' 
  then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 5
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusus = 'AP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'US%') as date) as varchar(10))
else ''
end as US_DATA,

--- US_DATA_REP ---
CASE
  when jnt.statusus = 'RP' 
  then
    cast( cast(
    (select max(ens.data) from ensensaio ens
    join tretrecho tre on tre.bold_id = ens.ptretrecho
    join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
    where jnt1.bold_id = jnt.bold_id and (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1)) and tre.antesTT = 0 and ens.cod_ensaio like 'US%'
    group by jnt1.bold_id) as date)  as varchar(10))

  when jnt.statusus = 'AL' 
  then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 5
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusus = 'RP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1)) and tre.antesTT = 0 and ens.cod_ensaio like 'US%') as date) as varchar(10))
else '' 
end as US_DATA_rep,

CLS.ENSAIOUS AS Percent_US,
jnt.statusES,

--- ES ---
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
------------and tre.tipo_ens = 0
and ens.cod_ensaio like 'ES%'
group by jnt1.bold_id) as ES,


---ES_DATA---
cast( cast((select max(ens.data) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where jnt1.bold_id = jnt.bold_id and tre.classificacao = 0
---------------and tre.tipo_ens = 0
and ens.cod_ensaio like 'ES%'
group by jnt1.bold_id) as date) as varchar(10)) as ES_DATA,


---LOTE_LP---
(select max(LTJ.Codigo)
from LTJLote_Junta LTJ join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 3 and ASS.FJNTJunta = JNT.Bold_ID) as LOTE_LP,


---LOTE_PM---
(select max(LTJ.Codigo)
from LTJLote_Junta LTJ join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 4 and ASS.FJNTJunta = JNT.Bold_ID) as LOTE_PM,


---LOTE_RX---
(select max(LTJ.Codigo)
from LTJLote_Junta LTJ
join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 6 and ASS.FJNTJunta = JNT.Bold_ID) as LOTE_RX,


---LOTE_US---
(select max(LTJ.Codigo)
from LTJLote_Junta LTJ join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 5 and ASS.FJNTJunta = JNT.Bold_ID) as LOTE_US,


---STATUS_USPA---
case
when jnt.statususpa <> '' then jnt.statususpa else 'NA' end as STATUS_USPA,


---USPA---
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where jnt1.bold_id = jnt.bold_id and (tre.classificacao = 1 or tre.classificacao = 4)
and tre.antesTT = 7
and ens.cod_ensaio like 'UP%'
group by jnt1.cod_junta) as USPA,

---USPA_DATA---
CASE
  when jnt.statususpa <> '' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
    join tretrecho tre on tre.bold_id = ens.ptretrecho
    join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
    where jnt1.bold_id = jnt.bold_id and (tre.classificacao = 1 or tre.classificacao = 4 ) and tre.antesTT = 7 and ens.cod_ensaio like 'UP%'
    group by jnt1.bold_id) as date)  as varchar(10))
else '' end as USPA_DATA,

jnt.noinicio as ETAPA,


---NON_EXECUTION_STATUS---

case when jnt.jobcard like '01%' then 'Falta Controlbox'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '02%' then 'Abertura de Raiz'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '03%' then 'Desalinhamento'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '04%' then 'Ângulo Chanfro / Nariz / Delardagem'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '05%' then 'Não Montado'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '13%' then 'Falta Ajuste'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '14%' then 'Sem Acesso'||'-'||jnt.jobcard||'-'||'FT'
when jnt.jobcard like '06%' then 'Falta preparação superfície (respingo, escoria)'||'-'||jnt.jobcard||'-'||'VT'
when jnt.jobcard like '07%' then 'Porosidade'||'-'||jnt.jobcard||'-'||'VT'
when jnt.jobcard like '08%' then 'Mordedura'||'-'||jnt.jobcard||'-'||'VT'
when jnt.jobcard like '09%' then 'Trinca'||'-'||jnt.jobcard||'-'||'VT'
when jnt.jobcard like '10%' then 'Reforço Exc.'||'-'||jnt.jobcard||'-'||'VT'
when jnt.jobcard like '11%' then 'Não Montado'||'-'||jnt.jobcard||'-'||'VT'
when jnt.jobcard like '12%' then 'Não Soldado'||'-'||jnt.jobcard||'-'||'VT' else jnt.status_junta end non_execution_status,

jnt.status_junta

---FROM---
from jntjunta jnt
left join jutjunta_df jutf on jutf.bold_id = jnt.bold_id
left join jutjunta_mp jutm on jutm.bold_id = jnt.bold_id
left join jutjunta_dm jutd on jutd.bold_id = jnt.bold_id
left join dfbDesenhoFabricacao dfb on (dfb.bold_id = jutF.pdfbdf)
left join dmtdesenhomontagem dmt1 on (dmt1.bold_id = dfb.pdmtdm)
left join mdlmodulo mdl1 on (mdl1.bold_id = dmt1.pmdlmodulo)
left join mprmateriaprima mpr on (mpr.bold_id = jutM.pmprmatpri)
left join dmtdesenhomontagem dmt on (dmt.bold_id = jutd.pdmtdm)
left join mdlmodulo mdl on (mdl.bold_id = dmt.pmdlmodulo)
left JOIN CLSCLASSE CLS ON CLS.BOLD_ID = JNT.PCLSCLASSE
left join cmpComponente cmp1 on (cmp1.bold_id = jutF.pcmpComp1 or cmp1.bold_id = jutM.pcmpComp1)
left join pctplano_corte pct1 on (pct1.bold_id = cmp1.ppctpcorte)
left join mPRmateriaprima mpr1 on (mpr1.bold_id = pct1.pmprmatpri)
left join cmpComponente cmp2 on (cmp2.bold_id = jutF.pcmpComp2 or cmp2.bold_id = jutM.pcmpComp2)
left join pctplano_corte pct2 on (pct2.bold_id = cmp2.ppctpcorte)
left join mPRmateriaprima mpr2 on (mpr2.bold_id = pct2.pmprmatpri)
left join dfbdesenhofabricacao dfb1 on (dfb1.bold_id = jutd.pdfbdf1)
left join dfbdesenhofabricacao dfb2 on (dfb2.bold_id = jutd.pdfbdf2)
left join matMaterial mat1 on mat1.bold_id = jnt.pmatmBase1
left join matMaterial mat2 on mat2.bold_id = jnt.pmatmBase2
left join attdi att on jnt.bold_id = att.pjntjunta
left join atdatividade atd on att.bold_id = atd.bold_id

---WHERE---
where (dfb.tipo_estrutura = 'JURONG') or (dfb1.tipo_estrutura = 'JURONG')