/*
One time BWR to expand Incident file to update Releasable to 1 for historical records.
*/
IMPORT Data_Services;
EXPORT Update_Incident_Releasable_to_1 := FUNCTION

	ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
												 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
												 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');												 

		FLAccidents_Ecrash.Layout_Infiles.incident_new UpdateReleasable(ds_incident L) := TRANSFORM
																																												SELF.Releasable := '1';
																																												SELF := L;
																																											END;

		upd_Releasable := PROJECT(ds_incident, UpdateReleasable(LEFT));
		
		OUTPUT(upd_Releasable,,'~thor_data400::in::ecrash::incident_update_releasable_'+workunit,overwrite,__compressed__,
					    csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

		do_all :=  SEQUENTIAL(
														FileServices.StartSuperFileTransaction(),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_update_releasable_'+workunit),
														FileServices.FinishSuperFileTransaction()
												 );
					 
		RETURN do_all;
END;

