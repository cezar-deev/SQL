
select
jnt.cod_junta,
ens.cod_ensaio,
ens.data_descarregamento,
inp.cod_inspetor,
inp.nome,
mask.mascara

from ensensaio ens inner join mscmascara mask on ens.pmscmascara = mask.bold_id
inner join tretrecho tre on tre.bold_id = ens.ptretrecho
inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor

where inp.nome like '%Sidney%'

