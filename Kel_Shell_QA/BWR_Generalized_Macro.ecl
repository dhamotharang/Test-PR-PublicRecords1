eyeball:=0;
Tag_name:='Input_echo_clean';

Layout_sprint3 := record
	INTEGER InputID; 
	STRING30 Account;
	UNSIGNED6 LexID; 
	UNSIGNED2 LexIDScore;  
	STRING20 InputFirstName;
	STRING120 InputAddress;
	STRING25 InputCity;
	STRING3 InputState;
	STRING5 InputZip;
	STRING10 InputHomePhone;
	STRING10 InputWorkPhone;
	STRING50 InputEmail;
	STRING20 InputArchiveDate; 
	//Cleaned 
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
	INTEGER DATEFIRSTSEEN;
	INTEGER DATELASTSEEN;
END;

FCRA_File := dataset('~ak::out::Vault::FCRA::THOR::Sprint3W20180924-090808',Layout_sprint3,CSV(HEADING(single), QUOTE('"')));
NonFCRA_file := dataset('~ak::out::Vault::nonFCRA::THOR::Sprint3_W20180924-090751',Layout_sprint3,CSV(HEADING(single), QUOTE('"')));

Kel_Shell_QA.Generalized_Macro_call(FCRA_File,eyeball,Tag_name);


EXPORT BWR_Generalized_Macro := 'todo';