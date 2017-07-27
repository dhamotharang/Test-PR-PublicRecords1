EXPORT mac_WaitToUpdate(

   pEcl2Run
  ,pFilesRegex
  ,pPollingFrequency  = '5'
  ,pEmailAddresses    = 'wk_ut._Constants.EmailAddressNotify'
  ,pEmailSubject      = 'workunit'
  ,pEmailBody         = ''
  ,pIsTesting         = 'true'

) :=
functionmacro
  
  import BizLinkFull,wk_ut,tools,_control,ut,bipv2;

  cronFreq        := CRON('0-59/' + pPollingFrequency + ' * * * *');

  promotetobuilt        := pEcl2Run;
  dFilesUsedByRunningProcesses := wk_ut.get_FilesRead_Multiple(,,pFilesRegex);

  sendemail1 := wk_ut.Send_Email(
                               pEmailAddresses
                              ,pEmailSubject + ' starting on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                              ,pEmailBody + '\n' + workunit
                            );

  sendemail2 := wk_ut.Send_Email(
                               pEmailAddresses
                              ,pEmailSubject + ' Finished on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                              ,pEmailBody + '\n' + workunit
                            );
  dothis := sequential(
     output('Checking for ' + pEmailSubject + ' files on ' + wk_ut.getTimeDate())
    ,output(dFilesUsedByRunningProcesses,all)
    ,output(dataset([{wk_ut.getTimeDate()}],{string Ran})  ,named('Running'),EXTEND)
    ,iff(not exists(dFilesUsedByRunningProcesses)  ,sequential(sendemail1,pEcl2Run,sendemail2,FAIL(pEmailSubject + ' Finished on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate())))
  );

  keepdoingthis :=  dothis : WHEN(cronFreq);
  
  return iff(pIsTesting  = true  ,dothis ,keepdoingthis);

endmacro;