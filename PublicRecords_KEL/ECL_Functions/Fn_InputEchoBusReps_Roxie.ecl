//This takes in the input and divides out each section of the auth reps and sets the
//Rep number and information to be used in the KEL attributes.
IMPORT PublicRecords_KEL, STD;

EXPORT Fn_InputEchoBusReps_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout) ds_input) := FUNCTION

	PublicRecords_KEL.ECL_Functions.InputEcho_Layout GetInputEcho1( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 1;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep1LexID;
				SELF.InputFirstNameEcho:= le.Rep1firstname;
				SELF.InputStreetEcho := le.Rep1Addr;
				SELF.InputCityEcho := le.Rep1City;
				SELF.InputStateEcho := le.Rep1State; 
				SELF.InputZipEcho := le.Rep1Zip;
				SELF.InputHomePhoneEcho := le.Rep1HomePhone;
				SELF.InputEmailEcho := le.Rep1EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := []; //Pop fields
				END;
	InputEcho1 := PROJECT(ds_input, GetInputEcho1(LEFT));

	PublicRecords_KEL.ECL_Functions.InputEcho_Layout GetInputEcho2( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 2;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep2LexID;
				SELF.InputFirstNameEcho:= le.Rep2firstname;
				SELF.InputStreetEcho := le.Rep2Addr;
				SELF.InputCityEcho := le.Rep2City;
				SELF.InputStateEcho := le.Rep2State; 
				SELF.InputZipEcho := le.Rep2Zip;
				SELF.InputHomePhoneEcho := le.Rep2HomePhone;
				SELF.InputEmailEcho := le.Rep2EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := []; //Pop fields
				END;
	InputEcho2 := PROJECT(ds_input, GetInputEcho2(LEFT));

// PublicRecords_KEL.ECL_Functions.AttrWithDate_Layout GetInputEcho3( RECORDOF(ds_input) le ) := 
PublicRecords_KEL.ECL_Functions.InputEcho_Layout GetInputEcho3( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 3;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep3LexID;
				SELF.InputFirstNameEcho:= le.Rep3firstname;
				SELF.InputStreetEcho := le.Rep3Addr;
				SELF.InputCityEcho := le.Rep3City;
				SELF.InputStateEcho := le.Rep3State; 
				SELF.InputZipEcho := le.Rep3Zip;
				SELF.InputHomePhoneEcho := le.Rep3HomePhone;
				SELF.InputEmailEcho := le.Rep3EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := []; //Pop fields
				END;
	InputEcho3 := PROJECT(ds_input, GetInputEcho3(LEFT));

	PublicRecords_KEL.ECL_Functions.InputEcho_Layout GetInputEcho4( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 4;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep4LexID;
				SELF.InputFirstNameEcho:= le.Rep4firstname;
				SELF.InputStreetEcho := le.Rep4Addr;
				SELF.InputCityEcho := le.Rep4City;
				SELF.InputStateEcho := le.Rep4State; 
				SELF.InputZipEcho := le.Rep4Zip;
				SELF.InputHomePhoneEcho := le.Rep4HomePhone;
				SELF.InputEmailEcho := le.Rep4EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := []; //Pop fields
				END;
	InputEcho4 := PROJECT(ds_input, GetInputEcho4(LEFT));
	
	PublicRecords_KEL.ECL_Functions.InputEcho_Layout GetInputEcho5( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 5;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep5LexID;
				SELF.InputFirstNameEcho:= le.Rep5firstname;
				SELF.InputStreetEcho := le.Rep5Addr;
				SELF.InputCityEcho := le.Rep5City;
				SELF.InputStateEcho := le.Rep5State; 
				SELF.InputZipEcho := le.Rep5Zip;
				SELF.InputHomePhoneEcho := le.Rep5HomePhone;
				SELF.InputEmailEcho := le.Rep5EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := []; //Pop fields
				END;
	InputEcho5 := PROJECT(ds_input, GetInputEcho5(LEFT));

	srtedEcho := SORT(InputEcho1 + InputEcho2 + InputEcho3 + InputEcho4 + InputEcho5, BusInputUIDAppend, RepNumber);
	EchoWUqId := PROJECT(srtedEcho, TRANSFORM(PublicRecords_KEL.ECL_Functions.InputEcho_Layout, SELF.InputUIDAppend := COUNTER, SELF := LEFT));

	RETURN EchoWUqId;
END;