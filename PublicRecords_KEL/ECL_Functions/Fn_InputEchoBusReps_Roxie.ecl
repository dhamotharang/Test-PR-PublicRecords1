//This takes in the input and divides out each section of the auth reps and sets the
//Rep number and information to be used in the KEL attributes.
IMPORT PublicRecords_KEL, STD;

EXPORT Fn_InputEchoBusReps_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) ds_input) := FUNCTION


	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho1( RECORDOF(ds_input) le ) := 
      TRANSFORM
			SELF.RepNumber := 1;
				SELF.P_InpAcct := le.AccountNumber;
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF.P_InpLexID := (INTEGER) le.Rep1LexID;
				SELF.P_InpNameFirst := le.Rep1firstname;
				SELF.P_InpNameMid := le.Rep1MiddleName;
				SELF.P_InpNameLast := le.Rep1lastname;
				SELF.P_InpAddrLine1 := le.Rep1StreetAddressLine1;
				SELF.P_InpAddrLine2 := le.Rep1StreetAddressLine2;
				SELF.P_InpAddrCity := le.Rep1City;
				SELF.P_InpAddrState := le.Rep1State; 
				SELF.P_InpAddrZip := le.Rep1Zip;
				SELF.P_InpPhoneHome := le.Rep1HomePhone;
				SELF.P_InpSSN := le.Rep1SSN;
				SELF.P_InpDOB := le.Rep1DOB;
				SELF.P_InpDL := le.Rep1DLNumber;
				SELF.P_InpDLState := le.Rep1DLState;
				SELF.InputFormernameEcho := le.Rep1FormerLastName;
				SELF.P_InpEmail := le.Rep1EmailAddress; 
				SELF.P_InpArchDt := le.ArchiveDate;
				SELF.P_InpPhoneWork := '';
				SELF.G_ProcUID := 0; //defined further below
				SELF := [];
	END;
	InputEcho1 := PROJECT(ds_input, GetInputEcho1(LEFT));

	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho2( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 2;
				SELF.P_InpAcct := le.AccountNumber;
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF.P_InpLexID := (INTEGER) le.Rep2LexID;
				SELF.P_InpNameFirst := le.Rep2firstname;
				SELF.P_InpNameMid := le.Rep2MiddleName;
				SELF.P_InpNameLast := le.Rep2lastname;
				SELF.P_InpAddrLine1 := le.Rep2StreetAddressLine1;
				SELF.P_InpAddrLine2 := le.Rep2StreetAddressLine2;
				SELF.P_InpAddrCity := le.Rep2City;
				SELF.P_InpAddrState := le.Rep2State; 
				SELF.P_InpAddrZip := le.Rep2Zip;
				SELF.P_InpPhoneHome := le.Rep2HomePhone;
				SELF.P_InpSSN := le.Rep2SSN;
				SELF.P_InpDOB := le.Rep2DOB;
				SELF.P_InpDL := le.Rep2DLNumber;
				SELF.P_InpDLState := le.Rep2DLState;
				SELF.InputFormernameEcho := le.Rep2FormerLastName;
				SELF.P_InpEmail := le.Rep2EmailAddress; 
				SELF.P_InpArchDt := le.ArchiveDate;
				SELF.P_InpPhoneWork := '';
				SELF.G_ProcUID := 0; //defined further below
				SELF := [];
	END;
	InputEcho2 := PROJECT(ds_input, GetInputEcho2(LEFT));

	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho3( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 3;
				SELF.P_InpAcct := le.AccountNumber;
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF.P_InpLexID := (INTEGER) le.Rep3LexID;
				SELF.P_InpNameFirst := le.Rep3firstname;
				SELF.P_InpNameMid := le.Rep3MiddleName;
				SELF.P_InpNameLast := le.Rep3lastname;
				SELF.P_InpAddrLine1 := le.Rep3StreetAddressLine1;
				SELF.P_InpAddrLine2 := le.Rep3StreetAddressLine2;
				SELF.P_InpAddrCity := le.Rep3City;
				SELF.P_InpAddrState := le.Rep3State; 
				SELF.P_InpAddrZip := le.Rep3Zip;
				SELF.P_InpPhoneHome := le.Rep3HomePhone;
				SELF.P_InpSSN := le.Rep3SSN;
				SELF.P_InpDOB := le.Rep3DOB;
				SELF.P_InpDL := le.Rep3DLNumber;
				SELF.P_InpDLState := le.Rep3DLState;
				SELF.InputFormernameEcho := le.Rep3FormerLastName;
				SELF.P_InpEmail := le.Rep3EmailAddress; 
				SELF.P_InpArchDt := le.ArchiveDate;
				SELF.P_InpPhoneWork := '';
				SELF.G_ProcUID := 0; //defined further below
				SELF := [];
	END;
	InputEcho3 := PROJECT(ds_input, GetInputEcho3(LEFT));

	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho4( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 4;
				SELF.P_InpAcct := le.AccountNumber;
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF.P_InpLexID := (INTEGER) le.Rep4LexID;
				SELF.P_InpNameFirst := le.Rep4firstname;
				SELF.P_InpNameMid := le.Rep4MiddleName;
				SELF.P_InpNameLast := le.Rep4lastname;
				SELF.P_InpAddrLine1 := le.Rep4StreetAddressLine1;
				SELF.P_InpAddrLine2 := le.Rep4StreetAddressLine2;
				SELF.P_InpAddrCity := le.Rep4City;
				SELF.P_InpAddrState := le.Rep4State; 
				SELF.P_InpAddrZip := le.Rep4Zip;
				SELF.P_InpPhoneHome := le.Rep4HomePhone;
				SELF.P_InpSSN := le.Rep4SSN;
				SELF.P_InpDOB := le.Rep4DOB;
				SELF.P_InpDL := le.Rep4DLNumber;
				SELF.P_InpDLState := le.Rep4DLState;
				SELF.InputFormernameEcho := le.Rep4FormerLastName;
				SELF.P_InpEmail := le.Rep4EmailAddress; 
				SELF.P_InpArchDt := le.ArchiveDate;
				SELF.P_InpPhoneWork := '';
				SELF.G_ProcUID := 0; //defined further below
				SELF := [];
	END;
	InputEcho4 := PROJECT(ds_input, GetInputEcho4(LEFT));
	
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho5( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.RepNumber := 5;
				SELF.P_InpAcct := le.AccountNumber;
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF.P_InpLexID := (INTEGER) le.Rep5LexID;
				SELF.P_InpNameFirst := le.Rep5firstname;
				SELF.P_InpNameMid := le.Rep5MiddleName;
				SELF.P_InpNameLast := le.Rep5lastname;
				SELF.P_InpAddrLine1 := le.Rep5StreetAddressLine1;
				SELF.P_InpAddrLine2 := le.Rep5StreetAddressLine2;
				SELF.P_InpAddrCity := le.Rep5City;
				SELF.P_InpAddrState := le.Rep5State; 
				SELF.P_InpAddrZip := le.Rep5Zip;
				SELF.P_InpPhoneHome := le.Rep5HomePhone;
				SELF.P_InpSSN := le.Rep5SSN;
				SELF.P_InpDOB := le.Rep5DOB;
				SELF.P_InpDL := le.Rep5DLNumber;
				SELF.P_InpDLState := le.Rep5DLState;
				SELF.InputFormernameEcho := le.Rep5FormerLastName;
				SELF.P_InpEmail := le.Rep5EmailAddress; 
				SELF.P_InpArchDt := le.ArchiveDate;
				SELF.P_InpPhoneWork := '';
				SELF.G_ProcUID := 0; //defined further below
				SELF := [];
	END;
	InputEcho5 := PROJECT(ds_input, GetInputEcho5(LEFT));

	srtedEcho := SORT(InputEcho1 + InputEcho2 + InputEcho3 + InputEcho4 + InputEcho5, G_ProcBusUID, RepNumber);
	EchoWUqId := PROJECT(srtedEcho, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, SELF.G_ProcUID := COUNTER, SELF := LEFT));

	RETURN EchoWUqId;
END;