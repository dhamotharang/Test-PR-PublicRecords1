IMPORT FLAccidents_Ecrash, Data_Services;

EXPORT fn_Data_Deletion_Incident_File (STRING logicalfilename) := FUNCTION

//Add spray check for expire options

  //Use the same filename to spray the file provided and check the layout
  incident_lay := RECORD
                   STRING incident_id;
			            END;
  ds_incident_delete :=	DATASET('~thor_data400::in::ecrash::incident_raw::deletion_' + logicalfilename,
									              incident_lay,
									              CSV(HEADING(1),
                                SEPARATOR([',','\t']),
                                TERMINATOR(['\n','\r\n','\n\r'])));
  d_incident_delete := DEDUP(SORT(DISTRIBUTE(ds_incident_delete(TRIM(incident_id, LEFT, RIGHT) <> ''), HASH32(incident_id)), 
	                                incident_id, LOCAL), 
	                           incident_id, LOCAL);
	p_incident_delete := PROJECT(d_incident_delete, TRANSFORM(FLAccidents_Ecrash.Layout_Infiles.incident_new, SELF := LEFT, SELF := []));
															 
	//Use common function to delete from Individual files
	seq_delete := SEQUENTIAL(fn_pre_Delete_counts(p_incident_delete),
	                         fn_InputFiles_Deletion_Common(p_incident_delete, logicalfilename),
													 fn_post_delete_counts());
	
	RETURN seq_delete;
	
END;

;