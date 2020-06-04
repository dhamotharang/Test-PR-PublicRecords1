import BIPV2,tools,BizLinkFull,wk_ut;

EXPORT Copy_Xlink_to_Alpha_Prod(

   pversion             = 'BIPV2.keysuffix'
  ,pistesting           = 'false'
  ,pSkipSuperStuff      = 'true'
  ,pOverwrite           = 'false'
  ,pkeyfilter2AlphaProd = '\'(bizlinkfull|segmentation_linkids|seleprox|bipv2_best|contact_title_linkids)\''              // copy everything in BIPV2FullKeys package
  ,psuperversions       = '\'built\''         //add them to these supers after copying
  ,pSrcDali             = '\'uspr-prod-thor-dali.risk.regn.net:7070\''
  ,pDestinationThor     = '\'thor400_112\''
) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build,BIPV2_Suppression;

  // pversion            := '20190601';
  // psuperversions      := 'qa'  ;       //add them to these supers after copying
  // pkeyfilter2AlphaProd := 'bizlinkfull';
  // pSkipSuperStuff     := true;
  // pOverwrite          := false;
  // pistesting          := false;
  // pSrcDali            := 'prod_dali.br.seisint.com:7070';

  myfiles :=  BIPV2_Build.keynames(pversion).BIPV2FullKeys 
            + BIPV2_Build.keynames(pversion).BIPV2WeeklyKeys 
            + BIPV2_Suppression.FileNames.key_sele_prox_names(pversion).dall_filenames
            ;
  
  return sequential(
     BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,[],pkeyfilter2AlphaProd,pSkipSuperStuff,pOverwrite,,myfiles,pDestinationThor ,,,pistesting,pSrcDali)
    ,BIPV2_Build.Promote(pversion,pkeyfilter2AlphaProd,,pIsTesting,myfiles).new2Built
  );

endmacro;
