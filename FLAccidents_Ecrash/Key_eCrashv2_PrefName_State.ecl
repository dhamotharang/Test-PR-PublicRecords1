﻿import Data_Services, Doxie;

	dsSlimFile := project(FLAccidents_Ecrash.File_KeybuildV2.eCrashSearchRecs(fname <> ''), FLAccidents_Ecrash.Layouts.key_slim_layout); 
	dsDedupFile := dedup(sort(distributed(dsSlimFile, hash64(accident_nbr)), 
	                          accident_nbr,fname,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local), 
											 accident_nbr,fname,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local);
	EXPORT	Key_eCrashv2_PrefName_State:=	INDEX(dsDedupFile
																							,{fname,jurisdiction_state,jurisdiction}
																							,{dsDedupFile}
																							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_PrefName_State_' + doxie.Version_SuperKey);
																							
																																
																															
