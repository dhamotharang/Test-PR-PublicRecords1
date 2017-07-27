import Gateway, Models;
export Layout_Interactive_In := RECORD
	STRING30  AccountNumber;
	STRING9   SSN;
	STRING30  FirstName;
	STRING30  MiddleName;
	STRING30  LastName;
	STRING5   NameSuffix;

	STRING8   DateOfBirth;
	
	STRING200 StreetAddress;
	STRING25  City;
	STRING2   State;
	STRING5   Zip;
	
	UNSIGNED	Age;
	STRING20  DLNumber;
	STRING2   DLState;
	
	STRING10  HomePhone;
	STRING10  WorkPhone;
		
	UNSIGNED  DPPAPurpose;
	UNSIGNED  GLBPurpose;
	STRING5   IndustryClass;
	boolean   LnBranded;
	UNSIGNED  HistoryDateYYYYMM;
	string20  HistoryDateTimeStamp;
	boolean   OfacOnly;
	boolean   AdditionalWatchlists;
	boolean   isStudent := false;		// for studentDefender model
	boolean   TestDataEnabled := false;	// for test seeds
	STRING20  TestDataTableName := '';	// for test seeds

	BOOLEAN   ExcludeWatchLists;
	UNSIGNED1 OFACVersion;
	
	BOOLEAN   IncludeAdditionalWatchlists;
	BOOLEAN   IncludeOFAC;
	REAL      GlobalWatchListThreshold;
	BOOLEAN   UseDOBFilter;
	INTEGER2  DOBRadius;
	STRING20  CustomFraudModel;
	STRING45  IPAddress := '';
	STRING50 	email := '';
	STRING20  Model;

	dataset(Gateway.Layouts.Config) gateways;
	string50 DataRestrictionMask;
	string50 DataPermissionMask;
	
	boolean   IncludeRiskIndices := false;
	string16 Channel := '';
	string8 Income := '';
	string8 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';
	string8 TimeofApplication := '';
	
	Dataset(Models.Layouts.Layout_Model_Request_In) ModelRequests;
	BOOLEAN _Blind := false;
	
END;