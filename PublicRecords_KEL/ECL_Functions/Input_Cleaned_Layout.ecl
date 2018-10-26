IMPORT PublicRecords_KEL;

EXPORT Input_Cleaned_Layout := RECORD
	INTEGER InputID; 
	INTEGER7 AppendedLexID; 
	INTEGER2 AppendedLexIDScore;  

	STRING5  InputCleanPrefix;
	STRING20 InputCleanFirstName;
	STRING20 InputCleanMiddleName;
	STRING20 InputCleanLastName;
	STRING5  InputCleanSuffix;

	STRING10 InputCleanPrimaryRange;
	STRING3 InputCleanPreDirection;
	STRING28 InputCleanPrimaryName;
	STRING4 InputCleanAddressSuffix;
	STRING3 InputCleanPostDirection;
	STRING10 InputCleanUnitDesig;
	STRING8 InputCleanSecondaryRange;
	STRING25 InputCleanCityName; 
	STRING3 InputCleanState;
	STRING5 InputCleanZip5; 
	STRING4 InputCleanZip4;
	STRING10 InputCleanLatitude;
	STRING11 InputCleanLongitude;
	STRING3 InputCleanCounty;
	STRING7 InputCleanGeoblock;
	STRING3 InputCleanAddressType;
	STRING4 InputCleanAddressStatus;
	STRING25 InputCleanCountry;
	STRING50 InputCleanEMail;
	STRING10 InputCleanHomePhone;
	STRING10 InputCleanWorkPhone;
	STRING20 InputCleanDLNumber;
	STRING3 InputCleanDLState;
	STRING8 InputCleanDOB;
	STRING9 InputCleanSSN;
	STRING20 ArchiveDate;

	PublicRecords_KEL.ECL_Functions.Cleaned_Date_Layout;  
END;