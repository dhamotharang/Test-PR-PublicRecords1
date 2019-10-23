IMPORT _control, std, ut;

EXPORT Proc_Build_OTP_File(string version) := function
	
	//This build uses the PhoneFraud.File_OTP.Base file for the input.	
	
	//Clear Delete File
	clearDelete 	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::otp_main_delete', true));	
	
	//Build Base File
	buildBase			:= output(PhonesInfo.Map_OTP,,'~thor_data400::base::phones::otp_main_'+version, __compressed__);
	
	//Move Base File
	moveBase			:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::otp_main',
																									'~thor_data400::base::phones::otp_main_father',
																									'~thor_data400::base::phones::otp_main_grandfather',
																									'~thor_data400::base::phones::otp_main_delete'], '~thor_data400::base::phones::otp_main_'+version, true);																						
	
	//Email Build Status	
	emailDOps					:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 	:= if(count(PhonesInfo.File_OTP.Main(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: OTP Phone File', 'Phones Metadata: OTP File Is Now Available.  Please see: ' + 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: No OTP Phone File', 'There Were No OTP Records In This Build')
																);	
	
	//Run Action
	return sequential(clearDelete,
										buildBase,
										moveBase,
										emailBuildNotice);
	
end;