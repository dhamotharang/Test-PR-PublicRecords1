import Workman;
EXPORT mac_WaitToUpdate(

   pEcl2Run
  ,pFilesRegex
  ,pPollingFrequency  = '5'
  ,pEmailAddresses    = 'WorkMan._Config.EmailAddressNotify'
  ,pEmailSubject      = 'workunit'
  ,pEmailBody         = ''
  ,pIsTesting         = 'true'

) :=
functionmacro

  return Workman.mac_WaitToUpdate(
     pEcl2Run
    ,pFilesRegex
    ,pPollingFrequency
    ,pEmailAddresses  
    ,pEmailSubject    
    ,pEmailBody       
    ,pIsTesting       
  );

endmacro;