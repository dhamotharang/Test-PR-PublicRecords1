EXPORT mac_WaitToUpdate(

   pEcl2Run
  ,pFilesRegex
  ,pPollingFrequency  = '5'
  ,pEmailAddresses    = '_control.myinfo.emailaddressnotify'
  ,pEmailSubject      = 'workunit'
  ,pEmailBody         = ''
  ,pIsTesting         = 'true'

) :=
functionmacro
  
  import BizLinkFull,wk_ut_dev,tools,_control,ut,bipv2;

  cronFreq        := CRON('0-59/' + pPollingFrequency + ' * * * *');

  promotetobuilt        := pEcl2Run;
  dFilesUsedByRunningProcesses := wk_ut_dev.get_FilesRead_Multiple(,,pFilesRegex);

  sendemail1 := wk_ut_dev.Send_Email(
                               pEmailAddresses
                              ,pEmailSubject + ' starting on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate()
                              ,pEmailBody + '\n' + workunit
                            );

  sendemail2 := wk_ut_dev.Send_Email(
                               pEmailAddresses
                              ,pEmailSubject + ' Finished on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate()
                              ,pEmailBody + '\n' + workunit
                            );
  dothis := sequential(
     output('Checking for ' + pEmailSubject + ' files on ' + ut.GetTimeDate())
    ,output(dFilesUsedByRunningProcesses,all)
    ,output(dataset([{ut.GetTimeDate()}],{string Ran})  ,named('Running'),EXTEND)
    ,iff(not exists(dFilesUsedByRunningProcesses)  ,sequential(sendemail1,pEcl2Run,sendemail2,FAIL(pEmailSubject + ' Finished on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate())))
  );

  keepdoingthis :=  dothis : WHEN(cronFreq);
  
  return iff(pIsTesting  = true  ,dothis ,keepdoingthis);

endmacro;