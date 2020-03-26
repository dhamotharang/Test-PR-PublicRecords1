IMPORT corp2, corp2_raw_az;
	
EXPORT Functions := MODULE

		//*************************************************************************************
		//invalid_name_type_desc: 	returns true or false based upon the incoming description.
		//*************************************************************************************
		EXPORT invalid_name_type_desc(STRING s, STRING recordOrigin) := FUNCTION
      
			 isValidDESC := map(recordOrigin = 'T'         => true, //Contact recs have blank name type codes
											  s in ['LEGAL',
												      'PRIOR',
															'SURVIVOR',
															'NON-SURVIVOR',
															'CONVERTED TO',
															'DIVIDED TO',
															'DOMESTICATED TO',
															'OTHER'] => true,
											  false);
									
			 RETURN if(isValidDESC,1,0);

		END;
		
END;