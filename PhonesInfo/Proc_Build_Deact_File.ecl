IMPORT _control, std, ut;

EXPORT Proc_Build_Deact_File(string version, string eclsourceip, string thor_name, string contacts) := FUNCTION
	
	//DF-28845: Remove Old PhonesMetadata Keys from Daily Build			

	//Spray Daily Raw File	
	sprayDaily 					:= PhonesInfo.Spray_Deact2_Daily(version, eclsourceip, thor_name);
		
	//Project File to Maintain Filenames
	ds_disconnect_daily := project(distribute(PhonesInfo.File_Deact.Raw2), PhonesInfo.Layout_Deact.History2);
	
	//Concat Daily Raw File to History File
	concatRawHistory		:= output(dedup(sort(distribute(ds_disconnect_daily + PhonesInfo.File_Deact.History2, hash(msisdn)), record, local), record, local),,'~thor_data400::in::phones::deact2_daily_history_'+version,__compressed__);
	
	//Delete Old Base and History Files 
	clearDelete 				:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::deact2_main_delete', true)),
																		nothor(fileservices.clearsuperfile('~thor_data400::in::phones::deact2_daily_history_delete', true))
																		);	
																			
	moveRawHistory			:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::deact2_daily_history',
																												'~thor_data400::in::phones::deact2_daily_history_father',
																												'~thor_data400::in::phones::deact2_daily_history_grandfather',
																												'~thor_data400::in::phones::deact2_daily_history_delete'], '~thor_data400::in::phones::deact2_daily_history_'+version, true);						

	//Build Base File
	buildBase						:= output(PhonesInfo.Remap_Deact_File,,'~thor_data400::base::phones::deact2_main_'+version, __compressed__);
	
	//Move Bases Files
	moveBase						:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::deact2_main',
																												'~thor_data400::base::phones::deact2_main_father',
																												'~thor_data400::base::phones::deact2_main_grandfather',
																												'~thor_data400::base::phones::deact2_main_delete'], '~thor_data400::base::phones::deact2_main_'+version, true);																						
	//Email Build Status	
	emailDOps						:= contacts;
	emailDev						:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget					:= contacts + emailDev;
	emailBuildNotice 		:= if(count(PhonesInfo.File_Deact.Main(phone<>'')) > 0
																	,fileservices.SendEmail(emailTarget, 'Phones Metadata: Digital Segment Deact File', 'Phones Metadata: Digital Segment Deact File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																	,fileservices.SendEmail(emailTarget, 'Phones Metadata: No Digital Segment Deact File', 'There Were No Digital Segment Deact Records In This Build')
																	);		
	
	//Run Actions
	return sequential(sprayDaily,
										concatRawHistory,
										clearDelete,
										moveRawHistory,
										buildBase,
										moveBase,
										emailBuildNotice
										);
	
end;