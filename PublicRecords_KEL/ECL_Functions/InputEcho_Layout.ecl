//input layout for the inputPII attributes (which InputBII uses also for Reps)
IMPORT PublicRecords_KEL;

EXPORT InputEcho_Layout := RECORD
	INTEGER BusInputUIDAppend;
	INTEGER InputUIDAppend;
	STRING65 InputAccountEcho;
	INTEGER7 InputLexIDEcho;
	STRING78 InputFirstNameEcho;
	STRING120 InputStreetEcho;
	STRING50 InputCityEcho;
	STRING25 InputStateEcho; 
	STRING10 InputZipEcho;
	STRING16 InputHomePhoneEcho;
	STRING16 InputWorkPhoneEcho;
	STRING54 InputEmailEcho;
	STRING20 InputArchiveDateEcho; 
	STRING1 InputAccountEchoPop;
	STRING1 InputLexIDEchoPop;
	STRING1 InputFirstNameEchoPop;
	STRING1 InputStreetEchoPop;
	STRING1 InputCityEchoPop;
	STRING1 InputStateEchoPop;
	STRING1 InputZipEchoPop;
	STRING1 InputHomePhoneEchoPop;
	STRING1 InputWorkPhoneEchoPop;
	STRING1 InputEmailEchoPop;
	STRING1 InputArchiveDateEchoPop;
	INTEGER RepNumber;
END;