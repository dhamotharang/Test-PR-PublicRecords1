import _control, std, ut;

EXPORT Proc_Build_Disconnect_GH(string version, string thor_name, string contacts) := function

//Clear Delete/Persist Files
	clearDelete 							:= sequential(nothor(Fileservices.ClearSuperfile('~thor_data400::base::phones::disconnect_gh_main_delete', true)),
																																		nothor(Fileservices.ClearSuperfile('~thor_data400::in::phones::deact_gh_history_delete', true)),
																																		nothor(FileServices.DeleteLogicalFile('~thor_data400::persist::gong_history_deact_sameDay')));	

//Build History/Base Files																			
	buildHistBase						:= PhonesInfo.Map_Disconnect_Gong_History(version);	
	
//Move History/Base Files	
	moveHistory								:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::deact_gh_history',
																																																						'~thor_data400::in::phones::deact_gh_history_father',
																																																						'~thor_data400::in::phones::deact_gh_history_grandfather',
																																																						'~thor_data400::in::phones::deact_gh_history_delete'], '~thor_data400::in::phones::deact_gh_history_'+version, true);						
															 
	moveBase											:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::disconnect_gh_main',
																																																						'~thor_data400::base::phones::disconnect_gh_main_father',
																																																						'~thor_data400::base::phones::disconnect_gh_main_grandfather',
																																																						'~thor_data400::base::phones::disconnect_gh_main_delete'], '~thor_data400::base::phones::disconnect_gh_main_'+version, true);																						

//Send Build Status	
	emailProduct							:= ';jeffrey.dix@lexisnexisrisk.com; barbara.gress@lexisnexisrisk.com; tracy.l.smith@lexisnexisrisk.com';
	emailDOps										:= contacts;
	emailDev											:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget								:= emailDops + emailDev;
	emailBuildNotice 		:= if(count(PhonesInfo.File_Deact_GH.Main_Current(phone<>'')) > 0
																										,fileservices.SendEmail(emailTarget, 'Phones Metadata: Disconnect Gong History File', 'Phones Metadata: Disconnect Gong History File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																										,fileservices.SendEmail(emailTarget, 'Phones Metadata: No Disconnect Gong History File', 'There Were No Disconnect Gong History Records in This Build')
																										);	
/*																	
//Send Deact Gong History Flag Breakdown Notification
	emailAttTarget					:= contact + emailProduct + emailDOps + emailDev; 
	senderEmail								:= emailDev;
	
	attachment 								:= PhonesInfo.fn_Email_Attachment_Deact_GH(version);
	mailFlagAttach 				:= FileServices.SendEmailAttachData(emailAttTarget
																																																							 ,'Phones Metadata: Deact Gong History Flags - ' + version//subject
																																																							 ,'Phones Metadata: Deact Gong History Flags Workunit: ' + WORKUNIT  //body
																																																							 ,(data)attachment
																																																							 ,'text/csv'
																																																							 ,'Deact_Gong_History.csv'
																																																							 ,
																																																							 ,
																																																							 ,senderEmail);
*/	
	return sequential(clearDelete,
																			buildHistBase,
																			moveHistory,
																			moveBase,
																			emailBuildNotice);
																			//,mailFlagAttach);
	
end;