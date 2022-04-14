


----------------   SQL WELMAP "D" QUE INCLUI O "A+B+C" ---------------


----------------------------------------------------- SELECT D -----------------------------------------------------------
select *
from(select
case when b.df like '%SMP%' then SUBSTRING(b.df FROM POSITION('-',b.df)+1 FOR 9) else null end AS SMP,
b.sub_bloco,
b.modulo,
b.area,
b.folha,
b.df,
b.peso,
b.cod_junta,
b.execucao,
b.tipo_junta,
b.nivel_inspecao,
b.extensao,
trim(b.status_predi) as status_predi,
b.rel_predi as predi,
b.predi_data,
trim(b.va_status) va_status,
b.va,
case when b.status_predi = 'PREDI' then b.predi_data else  b.va_data end va_data,
case when  b.va_insp like '%CIMC%' then b.vs_insp else b.va_insp end as va_insp,
case when b.va_status = 'AP' and b.rs_status is null then 'RS' else trim(b.rs_status)end rs_status,
case when b.rs_status = 'AP' and b.rs is null then 'RS02876_P71' else b.rs end rs ,
case when b.rs_status = 'AP' and b.rs_data is null then b.va_data  when
b.cod_junta = 'CP1-CRANE/FP2-001' then cast('05/12/2021' as date) else b.rs_data end rs_data,
trim(b.vs_status) vs_status,
b.vs,
case when b.vs_status = 'MT' then b.rs_data else b.vs_data end as vs_data,
b.vs_insp,

trim(case when (b.vs_status = 'REJ' AND b.pm_status = 'AL') then '' else b.pm_status end) 
pm_status,
case when (b.vs_status = 'REJ' and b.pm_status = 'AL') then '' else b.pm end  pm,
case when (b.vs_status = 'REJ' and b.pm_status = 'AL') then '' when b.pm_status like '%NA%' then 
b.lp_data when B.PM_STATUS = 'AP' AND B.PM_DATA = '' THEN B.LP_DATA else b.pm_data 
end pm_data ,

case when  b.pm_insp like '%CIMC%' then b.vs_insp when
 (b.vs_status = 'REJ' and b.status_junta = 'Waiting Visual Test' and b.pm_status = 'AL') then '' else 
b.pm_insp end as pm_insp,

trim(case when (b.vs_status = 'REJ' and b.us_status = 'AL') then '' else b.us_status end) us_status,
case when (b.vs_status = 'REJ'  and b.us_status = 'AL') then '' else b.us end  us,
case when (b.vs_status = 'REJ' and b.us_status = 'AL') then ''  WHEN
B.US_STATUS = 'RP' THEN B.US_DATA_REP ELSE B.US_DATA end us_data ,

case when  b.pm_insp like '%CIMC%' then b.vs_insp when
 (b.vs_status = 'REJ' and b.status_junta = 'Waiting Visual Test' and b.us_status = 'AL') then '' else 
b.US_insp end as us_insp,



--b.us_status,
--b.us,
--b.us_data,
--b.us_insp,


case when b.va_status = 'AP' and  b.non_execution_status like '%FT%' then b.status_junta  when
b.vs_status = 'AP' and b.non_execution_status like '%VT%' then b.status_junta else 
b.non_execution_status  end as non_execution_status ,
b.status_junta,
case when b.jobcard like '%Piol%' then 'Piol' when
b.non_execution_status like '%Gustavo%' then 'Gustavo' when
b.non_execution_status like '%Doglas%' then 'Doglas' when
b.non_execution_status like '%Johny%' then 'Johny' when
b.non_execution_status like '%Leandro%' then 'Leandro' end as Insp_rep,
case when b.non_execution_status like '%FT%' then 'Fitup' when
b.non_execution_status like '%VT%' then 'Visual' end as ensaio,
--data_rep,
cast(substring(b.data_rep from 1 for 2) as varchar (10))|| cast(substring(b.data_rep from 3 for 4) as varchar (10))|| cast(substring(b.data_rep from
7 for 10) as varchar (10)) as data_rep,
case when b.status_junta = 'Finalized' and b.us_data <> '' then b.us_data when
b.status_junta = 'Finalized' and b.us_data = '' and b.pm_data <> '' then b.pm_data when
b.status_junta = 'Finalized' and b.pm_data = '' and b.us_data = '' and b.vs_data <> '' then b.vs_data
end as dt_lib_jnt,

b.dt_cad as Cad_cad_jnt,
B.JOBCARD




----------------------------------------------------- SELECT B -----------------------------------------------------------

from(select
a.lp_data,
a.sub_bloco,
a.painel as modulo,
a.area,
a.folha,
case when a.Cod_DF_Cod_MP is null then a.peca_1 else a.Cod_DF_Cod_MP end as df,
round(a.peso,2) as peso,
cast(a.dt_cad as date) dt_cad,
a.cod_junta,
a.tipo as execucao,
a.tipo_junta,
a.nivel_inspecao,
a.extensao,
a.espessura1,
a.espessura2,
---Pre_fitup----

case when a.pre_fitup = '' then 'PREDI' else a.pre_fitup end as status_predi,
a.rel_predi,
a.dt_pre_fitup predi_data,
----VA-------
case when a.statusva = '' and a.pre_fitup = '' then 'PREDI' when
a.pre_fitup = 'AP' and a.statusva = ''  and a.non_execution_status  not like  '%FT%' then 'FUI'   when
a.pre_fitup = 'AP' and a.non_execution_status like '%FT%' and a.statusva = '' then 'REJ' when
a.pre_fitup = 'AP' and a.non_execution_status like '%FT%' and a.statusva = 'AP' then 'AP' when
a.pre_fitup = 'AP' and a.non_execution_status  NOT like '%FT%' and a.statusva = 'AP' then 'AP' 
when
a.statusva = 'AP' then  'AP' end va_status,
a.va,
case when a.pre_fitup = 'AP' and a.statusva = '' then  a.dt_pre_fitup else a.va_data end as va_data,
a.va_insp,

----RS-------
case when a.statusva = 'AP' and a.statusrs = '' and a.non_execution_status not like '%FT%' and 
a.status_junta = 'Waiting Welding Report' then 'RS' when
a.statusva = 'AP' and a.statusrs = 'AP' then 'AP' when
a.pre_fitup = '' and a.statusva = '' then '' end as rs_status,
a.rs,
case when a.statusva = 'AP' and a.statusrs is null then va_data when
a.statusva = 'AP' and a.statusrs = 'AP' then a.rs_data end rs_data,

----VS------

case when a.statusrs = 'AP' and a.statusvs = '' and a.non_execution_status not LIKE  '%VT%' then 
'VT' when
  a.statusrs = 'AP' and a.statusvs = 'AP' then 'AP' when
  a.statusrs = 'AP' and a.statusvs = '' and a.non_execution_status like '%VT%' then 'REJ' when
  a.statusrs = 'AP' and a.statusvs = '' and a.non_execution_status NOT like '%FT%' then 'VT' when
  a.statusrs = 'AP' and a.statusvs = 'AP' and a.non_execution_status like '%VT%' then 'AP'
  --a.statusvs = 'AP' then 'AP'
  end as vs_status,
  a.vs,

case when a.statusrs = 'AP' and a.statusvs = '' and a.non_execution_status like '%VT%' then

case when a.statusva = 'AP' and a.statusrs = 'AP' then a.vs_data end
 when
a.statusrs = 'AP' and a.statusvs = 'AP' and a.non_execution_status like '%VT%' then a.vs_data when
a.statusrs = 'AP' and a.statusvs = 'AP' then a.vs_data
end as vs_data,
a.vs_insp,
----PM-----
case when a.statusvs = 'AP' and a.statuspm = '' then 'MT' when
A.STATUSVS = '' AND A.STATUSPM = 'AL' THEN 'AL' WHEN
a.statusrs = 'AP' and a.statuspm <> 'NA' then a.statuspm when
a.statuspm like '%NA%' then a.statuslp end as pm_status,
case when a.statuspm like '%NA%' then a.lp else  a.pm end pm,
case when a.statusvs = 'AP' and a.statuspm = '' then a.vs_data when
a.statusvs = 'AP' and a.statuspm <> '' then  a.pm_data  when
a.statusrs = 'AP' and a.statuspm <> '' then  a.pm_data when
a.statuspm like '%NA%' then a.lp_data else a.pm_data end as pm_data,
case when a.statuspm like '%NA%' then a.lp_insp else a.pm_insp  end as pm_insp ,

----US-----

case when a.statusvs = 'AP' and a.statusus = '' then 'UT' when
A.STATUSVS = '' AND A.STATUSUS = 'AL' THEN 'AL' WHEN
a.statusvs = 'AP' and a.statusus <> ''  then a.statusus end as us_status,
a.us,
case when a.statusvs = 'AP' and a.statusus = '' then a.vs_data when
a.statusvs = 'AP' and a.statusus <> '' then  a.us_data when
a.statusrs = 'AP' and a.statusus <> '' then  a.us_data when
a.STATUSUS = 'RP' then a.US_DATA_rep  end as us_data,
A.US_DATA_REP,
a.us_insp,
a.non_execution_status,
a.status_junta,
a.jobcard,
right(a.jobcard,10) data_rep


----------------------------------------------------- SELECT A -----------------------------------------------------------
from (select
dfb.bold_id as pdfbdf,
jnt.datacadastro as dt_cad,
jnt.cod_junta,
jnt.observacoes as area,
jnt.desenhopetrobras as folha,
atd.cod_ensaio rel_predi,
jnt.statuspredi pre_fitup,
atd.data as dt_pre_fitup,
--jnt1.statusva,
case
when mdl.nome_modulo is null then mdl1.nome_modulo else mdl.nome_modulo
end as SUB_BLOCO,
case
when dmt.cod_dm is null then dmt1.cod_dm else dmt.cod_dm
end as PAINEL,
case when dfb.peso_total is null then dfb1.peso_total else dfb.peso_total end as peso,
case
when dfb.Cod_df is null then MPR.COD_MP
when MPR.COD_MP is null then dfb.Cod_df
else '' end as Cod_DF_Cod_MP,
CASE
WHEN cmp1.Cod_componente is null then dfb1.cod_df else cmp1.cod_componente end ||
case
when cmp1.ppctpcorte > 0 then ' - ' || mpr1.COD_MP else '' end as PECA_1 ,
case
WHEN cmp2.Cod_componente is null then dfb2.cod_df else cmp2.cod_componente end ||
case
when cmp2.ppctpcorte > 0 then '- ' || mpr2.COD_MP else '' end as PECA_2 ,
JobCard,
-------------------------------
jnt.nofim as Tanque,
-------------------------------
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

(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_ensaio like 'VA%'
group by jnt1.bold_id) as VA,


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
(select max(ens.cod_solda) from sldsolda ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
and tre.tipo_ens = 0
and ens.cod_solda like 'RS%'
group by jnt1.bold_id) as RS,
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
-------------------------------------------------------------------------------------------------
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

CASE
  when jnt.statusus = 'AP' then
    (select max(inp.nome) from ensensaio ens
     join tretrecho tre on tre.bold_id = ens.ptretrecho
     join inpinspetor inp on inp.bold_id = ens.pinpinspetor
     join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
     where
     jnt1.bold_id = jnt.bold_id
     and
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
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

CASE
  when jnt.statusus = 'AP' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
    join tretrecho tre on tre.bold_id = ens.ptretrecho
    join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
    where
    jnt1.bold_id = jnt.bold_id
    and
    (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
    and tre.antesTT = 0
    and ens.cod_ensaio like 'US%'
    group by jnt1.bold_id) as date)  as varchar(10))
  when jnt.statusus = 'AL' then
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


CASE
  when jnt.statusus = 'RP' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
    join tretrecho tre on tre.bold_id = ens.ptretrecho
    join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
    where
    jnt1.bold_id = jnt.bold_id
    and
    (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
    and tre.antesTT = 0
    and ens.cod_ensaio like 'US%'
    group by jnt1.bold_id) as date)  as varchar(10))
  when jnt.statusus = 'AL' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
     join assjntltj ass on ass.fjntjunta = jnt.bold_id
     join ltjlote_junta ltj on ltj.bold_id = ass.fltjlote_junta and ltj.tipo_ensaio = 5
     join ASSJNTLTJ ASS2 on ASS2.FLTJLote_junta = ltj.Bold_ID
     join JNTJunta JNT2 on ASS2.FJNTJunta = JNT2.BolD_ID and jnt2.statusus = 'RP'
     join tretrecho tre on tre.bold_id = ens.ptretrecho and tre.pjntjunta = jnt2.bold_id
     where
     (tre.classificacao = 1 or (tre.classificacao = 4 and ens.laudo = 1))
     and tre.antesTT = 0
     and ens.cod_ensaio like 'US%') as date) as varchar(10))
