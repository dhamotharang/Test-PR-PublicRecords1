IMPORT ut;
IMPORT Data_Services; // Deprecated ut.foreign_prod

EXPORT Update_Incident_Contrib_source := FUNCTION

  Incident_Contrib_source_layout := RECORD
		                                   STRING11 incident_id,
		                                   STRING3  contrib_source
	                                  END;

	ds_incident_CS   :=	DATASET('~thor_data400::in::ecrash::incident_newcontrib'
															,Incident_Contrib_source_layout
															,csv(terminator('\n'), separator(','),quote('"'),maxlength(10000)))(Incident_ID != 'Incident_ID');                    

 ds_incident      := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
															,FLAccidents_Ecrash.Layout_Infiles.incident_new
															,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');                  

	FLAccidents_Ecrash.Layout_Infiles.incident_new updateIncidents(ds_incident L, ds_incident_CS R) := TRANSFORM
															SELF.contrib_source := IF(stringlib.stringtouppercase(trim(R.contrib_source,left,right)) IN ['//N', 'NULL'],  '',  R.contrib_source);
															SELF := L;
	END;

	cmbnd_incidents := JOIN(DISTRIBUTE(ds_incident,HASH(incident_id)),DISTRIBUTE(ds_incident_CS,HASH(incident_id)),
					left.incident_id = right.incident_id,
					updateIncidents(left,right), left outer, LOCAL);
					
	 OUTPUT(cmbnd_incidents,,'~thor_data400::in::ecrash::incident_patch_prod_Contribsource_'+WORKUNIT,overwrite, __compressed__,
					csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

	do_all :=  SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_patch_prod_Contribsource_'+WORKUNIT),
		FileServices.FinishSuperFileTransaction()
	);
	 
	RETURN do_all;
END;