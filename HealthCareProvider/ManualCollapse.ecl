EXPORT ManualCollapse (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) hdr = HealthCareProvider.Files.Person_Salt_Output_DS, DATASET ({UNSIGNED8 BEFORE_LNPID, UNSIGNED8 AFTER_LNPID}) CDS) := FUNCTION
	
	De_Cds := DEDUP (SORT(CDS (BEFORE_LNPID > 0 AND AFTER_LNPID > 0),BEFORE_LNPID,AFTER_LNPID),BEFORE_LNPID,AFTER_LNPID);

	NPI_REC := RECORD
		UNSIGNED8 BEFORE_LNPID;
		UNSIGNED8 AFTER_LNPID;
		STRING10 	BEFORE_NPI_NUMBER;
		STRING10  AFTER_NPI_NUMBER;
	END;
	
	R := RECORD
		UNSIGNED8 LNPID;
		STRING10 NPI_NUMBER;
	END;
	
	Mini_HDR := DEDUP(SORT(PROJECT (HDR,R),LNPID,MAP(NPI_NUMBER <> '' => 1,2),LOCAL),LNPID,LOCAL);

	BEF_NPI := JOIN (Mini_HDR,De_Cds,LEFT.LNPID = RIGHT.BEFORE_LNPID,TRANSFORM(NPI_REC, SELF.BEFORE_NPI_NUMBER := LEFT.NPI_NUMBER; SELF := RIGHT; SELF := [];), LOOKUP);
	AFT_NPI := JOIN (Mini_HDR,De_Cds,LEFT.LNPID = RIGHT.AFTER_LNPID,TRANSFORM(NPI_REC, SELF.AFTER_NPI_NUMBER := LEFT.NPI_NUMBER; SELF := RIGHT; SELF := [];), LOOKUP);
	COM_NPI := JOIN (BEF_NPI, AFT_NPI,LEFT.AFTER_LNPID = RIGHT.AFTER_LNPID,TRANSFORM(NPI_REC, SELF.BEFORE_NPI_NUMBER := LEFT.BEFORE_NPI_NUMBER; SELF.AFTER_NPI_NUMBER := RIGHT.AFTER_NPI_NUMBER; SELF := LEFT;), LOOKUP);
	DE_NPI	:= DEDUP(SORT(COM_NPI,RECORD),RECORD);

	REM_MISMATCH_NPI := DE_NPI (~(BEFORE_NPI_NUMBER <> '' AND AFTER_NPI_NUMBER <> '' AND BEFORE_NPI_NUMBER <> AFTER_NPI_NUMBER));
	
	U_CDS := PROJECT (DEDUP(SORT (REM_MISMATCH_NPI,BEFORE_LNPID,AFTER_LNPID),BEFORE_LNPID,AFTER_LNPID),{UNSIGNED8 BEFORE_LNPID, UNSIGNED8 AFTER_LNPID}) (AFTER_LNPID > 0 AND BEFORE_LNPID > 0);
	
	Rec_Cnt := COUNT (U_CDS);
	
	J0 := JOIN (Hdr,U_CDS,LEFT.LNPID = RIGHT.BEFORE_LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
			SELF.LNPID := IF (LEFT.LNPID = RIGHT.BEFORE_LNPID,RIGHT.AFTER_LNPID,LEFT.LNPID);
			SELF := LEFT;
			),LEFT OUTER, LOOKUP);
	
	J1 := JOIN (DISTRIBUTE(Hdr,HASH32(LNPID)),DISTRIBUTE(U_CDS,HASH32(BEFORE_LNPID)),LEFT.LNPID = RIGHT.BEFORE_LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, 
			SELF.LNPID := IF (LEFT.LNPID = RIGHT.BEFORE_LNPID,RIGHT.AFTER_LNPID,LEFT.LNPID);
			SELF := LEFT;
			),LEFT OUTER,  LOCAL);

	Manual_Collapse := IF (REC_CNT > 10000,J1,J0);
	// OUTPUT (COUNT (U_NPI (CNT = 1)),NAMED('Unique_UPIN_Count'));
	// OUTPUT (COUNT (U_UPIN (CNT = 1)),NAMED('Unique_NPI_Count'));
	// OUTPUT (COUNT (U_NPI (CNT > 1)),NAMED('Multiple_UPIN_Count'));
	// OUTPUT (COUNT (U_UPIN (CNT > 1)),NAMED('Multiple_NPI_Count'));
	// OUTPUT (U_NPI (CNT > 1),NAMED('Sample_Multiple_UPIN_Count'));
	// OUTPUT (U_UPIN (CNT > 1),NAMED('Sample_NPI_Count'));

	// OUTPUT (COUNT(De_Cds),NAMED('Raw_Bef_Aft_LNPID'));
	// OUTPUT (Rec_Cnt,NAMED('Cleaned_Bef_Aft_LNPID'));
	OUTPUT (DE_NPI ((BEFORE_NPI_NUMBER <> '' AND AFTER_NPI_NUMBER <> '' AND BEFORE_NPI_NUMBER <> AFTER_NPI_NUMBER)));

	RETURN (DISTRIBUTE (Manual_Collapse, HASH32(LNPID)));
	// OUTPUT (COUNT (DE_CDS));
	// OUTPUT (COUNT (DE_NPI));
	// OUTPUT (DE_NPI (BEFORE_NPI_NUMBER <> '' AND AFTER_NPI_NUMBER <> '' AND BEFORE_NPI_NUMBER <> AFTER_NPI_NUMBER));
	// OUTPUT (COUNT (DE_NPI(BEFORE_NPI_NUMBER <> '' AND AFTER_NPI_NUMBER <> '' AND BEFORE_NPI_NUMBER <> AFTER_NPI_NUMBER)));
	// OUTPUT (sort(BEF_NPI,after_lnpid,before_lnpid));
	// OUTPUT (sort(AFT_NPI,after_lnpid,before_lnpid));
	// OUTPUT (sort(COM_NPI,after_lnpid,before_lnpid));
	
	// RETURN sort(REM_MISMATCH_NPI,after_lnpid,before_lnpid);
END;
