export MAC_GWLFile_Spray(sourceIP,sourcefile,filedate,group_name='\'thor400_44\'',email_target='\' \'') := 
macro
#workunit('name','Global Watch Lists')
#uniquename(spray_first)
#uniquename(pull_ofac_fse)
#uniquename(build_super)
#uniquename(build_all)
#uniquename(recordsize)
#uniquename(serverIP)

%serverIP% := map(
												sourceIP = 'edata10' => _control.IPAddress.edata10,
												sourceIP = 'edata12' => _control.IPAddress.edata12,
												sourceIP
												);

%recordsize%:=22918;

%spray_first% := FileServices.SprayFixed(%serverIP%,sourcefile, %recordsize%, group_name,'~thor_data400::in::globalwatchlists_'+filedate ,-1,,,true,true);
%pull_ofac_fse% := Globalwatchlists.Proc_Build_BW_Base(filedate); 
%build_super% 	:= sequential(
										 FileServices.StartSuperFileTransaction(),
										 FileServices.AddSuperFile('~thor_data400::base::globalwatchlists_delete', 
																							 '~thor_data400::base::globalwatchlists_father',, true),
										 FileServices.ClearSuperFile('~thor_data400::base::globalwatchlists_father'),
										 FileServices.AddSuperFile('~thor_data400::base::globalwatchlists_father', 
																							 '~thor_data400::base::globalwatchlists',, true),
										 FileServices.ClearSuperFile('~thor_data400::base::globalwatchlists'),
										 FileServices.AddSuperFile('~thor_data400::base::globalwatchlists', 
																							 '~thor_data400::in::globalwatchlists_'+filedate),
										 FileServices.AddSuperFile('~thor_data400::base::globalwatchlists', 
																							 '~thor_data400::in::globalwatchlists_ofac_fse_'+filedate),
										 FileServices.FinishSuperFileTransaction(),
										 FileServices.ClearSuperFile('~thor_data400::base::globalwatchlists_delete',true)
										 );

%build_all% 		:= GlobalWatchLists.proc_buildall(filedate);

/*
GlobalWatchLists.Out_File_GlobalWatchLists_Stats_Population(GlobalWatchLists.File_GlobalWatchLists
                                                           ,filedate
												           ,DoTheStats)
*/

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

RoxieKeyBuild.Mac_Daily_Email_Local('GLOBAL WATCH LISTS','SUCC',filedate,%send_succ_msg%,if(email_target<>' ',email_target,GlobalWatchLists.Spray_Notification_Email_Address));
RoxieKeyBuild.Mac_Daily_Email_Local('GLOBAL WATCH LISTS','FAIL',filedate,%send_fail_msg%,if(email_target<>' ',email_target,GlobalWatchLists.Spray_Notification_Email_Address));

#uniquename(update_version)

%update_version% := RoxieKeyBuild.updateversion('GlobalWatchListKeys',filedate,'jtao@seisint.com, kgummadi@seisint.com, skasavajjala@seisint.com',,'N|BN');

#uniquename(update_alpha_version)

%update_alpha_version% := RoxieKeyBuild.updateversion('GlobalWatchListKeys',filedate,'skasavajjala@seisint.com',,'N',,,'A'); 

#uniquename(create_orbitI)

%create_orbitI% := GlobalWatchLists.Proc_OrbitI_CreateBuild(filedate);

#uniquename(getupdate)

%getupdate% := GlobalWatchLists.fnOFACUpdates(filedate);



sequential(%spray_first%,%pull_ofac_fse%,%build_super%,%build_all%,%update_version%,%update_alpha_version%,%create_orbitI%,%getupdate%)//,DoTheStats)
			: success(%send_succ_msg%),
			  failure(%send_fail_msg%);

endmacro;