import _control, Std;

//iConectiv Ported Phone File

EXPORT Proc_Build_Combined_Port_Reformat_File(string version/*, string eclsourceip, string thor_name*/):= FUNCTION
																										
	//Build Historical iConectiv Base
	buildBase					:= output(PhonesInfo.Remap_Combined_Port_File,,'~thor_data400::base::phones::icport_main_'+version, overwrite, __compressed__);
	
	//Clear Historical iConectiv Delete Files
	clearDelete 			:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::icport_main_delete', true));	
	
	//Move Historical iConectiv Base Files
	moveBase					:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::icport_main',
																											'~thor_data400::base::phones::icport_main_father',
																											'~thor_data400::base::phones::icport_main_grandfather',
																											'~thor_data400::base::phones::icport_main_delete'], '~thor_data400::base::phones::icport_main_'+version, true);		
										 																															
	//Build iConectiv PortData Validate File
	buildPDVBase			:= PhonesInfo.Proc_Build_PortData_Valid_File(version);	
	
	//Email Build Status	
	emailDOps					:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 	:= if(count(PhonesInfo.File_iConectiv.Main(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: iConectiv Ported Phone File', 'Phones Metadata: iConectiv Ported Phone File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: No iConectiv Ported Phone File', 'There Were No iConectiv Ported Phone Records In This Build')
																);		
	
	RETURN sequential(buildBase,
										clearDelete,
										moveBase,
										buildPDVBase/*,
										emailBuildNotice*/);

END;