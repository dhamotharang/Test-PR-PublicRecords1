IMPORT Risk_Indicators;

EXPORT Layout_Business_Advisor_In := RECORD
	STRING30  AccountNumber;
	STRING14  BDID;
	STRING30  CompanyName;
	STRING30  AlternateCompanyName;
	STRING200 Addr;
	STRING30  City;
	STRING2   State;
	STRING5   Zip;
	STRING10  BusinessPhone;
	STRING9   TaxIDNumber;
	STRING45  BusinessIPAddress;

	STRING20  RepresentativeFirstName;
	STRING20  RepresentativeMiddleName;
	STRING20  RepresentativeLastName;
	STRING5   RepresentativeNameSuffix;
	STRING200 RepresentativeAddr;
	STRING30  RepresentativeCity;
	STRING2   RepresentativeState;
	STRING5   RepresentativeZip;
	STRING9   RepresentativeSSN;
	STRING8   RepresentativeDOB;
	STRING30  RepresentativeAge;
	STRING30  RepresentativeDLNumber;
	STRING30  RepresentativeDLState;
	STRING30  RepresentativeHomePhone;
	STRING100 RepresentativeEmailAddress;
	STRING30  RepresentativeFormerLastName;
	
	UNSIGNED  DPPAPurpose;
	UNSIGNED  GLBPurpose;
	STRING5   IndustryClass;
	BOOLEAN   LnBranded;
	UNSIGNED  HistoryDateYYYYMM;
	BOOLEAN   OfacOnly;
	BOOLEAN   ExcludeWatchLists;
	UNSIGNED1 OFACVersion;
	
	BOOLEAN   IncludeAdditionalWatchlists;
	BOOLEAN   IncludeOFAC;
	REAL      GlobalWatchListThreshold;
	BOOLEAN   UseDOBFilter;
	INTEGER2  DOBRadius;
	
	boolean   TestDataEnabled := false;	// for test seeds
	STRING20  TestDataTableName := '';	// for test seeds	
	string10 exactMatchLevel := '';
	string50 DataRestrictionMask := '';
	boolean	 _Blind := false;
  
  DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
END;
