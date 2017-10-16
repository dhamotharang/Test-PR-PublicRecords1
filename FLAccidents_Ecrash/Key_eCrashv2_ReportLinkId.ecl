import doxie, Data_Services; 

dsSlimFile := project(FLAccidents_Ecrash.File_KeybuildV2.eCrashSearchRecs(reportlinkid <> ''), FLAccidents_Ecrash.Layouts.key_slim_layout);
 
dsDedupFile := dedup(sort(distributed(dsSlimFile, hash64(accident_nbr)), 
	                        accident_nbr,reportlinkid,accident_date,report_type_id,report_id,jurisdiction_state,jurisdiction_nbr,agency_ori, local), 
										 accident_nbr,reportlinkid,accident_date,report_type_id,report_id,jurisdiction_state,jurisdiction_nbr,agency_ori, local);
										 

EXPORT Key_eCrashv2_ReportLinkId := INDEX(dsDedupFile 
																					,{reportlinkid}
																					,{dsDedupFile}
																					,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashv2_ReportLinkId_' + doxie.Version_SuperKey);
																							  

