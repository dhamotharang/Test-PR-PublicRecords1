import doxie, Data_Services; 

	dsSlimFile := project(FLAccidents_Ecrash.File_KeybuildV2.eCrashSearchRecs(officer_id <> ''), FLAccidents_Ecrash.Layouts.key_slim_layout); 
	dsDedupFile := dedup(sort(distributed(dsSlimFile, hash64(accident_nbr)), 
	                          accident_nbr,officer_id,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local), 
											 accident_nbr,officer_id,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local);
											 
	EXPORT	key_ecrashV2_OfficerBadgeNbr :=	INDEX(dsDedupFile
																				        ,{officer_id,jurisdiction_state,jurisdiction}
																				        ,{dsDedupFile}
																				        ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_OfficerBadgeNbr_' + doxie.Version_SuperKey);