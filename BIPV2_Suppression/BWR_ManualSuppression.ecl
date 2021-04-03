/*
  this will add seleid, proxid candidates to the suppression key, and update dops BIPV2SuppressionKeys package
*/

Build_date  := '20170420' ; 
IsTesting   := true       ; // true = output the new data to the wuid only.  false = build new suppression file and key, and update DOPS.

ds_suppression_sele_prox := 
  DATASET([
  
     {41375887  ,97700107 }
    ,{51780264  ,72420739 }
    ,{23045450  ,250034805}
    
  ],{UNSIGNED seleid,UNSIGNED proxid});


BIPV2_Suppression.Proc_build_candidates(
   ds_suppression_sele_prox
  ,Build_date
  ,IsTesting
);