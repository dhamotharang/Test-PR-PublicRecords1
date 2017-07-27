import addr_latest;

export mac_la_process(FTPServerIP,outfile,statfile,email_target='\' \'') := macro

#uniquename(super_out)
#uniquename(super_stat)
#uniquename(match_them)
#uniquename(spray_out)
#uniquename(spray_stat)

%super_out% := '~thor_data400::base::linebarger_watch';
%super_stat% := '~thor_data400::base::linebarger_stat';

%match_them% := addr_latest.bwr_la_search;
%spray_out% := FileServices.Despray(%super_out%,FTPServerIP,outfile,-1,,,true);
%spray_stat% := FileServices.Despray(%super_stat%,FTPServerIP,statfile,-1,,,true);

sequential(%match_them%,%spray_out%,%spray_stat%)
 : success(lib_fileservices.FileServices.sendemail(if(email_target<>' ',email_target,Addr_latest.Spray_Notification_Email_Address),'Linebarger Process Succeeded',
           'Output file: ' + outfile + ' and Stat file: ' + statfile + ' have been created!')),
   failure(lib_fileservices.FileServices.sendemail(if(email_target<>' ',email_target,Addr_latest.Spray_Notification_Email_Address),'Linebarger Process Failure',
           FAILMESSAGE));

endmacro;