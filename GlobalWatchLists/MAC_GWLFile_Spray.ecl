export MAC_GWLFile_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_200\'',email_target='\' \'') := 
macro
#workunit('name','Global Watch Lists')
#uniquename(spray_first)
#uniquename(build_super)
#uniquename(build_all)
#uniquename(recordsize)

%recordsize%:=22918;

%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::globalwatchlists_'+filedate ,-1,,,true,true);
%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			     FileServices.AddSuperFile('~thor_data400::base::globalwatchlists_delete', 
                                           '~thor_data400::base::globalwatchlists_father',, true),
                 FileServices.ClearSuperFile('~thor_data400::base::globalwatchlists_father'),
                 FileServices.AddSuperFile('~thor_data400::base::globalwatchlists_father', 
                                           '~thor_data400::base::globalwatchlists',, true),
                 FileServices.ClearSuperFile('~thor_data400::base::globalwatchlists'),
                 FileServices.AddSuperFile('~thor_data400::base::globalwatchlists', 
                                           '~thor_data400::in::globalwatchlists_'+filedate), 
			     FileServices.FinishSuperFileTransaction(),
                 FileServices.ClearSuperFile('~thor_data400::base::globalwatchlists_delete',true));

%build_all% := GlobalWatchLists.proc_buildall(filedate);

/*
GlobalWatchLists.Out_File_GlobalWatchLists_Stats_Population(GlobalWatchLists.File_GlobalWatchLists
                                                           ,filedate
												           ,DoTheStats)
*/

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

RoxieKeyBuild.Mac_Daily_Email_Local('GLOBAL WATCH LISTS','SUCC',filedate,%send_succ_msg%,if(email_target<>' ',email_target,GlobalWatchLists.Spray_Notification_Email_Address));
RoxieKeyBuild.Mac_Daily_Email_Local('GLOBAL WATCH LISTS','FAIL',filedate,%send_fail_msg%,if(email_target<>' ',email_target,GlobalWatchLists.Spray_Notification_Email_Address));

sequential(%spray_first%,%build_super%,%build_all%)//,DoTheStats)
			: success(%send_succ_msg%),
			  failure(%send_fail_msg%);

endmacro;