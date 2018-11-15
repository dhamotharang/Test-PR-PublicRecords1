//This takes in the input and divides out each section of the auth reps and sets the
//Rep number and information to be used in the KEL attributes.
IMPORT PublicRecords_KEL, STD;

EXPORT Fn_InputEchoBusReps_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) ds_input) := FUNCTION


	PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputEcho1( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 1;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep1LexID;
				SELF.InputFirstNameEcho := le.Rep1firstname;
				SELF.InputMiddleNameEcho := le.Rep1MiddleName;
				SELF.InputLastNameEcho := le.Rep1lastname;
				SELF.InputStreetEcho := le.Rep1Addr;
				SELF.InputCityEcho := le.Rep1City;
				SELF.InputStateEcho := le.Rep1State; 
				SELF.InputZipEcho := le.Rep1Zip;
				SELF.InputHomePhoneEcho := le.Rep1HomePhone;
				SELF.InputSSNEcho := le.Rep1SSN;
				SELF.InputDateOfBirthEcho := le.Rep1DOB;
				SELF.InputDLNumberEcho := le.Rep1DLNumber;
				SELF.InputDLStateEcho := le.Rep1DLState;
				SELF.InputFormernameEcho := le.Rep1FormerLastName;
				SELF.InputEmailEcho := le.Rep1EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := [];
	END;
	InputEcho1 := PROJECT(ds_input, GetInputEcho1(LEFT));

	PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputEcho2( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 2;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep2LexID;
				SELF.InputFirstNameEcho := le.Rep2firstname;
				SELF.InputMiddleNameEcho := le.Rep2MiddleName;
				SELF.InputLastNameEcho := le.Rep2lastname;
				SELF.InputStreetEcho := le.Rep2Addr;
				SELF.InputCityEcho := le.Rep2City;
				SELF.InputStateEcho := le.Rep2State; 
				SELF.InputZipEcho := le.Rep2Zip;
				SELF.InputHomePhoneEcho := le.Rep2HomePhone;
				SELF.InputSSNEcho := le.Rep2SSN;
				SELF.InputDateOfBirthEcho := le.Rep2DOB;
				SELF.InputDLNumberEcho := le.Rep2DLNumber;
				SELF.InputDLStateEcho := le.Rep2DLState;
				SELF.InputFormernameEcho := le.Rep2FormerLastName;
				SELF.InputEmailEcho := le.Rep2EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := [];
	END;
	InputEcho2 := PROJECT(ds_input, GetInputEcho2(LEFT));

	PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputEcho3( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 3;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep3LexID;
				SELF.InputFirstNameEcho := le.Rep3firstname;
				SELF.InputMiddleNameEcho := le.Rep3MiddleName;
				SELF.InputLastNameEcho := le.Rep3lastname;
				SELF.InputStreetEcho := le.Rep3Addr;
				SELF.InputCityEcho := le.Rep3City;
				SELF.InputStateEcho := le.Rep3State; 
				SELF.InputZipEcho := le.Rep3Zip;
				SELF.InputHomePhoneEcho := le.Rep3HomePhone;
				SELF.InputSSNEcho := le.Rep3SSN;
				SELF.InputDateOfBirthEcho := le.Rep3DOB;
				SELF.InputDLNumberEcho := le.Rep3DLNumber;
				SELF.InputDLStateEcho := le.Rep3DLState;
				SELF.InputFormernameEcho := le.Rep3FormerLastName;
				SELF.InputEmailEcho := le.Rep3EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := [];
	END;
	InputEcho3 := PROJECT(ds_input, GetInputEcho3(LEFT));

	PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputEcho4( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 4;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep4LexID;
				SELF.InputFirstNameEcho := le.Rep4firstname;
				SELF.InputMiddleNameEcho := le.Rep4MiddleName;
				SELF.InputLastNameEcho := le.Rep4lastname;
				SELF.InputStreetEcho := le.Rep4Addr;
				SELF.InputCityEcho := le.Rep4City;
				SELF.InputStateEcho := le.Rep4State; 
				SELF.InputZipEcho := le.Rep4Zip;
				SELF.InputHomePhoneEcho := le.Rep4HomePhone;
				SELF.InputSSNEcho := le.Rep4SSN;
				SELF.InputDateOfBirthEcho := le.Rep4DOB;
				SELF.InputDLNumberEcho := le.Rep4DLNumber;
				SELF.InputDLStateEcho := le.Rep4DLState;
				SELF.InputFormernameEcho := le.Rep4FormerLastName;
				SELF.InputEmailEcho := le.Rep4EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := [];
	END;
	InputEcho4 := PROJECT(ds_input, GetInputEcho4(LEFT));
	
	PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputEcho5( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 5;
				SELF.InputAccountEcho := le.AccountNumber;
				SELF.BusInputUIDAppend := le.BusInputUIDAppend;
				SELF.InputLexIDEcho := (INTEGER) le.Rep5LexID;
				SELF.InputFirstNameEcho := le.Rep5firstname;
				SELF.InputMiddleNameEcho := le.Rep5MiddleName;
				SELF.InputLastNameEcho := le.Rep5lastname;
				SELF.InputStreetEcho := le.Rep5Addr;
				SELF.InputCityEcho := le.Rep5City;
				SELF.InputStateEcho := le.Rep5State; 
				SELF.InputZipEcho := le.Rep5Zip;
				SELF.InputHomePhoneEcho := le.Rep5HomePhone;
				SELF.InputSSNEcho := le.Rep5SSN;
				SELF.InputDateOfBirthEcho := le.Rep5DOB;
				SELF.InputDLNumberEcho := le.Rep5DLNumber;
				SELF.InputDLStateEcho := le.Rep5DLState;
				SELF.InputFormernameEcho := le.Rep5FormerLastName;
				SELF.InputEmailEcho := le.Rep5EmailAddress; 
				SELF.InputArchiveDateEcho := le.ArchiveDate;
				SELF.InputWorkPhoneEcho := '';
				SELF.InputUIDAppend := 0; //defined further below
				SELF := [];
	END;
	InputEcho5 := PROJECT(ds_input, GetInputEcho5(LEFT));

	srtedEcho := SORT(InputEcho1 + InputEcho2 + InputEcho3 + InputEcho4 + InputEcho5, BusInputUIDAppend, RepNumber);
	EchoWUqId := PROJECT(srtedEcho, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout, SELF.InputUIDAppend := COUNTER, SELF := LEFT));

	RETURN EchoWUqId;
END;