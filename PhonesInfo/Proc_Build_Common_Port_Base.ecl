import _control, Doxie, RoxieKeyBuild, std, Ut;

//DF-24394: Deactivated TCPA Port File Process.  Source not updating as of 03/15/19.

EXPORT Proc_Build_Common_Port_Base(string version, string version2, const varstring eclsourceip, string thor_name):= function
	
//Process Daily Update Files
	//processTCPA := PhonesInfo.Proc_Build_TCPA_Port_File(version, eclsourceip, thor_name);
	processICon	:= PhonesInfo.Proc_Build_iConectiv_Port_File(version2, eclsourceip,thor_name);
	
//Create Common Base for Update Files	
	buildComBase:= output(PhonesInfo.Map_Common_Port_Main,,'~thor_data400::base::phones::ported_common_main_'+version, overwrite, __compressed__);

	clearDelete := nothor(fileservices.clearsuperfile('~thor_data400::base::phones::ported_common_main_delete', true));		
	
	moveComBase	:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::ported_common_main',
																								'~thor_data400::base::phones::ported_common_main_father',
																								'~thor_data400::base::phones::ported_common_main_grandfather',
																								'~thor_data400::base::phones::ported_common_main_delete'], '~thor_data400::base::phones::ported_common_main_'+version, true);

	//Run Build & Provide Email on Build Status
	sendEmail				:= sequential(/*processTCPA,*/ processICon, buildComBase, clearDelete, moveComBase/*, bkPhonesPort, mvBltPhonesPort, mvQAPhonesPort*/):
																Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Port Build Succeeded', workunit + ': Build complete.')),
																Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Port Build Failed', workunit + '\n' + FAILMESSAGE)
																);
				
	return sendEmail;

end;