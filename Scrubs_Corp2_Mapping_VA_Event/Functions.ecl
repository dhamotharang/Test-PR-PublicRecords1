IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//ValidEventFilingTypeCD: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidEventFilingTypeCD(STRING code) := FUNCTION
		
					 uc_code := corp2.t2u(code);

					 isValidCode						:= map(uc_code IN ['']																													=> TRUE,
																				 uc_code IN ['1','2','3','4']																							=> TRUE,
																				 uc_code IN ['A','C','D','E','F','J','L','M','N','O','P','R','S','T','W'] => TRUE,
																				 FALSE
																				);
																		 
					RETURN if(isValidCode,1,0);
		END;
		
END;