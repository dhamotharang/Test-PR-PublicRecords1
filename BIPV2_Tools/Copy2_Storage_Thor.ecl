import wk_ut,_control,tools,BIPV2_Build,bipv2;

EXPORT Copy2_Storage_Thor(

   filename       
  ,pversion          = 'bipv2.keysuffix'
  ,pUniqueOut        = '\'\''
  ,pNotifyEmails     = 'BIPV2_Build.mod_email.emailList'
  ,pDeleteSourceFile = 'true'
  ,pWorkmanFilename  = '\'~bipv2_build::@version@::workunit_history::copy2Storagethor.\''
  ,pWorkmanSuper     = '\'~bipv2_build::qa::workunit_history\''
  ,tempname          = '\'\''
  ,pCluster          = '\'thor400_24_store\''
  ,pEclserver        = '\'prod_esp.br.seisint.com\''//10.241.20.202
  ,pSourceDali       = '\'prod_dali.br.seisint.com\''
  ,pOutputEcl        = 'false'
  
) := 
functionmacro

  import wk_ut,_control,tools,BIPV2_Build;

  return tools.Copy2_Storage_Thor_Submit(
     filename       
    ,pversion         
    ,pUniqueOut       
    ,pNotifyEmails    
    ,pDeleteSourceFile
    ,pWorkmanFilename + pUniqueOut
    ,pWorkmanSuper    
    ,tempname         
    ,pCluster         
    ,pEclserver       
    ,pSourceDali      
    ,pOutputEcl                
  );

endmacro;