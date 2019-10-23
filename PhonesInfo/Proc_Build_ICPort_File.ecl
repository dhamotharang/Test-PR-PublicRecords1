import _control, Std;

//iConectiv Ported Phone File

EXPORT Proc_Build_ICPort_File(string version/*, string eclsourceip, string thor_name*/):= FUNCTION

	//This build uses the PhonesInfo.File_iConectiv.In_Port_Daily_History file for the input.			

/*
	//Spray Daily File
	sprayDaily 				:= PhonesInfo.Spray_iConectiv_Daily(version, eclsourceip, thor_name);
	
	//Project Daily File to Layout to Preserve Filename
	portDaily 				:= project(distribute(PhonesInfo.File_iConectiv.In_Port_Daily), PhonesInfo.Layout_iConectiv.History);
	
	//Concat Daily with History File
	concatRawHistory	:= output(dedup(sort(distribute(portDaily + PhonesInfo.File_iConectiv.In_Port_Daily_History, hash(phone)), record, local), record, local),,'~thor_data400::in::phones::iconectiv_daily_history_'+version,__compressed__);
	
	//Move History Files
	moveRawHistory		:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::iconectiv_daily_history',
																											'~thor_data400::in::phones::iconectiv_daily_history_father',
																											'~thor_data400::in::phones::iconectiv_daily_history_grandfather',
																											'~thor_data400::in::phones::iconectiv_daily_history_delete'], '~thor_data400::in::phones::iconectiv_daily_history_'+version, true);	
*/																											
	//Build Base
	buildBase					:= output(PhonesInfo.Remap_ICPort_File,,'~thor_data400::base::phones::icport_main_'+version, overwrite, __compressed__);
	
	//Clear Delete Files
	clearDelete 			:= //sequential(nothor(fileservices.clearsuperfile('~thor_data400::in::phones::iconectiv_daily_history_delete', true),
																	nothor(fileservices.clearsuperfile('~thor_data400::base::phones::icport_main_delete', true));
																	//);		
	
	//Move Base Files
	moveBase					:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::icport_main',
																											'~thor_data400::base::phones::icport_main_father',
																											'~thor_data400::base::phones::icport_main_grandfather',
																											'~thor_data400::base::phones::icport_main_delete'], '~thor_data400::base::phones::icport_main_'+version, true);		
										 																															
	//Email Build Status	
	emailDOps					:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 	:= if(count(PhonesInfo.File_iConectiv.Main(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: iConectiv Ported Phone File', 'Phones Metadata: iConectiv Ported Phone File Is Now Available.  Please see: ' + 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: No iConectiv Ported Phone File', 'There Were No iConectiv Ported Phone Records In This Build')
																);		
	
	//The sprayDaily/concatRawHistory/moveRawHistory actions will be added, once the existing Phone Metadata Build has been replaced by the Phones Transaction Build.
	//For now, the build will pull the PhonesInfo.File_iConectiv.In_Port_Daily_History File from the PhonesInfo.Proc_Build_iConectiv_Port_File build to generate the new iConectiv Port Base File.	

	RETURN sequential(//sprayDaily,
										//concatRawHistory,
										//moveRawHistory,
										buildBase,
										clearDelete,
										moveBase,
										emailBuildNotice);

END;