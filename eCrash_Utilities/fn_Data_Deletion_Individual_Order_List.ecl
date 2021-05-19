IMPORT FLAccidents_Ecrash;

EXPORT fn_Data_Deletion_Individual_Order_List (STRING logicalfilename) := FUNCTION

  //Incident File
	incident := FLAccidents_Ecrash.Infiles.Incident;
	d_incident := DISTRIBUTE(incident, HASH32(incident_id));
	
	//Update Cru_Order_ID_List 									
  incident_to_delete := d_incident(cru_order_id IN Cru_Order_ID_List);
	//Unique Incidents to delete
	unq_incident_to_delete := DEDUP(SORT(incident_to_delete(incident_id <> ''), incident_id, -(sent_to_hpcc_datetime), LOCAL), incident_id, LOCAL);
	
	//Use common function to delete from Individual files
	seq_delete := SEQUENTIAL(fn_pre_Delete_counts(unq_incident_to_delete),
	                         fn_InputFiles_Deletion_Common(unq_incident_to_delete, logicalfilename),
													 fn_post_delete_counts());
	
	
	RETURN seq_delete;
	
END;	

