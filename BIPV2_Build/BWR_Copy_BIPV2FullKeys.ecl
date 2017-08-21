import BIPV2,tools;
#workunit('name','BIPV2 Copy Keys');
istesting       := false;
SkipSuperStuff  := false;
oldroot         := 'thor_data400::key::bizlinkfull::' + BIPV2.keysuffix + '::';
newroot         := 'key::bizlinkfull::';
DeleteSrcFiles  := false;
lOverwrite      := true;

//copies to other clusters on prod
sequential(
  //copies bizlinkfull keys to correct names   
   BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,[oldroot ,newroot ] ,[]                                          ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname('20') ,pSkipSuperStuff := SkipSuperStuff,pDeleteSrcFiles := DeleteSrcFiles,pIsTesting := istesting,pOverwrite := lOverwrite ) // for package file     
  //copies to other clusters on prod   
  ,BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,[                 ] ,['thor_data400',tools.fun_Groupname('20')]  ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname('20') ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting )   //copy to 20         
  ,BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,[                 ] ,['thor_data400',tools.fun_Groupname('84')]  ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname('84') ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting )   //copy to 84
  ,BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,[                 ] ,['thor_data400',tools.fun_Groupname('92')]  ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname('92') ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting )   //copy to 92
  ,BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,[                 ] ,['thor_data400',tools.fun_Groupname('30')]  ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname('30') ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting )   //copy to 30

); 

//copy to dataland from prod , run on dataland    
//BIPV2_Build.Copy_BIPV2FullKeys(BIPV2.keysuffix  ,true ,['thor_data400',tools.fun_Groupname('20')] ,[]                                          ,'bizlinkfull' ,pdestinationgroup := tools.fun_Groupname() ,pIsTesting := istesting )   //package file keys  
//bipv2 weekly keys(contact linkids)       
//BIPV2_Build.Copy_BIPV2FullKeys('20130528'  ,true ,[] ,[],'' ,pdestinationgroup := tools.fun_Groupname() ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting ,pFiles := bipv2_build.keynames('20130528').BIPV2WeeklyKeys)   //package file keys         
