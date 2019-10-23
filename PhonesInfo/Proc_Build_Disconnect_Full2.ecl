import _control, std, ut;

EXPORT Proc_Build_Disconnect_Full2(string version, const varstring eclsourceip, string thor_name) := function

	sprayDaily 								:= PhonesInfo.Spray_Deact2_Daily(version, eclsourceip, thor_name);
		
		//Project File to Maintain Filenames
		ds_disconnect_daily 	:= project(distribute(PhonesInfo.File_Deact.Raw2), PhonesInfo.Layout_Deact.History2);
														
	concatRawHistory			:= output(dedup(sort(distribute(ds_disconnect_daily + PhonesInfo.File_Deact.History2, hash(msisdn)), record, local), record, local),,'~thor_data400::in::phones::deact2_daily_history_'+version,__compressed__);
	
	clearDelete 							:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::disconnect2_main_delete', true)),
																																		nothor(fileservices.clearsuperfile('~thor_data400::in::phones::deact2_daily_history_delete', true))
																																		);	
																			
	moveRawHistory					:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::deact2_daily_history',
																																																						'~thor_data400::in::phones::deact2_daily_history_father',
																																																						'~thor_data400::in::phones::deact2_daily_history_grandfather',
																																																						'~thor_data400::in::phones::deact2_daily_history_delete'], '~thor_data400::in::phones::deact2_daily_history_'+version, true);						

	buildBase										:= output(PhonesInfo.Map_Disconnect_Full,,'~thor_data400::base::phones::disconnect2_main_'+version, __compressed__);
															 
	moveBase											:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::disconnect2_main',
																																																						'~thor_data400::base::phones::disconnect2_main_father',
																																																						'~thor_data400::base::phones::disconnect2_main_grandfather',
																																																						'~thor_data400::base::phones::disconnect2_main_delete'], '~thor_data400::base::phones::disconnect2_main_'+version, true);																						
					
	emailNotice 							:= if(count(PhonesInfo.File_Deact.Main_Current2(phone<>'')) > 0
																										,sequential(fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'Phones Metadata: Phones Disconnect II File', 'Phones Metadata Disconnect II File Is Now Available.  Please see: '+'http://10.241.30.202:8010/?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid'))
																																					,fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'Phones Metadata: No Phones Disconnect II File', 'There Were No Phones Metadata Disconnect II Records in This Build')
																										);	
																	
	return sequential(sprayDaily,
																			concatRawHistory,
																			clearDelete,
																			moveRawHistory,
																			buildBase,
																			moveBase,
																			emailNotice
																			);
	
end;