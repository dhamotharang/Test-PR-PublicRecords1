import Enclarity, HealthCareProvider, doxie_files;
EXPORT UpdateSanctionFlag (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr = HealthCareFacility.Files.facility_Salt_Output_DS) := FUNCTION

	ENC_Bus_Sanc_Raw	:=	HealthCareProvider.Files.MPRD_FAC_DS(OIG_FLAG = 'Y');

	Enc_Bus_Sanc := PROJECT (ENC_Bus_Sanc_Raw,TRANSFORM(HealthCareProvider.Layouts.Sanction_Lookup_REC, SELF.GroupKey := LEFT.Group_Key; SELF.SRC := 'OIG'; SELF:=[];));

	ADD_LNPID_DS := DEDUP(SORT(JOIN(Enc_Bus_Sanc,HealthCareFacility.Files.facility_Salt_Output_DS (src = '64'),
																		LEFT.GroupKey = RIGHT.Vendor_ID AND RIGHT.SRC = '64',
																		TRANSFORM(HealthCareProvider.Layouts.Sanction_Lookup_REC, SELF.GroupKey := LEFT.GroupKey; SELF:= RIGHT; SELF:=[];)
																			),GroupKey,LNPID),GroupKey,LNPID); 

	GroupKey_LNPID_DS := DEDUP(SORT(JOIN(Enc_Bus_Sanc,ADD_LNPID_DS,LEFT.GroupKey = RIGHT.GroupKey,TRANSFORM(HealthCareProvider.Layouts.Sanction_Lookup_REC,SELF.LNPID := RIGHT.LNPID; SELF := LEFT; SELF := []), LEFT OUTER) (LNPID > 0 and GroupKey <> ''),RECORD),RECORD);

	Ingenix_Sanc_Raw	:=	HealthCareProvider.key_sanction; 
	
	Fac_HDR := HealthCareFacility.Files.Facility_Salt_Output_DS;

	IngBusSancFilter := DEDUP (SORT (JOIN(Ingenix_Sanc_Raw,Fac_HDR,LEFT.LNPID = RIGHT.LNPID,TRANSFORM (HealthCareProvider.Layouts.Sanction_Lookup_REC,SELF.LNPID := RIGHT.LNPID; SELF.SANC_ID := LEFT.SANC_ID; SELF:=[])),RECORD),RECORD);
	
	IngType := JOIN(IngBusSancFilter,doxie_files.key_sanctions_sancid,left.sanc_id=right.l_sancid,transform(HealthCareProvider.Layouts.Sanction_Lookup_REC,
										self.src:=map(right.sanc_brdtype ='FEDERAL BOARDS' and right.sanc_type = 'DEBARRED/EXCLUDED' => 'OIG',
																	right.sanc_brdtype ='FEDERAL BOARDS' and right.sanc_type in ['EXCLUDED','EXCLUDED/DELETED'] => 'OPM',
																	'STATE');self := left; self:=[]),keep(1000), limit(0));

	CombinedSanction := dedup(sort(GroupKey_LNPID_DS+IngType,LNPID,src),LNPID,src);

	Sanc_DS  := PROJECT (CombinedSanction, TRANSFORM(HealthCareProvider.Layouts.LNPID_SANC_REC, SELF.isState := IF (LEFT.SRC = 'STATE',TRUE,FALSE); 
																																															SELF.isOIG := IF (LEFT.SRC = 'OIG',TRUE,FALSE); 
																																															SELF.isOPM := IF (LEFT.SRC = 'OPM',TRUE,FALSE); 
																																															SELF := LEFT; SELF := [];));
	
	HealthCareProvider.Layouts.LNPID_SANC_REC doRollUp (HealthCareProvider.Layouts.LNPID_SANC_REC L, DATASET (HealthCareProvider.Layouts.LNPID_SANC_REC) R) := TRANSFORM
			SELF.isState := IF (EXISTS(R(isState = TRUE)),TRUE,FALSE);
			SELF.isOIG	 := IF (EXISTS(R(isOIG	 = TRUE)),TRUE,FALSE);
			SELF.isOPM	 := IF (EXISTS(R(isOPM 	 = TRUE)),TRUE,FALSE);
			SELF := L;
	END;
	
	R_Sanc_DS := ROLLUP (GROUP(Sanc_DS,LNPID),GROUP,doRollUp (LEFT, ROWS(LEFT)));
	
	Sanc_Flag_DS := UNGROUP (R_Sanc_DS);
	
	D_HDR	:=	DISTRIBUTE(HDR,HASH32(LNPID));
	
	Apply_Sanction_Flag := JOIN (D_HDR,DISTRIBUTE(Sanc_Flag_DS,HASH32(LNPID)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(RECORDOF(HDR), SELF.is_State_Sanction := RIGHT.isState; SELF.is_OIG_Sanction := RIGHT.isOIG; SELF.is_OPM_Sanction := RIGHT.isOPM; SELF := LEFT;), LEFT OUTER ,LOOKUP,  LOCAL);

	// Apply_Ingenix_Sanction_Flag	:=	JOIN (Apply_EnClarity_Sanction_Flag,HealthCareProvider.key_sanction,LEFT.LNPID = RIGHT.LNPID,TRANSFORM(RECORDOF(HDR), SELF.is_State_Sanction := IF (LEFT.LNPID = RIGHT.LNPID, TRUE,LEFT.is_State_Sanction); SELF := LEFT;), LEFT OUTER , LOOKUP, LOCAL);

	// OUTPUT (DE_Sanction_Base (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (Sanc_DS (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (Sanc_Flag_DS (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (Trim_Header (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (LNPID_VendorID (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (GetSanction_LNPID (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (De_GetSanction_LNPID (GROUP_KEY = '11769166790279800000000038549430865148'));
	// OUTPUT (Apply_EnClarity_Sanction_Flag (VENDOR_ID = '11769166790279800000000038549430865148'));
	// OUTPUT(COUNT(Apply_EnClarity_Sanction_Flag));
	// OUTPUT(COUNT(Apply_Ingenix_Sanction_Flag));
	RETURN Apply_Sanction_Flag;
END;
