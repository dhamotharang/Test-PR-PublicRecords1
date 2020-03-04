import tools,BIPV2,bipv2_build;

EXPORT proc_Copy_Xlink_To_Dataland(
   pversion             = 'BIPV2.keysuffix'
  ,pOverwrite           = 'false'
  ,pkeyfilter2Dataland  = '\'\''              // copy everything in BIPV2FullKeys package
  ,pUniqueOut           = '\'Xlink\''
  ,pCompileTest         = 'false'
  ,pdoParallel          = 'true'
) :=
functionmacro

  copy2datalandECL  := '#workunit(\'name\',\'BIPV2_Build.Copy_keys ' + pUniqueOut + ' @version@ from Prod to Dataland\');\n'
                      + 'BIPV2_Build.Copy_keys(\n\n   pversion         := \'@version@\'\n  ,pistesting       := false\n  ,pSkipSuperStuff  := true\n  ,pOverwrite       := ' + if(pOverwrite ,'true','false')+ '\n  ,pkeyfilter2Dataland       := \'' + pkeyfilter2Dataland + '\'\n  ,psuperversions   := \'built\'         //add them to these supers after copying\n);';

  import Workman,tools,BIPV2,BIPV2_Build;
  kickbuild := Workman.mac_WorkMan(copy2datalandECL ,pversion,wk_ut._Constants.Esp2Hthor(wk_ut._Constants.DevEsp),1         ,1       ,pESP := wk_ut._Constants.DevEsp ,pBuildName := pUniqueOut + 'DatalandCopy',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::' + pUniqueOut + '_Dataland_Copy'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
  );

  return kickbuild;
  
endmacro;
