IMPORT _control, Doxie, RoxieKeyBuild, std, Ut;

EXPORT Proc_Build_Combined_Common_Port_Base(string version, string version2, const varstring eclsourceip, string thor_name, string contacts):= function
	
//Process Daily Update Files
	
	//DF-28572: Stop Processing the Telo Files on 11/17/20; Keep Telo history as of 11/15/20. 	
	//processPort					:= PhonesInfo.Proc_Build_Historical_Port_File(version, eclsourceip, thor_name);	//Port File Used Before the PortData Validate 
	
	//Start Processing the iConectiv PortData Validate Files on 11/17/20.  Begin using files from 11/16/20.	
	processPortDataV		:= PhonesInfo.Proc_Build_PortData_Validate_File(version2, eclsourceip, thor_name);
	
//Create Common Base for Update Files	
	buildComBase:= output(PhonesInfo.Map_Common_Port_Main,,'~thor_data400::base::phones::ported_common_main_'+version, overwrite, __compressed__);

	clearDelete := nothor(fileservices.clearsuperfile('~thor_data400::base::phones::ported_common_main_delete', true));		
	
	moveComBase	:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::ported_common_main',
																								'~thor_data400::base::phones::ported_common_main_father',
																								'~thor_data400::base::phones::ported_common_main_grandfather',
																								'~thor_data400::base::phones::ported_common_main_delete'], '~thor_data400::base::phones::ported_common_main_'+version, true);

	//Run Build & Provide Email on Build Status
	sendEmail				:= sequential(//processPort, 
																processPortDataV,
																buildComBase, clearDelete, moveComBase):
																Success(FileServices.SendEmail(contacts, 'PhonesInfo Port Build Succeeded', workunit + ': Build complete.')),
																Failure(FileServices.SendEmail(contacts, 'PhonesInfo Port Build Failed', workunit + '\n' + FAILMESSAGE)
																);
				
	return sendEmail;

end;