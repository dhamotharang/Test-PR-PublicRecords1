import _control, std, ut;

EXPORT Proc_Build_Disconnect_Full(string version, const varstring eclsourceip, string thor_name) := function

	sprayDaily 						:= PhonesInfo.Spray_Deact_Daily(version, eclsourceip, thor_name);
	
														ds_disconnect_daily 	:= project(distribute(PhonesInfo.File_Deact.Raw), PhonesInfo.Layout_Deact.History);
														
	concatRawHistory			:= output(dedup(sort(distribute(ds_disconnect_daily + PhonesInfo.File_Deact.History, hash(phone)), record, local), record, local),,'~thor_data400::in::phones::deact_daily_history_'+version,__compressed__);
	
	clearDelete 					:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::disconnect_main_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::deact_daily_history_delete', true))
																			);	
																			
	moveRawHistory				:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::deact_daily_history',
																														'~thor_data400::in::phones::deact_daily_history_father',
																														'~thor_data400::in::phones::deact_daily_history_grandfather',
																														'~thor_data400::in::phones::deact_daily_history_delete'], '~thor_data400::in::phones::deact_daily_history_'+version, true);						

	buildBase							:= output(PhonesInfo.Map_Disconnect_Full,,'~thor_data400::base::phones::disconnect_main_'+version, __compressed__);
															 
	moveBase							:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::disconnect_main',
																														'~thor_data400::base::phones::disconnect_main_father',
																														'~thor_data400::base::phones::disconnect_main_grandfather',
																														'~thor_data400::base::phones::disconnect_main_delete'], '~thor_data400::base::phones::disconnect_main_'+version, true);																						
					
	emailNotice 					:= if(count(PhonesInfo.File_Deact.Main_Current(phone<>'')) > 0
																,sequential(fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'Phones Metadata: Phones Disconnect File', 'Phones Metadata Disconnect File Is Now Available.  Please see: '+'http://10.241.30.202:8010/?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid'))
																						,fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'Phones Metadata: No Phones Disconnect File', 'There Were No Phones Metadata Disconnect Records in This Build'));	
	
	return 								sequential( sprayDaily,
																		concatRawHistory,
																		clearDelete,
																		moveRawHistory,
																		buildBase,
																		moveBase,
																		emailNotice
																		);
	
end;