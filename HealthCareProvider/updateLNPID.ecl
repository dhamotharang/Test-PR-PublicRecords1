EXPORT updateLNPID (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr) := FUNCTION
	
	D_Header	:=	DISTRIBUTE (Hdr,HASH32(LNPID));
	
	Slim_Header	:=	PROJECT (D_Header,Layouts.LNPID_REC);
	
	Unique_LNPID	:=	DEDUP(SORT (Slim_Header,LNPID,RID,LOCAL),LNPID,LOCAL);
	
	Mismatch_LNPID	:=	Unique_LNPID (RID <> LNPID);
	
	D_Mismatch_LNPID	:=	DISTRIBUTE (Mismatch_LNPID,HASH32(LNPID));
	
	Assign_New_LNPID	:=	JOIN (D_Header, D_Mismatch_LNPID, LEFT.LNPID = RIGHT.LNPID, TRANSFORM(Layouts.NEW_LNPID_REC, SELF.NEW_LNPID := RIGHT.RID; SELF := LEFT;),LOCAL);
	
	Append_New_LNPID	:=	JOIN (D_Header, Assign_New_LNPID, LEFT.LNPID 	= RIGHT.LNPID AND
																													LEFT.RID		=	RIGHT.RID, 
																													TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
																														SELF.LNPID := IF(RIGHT.NEW_LNPID > 0, RIGHT.NEW_LNPID, LEFT.LNPID); SELF := LEFT;),LEFT OUTER,LOCAL);
	RETURN Append_New_LNPID;
END;