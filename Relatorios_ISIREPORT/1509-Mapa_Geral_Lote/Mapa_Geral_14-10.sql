

select
isi.painel as module,
jnt.desenhopetrobras as weld_map,
jnt.cod_junta joint,
ISI.LOTE_US,
ISI.PERCENT_US,
ISI.LOTE_PM,
ISI.PERCENT_PM,
JNT.NIVEL_INSPECAO,
ISI.TIPO_JUNTA,
jnt.extensao,
decode(jnt.execucao
            , 0, 'OFC'
            , 1, 'MNT'
            , 2, 'PMN'
            , 3, 'EDF') as stage,


jnt.statuspredi pre_fitup,
atd.data as dt_pre_fitup,
jnt.statusva ft,
isi.va_data,
jnt.statusrs wr,
cast(sol.rs_solda_data as date) as rs_data,
jnt.statusvs vt,
isi.vs_data,
jnt.statuspm mt,
isi.pm_data,
jnt.statusus ut,
isi.US_data,

case when isi.jobcard like '01%' then 'Falta Controlbox'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '02%' then 'Abertura de Raiz'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '03%' then 'Desalinhamento'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '04%' then 'Ângulo Chanfro / Nariz / Delardagem'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '05%' then 'Não Montado'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '13%' then 'Falta Ajuste'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '14%' then 'Sem Acesso'||'-'||isi.jobcard||'-'||'FT'
when isi.jobcard like '06%' then 'Falta preparação superfície (respingo, escoria)'||'-'||isi.jobcard||'-'||'VT'
when isi.jobcard like '07%' then 'Porosidade'||'-'||isi.jobcard||'-'||'VT'
when isi.jobcard like '08%' then 'Mordedura'||'-'||isi.jobcard||'-'||'VT'
when isi.jobcard like '09%' then 'Trinca'||'-'||isi.jobcard||'-'||'VT'
when isi.jobcard like '10%' then 'Reforço Exc.'||'-'||isi.jobcard||'-'||'VT'
when isi.jobcard like '11%' then 'Não Montado'||'-'||isi.jobcard||'-'||'VT'
when isi.jobcard like '12%' then 'Não Soldado'||'-'||isi.jobcard||'-'||'VT' else jnt.status_junta end non_execution_status,
isi.status_junta,
isi.jobcard


from vw_isireport_juntainspecionada isi
inner join jntjunta jnt on jnt.cod_junta = isi.cod_junta
left join attdi att on jnt.bold_id = att.pjntjunta
left join atdatividade atd on att.bold_id = atd.bold_id
inner join gat_solda sol on sol.pjntjunta = jnt.bold_id

where jnt.cod_junta not like '%#%' and jnt.desenhopetrobras not like '%#%'
and (isi.painel NOT LIKE '%TLQ%' AND ISI.painel NOT LIKE '%UR%' AND ISI.painel NOT LIKE '%PPR%'  )
