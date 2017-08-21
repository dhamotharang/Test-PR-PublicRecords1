IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//ValidCorpTypes: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidCorpTypes(STRING s) := FUNCTION
					 isValidType := case(corp2.t2u(s),
															 '01'					=> TRUE,
															 '03'					=> TRUE,
															 '04'					=> TRUE,
															 '05'					=> TRUE,
															 '07'					=> TRUE,
															 '10'					=> TRUE,
															 ''						=> TRUE,
															 FALSE
														  ); 
					 RETURN if(isValidType,1,0);			 
		END;
		
END;