else ''
end as US_DATA_rep,


CLS.ENSAIOUS AS Percent_US,
------------------------------------------
jnt.statusES,
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
------------and tre.tipo_ens = 0
and ens.cod_ensaio like 'ES%'
group by jnt1.bold_id) as ES,
cast( cast((select max(ens.data) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and tre.classificacao = 0
---------------and tre.tipo_ens = 0
and ens.cod_ensaio like 'ES%'
group by jnt1.bold_id) as date) as varchar(10)) as ES_DATA,
(
select max(LTJ.Codigo)
from LTJLote_Junta LTJ
join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 3 and ASS.FJNTJunta = JNT.Bold_ID
) as LOTE_LP,
(
select max(LTJ.Codigo)
from LTJLote_Junta LTJ
join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 4 and ASS.FJNTJunta = JNT.Bold_ID
) as LOTE_PM,
(
select max(LTJ.Codigo)
from LTJLote_Junta LTJ
join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 6 and ASS.FJNTJunta = JNT.Bold_ID
) as LOTE_RX,
(
select max(LTJ.Codigo)
from LTJLote_Junta LTJ
join ASSJNTLTJ ASS on ASS.FLTJLote_Junta = LTJ.Bold_ID
where Tipo_Ensaio = 5 and ASS.FJNTJunta = JNT.Bold_ID
) as LOTE_US,
case
when jnt.statususpa <> '' then jnt.statususpa
else 'NA' end as STATUS_USPA,
(select max(ens.cod_ensaio) from ensensaio ens
join tretrecho tre on tre.bold_id = ens.ptretrecho
join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
where
jnt1.bold_id = jnt.bold_id
and
(tre.classificacao = 1 or tre.classificacao = 4)
and tre.antesTT = 7
and ens.cod_ensaio like 'UP%'
group by jnt1.cod_junta) as USPA,
CASE
  when jnt.statususpa <> '' then
    cast( cast(
    (select max(ens.data) from ensensaio ens
    join tretrecho tre on tre.bold_id = ens.ptretrecho
    join jntjunta jnt1 on jnt1.bold_id = tre.pjntjunta
    where
    jnt1.bold_id = jnt.bold_id
    and
    (tre.classificacao = 1 or tre.classificacao = 4 )
    and tre.antesTT = 7
    and ens.cod_ensaio like 'UP%'
    group by jnt1.bold_id) as date)  as varchar(10))
