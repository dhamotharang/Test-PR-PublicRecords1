Import Data_Services, doxie_files, doxie,ut;

f_sanctn_incident := SANCTN.file_base_incident;


layout_SANCTN_incident_key := RECORD
  SANCTN.layout_SANCTN_incident_clean AND NOT [PARTY_NUMBER,RECORD_TYPE,MODIFIED_DATE,LOAD_DATE,CLN_MODIFIED_DATE,CLN_LOAD_DATE];
	
END;


/* Mask the SSNs found within the freeform text field */
layout_SANCTN_incident_key tSANCTN_key(f_sanctn_incident L) := transform
   self.incident_text := SANCTN.fMask_SSN(L.incident_text);
   self               := L;
end;

f_sanctn_incident_new := project(f_sanctn_incident,tSANCTN_key(LEFT));

KeyName 			:= 'thor_data400::key::sanctn::';

export Key_SANCTN_incident := index(f_sanctn_incident_new
                                   ,{BATCH_NUMBER,INCIDENT_NUMBER}
																	 ,{f_sanctn_incident_new}
																	 ,Data_Services.Data_location.Prefix('sanctn')+KeyName+'incident_'+doxie.Version_SuperKey);

