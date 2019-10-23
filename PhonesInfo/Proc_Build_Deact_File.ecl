IMPORT _control, std, ut;

EXPORT Proc_Build_Deact_File(string version/*, string eclsourceip, string thor_name*/) := FUNCTION

	//This build uses the PhonesInfo.File_Deact.History2 file for the input.	

/*
	//Spray Daily Raw File
	sprayDaily 					:= PhonesInfo.Spray_Deact2_Daily(version, eclsourceip, thor_name);
		
	//Project Daily Raw File to History Layout 
	deactDaily 					:= project(distribute(PhonesInfo.File_Deact.Raw2), PhonesInfo.Layout_Deact.History2);														
	
	//Concat Daily Raw File to History File
	concatRawHistory		:= output(dedup(sort(distribute(deactDaily + PhonesInfo.File_Deact.History2, hash(msisdn)), record, local), record, local),,'~thor_data400::in::phones::deact_daily_history_'+version,__compressed__);
	
	//Move History Files
	moveRawHistory			:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::deact2_daily_history',
																												'~thor_data400::in::phones::deact2_daily_history_father',
																												'~thor_data400::in::phones::deact2_daily_history_grandfather',
																												'~thor_data400::in::phones::deact2_daily_history_delete'], '~thor_data400::in::phones::deact2_daily_history_'+version, true);						
*/																												
	//Build Base File
	buildBase						:= output(PhonesInfo.Remap_Deact_File,,'~thor_data400::base::phones::deact2_main_'+version, __compressed__);
	
	//Delete Old Base and History Files 
	clearDelete 				:= //sequential(
																		nothor(fileservices.clearsuperfile('~thor_data400::base::phones::deact2_main_delete', true));//,
																		/*nothor(fileservices.clearsuperfile('~thor_data400::in::phones::deact2_daily_history_delete', true))
																		);*/	
	
	//Move Bases Files
	moveBase						:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::deact2_main',
																												'~thor_data400::base::phones::deact2_main_father',
																												'~thor_data400::base::phones::deact2_main_grandfather',
																												'~thor_data400::base::phones::deact2_main_delete'], '~thor_data400::base::phones::deact2_main_'+version, true);																						
	//Email Build Status	
	emailDOps						:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev						:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget					:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 		:= if(count(PhonesInfo.File_Deact.Main(phone<>'')) > 0
																	,fileservices.SendEmail(emailTarget, 'Phones Metadata: Digital Segment Deact File', 'Phones Metadata: Digital Segment Deact File Is Now Available.  Please see: ' + 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																	,fileservices.SendEmail(emailTarget, 'Phones Metadata: No Digital Segment Deact File', 'There Were No Digital Segment Deact Records In This Build')
																	);		
	
	//Run Actions
	//The sprayDaily/concatRawHistory/moveRawHistory actions will be added, once the existing Phone Metadata Build has been replaced by the Phones Transaction Build.
	//For now, the build will pull the PhonesInfo.File_Deact.History2 File from the PhonesInfo.Proc_Build_Disconnect_Full2 build to generate the new Digitial Segment Deact Base File.	

	return sequential(//sprayDaily,
										//concatRawHistory,
										//moveRawHistory,
										buildBase,
										clearDelete, 
										moveBase,
										emailBuildNotice
										);
	
end;