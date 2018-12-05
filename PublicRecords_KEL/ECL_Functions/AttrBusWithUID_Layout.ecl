IMPORT PublicRecords_KEL;

EXPORT AttrBusWithUID_Layout := RECORD
		INTEGER BusInputUIDAppend;
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
		STRING54 BusInputEmailEcho;
		STRING6 BusInputSICCodeEcho;
		STRING6 BusInputNAICSCodeEcho;
		STRING20 BusInputArchiveDateEcho;
		INTEGER InputUIDAppend;
END;