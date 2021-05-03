import BIPV2,tools,BizLinkFull,wk_ut;

EXPORT Copy_Xlink_to_Alpha_Prod(

   pversionSuppress    
  ,pversion             = 'BIPV2.keysuffix'
  ,pistesting           = 'false'
  ,pSkipSuperStuff      = 'true'
  ,pOverwrite           = 'false'
  ,pkeyfilter2AlphaProd = '\'(bizlinkfull|segmentation_linkids|seleprox|bipv2_best|contact_title_linkids|strnbrname|zipcityst|strnbrname)\''              // copy everything in BIPV2FullKeys package
  ,psuperversions       = '\'built\''         //add them to these supers after copying
  ,pSrcDali             = '\'uspr-prod-thor-dali.risk.regn.net:7070\''
  ,pDestinationThor     = '\'thor400_112\''
) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build,BIPV2_Suppression;

  // -- keys to copy
  myfiles :=  BIPV2_Build.keynames(pversion).BIPV2FullKeys_Alpha
            ;
            
  // -- suppression key to copy.  have to use it separately since it contains a different version.
  myfiles2 := BIPV2_Build.keynames(pversionSuppress).BIPV2SuppressionKeys_Alpha;
  
  return sequential(
     // -- copy package keys and then in separate call copy the suppression key
     BIPV2_Build.Copy_BIPV2FullKeys(pversion          ,psuperversions,true ,[] ,[],pkeyfilter2AlphaProd ,pSkipSuperStuff,pOverwrite,,myfiles  ,pDestinationThor ,,,pistesting,pSrcDali)
    ,BIPV2_Build.Copy_BIPV2FullKeys(pversionSuppress  ,psuperversions,true ,[] ,[],''                   ,pSkipSuperStuff,pOverwrite,,myfiles2 ,pDestinationThor ,,,pistesting,pSrcDali)
  
     // -- promote the keys and the suppression key to the built superfiles
    ,BIPV2_Build.Promote(pversion         ,pkeyfilter2AlphaProd,,pIsTesting,myfiles ).new2Built
    ,BIPV2_Build.Promote(pversionSuppress ,                    ,,pIsTesting,myfiles2).new2Built
  );

endmacro;
