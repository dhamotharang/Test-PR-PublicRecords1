import gateway;

export Layout_InstID_SoapCall := RECORD
	STRING30 AccountNumber;
	STRING20 FirstName;
	STRING20 MiddleName;
	STRING20 LastName;
	STRING5 NameSuffix;
	STRING100 StreetAddress;
	STRING25 City;
	STRING2 State;
	STRING9 Zip;
	STRING25 Country;
	STRING9 SSN;
	STRING8 DateOfBirth;
	STRING3 Age;
	STRING20 DLNumber;
	STRING2 DLState;
	STRING50 Email;
	STRING45 IPAddress;
	STRING10 HomePhone;
	STRING10 WorkPhone;
	STRING100 EmployerName;
	STRING20 FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM := 999999;
	string50 neutral_gateway := '';
	boolean IncludeScore := true;
	boolean RemoveFares := false;	// Fares filtering for use mainly in insurance
	string50 DataRestrictionMask := '0000000000000000000000000';
	integer bsversion;
	boolean LeadIntegrityMode := false;
	string30 did := '';
	string30 orig_account := '';
	boolean FraudpointMode := false;
	string20 HistoryDateTimeStamp := '';
	boolean Include_nonFCRA_Collections_Inquiries := false;
	boolean RetainInputDID := false; 
	string50 DataPermissionMask := '0000000000100';	//position 11 is FDN test fraud/contributory fraud - set default to populate 
	boolean isPrescreen := false;
	boolean IncludeLnJ := false; 
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	boolean ADL_Based_Shell := false;
	boolean PreScreen := false;
	unsigned3 LastSeenThreshold := 0; 
	boolean ExcludeIbehavior := false;  // temporary field until end of July 2017
END;


	
	