IMPORT FLAccidents_Ecrash, STD;

EXPORT fn_Data_Deletion_eCrash_Logic (STRING logicalfilename) := FUNCTION

	//Incident File
	incident := FLAccidents_Ecrash.Infiles.Incident;
	d_incident := DISTRIBUTE(incident, HASH32(incident_id));
	
	//Modify logic based on the requirement
	//Unique Incidents
	unq_incident := DEDUP(SORT(d_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL);

	//FL Incidents									
	fl_incident := d_incident(loss_state_abbr = 'FL' AND source_id IN ['TM','TF'] 
	                         AND STD.Str.ToUpperCase(TRIM(vendor_code, ALL)) = 'CRASHLOGIC');
	
	//Unique FL incidents
	unq_fl_incident := DEDUP(SORT(fl_incident(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL);
	
	//Use common function to delete from Individual files
	seq_delete := SEQUENTIAL(fn_pre_Delete_counts(unq_fl_incident),
	                         fn_InputFiles_Deletion_Common(unq_fl_incident, logicalfilename),
													 fn_post_delete_counts());
	
	RETURN seq_delete;
	
END;
	