/*
One time BWR to update Incident file field is_Suppressed to 1 for eCrash identified records.
*/
IMPORT Data_Services, FLAccidents_Ecrash, STD;
EXPORT Pre_Update_Incident_isSuppressed_to_1() := FUNCTION

 Spray_Appriss_Lay:= RECORD
	STRING 	﻿AgencyORITxt;
	STRING  LocalCodeTxt;
	STRING  StateNameTxt;
	STRING  DocumentIdNbr;
	STRING  InternalRepositoryIdTxt;
 END;


 ds_Incident_Appriss := DATASET(Data_Services.foreign_prod+'thor_data400::in::appriss_dw_oriandreportnumber20200921b'
													     ,Spray_Appriss_Lay
													     ,CSV(HEADING(1), TERMINATOR(['\n','\r\n','\n\r']), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000)));                    
 FLAccidents_Ecrash.mac_CleanFields(ds_Incident_Appriss, CleanIncAppriss);
 clean_Incident_Appriss := CleanIncAppriss(AgencyORITxt <> '' AND InternalRepositoryIdTxt <> '' AND StateNameTxt <>'');
 dds_Incident_Appriss := DEDUP(SORT(DISTRIBUTE(clean_Incident_Appriss, HASH32(AgencyORITxt, InternalRepositoryIdTxt, StateNameTxt)), 
                                    AgencyORITxt, InternalRepositoryIdTxt, StateNameTxt, LOCAL), 
															  AgencyORITxt, InternalRepositoryIdTxt, StateNameTxt, LOCAL);
 
 Layout_Incident := FLAccidents_Ecrash.Layout_Infiles.incident_new;
 ds_incident := FLAccidents_Ecrash.Infiles.incident;
 dds_incident := DISTRIBUTE(ds_incident, HASH32(ori_number, state_report_number, loss_state_abbr));

 Layout_Incident updateIncidents(dds_incident L, dds_Incident_Appriss R) := TRANSFORM
   // is_Right_Not_Present := (TRIM(L.ori_number, LEFT, RIGHT) = '' AND 
	                          // TRIM(L.state_report_number, LEFT, RIGHT) = '' AND 
														// TRIM(L.loss_state_abbr, LEFT, RIGHT) = ''));
	 // SELF.is_Suppressed := IF(is_Right_Not_Present, '0', '1');
	SELF.is_Suppressed :=IF((STD.Str.ToUpperCase(TRIM(L.ori_number, LEFT, RIGHT)) = STD.Str.ToUpperCase(TRIM(R.AgencyoriTxt, LEFT, RIGHT)) AND
											     STD.Str.ToUpperCase(TRIM(L.state_report_number, LEFT, RIGHT)) = STD.Str.ToUpperCase(TRIM(R.InternalRepositoryIdTxt, LEFT, RIGHT)) AND
											     STD.Str.ToUpperCase(TRIM(L.loss_state_abbr, LEFT, RIGHT)) = STD.Str.ToUpperCase(TRIM(R.StateNameTxt, LEFT, RIGHT))),
			                     '1', '0');
	SELF := L;
 END;
 upd_incidents := JOIN(dds_incident, dds_Incident_Appriss,
			                 STD.Str.ToUpperCase(TRIM(LEFT.ori_number, LEFT, RIGHT)) = STD.Str.ToUpperCase(TRIM(RIGHT.AgencyoriTxt, LEFT, RIGHT)) AND
											 STD.Str.ToUpperCase(TRIM(LEFT.state_report_number, LEFT, RIGHT)) = STD.Str.ToUpperCase(TRIM(RIGHT.InternalRepositoryIdTxt, LEFT, RIGHT)) AND
											 STD.Str.ToUpperCase(TRIM(LEFT.loss_state_abbr, LEFT, RIGHT)) = STD.Str.ToUpperCase(TRIM(RIGHT.StateNameTxt, LEFT, RIGHT)),
			                 updateIncidents(LEFT,RIGHT), LEFT OUTER, LOCAL);

 ds_Incident_Upd_Out := OUTPUT(upd_incidents ,, Files.Incident_Raw_LF('update_issuppressed'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
 New_Incident_Raw := SEQUENTIAL(
                                ds_Incident_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Incident_Raw_SF, 
																                      Files.Incident_Raw_LF('update_issuppressed')),
												        STD.File.FinishSuperFileTransaction()
												       );
 RETURN New_Incident_Raw;
END;

