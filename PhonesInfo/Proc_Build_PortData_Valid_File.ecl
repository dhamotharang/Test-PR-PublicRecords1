IMPORT _control, Std;

EXPORT Proc_Build_PortData_Valid_File(string version, string contacts) := FUNCTION

	//Build Base
	buildBase					:= output(PhonesInfo.Remap_Combined_PortData_Valid,,'~thor_data400::base::phones::portdata_valid_main_' + version, overwrite, __compressed__);
	
	//Clear Delete Files
	clearDelete 			:= nothor(Fileservices.ClearSuperFile('~thor_data400::base::phones::portdata_valid_main_delete', true));	
	
	//Move Base Files
	moveBase					:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::portdata_valid_main',
																											'~thor_data400::base::phones::portdata_valid_main_father',
																											'~thor_data400::base::phones::portdata_valid_main_grandfather',
																											'~thor_data400::base::phones::portdata_valid_main_delete'], '~thor_data400::base::phones::portdata_valid_main_'+version, true);		
										 																															
	//Email Build Status	
	emailDOps					:= contacts;
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= contacts + emailDev;
	emailBuildNotice 	:= if(count(PhonesInfo.File_iConectiv.Main(phone<>'')) > 0
																,Fileservices.SendEmail(emailTarget, 'Phones Metadata: iConectiv PortData Validate Phone File', 'Phones Metadata: iConectiv PortData Validate Phone File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,Fileservices.SendEmail(emailTarget, 'Phones Metadata: No iConectiv PortData Validate Phone File', 'There Were No iConectiv PortData Validate Phone Records In This Build')
																);		
	
	RETURN SEQUENTIAL(buildBase,
										clearDelete,
										moveBase,
										emailBuildNotice);

END;