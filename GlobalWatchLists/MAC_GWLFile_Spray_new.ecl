EXPORT MAC_GWLFile_Spray_new(filedate,OFAC_build = '\'N\'',group_name='\'thor400_44\'',email_target='\' \'') := 
MACRO

#workunit('name','Global Watch Lists')
#uniquename(spray_first)
#uniquename(pull_ofac_fse)
#uniquename(build_super)
#uniquename(build_all)
#uniquename(recordsize)
#uniquename(validate_recs)
#uniquename(validate_key)

%recordsize%:=22918;

%spray_first% 	:= IF(OFAC_BUILD = 'N',GlobalWatchLists_Preprocess.ProcessGlobalWatchlists(filedate),GlobalWatchLists_Preprocess.ProcessOFAC_Random(filedate));
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

%validate_recs%	:= IF(OFAC_BUILD = 'N',GlobalWatchLists_Preprocess.ValidateRawName_to_Base, GlobalWAtchLists_Preprocess.ValidateOFACRaw_to_Base);

%build_all% 		:= GlobalWatchLists.proc_buildall(filedate);

%validate_key%	:= GlobalWatchLists_Preprocess.ValidateBase_to_key;



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

%update_version% := DOPS.updateversion('GlobalWatchListKeys',filedate,'jtao@seisint.com, kgummadi@seisint.com, skasavajjala@seisint.com',,'N');

/******Comment out the dops update and orbit for GWL on  Insurance end -- DF - 21830
#uniquename(update_alpha_version)

%update_alpha_version% := DOPS.updateversion('GlobalWatchListKeys',filedate,'skasavajjala@seisint.com',,'N',,,'A'); 

#uniquename(create_orbitI)

%create_orbitI% := GlobalWatchLists.Proc_OrbitI_CreateBuild(filedate);
******************************************************/
#uniquename(create_orbit)


%create_orbit% := if ( trim(filedate)[9] <> 'o',Orbit3.proc_Orbit3_CreateBuild_AddItem( 'Global Watch Lists',filedate),Orbit3.proc_Orbit3_CreateOFACBuild( 'Global Watch Lists',filedate));

#uniquename(getupdate)

%getupdate% := GlobalWatchLists.fnOFACUpdates(filedate);

#uniquename(scrubs)
%scrubs%        := Scrubs_GlobalWatchlists.BaseBuildScrubs(filedate);

sequential(
						%spray_first%,%pull_ofac_fse%,%build_super%,%validate_recs%,%build_all%,
						%validate_key%,%update_version%,/*%update_alpha_version%,%create_orbitI%,*/%create_orbit% ,%getupdate%,%scrubs%)//,DoTheStats)
			: success(%send_succ_msg%),
			  failure(%send_fail_msg%);

ENDMACRO;