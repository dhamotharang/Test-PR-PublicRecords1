// tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(pSuperfileIn)[1].name)  ,pDeleteSourceFile  := true));

import wk_ut,_control;

EXPORT Copy2_Storage_Thor_Parallel(

   filename       
  ,pversion          = '\'\''
  ,pUniqueOut        = '\'\''
  ,pNotifyEmails     = '_control.MyInfo.emailaddressnotify'
  ,pDeleteSourceFile = 'false'
  ,pWorkmanFilename  = '\'\''
  ,pWorkmanSuper     = '\'\''
  ,tempname          = '\'\''
  ,pCluster          = '\'thor400_24_store\''
  ,pEclserver        = '\'prod_esp.br.seisint.com\''//10.241.20.202
  ,pSourceDali       = '\'prod_dali.br.seisint.com\''
  ,pOutputEcl        = 'false'
  
) := 
functionmacro

  doDelete := if(pDeleteSourceFile = true,'true','false');
  cluster := wk_ut._Constants.localhthor;

  ecl := 
        '#workunit(\'name\',\'tools.Copy2_Storage_Thor ' + filename + ' ' + pversion + '\');\n'
    +   'tools.Copy2_Storage_Thor('
    +   '\'' + filename    + '\''
    + ' ,\'' + tempname    + '\''
    + ' ,\'' + pCluster    + '\''
    + ' ,'   + doDelete    + ''
    + ' ,\'' + pEclserver  + '\''
    + ' ,\'' + pSourceDali + '\');'
    ;

  kickCopy := wk_ut.mac_ChainWuids(ecl  ,1 ,1        ,pversion  ,[] ,cluster,pNotifyEmails,,pOutputEcl,pUniqueOut      
      ,pOutputFilename   := pWorkmanFilename
      ,pOutputSuperfile  := pWorkmanSuper 
      // ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::copy2Storagethor.' + pUniqueOut
      // ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );

  return if(not wk_ut._constants.IsDev ,kickCopy);


endmacro;