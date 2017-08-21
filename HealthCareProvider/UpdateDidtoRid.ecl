EXPORT UpdateDidtoRid (DATASET ({UNSIGNED8 LNPID}) Infile, DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) HDR = HealthCareProvider.Files.Person_Salt_Output_DS) := FUNCTION

	De_Infile := DEDUP(SORT (Infile (LNPID > 0), LNPID), LNPID);

	REC_CNT := COUNT (De_Infile) : INDEPENDENT;
	
	J0 := JOIN (Hdr,De_Infile,LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
			SELF.LNPID := IF (LEFT.LNPID = RIGHT.LNPID,LEFT.RID,LEFT.LNPID);
			SELF := LEFT;
			),LEFT OUTER, LOOKUP);
	
	J1 := JOIN (DISTRIBUTE(Hdr,HASH32(LNPID)),DISTRIBUTE(De_Infile,HASH32(LNPID)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
			SELF.LNPID := IF (LEFT.LNPID = RIGHT.LNPID,LEFT.RID,LEFT.LNPID);
			SELF := LEFT;
			),LEFT OUTER,  LOCAL);

	Reset_DID_to_RID := IF (REC_CNT > 10000,J1,J0);

	RETURN (DISTRIBUTE (Reset_DID_to_RID, HASH32(LNPID)));
END;