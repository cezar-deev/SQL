/* Resumod e baixas por periodo */

select
a.inspetor,
sum(a.tj) as tj,
sum(a.tjva) as tjva,
sum(a.tjvs) as tjvs,
sum(a.tjpm) as tjpm,
sum(a.tjus) as tjus,
a.data data

from (select
case when inp.nome like '%Piol%' then 'Piol' when
inp.nome like '%Gustavo%' then 'Gustavo' when
inp.nome like '%Leandro%' then 'Leandro' when
inp.nome like '%Leandro%' then 'Leandro' when
inp.nome like '%Sidney%' then 'Sidney' when
inp.nome like '%FIRMINO%' then 'Firmino'
else inp.nome end as Inspetor,

sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)TJUS,
sum(case when ens.cod_ensaio like '%US%' then jnt.extensao else 0 end)EXT_US,
ens.data_descarregamento as data

from ensensaio ens inner join tretrecho tre on ens.ptretrecho = tre.bold_id
inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor

where cast(ens.data_descarregamento as date) between '12.11.2021'  and CURRENT_DATE  and (jnt.cod_junta not like '#%')

group by
inp.nome,
ens.data_descarregamento)a

group by
a.inspetor,
a.data

order by
a.data
