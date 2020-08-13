IMPORT PublicRecords_KEL;

EXPORT Input_UID_Bus_Layout := RECORD
	INTEGER G_ProcBusUID;
	PublicRecords_KEL.ECL_Functions.Input_Bus_Layout;
	STRING Rep6FirstName;
	STRING Rep6MiddleName;
	STRING Rep6LastName;
	STRING Rep6NameSuffix;
	STRING Rep6StreetAddressLine1;
	STRING Rep6StreetAddressLine2;
	STRING Rep6City;
	STRING Rep6State;
	STRING Rep6Zip;
	STRING Rep6SSN;
	STRING Rep6DOB;
	STRING Rep6Age;
	STRING Rep6DLNumber;
	STRING Rep6DLState;
	STRING Rep6HomePhone;
	STRING Rep6EmailAddress;
	STRING Rep6FormerLastName;
	STRING Rep6LexID;
END;