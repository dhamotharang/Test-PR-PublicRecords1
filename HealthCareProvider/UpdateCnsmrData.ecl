EXPORT UpdateCnsmrData (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr) := FUNCTION

	D_Header		:=	DISTRIBUTE (Hdr,HASH32(DID));
	
	D_WatchDOG	:=	DEDUP(SORT(DISTRIBUTE (HealthCareProvider.Files.WATCH_DOG_DS,HASH32(DID)) (DID > 0),DID,LOCAL),DID,LOCAL); 
	
	Update_Cnsmr_Data	:=	JOIN (D_Header, D_WatchDOG, LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(HDR), 
																				SELF.CNSMR_DOB := IF (LEFT.CNSMR_DOB = 0,RIGHT.DOB,LEFT.CNSMR_DOB); SELF.CNSMR_SSN := IF (RIGHT.VALID_SSN IN ['G','Z'] AND LEFT.CNSMR_SSN = '',RIGHT.SSN,LEFT.CNSMR_SSN); SELF := LEFT;), LEFT OUTER, LOCAL);
	
	RETURN Update_Cnsmr_Data;
END;