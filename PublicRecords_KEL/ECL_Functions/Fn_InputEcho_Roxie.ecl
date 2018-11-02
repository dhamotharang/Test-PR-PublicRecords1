//This takes in the input and gets the input echo
IMPORT PublicRecords_KEL, STD;

EXPORT Fn_InputEcho_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout_Slim) ds_input) := FUNCTION

	PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputEcho1( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim le ) := 
      TRANSFORM
		SELF.InputUIDAppend := le.InputUIDAppend;
		SELF.InputAccountEcho := le.Account;
		SELF.InputLexIDEcho := (INTEGER) le.LexID;
		SELF.InputFirstNameEcho:= le.FirstName;
		SELF.InputMiddleNameEcho:= le.MiddleName;
		SELF.InputLastNameEcho:= le.LastName;			
		SELF.InputStreetEcho := le.StreetAddress;
		SELF.InputCityEcho := le.City;
		SELF.InputStateEcho := le.State; 
		SELF.InputZipEcho := le.Zip;
		SELF.InputHomePhoneEcho := le.HomePhone;
		SELF.InputWorkPhoneEcho := le.WorkPhone;
		SELF.InputEmailEcho := le.Email; 
		SELF.InputArchiveDateEcho := le.historydate;
		SELF.InputSSNEcho := le.SSN;
		SELF.InputDateOfBirthEcho := le.DateOfBirth;
		SELF.InputDLNumberEcho := le.DLNumber;
		SELF.InputDLStateEcho := le.DLState;	
		//
		SELF.InputIncomeEcho := le.Income;
		// SELF.InputBalanceEcho := '';
		// SELF.InputChargeOffdEcho := '';
		// SELF.InputFormerNameEcho := '';
		// SELF.InputEmployerNameEcho := '';	
		SELF := [];
	END;
	InputEcho := PROJECT(ds_input, GetInputEcho1(LEFT));
	
	RETURN InputEcho;
END;