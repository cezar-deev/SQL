
select 
    (
    CASE @SITE
      WHEN 'JURONG' THEN
          'Brazil'
	  WHEN 'DSMT' THEN
          'Korea'
      WHEN 'TERCIARIO' THEN    
      'Brazil'    
    END) AS ndt_test
from prgprojeto