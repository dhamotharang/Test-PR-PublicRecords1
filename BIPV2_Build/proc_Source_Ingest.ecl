
import BIPV2;

EXPORT proc_Source_Ingest(

    pversion     = 'BIPV2.KeySuffix'
   ,pOutputECL   = 'false'
   
) := 
functionmacro

  import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

  //got code from here: BIPV2.BWR_Build_Source_Ingest.  run this to get updated code if it changes: wk_ut.get_Attribute_Text('BIPV2.BWR_Build_Source_Ingest');
  myecl   :=  'import wk_ut,bipv2_build,strata;\n\npversion := \'@version@\';\n\n#workunit (\'name\', \'BIPV2.BWR_Build_Source_Ingest \' + pversion);\n#option   (\'multiplePersistInstances\',FALSE);\n\n'
            + 'Build_Stats	        := BIPV2.BH_Source_Ingest_Field_Pop_stats;\n'
            + 'sequential( \n   BIPV2.Create_Supers\n  ,BIPV2.Build_Source_Ingest(pversion)\n  ,Build_Stats\n  \n);\n'
  ;
  
  cluster := BIPV2_Build._Constants().Groupname;
  
  kickBuild := wk_ut.mac_ChainWuids(myecl,1,1,pversion,[],cluster,BIPV2_Build.mod_email.emailList + ',giri.rajulapalli@lexisnexis.com',,pOutputECL,'BIPV2_Source_Ingest'
    ,'~bipv2_build::' + pversion + '::workunit_history::proc_Source_Ingest'
    ,'~bipv2_build::qa::workunit_history'                                   
  );
  
  return kickBuild;

endmacro;
