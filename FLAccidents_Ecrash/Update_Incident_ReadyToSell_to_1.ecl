/*
One time BWR to update Incident file field Ready_To_Sell_Data to 1 for historical records.
*/
IMPORT Data_Services;
EXPORT Update_Incident_ReadyToSell_to_1 := FUNCTION

	ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
												 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
												 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');												 

	FLAccidents_Ecrash.Layout_Infiles.incident_new UpdateReadyToSell(ds_incident L) := TRANSFORM
																																											SELF.Ready_To_Sell_Data := '1';
																																											SELF := L;
																																										 END;

	upd_readytosell := PROJECT(ds_incident, UpdateReadyToSell(LEFT));
		
	ds_incident_upd := OUTPUT(upd_readytosell,,'~thor_data400::in::ecrash::incident_update_readytosell_'+workunit,overwrite,__compressed__,
				                    csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

	do_all :=  SEQUENTIAL(
	                      ds_incident_upd,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_update_readytosell_'+workunit),
												FileServices.FinishSuperFileTransaction()
											 );
					 
		RETURN do_all;
END;

