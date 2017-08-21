IMPORT corp2, corp2_raw_ok;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_name_type_code: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordOrigin) := FUNCTION
      
			 isValidCD := map(recordOrigin = 'T'             => true, //Contact recs have blank name type codes
											  s in ['01','F','04','07','10'] => true,
											  false);
									
			 RETURN if(isValidCD,1,0);

		END;
		
END;