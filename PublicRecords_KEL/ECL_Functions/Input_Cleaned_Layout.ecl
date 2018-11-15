IMPORT PublicRecords_KEL;

EXPORT Input_Cleaned_Layout := RECORD
	INTEGER InputUIDAppend; 
	INTEGER BusInputUIDAppend;	
	INTEGER7 LexIDAppend; 
	INTEGER2 LexIDScoreAppend;  

	STRING5  InputPrefixClean;
	STRING20 InputFirstNameClean;
	STRING20 InputMiddleNameClean;
	STRING20 InputLastNameClean;
	STRING5  InputSuffixClean;

	STRING10 InputPrimaryRangeClean;
	STRING3 InputPreDirectionClean;
	STRING28 InputPrimaryNameClean;
	STRING4 InputAddressSuffixClean;
	STRING3 InputPostDirectionClean;
	STRING10 InputUnitDesigClean;
	STRING8 InputSecondaryRangeClean;
	STRING25 InputCityClean; 
	STRING3 InputStateClean;
	STRING5 InputZip5Clean; 
	STRING4 InputZip4Clean;
	STRING10 InputLatitudeClean;
	STRING11 InputLongitudeClean;
	STRING3 InputCountyClean;
	STRING7 InputGeoblockClean;
	STRING3 InputAddressTypeClean;
	STRING4 InputAddressStatusClean;
	STRING50 InputEMailClean;
	STRING10 InputHomePhoneClean;
	STRING10 InputWorkPhoneClean;
	STRING20 InputDLNumberClean;
	STRING3 InputDLStateClean;
	STRING8 InputDOBClean;
	STRING9 InputSSNClean;
	STRING20 InputArchiveDateClean;

	PublicRecords_KEL.ECL_Functions.Cleaned_Date_Layout;  
END;