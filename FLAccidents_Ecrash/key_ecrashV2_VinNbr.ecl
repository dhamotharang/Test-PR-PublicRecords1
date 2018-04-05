import doxie, Data_Services; 

	dsSlimFile := project(FLAccidents_Ecrash.File_KeybuildV2.eCrashSearchRecs(vin <> ''), FLAccidents_Ecrash.Layouts.key_slim_layout); 
	dsDedupFile := dedup(sort(distributed(dsSlimFile, hash64(accident_nbr)), 
	                          accident_nbr,vin,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local), 
											 accident_nbr,vin,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local);
											 
	EXPORT	key_ecrashV2_VinNbr :=	INDEX(dsDedupFile
																				,{vin,jurisdiction_state,jurisdiction}
																				,{dsDedupFile}
																				,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_VinNbr_' + doxie.Version_SuperKey);
																							