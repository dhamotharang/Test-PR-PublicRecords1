import wk_ut,_control;

EXPORT Copy2_Storage_Thor_Submit(

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

  import wk_ut;
  
  doDelete := if(pDeleteSourceFile = true,'true','false');
  cluster := wk_ut._Constants.localhthor;

  ecl := 
      '#workunit(\'name\',\'tools.Submit_Copy2_Storage_Thor ' + filename + ' ' + pversion + '\');\n' 
    + 'tools.Copy2_Storage_Thor_Parallel('
    +   '\'' + filename         + '\''
    + ' ,\'' + pversion         + '\''
    + ' ,\'' + pUniqueOut       + '\''
    + ' ,\'' + pNotifyEmails    + '\''
    + ' ,'   + doDelete         + ''
    + ' ,\'' + pWorkmanFilename + '\''
    + ' ,\'' + pWorkmanSuper    + '\''
    + ' ,\'' + tempname         + '\''
    + ' ,\'' + pCluster         + '\''
    + ' ,\'' + pEclserver       + '\''
    + ' ,\'' + pSourceDali      + '\');'
    ;

  kickWuid	  := wk_ut.CreateWuid(ecl,cluster);

  wuid_link := '<a href="http://' + wk_ut._constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + kickWuid + '#/stub/Summary">Storage Thor Copy Wuid</a>';
  
  return if(pOutputEcl = false  ,wuid_link  ,ecl);

endmacro;