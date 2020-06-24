//takes in the input and divides out each section of the auth reps and sets the
//Rep number and information to be used in the KEL attributes.
//For the BRM query, it takes the input and sets the p_inpacct to be used in KEL query.
//It is only needed because b_inpacct is determined by p_inpacct supplied.
IMPORT PublicRecords_KEL,BRM_Marketing_attributes;

EXPORT Fn_BRM_Prep_InputRepPII( DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) input) := FUNCTION

	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputEcho1( RECORDOF(input) le ) := 
      TRANSFORM
						SELF.RepNumber := 1;
				SELF.P_InpAcct := le.AccountNumber;
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF := [];
	END;
	InputEcho1 := PROJECT(input, GetInputEcho1(LEFT));
	srtedEcho := SORT(InputEcho1, G_ProcBusUID);
	EchoWUqId := PROJECT(srtedEcho, TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, SELF.G_ProcUID := COUNTER, SELF := LEFT));

	RETURN EchoWUqId;
END;