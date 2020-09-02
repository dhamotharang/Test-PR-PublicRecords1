/*
One time BWR to expand Incident file layout with new fields.
*/
IMPORT Data_Services, FLAccidents_Ecrash;
EXPORT Pre_Update_Incident_InputFile := FUNCTION

 ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
											 ,Layout_Incident
											 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');
													 

 FLAccidents_Ecrash.Layout_Infiles.incident_NEW ExpandIncidentLayout(ds_incident L) := TRANSFORM
                                                                                        SELF.ori_number := IF(TRIM(L.ori_number, ALL) = 'TXHPD0000', 'TX1015700', L.ori_number);
																																										    SELF := L;
																																									      SELF := [];
																																								       END;
																									 
 upd_incident_layout := PROJECT(ds_incident, ExpandIncidentLayout(LEFT));
		
 ds_incident_upd := OUTPUT(upd_incident_layout,,'~thor_data400::in::ecrash::incident_layout_change_'+workunit,overwrite,__compressed__,
				                   csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

 do_all :=  SEQUENTIAL(
												ds_incident_upd,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_layout_change_'+workunit),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

