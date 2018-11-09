IMPORT PublicRecords_KEL;
//Layout for attributes

EXPORT Attr_Layout := RECORD
	PublicRecords_KEL.ECL_Functions.InputEcho_Layout AND NOT [BusInputUIDAppend, RepNumber];
	INTEGER7 LexIDAppend; 
	INTEGER2 LexIDScoreAppend; 
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
	STRING54 InputEmailClean;
	STRING10 InputHomePhoneClean;
	STRING10 InputWorkPhoneClean;
	STRING20 InputArchiveDateClean;
	STRING3 InputPrefixCleanPop,
	STRING3 InputFirstNameCleanPop,
	STRING3 InputSuffixCleanPop,
	STRING3 InputPrimaryRangeCleanPop,
	STRING3 InputPreDirectionCleanPop,
	STRING3 InputPrimaryNameCleanPop,
	STRING3 InputAddressSuffixCleanPop,
	STRING3 InputPostDirectionCleanPop,
	STRING3 InputUnitDesigCleanPop,
	STRING3 InputSecondaryRangeCleanPop,
	STRING3 InputCityCleanPop, 
	STRING3 InputStateCleanPop,
	STRING3 InputZip5CleanPop,
	STRING3 InputZip4CleanPop,
	STRING3 InputLatitudeCleanPop,
	STRING3 InputLongitudeCleanPop,
	STRING3 InputCountyCleanPop,
	STRING3 InputGeoblockCleanPop,
	STRING3 InputAddressTypeCleanPop,
	STRING3 InputAddressStatusCleanPop,
	STRING3 InputEmailCleanPop,
	STRING3 InputHomePhoneCleanPop,
	STRING3 InputWorkPhoneCleanPop,
	STRING3 InputArchiveDateCleanPop
 END;