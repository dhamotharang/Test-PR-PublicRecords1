EXPORT UpdateEntityType (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr) := FUNCTION
	
	NPPES_DS := PROJECT (HealthCareProvider.files.NPPES_DID_DS,transform(HealthCareProvider.Layouts.Entity_Type_REC,SELF.Entity_Type := LEFT.Entity_Type_Code; SELF.Npi_Number := LEFT.npi;));

	S_NPPES_DS := DEDUP (SORT (NPPES_DS (ENTITY_TYPE <> ''),NPI_NUMBER,ENTITY_TYPE),NPI_NUMBER);

	Append_Entity_Type := JOIN (HDR,S_NPPES_DS,LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.ENTITY_TYPE := IF (LEFT.ENTITY_TYPE = '',RIGHT.ENTITY_TYPE,LEFT.ENTITY_TYPE); SELF := LEFT;), LEFT OUTER, LOOKUP, LOCAL);

	RETURN Append_Entity_Type;
END;