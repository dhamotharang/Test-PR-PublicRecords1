IMPORT PublicRecords_KEL, Gateway;

// When defining fields here you cannot utilize variable length definitions such as "STRING" otherwise the LIBRARY interface breaks
EXPORT Interface_Options := INTERFACE

	EXPORT STRING100 AttributeSetName := '';
	EXPORT STRING100 VersionName := '';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING8 ArchiveDate := '0';
	EXPORT STRING250 InputFileName := '';
	EXPORT STRING100 IntendedPurpose := '';
	EXPORT STRING100 Data_Restriction_Mask := '';
	EXPORT STRING100 Data_Permission_Mask := '';
	EXPORT UNSIGNED GLBAPurpose := 0;
	EXPORT UNSIGNED DPPAPurpose := 0;
	EXPORT BOOLEAN Override_Experian_Restriction := FALSE;
	EXPORT STRING100 Allowed_Sources := '';
	EXPORT INTEGER ScoreThreshold := 80;
	EXPORT BOOLEAN ExcludeConsumerAttributes := FALSE;
	EXPORT BOOLEAN isMarketing := FALSE; // When TRUE enables Marketing Restrictions
	EXPORT BOOLEAN IsPrescreen := FALSE; // When TRUE enables Marketing Restrictions
	EXPORT STRING5 IndustryClass := ''; // When set to UTILI or DRMKT this restricts Utility data
	EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	EXPORT DATA57 KEL_Permissions_Mask := x''; // Set by PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate()
	EXPORT BOOLEAN OutputMasterResults := FALSE;
	EXPORT BOOLEAN IncludeMinors := TRUE;
	EXPORT INTEGER upperage := 20;
	EXPORT BOOLEAN TurnOffRelatives := FALSE;
	EXPORT BOOLEAN TurnOffHouseHolds := FALSE;
	EXPORT BOOLEAN UseIngestDate := FALSE;//used to archive by header first ingest date instead of dfs/vdfs
	
	EXPORT BOOLEAN IncludeInferredPerformance := FALSE;
		
	EXPORT DATASET(Gateway.Layouts.Config) Gateways := DATASET([], Gateway.Layouts.Config);

	// BIP Append Options
	EXPORT UNSIGNED BIPAppendScoreThreshold := 75;
	EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
	EXPORT BOOLEAN BIPAppendPrimForce := FALSE;
	EXPORT BOOLEAN BIPAppendReAppend := TRUE;
	EXPORT BOOLEAN BIPAppendIncludeAuthRep := FALSE;
	
	EXPORT BOOLEAN CaliforniaInPerson := False; 
	//lexid append and pii append
	EXPORT BOOLEAN RetainInputLexid := False; //keep input lexid
	EXPORT BOOLEAN BestPIIAppend := False; //do not append best pii for running

	// CCPA Options
	EXPORT UNSIGNED1 LexIdSourceOptout := 1;
	EXPORT STRING100 TransactionID := '';
	EXPORT STRING100 BatchUID := '';
	EXPORT UNSIGNED6 GlobalCompanyId := 0;
	
	



END;	