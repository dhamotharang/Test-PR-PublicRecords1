EXPORT phone_noreconn_param := MODULE

	EXPORT searchParams := INTERFACE
		// COMPLIANCE SETTINGS
		EXPORT UNSIGNED1 DPPAPurpose := 0;
		EXPORT UNSIGNED1 GLBPurpose := 0;
		EXPORT STRING32  ApplicationType := '';
		EXPORT STRING5   IndustryClass := '';

		// SEARCH FIELDS
		EXPORT STRING30  Acctno := '';
		EXPORT STRING14  DID := '';
		EXPORT STRING11  SSN := '';
		EXPORT STRING120 UnParsedFullName := '';
		EXPORT STRING30  FirstName := '';
		EXPORT STRING30  MiddleName := '';
		EXPORT STRING30  LastName := '';
		EXPORT STRING4   NameSuffix := '';
		EXPORT STRING120 CompanyName := '';
		EXPORT STRING200 Addr := '';
		EXPORT STRING10  PrimRange := '';
		EXPORT STRING2   PreDir := '';
		EXPORT STRING30  PrimName := '';
		EXPORT STRING4   Suffix := '';
		EXPORT STRING2   PostDir := '';
		EXPORT STRING10  SecRange := '';
		EXPORT STRING25  City := '';
		EXPORT STRING2   State := '';
		EXPORT STRING6   Zip := '';
		EXPORT STRING15  Phone := '';
		
	  EXPORT UNSIGNED datefirstseen := 0;
	  EXPORT UNSIGNED datelastseen := 0;
		EXPORT STRING30  County := '';
		
		// OPTIONS
		EXPORT BOOLEAN   ExcludeCurrentGong := FALSE;
		EXPORT BOOLEAN   IncludeFullPhonesPlus := FALSE;
		EXPORT BOOLEAN   IncludeLastResort := FALSE;
		EXPORT BOOLEAN   IncludeRealTimePhones := FALSE;
		EXPORT BOOLEAN   IncludeHRI := FALSE;

		// TUNING
		EXPORT BOOLEAN   AllowNickNames := FALSE;
		EXPORT BOOLEAN   PhoneticMatch := FALSE;
		EXPORT UNSIGNED1 ScoreThreshold := 0;

		// RECORD MANAGEMENT
		EXPORT UNSIGNED8 MaxResults := 0;
		EXPORT UNSIGNED8 MaxResultsThisTime := 0;
		EXPORT UNSIGNED8 SkipRecords := 0;
		EXPORT BOOLEAN   StrictMatch := FALSE;
	END;

END;
