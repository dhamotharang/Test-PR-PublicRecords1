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
  
  import BizLinkFull,WorkMan,tools,_control,ut,bipv2;

  cronFreq        := CRON('0-59/' + pPollingFrequency + ' * * * *');

  promotetobuilt        := pEcl2Run;
  dFilesUsedByRunningProcesses := WorkMan.get_FilesRead_Multiple(,,pFilesRegex);

  sendemail1 := WorkMan.Send_Email(
                               pEmailAddresses
                              ,pEmailSubject + ' starting on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                              ,pEmailBody + '\n' + workunit
                            );

  sendemail2 := WorkMan.Send_Email(
                               pEmailAddresses
                              ,pEmailSubject + ' Finished on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                              ,pEmailBody + '\n' + workunit
                            );
  dothis := sequential(
     output('Checking for ' + pEmailSubject + ' files on ' + WorkMan.getTimeDate())
    ,output(dFilesUsedByRunningProcesses,all)
    ,output(dataset([{WorkMan.getTimeDate()}],{string Ran})  ,named('Running'),EXTEND)
    ,iff(not exists(dFilesUsedByRunningProcesses)  ,sequential(sendemail1,pEcl2Run,sendemail2,FAIL(pEmailSubject + ' Finished on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate())))
  );

  keepdoingthis :=  dothis : WHEN(cronFreq);
  
  return iff(pIsTesting  = true  ,dothis ,keepdoingthis);

endmacro;