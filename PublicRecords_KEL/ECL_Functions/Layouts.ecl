﻿IMPORT PublicRecords_KEL;

EXPORT Layouts := MODULE

	SHARED LayoutInputPIIEchoInternal := RECORD
		STRING65 InputAccountEcho;
		INTEGER7 InputLexIDEcho;
		STRING78 InputFirstNameEcho;
		STRING78 InputMiddleNameEcho;
		STRING78 InputLastNameEcho;
		STRING120 InputStreetEcho;
		STRING50 InputCityEcho;
		STRING25 InputStateEcho;
		STRING10 InputZipEcho;
		STRING10 InputSSNEcho;
		STRING10 InputDOBEcho;
		STRING50 InputDLEcho;
		STRING25 InputDLStateEcho;
		STRING16 InputHomePhoneEcho;
		STRING16 InputWorkPhoneEcho;
		STRING54 InputEmailEcho;
		STRING20 InputArchiveDateEcho;
	END;

	SHARED LayoutInputPIICleanInternal := RECORD
		INTEGER7 LexIDAppend;
		INTEGER3 LexIDScoreAppend;
		STRING6 InputPrefixClean;
		STRING20 InputFirstNameClean;
		STRING20 InputMiddleNameClean;
		STRING30 InputLastNameClean;
		STRING6 InputSuffixClean;
		STRING10 InputPrimaryRangeClean;
		STRING6 InputPreDirectionClean;
		STRING28 InputPrimaryNameClean;
		STRING6 InputAddressSuffixClean;
		STRING6 InputPostDirectionClean;
		STRING10 InputUnitDesigClean;
		STRING8 InputSecondaryRangeClean;
		STRING25 InputCityClean;
		STRING6 InputStateClean;
		STRING6 InputZip5Clean;
		STRING6 InputZip4Clean;
		STRING InputStreetClean;
		STRING InputFullAddressClean;
		STRING10 InputLatitudeClean;
		STRING11 InputLongitudeClean;
		STRING6 InputCountyClean;
		STRING7 InputGeoblockClean;
		STRING6 InputAddressTypeClean;
		STRING6 InputAddressStatusClean;
		STRING9 InputSSNClean;
		STRING10 InputDOBClean;
		STRING50 InputDLClean;
		STRING6 InputDLStateClean;
		STRING10 InputHomePhoneClean;
		STRING10 InputWorkPhoneClean;
		STRING54 InputEmailClean;
		STRING20 InputArchiveDateClean;
	END;
	
	EXPORT LayoutInputPII := RECORD
		INTEGER InputUIDAppend;
		INTEGER BusInputUIDAppend;
		INTEGER RepNumber;
		LayoutInputPIIEchoInternal;
		LayoutInputPIICleanInternal;
		STRING10 InputIncomeEcho;
		STRING10 InputBalanceEcho;
		STRING10 InputChargeoFFdEcho;
		STRING70 InputFormernameEcho;
		STRING100 InputEmploymentEcho;
		PublicRecords_KEL.ECL_Functions.Cleaned_Date_Layout;
	END;
	
	SHARED LayoutInputPIIInternal := RECORD
		LayoutInputPIIEchoInternal;
		STRING1 InputAccountEchoPop;
		STRING1 InputLexIDEchoPop;
		STRING1 InputFirstNameEchoPop;
		STRING1 InputMiddleNameEchoPop;
		STRING1 InputLastNameEchoPop;
		STRING1 InputStreetEchoPop;
		STRING1 InputCityEchoPop;
		STRING1 InputStateEchoPop;
		STRING1 InputZipEchoPop;
		STRING1 InputSSNEchoPop;
		STRING1 InputDOBEchoPop;
		STRING1 InputDLEchoPop;
		STRING1 InputDLStateEchoPop;
		STRING1 InputHomePhoneEchoPop;
		STRING1 InputWorkPhoneEchoPop;
		STRING1 InputEmailEchoPop;
		STRING1 InputArchiveDateEchoPop;
		LayoutInputPIICleanInternal;
		STRING6 InputPrefixCleanPop;
		STRING6 InputFirstNameCleanPop;
		STRING6 InputMiddleNameCleanPop;
		STRING6 InputLastNameCleanPop;
		STRING6 InputSuffixCleanPop;
		STRING6 InputPrimaryRangeCleanPop;
		STRING6 InputPreDirectionCleanPop;
		STRING6 InputPrimaryNameCleanPop;
		STRING6 InputAddressSuffixCleanPop;
		STRING6 InputPostDirectionCleanPop;
		STRING6 InputUnitDesigCleanPop;
		STRING6 InputSecondaryRangeCleanPop;
		STRING6 InputCityCleanPop;
		STRING6 InputStateCleanPop;
		STRING6 InputZip5CleanPop;
		STRING6 InputZip4CleanPop;
		STRING6 InputStreetCleanPop;
		STRING6 InputFullAddressCleanPop;
		STRING6 InputLatitudeCleanPop;
		STRING6 InputLongitudeCleanPop;
		STRING6 InputCountyCleanPop;
		STRING6 InputGeoblockCleanPop;
		STRING6 InputAddressTypeCleanPop;
		STRING6 InputAddressStatusCleanPop;
		STRING6 InputSSNCleanPop;
		STRING6 InputDOBCleanPop;
		STRING6 InputDLCleanPop;
		STRING6 InputDLStateCleanPop;
		STRING6 InputHomePhoneCleanPop;
		STRING6 InputWorkPhoneCleanPop;
		STRING6 InputEmailCleanPop;
		STRING6 InputArchiveDateCleanPop;
	END;
	
	SHARED LayoutInputBIIBusinessEchoInternal := RECORD
		STRING65 BusInputAccountEcho;
		// INTEGER	BusInputUIDAppend;
		INTEGER7 InputLexIDBusExtendedFamilyEcho;
		INTEGER7 InputLexIDBusLegalFamilyEcho;
		INTEGER7 InputLexIDBusLegalEntityEcho;
		INTEGER7 InputLexIDBusPlaceGroupEcho;
		INTEGER7 InputLexIDBusPlaceEcho;
		STRING120 BusInputNameEcho;
		STRING120 BusInputAlternateNameEcho;
		STRING120 BusInputStreetEcho;
		STRING50 BusInputCityEcho;
		STRING25 BusInputStateEcho;
		STRING10 BusInputZipEcho;
		STRING16 BusInputPhoneEcho;
		STRING45 BusInputIPAddressEcho;
		STRING50 BusInputURLEcho;
		STRING50 BusInputEmailEcho;
		STRING10 BusInputTINEcho;
		STRING6 BusInputSICCodeEcho;
		STRING6 BusInputNAICSCodeEcho;
		STRING20 BusInputArchiveDateEcho;
	END;
	
	SHARED LayoutInputBIIRepEchoInternal := RECORD
		INTEGER7 BusInputRep1LexIDEcho;
		STRING78 BusInputRep1FirstNameEcho;
		STRING78 BusInputRep1MiddleNameEcho;
		STRING78 BusInputRep1LastNameEcho;
		STRING120 BusInputRep1StreetEcho;
		STRING50 BusInputRep1CityEcho;
		STRING25 BusInputRep1StateEcho;
		STRING10 BusInputRep1ZipEcho;
		STRING10 BusInputRep1PhoneEcho;
		STRING10 BusInputRep1SSNEcho;
		STRING10 BusInputRep1DOBEcho;
		STRING54 BusInputRep1EmailEcho;
		STRING50 BusInputRep1DLEcho;
		STRING25 BusInputRep1DLStateEcho;
		INTEGER7 BusInputRep2LexIDEcho;
		STRING78 BusInputRep2FirstNameEcho;
		STRING78 BusInputRep2MiddleNameEcho;
		STRING78 BusInputRep2LastNameEcho;
		STRING120 BusInputRep2StreetEcho;
		STRING50 BusInputRep2CityEcho;
		STRING25 BusInputRep2StateEcho;
		STRING10 BusInputRep2ZipEcho;
		STRING10 BusInputRep2PhoneEcho;
		STRING10 BusInputRep2SSNEcho;
		STRING10 BusInputRep2DOBEcho;
		STRING54 BusInputRep2EmailEcho;
		STRING50 BusInputRep2DLEcho;
		STRING25 BusInputRep2DLStateEcho;
		INTEGER7 BusInputRep3LexIDEcho;
		STRING78 BusInputRep3FirstNameEcho;
		STRING78 BusInputRep3MiddleNameEcho;
		STRING78 BusInputRep3LastNameEcho;
		STRING120 BusInputRep3StreetEcho;
		STRING50 BusInputRep3CityEcho;
		STRING25 BusInputRep3StateEcho;
		STRING10 BusInputRep3ZipEcho;
		STRING10 BusInputRep3PhoneEcho;
		STRING10 BusInputRep3SSNEcho;
		STRING10 BusInputRep3DOBEcho;
		STRING54 BusInputRep3EmailEcho;
		STRING50 BusInputRep3DLEcho;
		STRING25 BusInputRep3DLStateEcho;
		INTEGER7 BusInputRep4LexIDEcho;
		STRING78 BusInputRep4FirstNameEcho;
		STRING78 BusInputRep4MiddleNameEcho;
		STRING78 BusInputRep4LastNameEcho;
		STRING120 BusInputRep4StreetEcho;
		STRING50 BusInputRep4CityEcho;
		STRING25 BusInputRep4StateEcho;
		STRING10 BusInputRep4ZipEcho;
		STRING10 BusInputRep4PhoneEcho;
		STRING10 BusInputRep4SSNEcho;
		STRING10 BusInputRep4DOBEcho;
		STRING54 BusInputRep4EmailEcho;
		STRING50 BusInputRep4DLEcho;
		STRING25 BusInputRep4DLStateEcho;
		INTEGER7 BusInputRep5LexIDEcho;
		STRING78 BusInputRep5FirstNameEcho;
		STRING78 BusInputRep5MiddleNameEcho;
		STRING78 BusInputRep5LastNameEcho;
		STRING120 BusInputRep5StreetEcho;
		STRING50 BusInputRep5CityEcho;
		STRING25 BusInputRep5StateEcho;
		STRING10 BusInputRep5ZipEcho;
		STRING10 BusInputRep5PhoneEcho;
		STRING10 BusInputRep5SSNEcho;
		STRING10 BusInputRep5DOBEcho;
		STRING54 BusInputRep5EmailEcho;
		STRING50 BusInputRep5DLEcho;
		STRING25 BusInputRep5DLStateEcho;
	END;
	
	SHARED LayoutInputBIIBusinessCleanInternal := RECORD
		INTEGER7 LexIDBusExtendedFamilyAppend;
		INTEGER7 LexIDBusLegalFamilyAppend;
		INTEGER7 LexIDBusLegalEntityAppend;
		INTEGER7 LexIDBusPlaceGroupAppend;
		INTEGER7 LexIDBusPlaceAppend;
		INTEGER3 BusLexIDScoreAppend;
		INTEGER3 BusLexIDWeightAppend;	
		STRING20 BusInputArchiveDateClean;
		// STRING20 BusInputArchiveDateTimeClean;
		STRING120 BusInputNameClean;
		STRING120 BusInputAlternateNameClean;
		STRING10 BusInputPrimRangeClean;
		STRING6	BusInputPreDirClean;
		STRING28 BusInputPrimNameClean;
		STRING6	BusInputAddrSuffixClean;
		STRING6	BusInputPostDirClean;
		STRING10 BusInputUnitDesigClean;
		STRING8	BusInputSecRangeClean;
		STRING25 BusInputCityClean;
		STRING6	BusInputStateClean;
		STRING6	BusInputZip5Clean;
		STRING6	BusInputZip4Clean;
		STRING BusInputStreetClean;
		STRING BusInputFullAddressClean;
		STRING10 BusInputLatitudeClean;
		STRING11 BusInputLongitudeClean;
		STRING6	BusInputCountyClean;
		STRING7	BusInputGeoblockClean;
		STRING6	BusInputAddrTypeClean;
		STRING6	BusInputAddrStatusClean;
		STRING10 BusInputPhoneClean;
		STRING10 BusInputTINClean;
		STRING54 BusInputEmailClean;
	END;
	
	EXPORT LayoutInputBII := RECORD
		INTEGER BusInputUIDAppend;
		LayoutInputBIIBusinessEchoInternal;
		LayoutInputBIIBusinessCleanInternal;
	END;
	
	Shared LayoutInputBIIRepCleanInternal := RECORD
		STRING6	BusInputRep1PrefixClean;
		STRING20 BusInputRep1FirstNameClean;
		STRING20 BusInputRep1MiddleNameClean;
		STRING30 BusInputRep1LastNameClean;
		STRING6	BusInputRep1SuffixClean;
		STRING10 BusInputRep1PrimRangeClean;
		STRING6	BusInputRep1PreDirClean;
		STRING28 BusInputRep1PrimNameClean;
		STRING6	BusInputRep1AddrSuffixClean;
		STRING6	BusInputRep1PostDirClean;
		STRING10 BusInputRep1UnitDesigClean;
		STRING8	BusInputRep1SecRangeClean;
		STRING25 BusInputRep1CityClean;
		STRING6	BusInputRep1StateClean;
		STRING6	BusInputRep1Zip5Clean;
		STRING6	BusInputRep1Zip4Clean;
		STRING BusInputRep1StreetClean;
		STRING BusInputRep1FullAddressClean;
		STRING10 BusInputRep1LatitudeClean;
		STRING11 BusInputRep1LongitudeClean;
		STRING6	BusInputRep1CountyClean;
		STRING7	BusInputRep1GeoblockClean;
		STRING6	BusInputRep1AddrTypeClean;
		STRING6	BusInputRep1AddrStatusClean;
		STRING10 BusInputRep1PhoneClean;
		STRING10 BusInputRep1SSNClean;
		STRING10 BusInputRep1DOBClean;
		STRING50 BusInputRep1DLClean;
		STRING6	BusInputRep1DLStateClean;
		STRING54 BusInputRep1EmailClean;
		STRING6	BusInputRep2PrefixClean;
		STRING20 BusInputRep2FirstNameClean;
		STRING20 BusInputRep2MiddleNameClean;
		STRING30 BusInputRep2LastNameClean;
		STRING6	BusInputRep2SuffixClean;
		STRING10 BusInputRep2PrimRangeClean;
		STRING6	BusInputRep2PreDirClean;
		STRING28 BusInputRep2PrimNameClean;
		STRING6	BusInputRep2AddrSuffixClean;
		STRING6	BusInputRep2PostDirClean;
		STRING10 BusInputRep2UnitDesigClean;
		STRING8	BusInputRep2SecRangeClean;
		STRING25 BusInputRep2CityClean;
		STRING6	BusInputRep2StateClean;
		STRING6	BusInputRep2Zip5Clean;
		STRING6	BusInputRep2Zip4Clean;
		STRING BusInputRep2StreetClean;
		STRING BusInputRep2FullAddressClean;
		STRING10 BusInputRep2LatitudeClean;
		STRING11 BusInputRep2LongitudeClean;
		STRING6	BusInputRep2CountyClean;
		STRING7	BusInputRep2GeoblockClean;
		STRING6	BusInputRep2AddrTypeClean;
		STRING6	BusInputRep2AddrStatusClean;
		STRING10 BusInputRep2PhoneClean;
		STRING10 BusInputRep2SSNClean;
		STRING10 BusInputRep2DOBClean;
		STRING50 BusInputRep2DLClean;
		STRING6	BusInputRep2DLStateClean;
		STRING54 BusInputRep2EmailClean;
		STRING6	BusInputRep3PrefixClean;
		STRING20 BusInputRep3FirstNameClean;
		STRING20 BusInputRep3MiddleNameClean;
		STRING30 BusInputRep3LastNameClean;
		STRING6	BusInputRep3SuffixClean;
		STRING10 BusInputRep3PrimRangeClean;
		STRING6	BusInputRep3PreDirClean;
		STRING28 BusInputRep3PrimNameClean;
		STRING6	BusInputRep3AddrSuffixClean;
		STRING6	BusInputRep3PostDirClean;
		STRING10 BusInputRep3UnitDesigClean;
		STRING8	BusInputRep3SecRangeClean;
		STRING25 BusInputRep3CityClean;
		STRING6	BusInputRep3StateClean;
		STRING6	BusInputRep3Zip5Clean;
		STRING6	BusInputRep3Zip4Clean;
		STRING BusInputRep3StreetClean;
		STRING BusInputRep3FullAddressClean;
		STRING10 BusInputRep3LatitudeClean;
		STRING11 BusInputRep3LongitudeClean;
		STRING6	BusInputRep3CountyClean;
		STRING7	BusInputRep3GeoblockClean;
		STRING6	BusInputRep3AddrTypeClean;
		STRING6	BusInputRep3AddrStatusClean;
		STRING10 BusInputRep3PhoneClean;
		STRING10 BusInputRep3SSNClean;
		STRING10 BusInputRep3DOBClean;
		STRING50 BusInputRep3DLClean;
		STRING6	BusInputRep3DLStateClean;
		STRING54 BusInputRep3EmailClean;
		STRING6	BusInputRep4PrefixClean;
		STRING20 BusInputRep4FirstNameClean;
		STRING20 BusInputRep4MiddleNameClean;
		STRING30 BusInputRep4LastNameClean;
		STRING6	BusInputRep4SuffixClean;
		STRING10 BusInputRep4PrimRangeClean;
		STRING6	BusInputRep4PreDirClean;
		STRING28 BusInputRep4PrimNameClean;
		STRING6	BusInputRep4AddrSuffixClean;
		STRING6	BusInputRep4PostDirClean;
		STRING10 BusInputRep4UnitDesigClean;
		STRING8	BusInputRep4SecRangeClean;
		STRING25 BusInputRep4CityClean;
		STRING6	BusInputRep4StateClean;
		STRING6	BusInputRep4Zip5Clean;
		STRING6	BusInputRep4Zip4Clean;
		STRING BusInputRep4StreetClean;
		STRING BusInputRep4FullAddressClean;
		STRING10 BusInputRep4LatitudeClean;
		STRING11 BusInputRep4LongitudeClean;
		STRING6	BusInputRep4CountyClean;
		STRING7	BusInputRep4GeoblockClean;
		STRING6	BusInputRep4AddrTypeClean;
		STRING6	BusInputRep4AddrStatusClean;
		STRING10 BusInputRep4PhoneClean;
		STRING10 BusInputRep4SSNClean;
		STRING10 BusInputRep4DOBClean;
		STRING50 BusInputRep4DLClean;
		STRING6	BusInputRep4DLStateClean;
		STRING54 BusInputRep4EmailClean;
		STRING6	BusInputRep5PrefixClean;
		STRING20 BusInputRep5FirstNameClean;
		STRING20 BusInputRep5MiddleNameClean;
		STRING30 BusInputRep5LastNameClean;
		STRING6	BusInputRep5SuffixClean;
		STRING10 BusInputRep5PrimRangeClean;
		STRING6	BusInputRep5PreDirClean;
		STRING28 BusInputRep5PrimNameClean;
		STRING6	BusInputRep5AddrSuffixClean;
		STRING6	BusInputRep5PostDirClean;
		STRING10 BusInputRep5UnitDesigClean;
		STRING8	BusInputRep5SecRangeClean;
		STRING25 BusInputRep5CityClean;
		STRING6 BusInputRep5StateClean;
		STRING6 BusInputRep5Zip5Clean;
		STRING6 BusInputRep5Zip4Clean;
		STRING BusInputRep5StreetClean;
		STRING BusInputRep5FullAddressClean;
		STRING10 BusInputRep5LatitudeClean;
		STRING11 BusInputRep5LongitudeClean;
		STRING6	BusInputRep5CountyClean;
		STRING7	BusInputRep5GeoblockClean;
		STRING6	BusInputRep5AddrTypeClean;
		STRING6	BusInputRep5AddrStatusClean;
		STRING10 BusInputRep5PhoneClean;
		STRING10 BusInputRep5SSNClean;
		STRING10 BusInputRep5DOBClean;
		STRING50 BusInputRep5DLClean;
		STRING6	BusInputRep5DLStateClean;
		STRING54 BusInputRep5EmailClean;
	END;
	
	SHARED LayoutInputBIIInternal := RECORD
		LayoutInputBIIBusinessEchoInternal;
		LayoutInputBIIRepEchoInternal;
		STRING1	BusInputArchiveDateEchoPop;
		STRING1	BusInputNameEchoPop;
		STRING1	BusInputAlternateNameEchoPop;
		STRING1	BusInputStreetEchoPop;
		STRING1	BusInputCityEchoPop;
		STRING1	BusInputStateEchoPop;
		STRING1	BusInputZipEchoPop;
		STRING1	BusInputPhoneEchoPop;
		STRING1	BusInputTINEchoPop;
		STRING1	BusInputSICCodeEchoPop;
		STRING1	BusInputNAICSCodeEchoPop;
		STRING1	BusInputRep1LexIDEchoPop;
		STRING1	BusInputRep1FirstNameEchoPop;
		STRING1	BusInputRep1MiddleNameEchoPop;
		STRING1	BusInputRep1LastNameEchoPop;
		STRING1	BusInputRep1StreetEchoPop;
		STRING1	BusInputRep1CityEchoPop;
		STRING1	BusInputRep1StateEchoPop;
		STRING1	BusInputRep1ZipEchoPop;
		STRING1	BusInputRep1PhoneEchoPop;
		STRING1	BusInputRep1SSNEchoPop;
		STRING1	BusInputRep1DOBEchoPop;
		STRING1	BusInputRep1EmailEchoPop;
		STRING1	BusInputRep1DLEchoPop;
		STRING1	BusInputRep1DLStateEchoPop;
		STRING1	BusInputRep2LexIDEchoPop;
		STRING1	BusInputRep2FirstNameEchoPop;
		STRING1	BusInputRep2MiddleNameEchoPop;
		STRING1	BusInputRep2LastNameEchoPop;
		STRING1	BusInputRep2StreetEchoPop;
		STRING1	BusInputRep2CityEchoPop;
		STRING1	BusInputRep2StateEchoPop;
		STRING1	BusInputRep2ZipEchoPop;
		STRING1	BusInputRep2PhoneEchoPop;
		STRING1	BusInputRep2SSNEchoPop;
		STRING1	BusInputRep2DOBEchoPop;
		STRING1	BusInputRep2EmailEchoPop;
		STRING1	BusInputRep2DLEchoPop;
		STRING1	BusInputRep2DLStateEchoPop;
		STRING1	BusInputRep3LexIDEchoPop;
		STRING1	BusInputRep3FirstNameEchoPop;
		STRING1	BusInputRep3MiddleNameEchoPop;
		STRING1	BusInputRep3LastNameEchoPop;
		STRING1	BusInputRep3StreetEchoPop;
		STRING1	BusInputRep3CityEchoPop;
		STRING1	BusInputRep3StateEchoPop;
		STRING1	BusInputRep3ZipEchoPop;
		STRING1	BusInputRep3PhoneEchoPop;
		STRING1	BusInputRep3SSNEchoPop;
		STRING1	BusInputRep3DOBEchoPop;
		STRING1	BusInputRep3EmailEchoPop;
		STRING1	BusInputRep3DLEchoPop;
		STRING1	BusInputRep3DLStateEchoPop;
		STRING1	BusInputRep4LexIDEchoPop;
		STRING1	BusInputRep4FirstNameEchoPop;
		STRING1	BusInputRep4MiddleNameEchoPop;
		STRING1	BusInputRep4LastNameEchoPop;
		STRING1	BusInputRep4StreetEchoPop;
		STRING1	BusInputRep4CityEchoPop;
		STRING1	BusInputRep4StateEchoPop;
		STRING1	BusInputRep4ZipEchoPop;
		STRING1	BusInputRep4PhoneEchoPop;
		STRING1	BusInputRep4SSNEchoPop;
		STRING1	BusInputRep4DOBEchoPop;
		STRING1	BusInputRep4EmailEchoPop;
		STRING1	BusInputRep4DLEchoPop;
		STRING1	BusInputRep4DLStateEchoPop;
		STRING1	BusInputRep5LexIDEchoPop;
		STRING1	BusInputRep5FirstNameEchoPop;
		STRING1	BusInputRep5MiddleNameEchoPop;
		STRING1	BusInputRep5LastNameEchoPop;
		STRING1	BusInputRep5StreetEchoPop;
		STRING1	BusInputRep5CityEchoPop;
		STRING1	BusInputRep5StateEchoPop;
		STRING1	BusInputRep5ZipEchoPop;
		STRING1	BusInputRep5PhoneEchoPop;
		STRING1	BusInputRep5SSNEchoPop;
		STRING1	BusInputRep5DOBEchoPop;
		STRING1	BusInputRep5EmailEchoPop;
		STRING1	BusInputRep5DLEchoPop;
		STRING1	BusInputRep5DLStateEchoPop;
		
		LayoutInputBIIBusinessCleanInternal;
		LayoutInputBIIRepCleanInternal;
		STRING6	BusInputArchiveDateCleanPop;
		// STRING6 BusInputArchiveDateTimeCleanPop;
		STRING6	BusInputNameCleanPop;
		STRING6	BusInputAlternateNameCleanPop;
		STRING6	BusInputPrimRangeCleanPop;
		STRING6	BusInputPreDirCleanPop;
		STRING6	BusInputPrimNameCleanPop;
		STRING6	BusInputAddrSuffixCleanPop;
		STRING6	BusInputPostDirCleanPop;
		STRING6	BusInputUnitDesigCleanPop;
		STRING6	BusInputSecRangeCleanPop;
		STRING6	BusInputCityCleanPop;
		STRING6	BusInputStateCleanPop;
		STRING6	BusInputZip5CleanPop;
		STRING6	BusInputZip4CleanPop;
		STRING6	BusInputStreetCleanPop;
		STRING6	BusInputFullAddressCleanPop;
		STRING6	BusInputLatitudeCleanPop;
		STRING6	BusInputLongitudeCleanPop;
		STRING6	BusInputCountyCleanPop;
		STRING6	BusInputGeoblockCleanPop;
		STRING6	BusInputAddrTypeCleanPop;
		STRING6	BusInputAddrStatusCleanPop;
		STRING6	BusInputPhoneCleanPop;
		STRING6	BusInputTINCleanPop;
		STRING6	BusInputEmailCleanPop;	
		STRING6	BusInputRep1PrefixCleanPop;
		STRING6	BusInputRep1FirstNameCleanPop;
		STRING6	BusInputRep1MiddleNameCleanPop;
		STRING6	BusInputRep1LastNameCleanPop;
		STRING6	BusInputRep1SuffixCleanPop;
		STRING6	BusInputRep1PrimRangeCleanPop;
		STRING6	BusInputRep1PreDirCleanPop;
		STRING6	BusInputRep1PrimNameCleanPop;
		STRING6	BusInputRep1AddrSuffixCleanPop;
		STRING6	BusInputRep1PostDirCleanPop;
		STRING6	BusInputRep1UnitDesigCleanPop;
		STRING6	BusInputRep1SecRangeCleanPop;
		STRING6	BusInputRep1CityCleanPop;
		STRING6	BusInputRep1StateCleanPop;
		STRING6	BusInputRep1Zip5CleanPop;
		STRING6	BusInputRep1Zip4CleanPop;
		STRING6	BusInputRep1StreetCleanPop;
		STRING6	BusInputRep1FullAddressCleanPop;
		STRING6	BusInputRep1LatitudeCleanPop;
		STRING6	BusInputRep1LongitudeCleanPop;
		STRING6	BusInputRep1CountyCleanPop;
		STRING6	BusInputRep1GeoblockCleanPop;
		STRING6	BusInputRep1AddrTypeCleanPop;
		STRING6	BusInputRep1AddrStatusCleanPop;
		STRING6	BusInputRep1PhoneCleanPop;
		STRING6	BusInputRep1SSNCleanPop;
		STRING6	BusInputRep1DOBCleanPop;
		STRING6	BusInputRep1EmailCleanPop;
		STRING6	BusInputRep1DLCleanPop;
		STRING6	BusInputRep1DLStateCleanPop;
		STRING6	BusInputRep2PrefixCleanPop;
		STRING6	BusInputRep2FirstNameCleanPop;
		STRING6	BusInputRep2MiddleNameCleanPop;
		STRING6	BusInputRep2LastNameCleanPop;
		STRING6	BusInputRep2SuffixCleanPop;
		STRING6	BusInputRep2PrimRangeCleanPop;
		STRING6	BusInputRep2PreDirCleanPop;
		STRING6	BusInputRep2PrimNameCleanPop;
		STRING6	BusInputRep2AddrSuffixCleanPop;
		STRING6	BusInputRep2PostDirCleanPop;
		STRING6	BusInputRep2UnitDesigCleanPop;
		STRING6	BusInputRep2SecRangeCleanPop;
		STRING6	BusInputRep2CityCleanPop;
		STRING6	BusInputRep2StateCleanPop;
		STRING6	BusInputRep2Zip5CleanPop;
		STRING6	BusInputRep2Zip4CleanPop;
		STRING6	BusInputRep2StreetCleanPop;
		STRING6	BusInputRep2FullAddressCleanPop;
		STRING6	BusInputRep2LatitudeCleanPop;
		STRING6	BusInputRep2LongitudeCleanPop;
		STRING6	BusInputRep2CountyCleanPop;
		STRING6	BusInputRep2GeoblockCleanPop;
		STRING6	BusInputRep2AddrTypeCleanPop;
		STRING6	BusInputRep2AddrStatusCleanPop;
		STRING6	BusInputRep2PhoneCleanPop;
		STRING6	BusInputRep2SSNCleanPop;
		STRING6	BusInputRep2DOBCleanPop;
		STRING6	BusInputRep2EmailCleanPop;
		STRING6	BusInputRep2DLCleanPop;
		STRING6	BusInputRep2DLStateCleanPop;
		STRING6	BusInputRep3PrefixCleanPop;
		STRING6	BusInputRep3FirstNameCleanPop;
		STRING6	BusInputRep3MiddleNameCleanPop;
		STRING6	BusInputRep3LastNameCleanPop;
		STRING6	BusInputRep3SuffixCleanPop;
		STRING6	BusInputRep3PrimRangeCleanPop;
		STRING6	BusInputRep3PreDirCleanPop;
		STRING6	BusInputRep3PrimNameCleanPop;
		STRING6	BusInputRep3AddrSuffixCleanPop;
		STRING6	BusInputRep3PostDirCleanPop;
		STRING6	BusInputRep3UnitDesigCleanPop;
		STRING6	BusInputRep3SecRangeCleanPop;
		STRING6	BusInputRep3CityCleanPop;
		STRING6	BusInputRep3StateCleanPop;
		STRING6	BusInputRep3Zip5CleanPop;
		STRING6	BusInputRep3Zip4CleanPop;
		STRING6	BusInputRep3StreetCleanPop;
		STRING6	BusInputRep3FullAddressCleanPop;
		STRING6	BusInputRep3LatitudeCleanPop;
		STRING6	BusInputRep3LongitudeCleanPop;
		STRING6	BusInputRep3CountyCleanPop;
		STRING6	BusInputRep3GeoblockCleanPop;
		STRING6	BusInputRep3AddrTypeCleanPop;
		STRING6	BusInputRep3AddrStatusCleanPop;
		STRING6	BusInputRep3PhoneCleanPop;
		STRING6	BusInputRep3SSNCleanPop;
		STRING6	BusInputRep3DOBCleanPop;
		STRING6	BusInputRep3EmailCleanPop;
		STRING6	BusInputRep3DLCleanPop;
		STRING6	BusInputRep3DLStateCleanPop;
		STRING6	BusInputRep4PrefixCleanPop;
		STRING6	BusInputRep4FirstNameCleanPop;
		STRING6	BusInputRep4MiddleNameCleanPop;
		STRING6	BusInputRep4LastNameCleanPop;
		STRING6	BusInputRep4SuffixCleanPop;
		STRING6	BusInputRep4PrimRangeCleanPop;
		STRING6	BusInputRep4PreDirCleanPop;
		STRING6	BusInputRep4PrimNameCleanPop;
		STRING6	BusInputRep4AddrSuffixCleanPop;
		STRING6	BusInputRep4PostDirCleanPop;
		STRING6	BusInputRep4UnitDesigCleanPop;
		STRING6	BusInputRep4SecRangeCleanPop;
		STRING6	BusInputRep4CityCleanPop;
		STRING6	BusInputRep4StateCleanPop;
		STRING6	BusInputRep4Zip5CleanPop;
		STRING6	BusInputRep4Zip4CleanPop;
		STRING6	BusInputRep4StreetCleanPop;
		STRING6	BusInputRep4FullAddressCleanPop;
		STRING6	BusInputRep4LatitudeCleanPop;
		STRING6	BusInputRep4LongitudeCleanPop;
		STRING6	BusInputRep4CountyCleanPop;
		STRING6	BusInputRep4GeoblockCleanPop;
		STRING6	BusInputRep4AddrTypeCleanPop;
		STRING6	BusInputRep4AddrStatusCleanPop;
		STRING6	BusInputRep4PhoneCleanPop;
		STRING6	BusInputRep4SSNCleanPop;
		STRING6	BusInputRep4DOBCleanPop;
		STRING6	BusInputRep4EmailCleanPop;
		STRING6	BusInputRep4DLCleanPop;
		STRING6	BusInputRep4DLStateCleanPop;
		STRING6	BusInputRep5PrefixCleanPop;
		STRING6	BusInputRep5FirstNameCleanPop;
		STRING6	BusInputRep5MiddleNameCleanPop;
		STRING6	BusInputRep5LastNameCleanPop;
		STRING6	BusInputRep5SuffixCleanPop;
		STRING6	BusInputRep5PrimRangeCleanPop;
		STRING6	BusInputRep5PreDirCleanPop;
		STRING6	BusInputRep5PrimNameCleanPop;
		STRING6	BusInputRep5AddrSuffixCleanPop;
		STRING6	BusInputRep5PostDirCleanPop;
		STRING6	BusInputRep5UnitDesigCleanPop;
		STRING6	BusInputRep5SecRangeCleanPop;
		STRING6	BusInputRep5CityCleanPop;
		STRING6	BusInputRep5StateCleanPop;
		STRING6	BusInputRep5Zip5CleanPop;
		STRING6	BusInputRep5Zip4CleanPop;
		STRING6	BusInputRep5StreetCleanPop;
		STRING6	BusInputRep5FullAddressCleanPop;
		STRING6	BusInputRep5LatitudeCleanPop;
		STRING6	BusInputRep5LongitudeCleanPop;
		STRING6	BusInputRep5CountyCleanPop;
		STRING6	BusInputRep5GeoblockCleanPop;
		STRING6	BusInputRep5AddrTypeCleanPop;
		STRING6	BusInputRep5AddrStatusCleanPop;
		STRING6	BusInputRep5PhoneCleanPop;
		STRING6	BusInputRep5SSNCleanPop;
		STRING6	BusInputRep5DOBCleanPop;
		STRING6	BusInputRep5EmailCleanPop;
		STRING6	BusInputRep5DLCleanPop;
		STRING6	BusInputRep5DLStateCleanPop;
		INTEGER7 LexIDForRep1Append;
		INTEGER3 LexIDScoreForRep1Append;
		INTEGER7 LexIDForRep2Append;
		INTEGER3 LexIDScoreForRep2Append;
		INTEGER7 LexIDForRep3Append;
		INTEGER3 LexIDScoreForRep3Append;
		INTEGER7 LexIDForRep4Append;
		INTEGER3 LexIDScoreForRep4Append;
		INTEGER7 LexIDForRep5Append;
		INTEGER3 LexIDScoreForRep5Append;
	END;
	
	SHARED LayoutPersonInternal := RECORD
		STRING10 CrimHistoryBuild;
		INTEGER3 ArrestCnt1Y;
		INTEGER3 ArrestCnt7Y;
		STRING10 ArrestNew1Y;
		STRING10 ArrestOld1Y;
		STRING10 ArrestNew7Y;
		STRING10 ArrestOld7Y;
		INTEGER3 MonSinceNewestArrestCnt1Y;
		INTEGER3 MonSinceOldestArrestCnt1Y;
		INTEGER3 MonSinceNewestArrestCnt7Y;
		INTEGER3 MonSinceOldestArrestCnt7Y;
		INTEGER3 CrimCnt1Y;
		INTEGER3 CrimCnt7Y;
		STRING10 CrimNew1Y;
		STRING10 CrimOld1Y;
		STRING10 CrimNew7Y;
		STRING10 CrimOld7Y;
		INTEGER3 MonSinceNewestCrimCnt1Y;
		INTEGER3 MonSinceOldestCrimCnt1Y;
		INTEGER3 MonSinceNewestCrimCnt7Y;
		INTEGER3 MonSinceOldestCrimCnt7Y;
		INTEGER3 FelonyCnt1Y;
		INTEGER3 FelonyCnt7Y;
		STRING10 FelonyNew1Y;
		STRING10 FelonyOld1Y;
		STRING10 FelonyNew7Y;
		STRING10 FelonyOld7Y;
		INTEGER3 MonSinceNewestFelonyCnt1Y;
		INTEGER3 MonSinceOldestFelonyCnt1Y;
		INTEGER3 MonSinceNewestFelonyCnt7Y;
		INTEGER3 MonSinceOldestFelonyCnt7Y;
		INTEGER3 NonfelonyCnt1Y;
		INTEGER3 NonfelonyCnt7Y;
		STRING10 NonfelonyNew1Y;
		STRING10 NonfelonyOld1Y;
		STRING10 NonfelonyNew7Y;
		STRING10 NonfelonyOld7Y;
		INTEGER3 MonSinceNewestNonfelonyCnt1Y;
		INTEGER3 MonSinceOldestNonfelonyCnt1Y;
		INTEGER3 MonSinceNewestNonfelonyCnt7Y;
		INTEGER3 MonSinceOldestNonfelonyCnt7Y;
		STRING6 CrimSeverityIndex7Y;
		STRING6 CrimBehaviorIndex7Y;
		STRING10 BkHistoryBuild ;
		INTEGER3 BkCnt1Y ;
		INTEGER3 BkCnt7Y ;
		INTEGER3 BkCnt10Y ;
		STRING DtOfBksList1Y ;
		STRING DtOfBksList7Y ;
		STRING DtOfBksList10Y ;
		STRING10 BkNew1Y ;
		STRING10 BkNew7Y ;
		STRING10 BkNew10Y ;
		STRING10 BkOld1Y ;
		STRING10 BkOld7Y ;
		STRING10 BkOld10Y ;
		INTEGER3 MonSinceNewestBkCnt1Y ;
		INTEGER3 MonSinceNewestBkCnt7Y ;
		INTEGER3 MonSinceNewestBkCnt10Y ;
		INTEGER3 MonSinceOldestBkCnt1Y ;
		INTEGER3 MonSinceOldestBkCnt7Y ;
		INTEGER3 MonSinceOldestBkCnt10Y ;
		STRING ChForBksList1Y ;
		STRING ChForBksList7Y ;
		STRING ChForBksList10Y ;
		STRING6 BkWithNewestDateCh1Y ;
		STRING6 BkWithNewestDateCh7Y ;
		STRING6 BkWithNewestDateCh10Y ;
		INTEGER3 BkUnderCh7Cnt1Y ;
		INTEGER3 BkUnderCh7Cnt7Y ;
		INTEGER3 BkUnderCh7Cnt10Y ;
		INTEGER3 BkUnderCh13Cnt1Y ;
		INTEGER3 BkUnderCh13Cnt7Y ;
		INTEGER3 BkUnderCh13Cnt10Y ;
		STRING10 NewestBkUpdateDt1Y ;
		STRING10 NewestBkUpdateDt7Y ;
		STRING10 NewestBkUpdateDt10Y ;
		INTEGER3 MonSinceNewestBkUpdateCnt1Y ;
		INTEGER3 MonSinceNewestBkUpdateCnt7Y ;
		INTEGER3 MonSinceNewestBkUpdateCnt10Y ;
		STRING DispOfBksList1Y ;
		STRING DispOfBksList7Y ;
		STRING DispOfBksList10Y ;
		STRING10 BkWithNewestDateDisp1Y ;
		STRING10 BkWithNewestDateDisp7Y ;
		STRING10 BkWithNewestDateDisp10Y ;
		STRING10 DispOfNewestBkDt1Y ;
		STRING10 DispOfNewestBkDt7Y ;
		STRING10 DispOfNewestBkDt10Y ;
		INTEGER3 MonSinceDispOfNewestBkCnt1Y ;
		INTEGER3 MonSinceDispOfNewestBkCnt7Y ;
		INTEGER3 MonSinceDispOfNewestBkCnt10Y ;
		INTEGER3 BkDisposedCnt1Y ;
		INTEGER3 BkDisposedCnt7Y ;
		INTEGER3 BkDisposedCnt10Y ;
		INTEGER3 BkDismissedCnt1Y ;
		INTEGER3 BkDismissedCnt7Y ;
		INTEGER3 BkDismissedCnt10Y ;
		INTEGER3 BkDischargedCnt1Y ;
		INTEGER3 BkDischargedCnt7Y ;
		INTEGER3 BkDischargedCnt10Y ;
		STRING TypeOfBksList1Y ;
		STRING TypeOfBksList7Y ;
		STRING TypeOfBksList10Y ;
		STRING6 BkHavingBusTypeFlag1Y ;
		STRING6 BkHavingBusTypeFlag7Y ;
		STRING6 BkHavingBusTypeFlag10Y ;
		STRING6 BkSeverityIndex10Y ;
	END;
	
	EXPORT LayoutPerson := RECORD
		INTEGER InputUIDAppend;
		LayoutPersonInternal;
	END;
	
	SHARED LayoutBusinessSeleIDInternal := RECORD
		STRING6 LexIDBusLegalEntitySeen;
		STRING6 LexIDBusLegalEntityRestricted;
		STRING10 BusHeaderHistoryBuild;
		STRING SrcVerBusLegalEntityList;
		STRING OldestDtSrcVerBusLegalEntityList;
		STRING NewestDtSrcVerBusLegalEntityList;	
