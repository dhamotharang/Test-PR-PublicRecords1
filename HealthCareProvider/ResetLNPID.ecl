EXPORT ResetLNPID (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Infile, DATASET ({UNSIGNED8 LNPID}) rLNPID) := FUNCTION

	R_LNPID := JOIN (Infile,rLNPID,LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.LNPID := IF (LEFT.LNPID = RIGHT.LNPID,LEFT.RID,LEFT.LNPID), SELF := LEFT;),LOOKUP,LEFT OUTER);

	D_LNPID := DISTRIBUTE (R_LNPID,HASH32(LNPID));
	ITER := thorlib.wuid();
	HealthCareProvider.Mac_SF_BuildProcess(D_LNPID,
																					HealthCareProvider.Files.HealthCare_Prefix, 
																					HealthCareProvider.Files.person_out_Suffix, 
																					iter, SaltOut, 3, ,true, false);

	HealthCareProvider.Mac_SF_BuildProcess(D_LNPID,
																					HealthCareProvider.Files.HealthCare_Prefix, 
																					HealthCareProvider.Files.person_In_Suffix, 
																					iter, SaltIn, 3, ,true, true);
	
	RETURN SEQUENTIAL(SaltOut,SaltIn);
END;