import BIPV2,tools,BizLinkFull,wk_ut;

//copies xlink keys to other clusters on prod, and copies them to 1 cluster on dataland

EXPORT Copy_xlink_keys(

   pversion             = 'BIPV2.keysuffix'
  ,pistesting           = 'false'
  ,pSkipSuperStuff      = 'false'
  ,pOverwrite           = 'false'
  ,pkeyfilter           = '\'bizlinkfull\''
  ,pkeyfilter2Dataland  = '\'bizlinkfull|bipv2_seleid_relative|bipv2_best\''
  ,psuperversions       = '\'built\''         //add them to these supers after copying

) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;
  
  copy2datalandECL  := '#workunit(\'name\',\'BIPV2_Build.Copy_xlink_keys @version@ from Prod to Dataland\');\\nBIPV2_Build.Copy_xlink_keys(\\n\\n   pversion         := \'@version@\'\\n  ,pistesting       := false\\n  ,pSkipSuperStuff  := true\\n  ,pOverwrite       := false\\n  ,pkeyfilter2Dataland       := \'bizlinkfull|bipv2_seleid_relative|bipv2_best\'\\n  ,psuperversions   := \'built\'         //add them to these supers after copying\\n);';
	kickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,'infinband_hthor',pESP := '10.241.3.242',pOutputEcl := false,pUniqueOutput := 'XlinkDatalandCopy');  //kick off on dataland

  semail := BIPV2_Build.Send_Emails(pversion,pBuildName := 'BIPV2 Copy Xlink Keys').BIPV2FullKeys;

  returnresult := iff(Tools._Constants.isdataland = false,
    //prod copies to each cluster
    sequential(
       BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,['thor_data400',tools.fun_Groupname('20')]  ,pkeyfilter ,pSkipSuperStuff,pOverwrite,,,tools.fun_Groupname('20') ,,,pistesting)   //copy to 20         
      ,BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,['thor_data400',tools.fun_Groupname('92')]  ,pkeyfilter ,pSkipSuperStuff,pOverwrite,,,tools.fun_Groupname('92') ,,,pistesting)   //copy to 92
      ,BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,['thor_data400',tools.fun_Groupname('30')]  ,pkeyfilter ,pSkipSuperStuff,pOverwrite,,,tools.fun_Groupname('30') ,,,pistesting)   //copy to 30
      ,BizLinkFull.Promote(pversion,pkeyfilter,,pIsTesting,tools.fun_Groupname('20')).new2Built
      ,BizLinkFull.Promote(pversion,pkeyfilter,,pIsTesting,tools.fun_Groupname('92')).new2Built
      ,BizLinkFull.Promote(pversion,pkeyfilter,,pIsTesting,tools.fun_Groupname('30')).new2Built
      ,kickDatalandCopy
      ,semail.BuildSuccess
    )
    //copies to dataland from prod
    ,sequential(
       BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,[],pkeyfilter2Dataland,pSkipSuperStuff,pOverwrite,,,tools.fun_Groupname('') ,,,pistesting)
      ,BIPV2_Build.Promote(pversion,pkeyfilter2Dataland,,pIsTesting).new2Built
    )
  ) : failure(semail.BuildFailure); 

  return returnresult;
  
endmacro;

//copy to dataland from prod , run on dataland    
//BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,['thor_data400',tools.fun_Groupname('20')] ,[]                                          ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := istesting )   //package file keys  
//bipv2 weekly keys(contact linkids)       
//BIPV2_Build.Copy_BIPV2FullKeys('20130528'  ,true ,[] ,[],'' ,pdestinationgroup := tools.fun_Groupname() ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting ,pFiles := bipv2_build.keynames('20130528').BIPV2WeeklyKeys)   //package file keys         
//BIPV2_Build.Copy_BIPV2FullKeys('20130718'  ,,true ,[] ,[],'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := false )   //package file keys  
