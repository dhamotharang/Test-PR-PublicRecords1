import _control, Std;

//iConectiv Ported Phone File

EXPORT Proc_Build_Combined_Port_Reformat_File(string version, string contacts/*, string eclsourceip, string thor_name*/):= FUNCTION
	
	//DF-28572: Stop Processing the Telo Files on 11/17/20; Keep Telo history as of 11/15/20. 		
	/*
	//Build Historical iConectiv Base
	buildBase					:= output(PhonesInfo.Remap_Combined_Port_File,,'~thor_data400::base::phones::icport_main_'+version, overwrite, __compressed__);
	
	//Clear Historical iConectiv Delete Files
	clearDelete 			:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::icport_main_delete', true));	
	
	//Move Historical iConectiv Base Files
	moveBase					:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::icport_main',
																											'~thor_data400::base::phones::icport_main_father',
																											'~thor_data400::base::phones::icport_main_grandfather',
																											'~thor_data400::base::phones::icport_main_delete'], '~thor_data400::base::phones::icport_main_'+version, true);		
	*/	
									 																															
	//Build iConectiv PortData Validate File
	//Start Processing the iConectiv PortData Validate Files on 11/17/20.  Begin using files from 11/16/20.	
	buildPDVBase			:= PhonesInfo.Proc_Build_PortData_Valid_File(version, contacts);	
	
	//Email Build Status	
	emailDOps					:= contacts;
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= contacts + emailDev;
	emailBuildNotice 	:= if(count(PhonesInfo.File_iConectiv.Main(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: iConectiv Ported Phone File', 'Phones Metadata: iConectiv Ported Phone File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: No iConectiv Ported Phone File', 'There Were No iConectiv Ported Phone Records In This Build')
																);		
	
	RETURN buildPDVBase; /*sequential(buildBase,
																		clearDelete,
																		moveBase,
																		buildPDVBase,
																		emailBuildNotice);*/

END;