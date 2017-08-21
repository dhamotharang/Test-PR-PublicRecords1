EXPORT updateRID (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr) := FUNCTION
	
	D_Header	:=	DISTRIBUTE (Hdr,HASH32(LNPID));
	
	First_Record_In_Cluster := DEDUP(SORT(D_Header,LNPID,RID,LOCAL),LNPID,LOCAL) (LNPID <> RID);
	
	Update_RID_for_Singleton := JOIN (D_Header,First_Record_In_Cluster,LEFT.LNPID = RIGHT.LNPID,TRANSFORM (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF.RID := IF (LEFT.LNPID = RIGHT.LNPID AND LEFT.RID = RIGHT.RID,RIGHT.LNPID,LEFT.RID), SELF := LEFT), LEFT OUTER, LOCAL);

	Slim_Header	:=	PROJECT (Update_RID_for_Singleton,HealthCareProvider.Layouts.LNPID_REC);
	
	Unique_LNPID	:=	DEDUP(SORT (Slim_Header,LNPID,RID,LOCAL),LNPID,LOCAL);
	
	Mismatch_LNPID	:=	Unique_LNPID (RID <> LNPID);
	
	D_Mismatch_LNPID	:=	DISTRIBUTE (Mismatch_LNPID,HASH32(LNPID));
	
	Assign_New_LNPID	:=	JOIN (Update_RID_for_Singleton, D_Mismatch_LNPID, LEFT.LNPID = RIGHT.LNPID AND LEFT.RID = RIGHT.RID, TRANSFORM(HealthCareProvider.Layouts.NEW_LNPID_REC, SELF.NEW_RID := RIGHT.LNPID; SELF := LEFT; SELF := [];),LOCAL);
	
	Append_New_LNPID	:=	JOIN (Update_RID_for_Singleton, Assign_New_LNPID, LEFT.LNPID 	= RIGHT.LNPID AND
																													LEFT.RID		=	RIGHT.RID, 
																													TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
																														SELF.RID := IF(RIGHT.NEW_RID > 0, RIGHT.NEW_LNPID, LEFT.RID); SELF := LEFT;),LEFT OUTER,LOCAL);
	RETURN Append_New_LNPID;
END;

	
		
