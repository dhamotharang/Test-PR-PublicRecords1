IMPORT PublicRecords_KEL;
//Layout for attributes

EXPORT Attr_Layout := RECORD
	INTEGER InputID; 
	STRING30 Account;
	INTEGER7 InputLexID;
	STRING70 InputFirstName;
	STRING120 InputAddress;
	STRING50 InputCity;
	STRING25 InputState; 
	STRING10 InputZip;
	STRING10 InputHomePhone;
	STRING10 InputWorkPhone;
	STRING50 InputEmail;
	STRING20 InputArchiveDate; 
	//Cleaned 
	INTEGER7 AppendedLexID; 
	INTEGER2 AppendedLexIDScore;  
	STRING5 InputCleanPrefix;
	STRING20 InputCleanFirstName;
	STRING5 InputCleanSuffix;
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
 END;