IMPORT  _Validate,  tools,  ut, MDR, std;

export  Standardize_Input :=  MODULE;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- map fields
	// -- do any conversions/validations
	//////////////////////////////////////////////////////////////////////////////////////
EXPORT fPreProcess(DATASET(Layouts.Sprayed_Input) pRawInput, string pversion) := FUNCTION
	  
		NAICSCodes.Layouts.NAICSLookup NormTrf(NAICSCodes.Layouts.Sprayed_Input L) := transform			
				SELF			              := L;
				SELF 									  := [];
			end;

		RETURN PROJECT(pRawInput, NormTrf(LEFT));

	END;

	EXPORT fAll( DATASET(NAICSCodes.Layouts.Sprayed_Input) pRawFileInput
							,STRING  pversion
	           ) := FUNCTION
						 
		dPreprocess	:= fPreProcess(pRawFileInput, pversion) 
		;

		RETURN dPreprocess;
	
	END;

END;
