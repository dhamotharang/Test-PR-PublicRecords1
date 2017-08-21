import Doxie, RoxieKeyBuild, std, Ut;

EXPORT Proc_Build_Common_Port_Key(string version, string version2):= function

//Process Daily Update Files
	processTCPA := PhonesInfo.Proc_Build_TCPA_Port_File(version);
	processICon	:= PhonesInfo.Proc_Build_iConectiv_Port_File(version2);
	
//Create Common Base for Update Files	
	buildComBase:= output(PhonesInfo.Map_Common_Port_Main,,'~thor_data400::base::phones::ported_common_main_'+version, overwrite, __compressed__);

	clearDelete := nothor(fileservices.clearsuperfile('~thor_data400::base::phones::ported_common_main_delete', true));		
	
	moveComBase	:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::ported_common_main',
																								'~thor_data400::base::phones::ported_common_main_father',
																								'~thor_data400::base::phones::ported_common_main_grandfather',
																								'~thor_data400::base::phones::ported_common_main_delete'], '~thor_data400::base::phones::ported_common_main_'+version, true);

//Build Common Ported Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhonesInfo.Key_Phones.Ported
																							,'~thor_data400::key::phones_ported'
																							,'~thor_data400::key::'+version+'::phones_ported'
																							,bkPhonesPort
																							);	

//Move Common Ported Key to Superfiles	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phones_ported'
																							,'~thor_data400::key::'+version+'::phones_ported'
																							,mvBltPhonesPort
																							);
	
	ut.mac_sk_move_v2('~thor_data400::key::phones_ported','Q',mvQAPhonesPort);

	//Run Build & Provide Email on Build Status
	sendEmail				:= sequential(processTCPA, processICon, buildComBase, clearDelete, moveComBase, bkPhonesPort, mvBltPhonesPort, mvQAPhonesPort):
																Success(FileServices.SendEmail('judy.tao@lexisnexis.com', 'PhonesInfo Port Key Build Succeeded', workunit + ': Build complete.')),
																Failure(FileServices.SendEmail('judy.tao@lexisnexis.com', 'PhonesInfo Port Key Build Failed', workunit + '\n' + FAILMESSAGE)
																);
				
	return sendEmail;

end;