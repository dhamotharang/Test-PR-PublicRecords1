import tools,BIPV2,bipv2_build;

EXPORT proc_Copy_Xlink_To_AlphaProd(
   pversion         = 'BIPV2.KeySuffix'
  ,pcluster         = '\'hthor_prod_eclcc\''
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
  ,pdoParallel      = 'true'
  ,pLESP            = '\'alpha_prod_thor_esp.risk.regn.net\''
) :=
functionmacro
    
  // version           := pversion                         ;
  cluster           := pcluster                         ;
  
  ecl_text :=   '#workunit(\'name\',\'BIPV2_Build.Copy_Xlink_to_Alpha_Prod @version@\');\n\n'
              + '#workunit(\'priority\',\'high\');\n'
              + 'BIPV2_Build.Copy_Xlink_to_Alpha_Prod(\'@version@\',false,true,false,\'(bizlinkfull|segmentation_linkids|seleprox|bipv2_best|contact_title_linkids)\');'
              ;
                     
  import Workman,tools,BIPV2,BIPV2_Build;
  kickbuild := Workman.mac_WorkMan(ecl_text ,pversion,cluster,1         ,1       ,pESP := pLESP ,pBuildName := 'Copy_Xlink_to_Alpha_Prod',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::BIPV2_Build.Copy_Xlink_to_Alpha_Prod'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
  );

  return kickbuild;
  

endmacro;
