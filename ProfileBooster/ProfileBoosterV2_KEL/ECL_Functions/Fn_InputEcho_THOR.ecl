//This takes in the input and gets the input echo
IMPORT ProfileBooster,ProfileBooster.ProfileBoosterV2_KEL, STD;

EXPORT Fn_InputEcho_THOR( DATASET(ProfileBoosterV2_KEL.ECL_Functions.Input_Layout_Slim) ds_input) := FUNCTION

	ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho1( ProfileBoosterV2_KEL.ECL_Functions.Input_Layout_Slim le ) := 
      TRANSFORM
		SELF.G_ProcUID := le.G_ProcUID;
		SELF.P_InpAcct := le.Account;
		SELF.P_InpLexID := (INTEGER) le.LexID;
		SELF.P_InpNameFirst:= le.FirstName;
		SELF.P_InpNameMid:= le.MiddleName;
		SELF.P_InpNameLast:= le.LastName;			
		SELF.P_InpAddrLine1 := le.StreetAddressLine1;
		// SELF.P_InpAddrLine2 := le.StreetAddressLine2;
		SELF.P_InpAddrCity := le.City;
		SELF.P_InpAddrState := le.State; 
		SELF.P_InpAddrZip := le.Zip;
		SELF.P_InpPhoneHome := le.HomePhone;
		SELF.P_InpPhoneWork := le.WorkPhone;
		SELF.P_InpEmail := le.Email; 
		SELF.P_InpArchDt := le.historydate;
		SELF.P_InpSSN := le.SSN;
		SELF.P_InpDOB := le.DateOfBirth;
		SELF.P_InpDL := le.DLNumber;
		SELF.P_InpDLState := le.DLState;	
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