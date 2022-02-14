select
    dados.cod_dm,
     sum(dados.peso_total) as peso_escopo
     , sum(dados.extensao) as jnt_ext
from
(select
        dfb.tipo_estrutura
        , mdl.nome_modulo
        , dmt.cod_dm
        , dfb.cod_df
        , dfb.peso_total
        , av.jnt_ext as extensao

  from
        dfbdesenhofabricacao dfb
        inner join dmtdesenhomontagem dmt on dfb.pdmtdm = dmt.bold_id
        inner join mdlmodulo mdl on dmt.pmdlmodulo = mdl.bold_id
        left join gat_avancodf_fab av on dfb.bold_id = av.pdfbdf
        left join gat_avancocmp cmps on dfb.bold_id = cmps.pdfbdf) dados

        where
     DADOS.tipo_estrutura = @tipo_estrutura

        group by 1