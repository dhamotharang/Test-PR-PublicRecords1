import _control, std, ut;

EXPORT Proc_Build_Lerg1_Prep(string version, const varstring eclsourceip, string emailTarget, string thor_name) := function

	sprayLerg 				:= PhonesInfo.Spray_Lerg(version, eclsourceip, thor_name);
		
	//Project File to Maintain Filenames
	dsL1 							:= project(distribute(PhonesInfo.File_Lerg.Lerg1), PhonesInfo.Layout_Lerg.lerg1Hist);
	dsL1C							:= project(distribute(PhonesInfo.File_Lerg.Lerg1Con), PhonesInfo.Layout_Lerg.lerg1ConHist);	
	
	ccL1RawHistory		:= output(dedup(sort(distribute(dsL1 + PhonesInfo.File_Lerg.Lerg1Hist, hash(ocn)), record, local), record, local),,'~thor_data400::in::phones::lerg1_history_'+version,__compressed__);
	ccL1CRawHistory		:= output(dedup(sort(distribute(dsL1C + PhonesInfo.File_Lerg.Lerg1ConHist, hash(ocn)), record, local), record, local),,'~thor_data400::in::phones::lerg1con_history_'+version,__compressed__);
	
	clearDelete 			:= parallel(nothor(fileservices.clearsuperfile('~thor_data400::in::phones::lerg1_history_delete', true)),
																nothor(fileservices.clearsuperfile('~thor_data400::in::phones::lerg1con_history_delete', true)),
																nothor(fileservices.clearsuperfile('~thor_data400::in::phones::lerg1_prep_delete', true))
																);	
																			
	moveL1RawHistory	:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::lerg1_history',
																											'~thor_data400::in::phones::lerg1_history_father',
																											'~thor_data400::in::phones::lerg1_history_grandfather',
																											'~thor_data400::in::phones::lerg1_history_delete'], '~thor_data400::in::phones::lerg1_history_'+version, true);						
	
	moveL1CRawHistory	:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::lerg1con_history',
																											'~thor_data400::in::phones::lerg1con_history_father',
																											'~thor_data400::in::phones::lerg1con_history_grandfather',
																											'~thor_data400::in::phones::lerg1con_history_delete'], '~thor_data400::in::phones::lerg1con_history_'+version, true);	
	
	buildPrep					:= output(PhonesInfo.Map_Lerg1_Prep(version),,'~thor_data400::in::phones::lerg1_prep_'+version, __compressed__);
															 
	movePrep					:= STD.File.PromoteSuperFileList(['~thor_data400::in::phones::lerg1_prep',
																											'~thor_data400::in::phones::lerg1_prep_father',
																											'~thor_data400::in::phones::lerg1_prep_grandfather',
																											'~thor_data400::in::phones::lerg1_prep_delete'], '~thor_data400::in::phones::lerg1_prep_'+version, true);																						
				
	emailNotice 			:= if(count(PhonesInfo.File_Lerg.Lerg1Prep(dt_last_reported=version[1..8])) > 0
													,fileservices.SendEmail(emailTarget, 'Phones Metadata: Lerg1 Prep File', 'An updated Lerg1 prep file is now available.')
													,fileservices.SendEmail(emailTarget, 'Phones Metadata: No Lerg1 Prep File Update', 'There was no Lerg1 prep file update in this build.')
													);	
																	
	return sequential(sprayLerg,
										parallel(ccL1RawHistory, ccL1CRawHistory),
										clearDelete,
										parallel(moveL1RawHistory, moveL1CRawHistory),
										buildPrep,
										movePrep,
										emailNotice
										);
	
end;