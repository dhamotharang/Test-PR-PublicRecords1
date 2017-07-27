
import BIPV2;

EXPORT proc_Source_Ingest(
    pversion     = 'BIPV2.KeySuffix'
   ,pOutputECL    = 'false'
) := 
functionmacro

  import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

  myecl   :=  'import wk_ut,bipv2_build;\n\npversion := \'@version@\';\n#workunit(\'priority\',\'high\');\n#workunit (\'name\', \'BIPV2 Business Header Source Ingest -\'+pversion);\n#option(\'multiplePersistInstances\',FALSE);\n\n//Build_Ingest := output(BIPV2.BL_Init());\nBuild_Stats	 := BIPV2.BH_Source_Ingest_Field_Pop_stats;\n\n// -- Send Orbit item list--makes it easier to fill this out in Orbit\nfileitems         := wk_ut.get_StringFilesRead(workunit,\'^(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$\');  \nSendOrbitItemList := BIPV2_Build.Send_Emails(pversion,pBuildName := \'BIPV2 Full Build Orbit Item List\',pBuildMessage := fileitems).BIPV2WeeklyKeys.BuildNote;\n\n'
            + 'sequential( BIPV2.Create_Supers\n					 ,BIPV2.Build_Source_Ingest(pversion)\n					 ,Build_Stats\n           ,SendOrbitItemList\n					);\n//EXPORT BWR_Build_Source_Ingest := \'todo\';';
  cluster := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(myecl,1,1,pversion,[],cluster,BIPV2_Build.mod_email.emailList + ',giri.rajulapalli@lexisnexis.com',,pOutputECL,'BIPV2_Source_Ingest'
    ,'~bipv2_build::' + pversion + '::workunit_history::proc_Source_Ingest'
    ,'~bipv2_build::qa::workunit_history'                                   
  );
  
  return kickBuild;

endmacro;
