               /* LAUDOS E STATUS: PREDI,VA,VS,PM,US,STATUS  */

select cod_junta,statuspredi as PREDI,statusva as VA,statusrs as Resold,statusvs as VS,statusPM as PM,statusus as US,status_junta,jobcard,observacoes,datacadastro as Data_Cad,bold_id
from jntjunta
where cod_junta  like 'VP-FR3%'