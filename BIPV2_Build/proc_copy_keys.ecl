import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;

//copies xlink keys to other clusters on prod, and copies them to 1 cluster on dataland

EXPORT proc_copy_keys(

   pversion             = 'BIPV2.keysuffix'
  ,pkeyfilter           = '\'bizlinkfull\''
  ,pkeyfilter2Dataland  = '\'bizlinkfull|bipv2_seleid_relative|bipv2_best|bipv2::internal_linking\''
  ,pUniqueOut           = '\'Xlink\''
  ,pOverwrite           = '\'false\''

) :=
functionmacro

  import BIPV2,tools,BizLinkFull,wk_ut,bipv2_build;
  copyECL   := '#workunit(\'name\',\'BIPV2_Build.Copy_keys ' + pUniqueOut + ' @version@\');\n' + 'BIPV2_Build.Copy_keys      (\'@version@\'\n,pOverwrite := ' + pOverwrite + '\n,pkeyfilter := \'' + pkeyfilter + '\'\n,pkeyfilter2Dataland := \'' + pkeyfilter2Dataland + '\'\n,pUniqueOut := \'' + pUniqueOut + '\'\n);';
  kickCopy	:= wk_ut.mac_ChainWuids(copyECL,1,1,pversion,,wk_ut._constants.LocalHthor,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Copy',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_copy_keys' + '.' + pUniqueOut
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
);

  return kickCopy;
  
endmacro;

//copy to dataland from prod , run on dataland    
//BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,['thor_data400',tools.fun_Groupname('20')] ,[]                                          ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := istesting )   //package file keys  
//bipv2 weekly keys(contact linkids)       
//BIPV2_Build.Copy_BIPV2FullKeys('20130528'  ,true ,[] ,[],'' ,pdestinationgroup := tools.fun_Groupname() ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting ,pFiles := bipv2_build.keynames('20130528').BIPV2WeeklyKeys)   //package file keys         
//BIPV2_Build.Copy_BIPV2FullKeys('20130718'  ,,true ,[] ,[],'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := false )   //package file keys  
