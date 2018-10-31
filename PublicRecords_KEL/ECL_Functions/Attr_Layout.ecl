IMPORT PublicRecords_KEL;
//Layout for attributes

EXPORT Attr_Layout := RECORD
	PublicRecords_KEL.ECL_Functions.InputEcho_Layout AND NOT [BusInputUIDAppend, RepNumber];
	INTEGER7 AppendedLexID; 
	INTEGER2 AppendedLexIDScore;  
	STRING5 InputPrefixClean;
	STRING20 InputFirstNameClean;
	STRING5 InputSuffixClean;
	STRING10 InputPrimaryRangeClean;
	STRING3 InputPreDirectionClean;
	STRING28 InputPrimaryNameClean;
	STRING4 InputAddressSuffixClean;
	STRING3 InputPostDirectionClean;
	STRING10 InputUnitDesigClean;
	STRING8 InputSecondaryRangeClean;
	STRING25 InputCityNameClean; 
	STRING3 InputStateClean;
	STRING5 InputZip5Clean; 
	STRING4 InputZip4Clean;
	STRING10 InputLatitudeClean;
	STRING11 InputLongitudeClean;
	STRING3 InputCountyClean;
	STRING7 InputGeoblockClean;
	STRING3 InputAddressTypeClean;
	STRING4 InputAddressStatusClean;
	STRING54 InputEmailClean;
	STRING10 InputHomePhoneClean;
	STRING10 InputWorkPhoneClean;
	STRING20 InputArchiveDateClean;
 END;