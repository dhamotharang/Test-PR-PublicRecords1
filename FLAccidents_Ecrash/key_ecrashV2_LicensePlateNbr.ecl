import Data_Services, Doxie;

	dsSlimFile := project(FLAccidents_Ecrash.File_KeybuildV2.eCrashSearchRecs(tag_nbr <> ''), FLAccidents_Ecrash.Layouts.key_slim_layout); 
	dsDedupFile := dedup(sort(distributed(dsSlimFile, hash64(accident_nbr)), 
	                          accident_nbr,tag_nbr,tagnbr_st,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local), 
											 accident_nbr,tag_nbr,tagnbr_st,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local);
											 
	EXPORT	key_ecrashV2_LicensePlateNbr :=	INDEX(dsDedupFile
																							  ,{tag_nbr,tagnbr_st,jurisdiction_state,jurisdiction}
																							  ,{dsDedupFile}
																							  ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_LicensePlateNbr_' + doxie.Version_SuperKey);