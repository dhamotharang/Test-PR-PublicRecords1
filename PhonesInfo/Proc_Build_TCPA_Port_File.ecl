import Std;

EXPORT Proc_Build_TCPA_Port_File(string version, const varstring eclsourceip, string thor_name):= function

	sprayDaily 						:= Spray_TCPA_Daily(version, eclsourceip, thor_name);
	
	buildBase							:= output(PhonesInfo.Map_TCPA_Port_File(version),,'~thor_data400::base::phones::tcpa_main_'+version,__compressed__);

													ds_daily_CL := project(distribute(PhonesInfo.File_TCPA.Daily_Raw_Wireless_to_Wireline), PhonesInfo.Layout_TCPA.History);
													ds_daily_LC := project(distribute(PhonesInfo.File_TCPA.Daily_Raw_Wireline_to_Wireless), PhonesInfo.Layout_TCPA.History);
		
	concatRawHistory			:= sequential(output(dedup(sort(ds_daily_CL + PhonesInfo.File_TCPA.Daily_History_Raw_Wireless_to_Wireline, record), record),,'~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_'+version,__compressed__),
																			output(dedup(sort(ds_daily_LC + PhonesInfo.File_TCPA.Daily_History_Raw_Wireline_to_Wireless, record), record),,'~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_'+version,__compressed__)
																			);	
	
	clearDelete 					:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::tcpa_main_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_delete', true))
																			);	
	
	moveBase							:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::tcpa_main',
																													'~thor_data400::base::phones::tcpa_main_father',
																													'~thor_data400::base::phones::tcpa_main_grandfather',
																													'~thor_data400::base::phones::tcpa_main_delete'], '~thor_data400::base::phones::tcpa_main_'+version, true);																						

	moveRawHistory				:= sequential(STD.File.PromoteSuperFileList(['~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history',
																													'~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_father',
																													'~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_grandfather',
																													'~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_delete'], '~thor_data400::in::phones::wireless_to_wireline::tcpa_daily_history_'+version, true),																						

													STD.File.PromoteSuperFileList(['~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history',
																													'~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_father',
																													'~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_grandfather',
																													'~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_delete'], '~thor_data400::in::phones::wireline_to_wireless::tcpa_daily_history_'+version, true)																						
																			);
																				
	return 								sequential(	sprayDaily, 
																		buildBase,
																		concatRawHistory,
																		clearDelete,
																		moveBase,
																		moveRawHistory
																		);

end;