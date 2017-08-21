EXPORT ExtractDeleteRecords (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) current, DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) prior) := FUNCTION 

	D_Current := DISTRIBUTE (Current,HASH32(RID));
	D_Prior		:= DISTRIBUTE (Prior,HASH32(RID));
	
	DeletedRecords := JOIN (D_Current,D_Prior,LEFT.RID = RIGHT.RID, TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := RIGHT; SELF := [];), RIGHT ONLY,LOCAL, HASH);
	
	RETURN DeletedRecords;
	
END;