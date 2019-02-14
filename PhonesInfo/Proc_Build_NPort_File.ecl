IMPORT _control, Std;

//Neustar Ported Phone File

EXPORT Proc_Build_NPort_File(string version/*, string eclsourceip, string thor_name*/):= FUNCTION

	//This build uses the PhonesInfo.File_TCPA.Main_Current file for the input.	
	
/*
	//Spray Daily Raw Files 
	sprayDaily 				:= Spray_TCPA_Daily(version, eclsourceip, thor_name);
	
	//Project Daily Raw Files to History Layout 
	ds_daily_CL 			:= project(distribute(PhonesInfo.File_TCPA.Daily_Raw_Wireless_to_Wireline), PhonesInfo.Layout_TCPA.History);
	ds_daily_LC 			:= project(distribute(PhonesInfo.File_TCPA.Daily_Raw_Wireline_to_Wireless), PhonesInfo.Layout_TCPA.History);
	
	//Concat Daily Raw File to History File
	concatRawHistory	:= sequential(output(dedup(sort(ds_daily_CL + PhonesInfo.File_TCPA.Daily_History_Raw_Wireless_to_Wireline, record), record),,'~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_'+version,__compressed__),
																	output(dedup(sort(ds_daily_LC + PhonesInfo.File_TCPA.Daily_History_Raw_Wireline_to_Wireless, record), record),,'~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_'+version,__compressed__)
																	);	
	
	//Move History Files
	moveRawHistory		:= sequential(Std.File.PromoteSuperFileList(['~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history',
																																 '~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_father',
																																 '~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_grandfather',
																																 '~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_delete'], '~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_'+version, true),																						

																	Std.File.PromoteSuperFileList(['~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history',
																																 '~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_father',
																																 '~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_grandfather',
																																 '~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_delete'], '~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_'+version, true)																						
																	);			
*/	
	//Build Base File
	buildBase					:= output(PhonesInfo.Remap_TCPA_File,,'~thor_data400::base::phones::nport_main_'+version,__compressed__);

	//Clear Delete Files
	clearDelete 			:= //sequential(
																	nothor(fileservices.clearsuperfile('~thor_data400::base::phones::nport_main_delete', true));//,
																	//nothor(fileservices.clearsuperfile('~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_delete', true)),
																	//nothor(fileservices.clearsuperfile('~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_delete', true))	
																	//);				
	
	//Move Base Files
	moveBase					:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::nport_main',
																											'~thor_data400::base::phones::nport_main_father',
																											'~thor_data400::base::phones::nport_main_grandfather',
																											'~thor_data400::base::phones::nport_main_delete'], '~thor_data400::base::phones::nport_main_'+version, true);																						
	
	//Email Build Status	
	emailDOps					:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 	:= if(count(PhonesInfo.File_TCPA.Main(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: Neustar Ported Phone File', 'Phones Metadata: Neustar Ported Phone File Is Now Available.  Please see: ' + 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: No Neustar Ported Phone File', 'There Were No Neustar Ported Phone Records In This Build')
																);		
	
	//Run Actions
	//The sprayDaily/concatRawHistory/moveRawHistory actions will be added, once the existing Phone Metadata Build has been replaced by the Phones Transaction Build.
	//For now, the build will pull the PhonesInfo.File_TCPA.Main_Current Base File from the PhonesInfo.Proc_Build_TCPA_Port_File build to generate the new Neustar Port Base File.	
	
	RETURN sequential(//sprayDaily,
										//concatRawHistory,
										//moveRawHistory,
										buildBase,
										clearDelete,
										moveBase,
										emailBuildNotice
										);

END;