//Tradeline		
		STRING10	B2bHistoryBuild;
		INTEGER3	B2bTLCntEv;
		INTEGER3	B2bTLCnt2Y;
		INTEGER3	B2bTLInCarrCnt2Y;
		INTEGER3	B2bTLInFltCnt2Y;
		INTEGER3	B2bTLInMatCnt2Y;
		INTEGER3	B2bTLInOpsCnt2Y;
		INTEGER3	B2bTLInOthCnt2Y;
		DECIMAL7_2	B2bTLInCarrPct2Y;
		DECIMAL7_2	B2bTLInFltPct2Y;
		DECIMAL7_2	B2bTLInMatPct2Y;
		DECIMAL7_2	B2bTLInOpsPct2Y;
		DECIMAL7_2	B2bTLInOthPct2Y;
		STRING10	B2bOldestTLDtEv;
		INTEGER3	B2bOldestTLMsinceEv;
		STRING10	B2bOldestTLDt2Y;
		STRING10	B2bNewestTLDt2Y;
		INTEGER3	B2bOldestTLMsince2Y;
		INTEGER3	B2bNewestTLMsince2Y;
		INTEGER3	B2bActvTLCnt;
		INTEGER3	B2bActvTLInCarrCnt;
		INTEGER3	B2bActvTLInFltCnt;
		INTEGER3	B2bActvTLInMatCnt;
		INTEGER3	B2bActvTLInOpsCnt;
		INTEGER3	B2bActvTLInOthCnt;
		DECIMAL7_2	B2bActvTLInCarrPct;
		DECIMAL7_2	B2bActvTLInFltPct;
		DECIMAL7_2	B2bActvTLInMatPct;
		DECIMAL7_2	B2bActvTLInOpsPct;
		DECIMAL7_2	B2bActvTLInOthPct;	
		INTEGER3	B2bActvTLCntArch1Y;
		INTEGER3	B2bActvTLInCarrCntArch1Y;
		INTEGER3	B2bActvTLInFltCntArch1Y;
		INTEGER3	B2bActvTLInMatCntArch1Y;
		INTEGER3	B2bActvTLInOpsCntArch1Y;
		INTEGER3	B2bActvTLInOthCntArch1Y;
		DECIMAL9_4	B2bActvTLCntGrow1Y;
		DECIMAL9_4	B2bActvTLCntInCarrGrow1Y;
		DECIMAL9_4	B2bActvTLCntInFltGrow1Y;
		DECIMAL9_4	B2bActvTLCntInMatGrow1Y;
		DECIMAL9_4	B2bActvTLCntInOpsGrow1Y;
		DECIMAL9_4	B2bActvTLCntInOthGrow1Y;
		INTEGER4	B2bActvTLBalTot;
		INTEGER4	B2bActvTLBalInCarrTot;
		INTEGER4	B2bActvTLBalInFltTot;
		INTEGER4	B2bActvTLBalInMatTot;
		INTEGER4	B2bActvTLBalInOpsTot;
		INTEGER4	B2bActvTLBalInOthTot;
		DECIMAL7_2	B2bActvTLBalInCarrPct;
		DECIMAL7_2	B2bActvTLBalInFltPct;
		DECIMAL7_2	B2bActvTLBalInMatPct;
		DECIMAL7_2	B2bActvTLBalInOpsPct;
		DECIMAL7_2	B2bActvTLBalInOthPct;	
		STRING6	B2bActvTLBalTotBin;
		STRING6	B2bActvTLBalInCarrTotBin;
		STRING6	B2bActvTLBalInFltTotBin;
		STRING6	B2bActvTLBalInMatTotBin;
		STRING6	B2bActvTLBalInOpsTotBin;
		STRING6	B2bActvTLBalInOthTotBin;
		INTEGER4	B2bActvTLBalAvg;
		INTEGER4	B2bActvTLBalInCarrAvg;
		INTEGER4	B2bActvTLBalInFltAvg;
		INTEGER4	B2bActvTLBalInMatAvg;
		INTEGER4	B2bActvTLBalInOpsAvg;
		INTEGER4	B2bActvTLBalInOthAvg;
		INTEGER4	B2bActvTLBalArch1Y;
		INTEGER4	B2bActvTLBalInCarrArch1Y;
		INTEGER4	B2bActvTLBalInFltArch1Y;
		INTEGER4	B2bActvTLBalInMatArch1Y;
		INTEGER4	B2bActvTLBalInOpsArch1Y;
		INTEGER4	B2bActvTLBalInOthArch1Y;
		DECIMAL9_4	B2bActvTLBalGrow1Y;
		DECIMAL9_4	B2bActvTLBalInCarrGrow1Y;
		DECIMAL9_4	B2bActvTLBalInFltGrow1Y;
		DECIMAL9_4	B2bActvTLBalInMatGrow1Y;
		DECIMAL9_4	B2bActvTLBalInOpsGrow1Y;
		DECIMAL9_4	B2bActvTLBalInOthGrow1Y;
		STRING6	B2bActvTLBalGrowIndex1Y;
		STRING6	B2bActvTLBalInCarrGrowIndex1Y;
		STRING6	B2bActvTLBalInFltGrowIndex1Y;
		STRING6	B2bActvTLBalInMatGrowIndex1Y;
		STRING6	B2bActvTLBalInOpsGrowIndex1Y;
		STRING6	B2bActvTLBalInOthGrowIndex1Y;
		INTEGER4	B2bTLBalMax2Y;
		INTEGER4	B2bTLBalInCarrMax2Y;
		INTEGER4	B2bTLBalInFltMax2Y;
		INTEGER4	B2bTLBalInMatMax2Y;
		INTEGER4	B2bTLBalInOpsMax2Y;
		INTEGER4	B2bTLBalInOthMax2Y;
		STRING10	B2bMaxTLBalDt2Y;
		STRING10	B2bMaxTLBalInCarrDt2Y;
		STRING10	B2bMaxTLBalInFltDt2Y;
		STRING10	B2bMaxTLBalInMatDt2Y;
		STRING10	B2bMaxTLBalInOpsDt2Y;
		STRING10	B2bMaxTLBalInOthDt2Y;
		INTEGER3	B2bMaxTLBalMsince2Y;
		INTEGER3	B2bMaxTLBalInCarrMsince2Y;
		INTEGER3	B2bMaxTLBalInFltMsince2Y;
		INTEGER3	B2bMaxTLBalInMatMsince2Y;
		INTEGER3	B2bMaxTLBalInOpsMsince2Y;
		INTEGER3	B2bMaxTLBalInOthMsince2Y;
		STRING6	B2bTLWMaxBalSeg2Y;
		STRING6	B2bActvTLWorstPerfIndex;
		STRING6	B2bActvTLWorstPerfInCarrIndex;
		STRING6	B2bActvTLWorstPerfInFltIndex;
		STRING6	B2bActvTLWorstPerfInMatIndex;
		STRING6	B2bActvTLWorstPerfInOpsIndex;
		STRING6	B2bActvTLWorstPerfInOthIndex;
		INTEGER3	B2bActvTLW1pDpdCnt;
		INTEGER3	B2bActvTLW31pDpdCnt;
		INTEGER3	B2bActvTLW61pDpdCnt;
		INTEGER3	B2bActvTLW91pDpdCnt;
		DECIMAL7_2	B2bActvTLW1pDpdPct;
		DECIMAL7_2	B2bActvTLW31pDpdPct;
		DECIMAL7_2	B2bActvTLW61pDpdPct;
		DECIMAL7_2	B2bActvTLW91pDpdPct;
		INTEGER4	B2bBalOnActvTL1pDpdTot;
		INTEGER4	B2bBalOnActvTL31pDpdTot;
		INTEGER4	B2bBalOnActvTL61pDpdTot;
		INTEGER4	B2bBalOnActvTL91pDpdTot;
		DECIMAL7_2	B2bBalOnActvTL1pDpdPct;
		DECIMAL7_2	B2bBalOnActvTL31pDpdPct;
		DECIMAL7_2	B2bBalOnActvTL61pDpdPct;
		DECIMAL7_2	B2bBalOnActvTL91pDpdPct;
		INTEGER4	B2bBalOnActvTL1pDpdTotArch1Y;
		INTEGER4	B2bBalOnActvTL31pDpdTotArch1Y;
		INTEGER4	B2bBalOnActvTL61pDpdTotArch1Y;
		INTEGER4	B2bBalOnActvTL91pDpdTotArch1Y;
		DECIMAL9_4	B2bBalOnActvTL1pDpdGrow1Y;
		DECIMAL9_4	B2bBalOnActvTL31pDpdGrow1Y;
		DECIMAL9_4	B2bBalOnActvTL61pDpdGrow1Y;
		DECIMAL9_4	B2bBalOnActvTL91pDpdGrow1Y;
		STRING6	B2bTLWorstPerfIndex2Y;
		STRING6	B2bTLWorstPerfInCarrIndex2Y;
		STRING6	B2bTLWorstPerfInFltIndex2Y;
		STRING6	B2bTLWorstPerfInMatIndex2Y;
		STRING6	B2bTLWorstPerfInOpsIndex2Y;
		STRING6	B2bTLWorstPerfInOthIndex2Y;
		STRING10	B2bTLWorstPerfDt2Y;
		STRING10	B2bTLWorstPerfInCarrDt2Y;
		STRING10	B2bTLWorstPerfInFltDt2Y;
		STRING10	B2bTLWorstPerfInMatDt2Y;
		STRING10	B2bTLWorstPerfInOpsDt2Y;
		STRING10	B2bTLWorstPerfInOthDt2Y;
		INTEGER3	B2bTLWorstPerfMsince2Y;
		INTEGER3	B2bTLWorstPerfInCarrMsince2Y;
		INTEGER3	B2bTLWorstPerfInFltMsince2Y;
		INTEGER3	B2bTLWorstPerfInMatMsince2Y;
		INTEGER3	B2bTLWorstPerfInOpsMsince2Y;
		INTEGER3	B2bTLWorstPerfInOthMsince2Y;
		INTEGER3	B2bTLCnt24Mfull;
		INTEGER3	B2bTLInCarrCnt24Mfull;
		INTEGER3	B2bTLInFltCnt24Mfull;
		INTEGER3	B2bTLInMatCnt24Mfull;
		INTEGER3	B2bTLInOpsCnt24Mfull;
		INTEGER3	B2bTLInOthCnt24Mfull;
		STRING30	B2bIndOfMonWTLStr24Mfull;
		STRING30	B2bIndOfMonWTLInCarrStr24Mfull;
		STRING30	B2bIndOfMonWTLInFltStr24Mfull;
		STRING30	B2bIndOfMonWTLInMatStr24Mfull;
		STRING30	B2bIndOfMonWTLInOpsStr24Mfull;
		STRING30	B2bIndOfMonWTLInOthStr24Mfull;
		INTEGER3	B2bMonWTLCnt24Mfull;
		INTEGER3	B2bMonWTLInCarrCnt24Mfull;
		INTEGER3	B2bMonWTLInFltCnt24Mfull;
		INTEGER3	B2bMonWTLInMatCnt24Mfull;
		INTEGER3	B2bMonWTLInOpsCnt24Mfull;
		INTEGER3	B2bMonWTLInOthCnt24Mfull;
		DECIMAL7_2	B2bTLBalVol24Mfull;
		DECIMAL7_2	B2bTLBalInCarrVol24Mfull;
		DECIMAL7_2	B2bTLBalInFltVol24Mfull;
		DECIMAL7_2	B2bTLBalInMatVol24Mfull;
		DECIMAL7_2	B2bTLBalInOpsVol24Mfull;
		DECIMAL7_2	B2bTLBalInOthVol24Mfull;	
	END;	
		
	EXPORT LayoutBusinessSeleID := RECORD
		INTEGER BusInputUIDAppend;
		LayoutBusinessSeleIDInternal;
	END;
	
	EXPORT LayoutMaster := RECORD
		INTEGER InputUIDAppend;
		LayoutInputPIIInternal;
		LayoutPersonInternal;
		STRING65 BusInputAccountEcho;
		INTEGER BusInputUIDAppend;
		LayoutInputBIIInternal - BusInputAccountEcho;
		LayoutBusinessSeleIDInternal;
	END;	

END;