else ''
end as USPA_DATA,
jnt.noinicio as ETAPA,
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
when jnt.jobcard like '12%' then 'Não Soldado'||'-'||jnt.jobcard||'-'||'VT' else jnt.status_junta end 
non_execution_status,
jnt.status_junta

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
left join cmpComponente cmp1 on (cmp1.bold_id = jutF.pcmpComp1 or cmp1.bold_id = 
jutM.pcmpComp1)
left join pctplano_corte pct1 on (pct1.bold_id = cmp1.ppctpcorte)
left join mPRmateriaprima mpr1 on (mpr1.bold_id = pct1.pmprmatpri)
left join cmpComponente cmp2 on (cmp2.bold_id = jutF.pcmpComp2 or cmp2.bold_id = 
jutM.pcmpComp2)
left join pctplano_corte pct2 on (pct2.bold_id = cmp2.ppctpcorte)
left join mPRmateriaprima mpr2 on (mpr2.bold_id = pct2.pmprmatpri)
left join dfbdesenhofabricacao dfb1 on (dfb1.bold_id = jutd.pdfbdf1)
left join dfbdesenhofabricacao dfb2 on (dfb2.bold_id = jutd.pdfbdf2)
left join matMaterial mat1 on mat1.bold_id = jnt.pmatmBase1
left join matMaterial mat2 on mat2.bold_id = jnt.pmatmBase2
left join attdi att on jnt.bold_id = att.pjntjunta
left join atdatividade atd on att.bold_id = atd.bold_id

where (dfb.tipo_estrutura = 'JURONG') or (dfb1.tipo_estrutura = 'JURONG'))a)b
where b.cod_junta not like '#%' and  b.cod_junta not like '%S/R%' )c