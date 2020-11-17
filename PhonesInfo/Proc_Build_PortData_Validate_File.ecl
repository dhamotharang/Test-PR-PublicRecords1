IMPORT Std;

EXPORT Proc_Build_PortData_Validate_File(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	//Spray Raw PortData Validate File
	sprayDaily						:= PhonesInfo.Spray_iConectiv_PortData_Validate_Daily(version, eclsourceip, thor_name);
	
	//Concat Raw PortData Validate File w/ History Table
	filterDaily 					:= project(distribute(PhonesInfo.File_iConectiv.Portdata_Validate_Daily), PhonesInfo.Layout_iConectiv.PortData_Validate_History);
	concatDailyHistory		:= output(dedup(sort(distribute(filterDaily + PhonesInfo.File_iConectiv.PortData_Validate_History, hash(jsonData)), record, local), record, local),, '~thor_data400::in::phones::portdata_validate_history_' + version, __compressed__);
	
	//Move PortData Validate History Files
	moveDailyHistory			:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::portdata_validate_history',
																													'~thor_data400::in::phones::portdata_validate_history_father',
																													'~thor_data400::in::phones::portdata_validate_history_grandfather',
																													'~thor_data400::in::phones::portdata_validate_history_delete'], '~thor_data400::in::phones::portdata_validate_history_' + version, true);	
	
	//Build PortData Validate Base
	buildBase							:= output(PhonesInfo.Map_PortData_Validate,,'~thor_data400::base::phones::portdata_validate_main_' + version, overwrite, __compressed__);
	
	//Clear Delete Files
	clearDelete 					:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::portdata_validate_main_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::portdata_validate_history_delete', true))
																			);		
	
	//Move Base File
	moveBase							:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::portdata_validate_main',
																													'~thor_data400::base::phones::portdata_validate_main_father',
																													'~thor_data400::base::phones::portdata_validate_main_grandfather',
																													'~thor_data400::base::phones::portdata_validate_main_delete'], '~thor_data400::base::phones::portdata_validate_main_' + version, true);
																																					
	RETURN SEQUENTIAL(sprayDaily, 
										concatDailyHistory,
										moveDailyHistory,
										buildBase,
										clearDelete,
										moveBase);

END;