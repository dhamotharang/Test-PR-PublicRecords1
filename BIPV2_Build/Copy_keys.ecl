import BIPV2,tools,BizLinkFull,wk_ut;

//copies xlink keys to other clusters on prod, and copies them to 1 cluster on dataland

EXPORT Copy_keys(

   pversion             = 'BIPV2.keysuffix'
  ,pistesting           = 'false'
  ,pSkipSuperStuff      = 'false'
  ,pOverwrite           = 'false'
  ,pkeyfilter           = '\'bizlinkfull\''
  ,pkeyfilter2Dataland  = '\'\''              // copy everything in BIPV2FullKeys package
  // ,pkeyfilter2Dataland  = '\'bizlinkfull|bipv2_seleid_relative|bipv2_best|bipv2::internal_linking\''
  ,psuperversions       = '\'built\''         //add them to these supers after copying
  ,pUniqueOut           = '\'Xlink\''
  ,pSkipDatalandCopy    = 'false'
  
) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;
  
  copy2datalandECL  := '#workunit(\'name\',\'BIPV2_Build.Copy_keys ' + pUniqueOut + ' @version@ from Prod to Dataland\');\n'
                      + 'BIPV2_Build.Copy_keys(\n\n   pversion         := \'@version@\'\n  ,pistesting       := false\n  ,pSkipSuperStuff  := true\n  ,pOverwrite       := ' + if(pOverwrite ,'true','false')+ '\n  ,pkeyfilter2Dataland       := \'' + pkeyfilter2Dataland + '\'\n  ,psuperversions   := \'built\'         //add them to these supers after copying\n);';
	kickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,wk_ut._Constants.Esp2Hthor(wk_ut._Constants.DevEsp),pESP := wk_ut._Constants.DevEsp,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'DatalandCopy',pNotifyEmails := BIPV2_Build.mod_email.emailList
                          ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::' + pUniqueOut + '_Dataland_Copy'
                          ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );  //kick off on dataland

  semail := BIPV2_Build.Send_Emails(pversion,pBuildName := 'BIPV2 Copy ' + pUniqueOut + ' Keys').BIPV2FullKeys;

  returnresult := iff(Tools._Constants.isdataland = false,
    //prod copies to each cluster
    sequential(
      if(pkeyfilter != '' //hack because we will probably never copy all of the keys to other clusters(normally a blank would signify all keys)
      ,sequential(
         BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,['thor_data400',tools.fun_Clustername_DFU('44')]  ,pkeyfilter ,pSkipSuperStuff,pOverwrite,,,tools.fun_Clustername_DFU('44') ,,,pistesting)   //copy to 44
        ,BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,['thor_data400',tools.fun_Clustername_DFU('66')]  ,pkeyfilter ,pSkipSuperStuff,pOverwrite,,,tools.fun_Clustername_DFU('66') ,,,pistesting)   //copy to 66
        ,BizLinkFull.Promote(pversion,pkeyfilter,,pIsTesting,tools.fun_Clustername_DFU('44')).new2Built
        ,BizLinkFull.Promote(pversion,pkeyfilter,,pIsTesting,tools.fun_Clustername_DFU('66')).new2Built
      ))
      ,if(pSkipDatalandCopy = false,kickDatalandCopy)
      ,semail.BuildSuccess
    )
    //copies to dataland from prod
    ,sequential(
       BIPV2_Build.Copy_BIPV2FullKeys(pversion  ,psuperversions,true ,[] ,[],pkeyfilter2Dataland,pSkipSuperStuff,pOverwrite,,,tools.fun_Clustername_DFU('') ,,,pistesting)
      ,BIPV2_Build.Promote(pversion,pkeyfilter2Dataland,,pIsTesting).new2Built
      ,BIPV2_Build.Promote(pversion,,,pIsTesting,BIPV2.Filenames(pversion).Common_Base.dall_filenames).new2built
    )
  ) : failure(semail.BuildFailure); 

  return returnresult;
  
endmacro;

//copy to dataland from prod , run on dataland    
//BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,['thor_data400',tools.fun_Groupname('20')] ,[]                                          ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := istesting )   //package file keys  
//bipv2 weekly keys(contact linkids)       
//BIPV2_Build.Copy_BIPV2FullKeys('20130528'  ,true ,[] ,[],'' ,pdestinationgroup := tools.fun_Groupname() ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting ,pFiles := bipv2_build.keynames('20130528').BIPV2WeeklyKeys)   //package file keys         
//BIPV2_Build.Copy_BIPV2FullKeys('20130718'  ,,true ,[] ,[],'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := false )   //package file keys  
