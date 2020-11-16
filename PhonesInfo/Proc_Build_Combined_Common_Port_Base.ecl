﻿IMPORT _control, Doxie, RoxieKeyBuild, std, Ut;

EXPORT Proc_Build_Combined_Common_Port_Base(string version, string version2, const varstring eclsourceip, string thor_name):= function
	
//Process Daily Update Files
	processPort					:= PhonesInfo.Proc_Build_Historical_Port_File(version, eclsourceip, thor_name);	//Port File Used Before the PortData Validate 
	processPortDataV		:= PhonesInfo.Proc_Build_PortData_Validate_File(version2, eclsourceip, thor_name);
	
//Create Common Base for Update Files	
	buildComBase:= output(PhonesInfo.Map_Common_Port_Main,,'~thor_data400::base::phones::ported_common_main_'+version, overwrite, __compressed__);

	clearDelete := nothor(fileservices.clearsuperfile('~thor_data400::base::phones::ported_common_main_delete', true));		
	
	moveComBase	:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::ported_common_main',
																								'~thor_data400::base::phones::ported_common_main_father',
																								'~thor_data400::base::phones::ported_common_main_grandfather',
																								'~thor_data400::base::phones::ported_common_main_delete'], '~thor_data400::base::phones::ported_common_main_'+version, true);

	//Run Build & Provide Email on Build Status
	sendEmail				:= sequential(processPort, 
																processPortDataV,
																buildComBase, clearDelete, moveComBase):
																Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Port Build Succeeded', workunit + ': Build complete.')),
																Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Port Build Failed', workunit + '\n' + FAILMESSAGE)
																);
				
	return sendEmail;

end;