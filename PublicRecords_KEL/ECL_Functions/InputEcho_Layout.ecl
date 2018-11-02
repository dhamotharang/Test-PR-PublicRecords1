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
	INTEGER RepNumber;
END;