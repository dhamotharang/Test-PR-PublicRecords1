import std;

EXPORT Proc_Build_iConectiv_Port_File(string version, const varstring eclsourceip, string thor_name):= function

	sprayDaily 						:= PhonesInfo.Spray_iConectiv_Daily(version, eclsourceip, thor_name);
	ds_iConectiv_daily 		:= project(distribute(PhonesInfo.File_iConectiv.In_Port_Daily), PhonesInfo.Layout_iConectiv.History);
	
	concatRawHistory			:= output(dedup(sort(distribute(ds_iConectiv_daily + PhonesInfo.File_iConectiv.In_Port_Daily_History, hash(phone)), record, local), record, local),,'~thor_data400::in::phones::iconectiv_daily_history_'+version,__compressed__);
	
	moveRawHistory				:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::iconectiv_daily_history',
																														'~thor_data400::in::phones::iconectiv_daily_history_father',
																														'~thor_data400::in::phones::iconectiv_daily_history_grandfather',
																														'~thor_data400::in::phones::iconectiv_daily_history_delete'], '~thor_data400::in::phones::iconectiv_daily_history_'+version, true);	
	
	buildBase							:= output(PhonesInfo.Map_iConectiv_Port_Full,,'~thor_data400::base::phones::iconectiv_main_'+version,overwrite,__compressed__);
													 
	clearDelete 					:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::iconectiv_main_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::iconectiv_daily_history_delete', true))
																			);		
		
	moveBase							:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::iconectiv_main',
																														'~thor_data400::base::phones::iconectiv_main_father',
																														'~thor_data400::base::phones::iconectiv_main_grandfather',
																														'~thor_data400::base::phones::iconectiv_main_delete'], '~thor_data400::base::phones::iconectiv_main_'+version, true);
																																					
	return 	sequential(	SprayDaily, 
											concatRawHistory,
											moveRawHistory,
											buildBase,
											clearDelete,
											moveBase);

end;