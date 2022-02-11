//PENDENCIA DE PINTURA

SELECT
COD_DF,
STATUS_DF_FAB,
STATUS_DF_MNT
     FROM DFBDESENHOFABRICACAO
               WHERE STATUS_DF_FAB lIKE '%Pintura' or STATUS_DF_MNT lIKE '%Pintura'

//----


SELECT
MDL.NOME_MODULO AS MODULO,
DMT.COD_DM,
DFB.COD_DF,
DFB.ROMANEIO AS SMP,
CNP.COD_CONDPI,
DFB.STATUS_DF_FAB,
DFB.STATUS_DF_MNT

     FROM DFBDESENHOFABRICACAO DFB
     LEFT JOIN CNPCODICAOPINTURA CNP ON CNP.BOLD_ID = DFB.PCNPCODPIN
     LEFT JOIN DMTDESENHOMONTAGEM DMT ON DMT.BOLD_ID = DFB.PDMTDM
     LEFT JOIN MDLMODULO MDL ON MDL.BOLD_ID = DMT.PMDLMODULO
               WHERE DFB.STATUS_DF_FAB lIKE '%Pintura' or DFB.STATUS_DF_MNT lIKE '%Pintura'

//---------------------------

//REL PINTURA DE FAB//

SELECT
PDFBDF, 
COD_ENSAIO,
DATA,
TIPO_ATD
FROM ATDATIVIDADE
WHERE COD_ENSAIO LIKE 'PI%' AND TIPO_ATD='FBR'

//---------------------------

//REL PINTURA DE MNT//

SELECT
PDFBDF, 
COD_ENSAIO,
DATA,
TIPO_ATD
FROM ATDATIVIDADE
WHERE COD_ENSAIO LIKE 'PI%' AND TIPO_ATD='MNT'

//----------------------------------

SELECT
MDL.NOME_MODULO AS MODULO,
DMT.COD_DM,
DFB.COD_DF,
DFB.ROMANEIO AS SMP,
CNP.COD_CONDPI,
DFB.STATUS_DF_FAB,
FAB.COD_ENSAIO AS REL_PINT_FAB,
DFB.STATUS_DF_MNT,
MON.COD_ENSAIO AS REL_PINT_MNT
     FROM DFBDESENHOFABRICACAO DFB
     LEFT JOIN CNPCODICAOPINTURA CNP ON CNP.BOLD_ID = DFB.PCNPCODPIN
     LEFT JOIN DMTDESENHOMONTAGEM DMT ON DMT.BOLD_ID = DFB.PDMTDM
     LEFT JOIN MDLMODULO MDL ON MDL.BOLD_ID = DMT.PMDLMODULO
     LEFT JOIN 
                (SELECT
                PDFBDF, 
                COD_ENSAIO,
                DATA,
                TIPO_ATD
                FROM ATDATIVIDADE
                WHERE COD_ENSAIO LIKE 'PI%' AND TIPO_ATD='FBR') FAB ON FAB.PDFBDF = DFB.BOLD_ID
    LEFT JOIN   
                (SELECT
                PDFBDF, 
                COD_ENSAIO,
                DATA,
                TIPO_ATD
                FROM ATDATIVIDADE
                WHERE COD_ENSAIO LIKE 'PI%' AND TIPO_ATD='MNT') MON ON MON.PDFBDF = DFB.BOLD_ID