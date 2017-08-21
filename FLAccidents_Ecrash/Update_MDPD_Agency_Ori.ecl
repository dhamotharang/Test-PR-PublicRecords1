/*
One time BWR to update ori_number, report_agency_ori in Incident file for MDPD ORI update.
*/
IMPORT Data_Services;
EXPORT Update_MDPD_Agency_Ori := FUNCTION
								 
		ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
													 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
													 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');
													 

		FLAccidents_Ecrash.Layout_Infiles.incident_new updateAgencyOri(ds_incident L) := TRANSFORM
																											SELF.ori_number := IF (L.ori_number = 'FL0130600','FL0130000',L.ori_number);
																											SELF.report_agency_ori := IF (L.report_agency_ori = 'FL0130600','FL0130000',L.report_agency_ori);
																											SELF := L;
																									 END;
																									 
		upd_incidet := PROJECT(ds_incident, updateAgencyOri(LEFT));
		
		OUTPUT(upd_incidet,,'~thor_data400::in::ecrash::incident_patch_mdpd_agencyori_'+workunit,overwrite,__compressed__,
					csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

		do_all :=  SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_patch_mdpd_agencyori_'+workunit),
														FileServices.FinishSuperFileTransaction()
												 );
					 
		RETURN do_all;
END;

