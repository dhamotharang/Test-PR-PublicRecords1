/*
  Will watch a workunit and send an email when the workunit stops(either completes, fails or aborts)

  Example of it being used on a workunit.  It will check every minute in this case:
  tools.mac_Notify('W20121219-174443',,'1');

*/
EXPORT mac_Notify(
     pWorkunit                                                //workunit to watch
    ,pNotifyEmails     = '_control.MyInfo.EmailAddressNotify' //emails to send to when workunit stops(completes,fails or aborts)
    ,pPollingFrequency = '\'5\''                              //in minutes.  So 5 means poll every 5 minutes.
) := 
macro
  tools.Workunit_utils.mac_NotifyMe(pWorkunit,pNotifyEmails,pPollingFrequency);
endmacro;
