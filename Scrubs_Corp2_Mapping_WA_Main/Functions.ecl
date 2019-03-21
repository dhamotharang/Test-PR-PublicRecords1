IMPORT corp2, corp2_raw_wa; 
	 
EXPORT Functions := MODULE

		//******************************************************************************
		//invalid_name_type_code: 	returns true or false based upon the incoming code.
		//******************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordOrigin) := FUNCTION
      
			 isValidCD := map(recordOrigin = 'T'   => true, //Contact recs have blank name type codes
											  s in ['01','07','I'] => true,
											  false);
									
			 RETURN if(isValidCD,1,0);

		END;
		//*******************************************************************************
		//invalid_name_type_desc: 	returns true or false based upon the incoming	code.
		//*******************************************************************************
		EXPORT invalid_name_type_desc(STRING s, STRING recordorigin) := FUNCTION

				isValidDesc := map(recordOrigin = 'T'                => true, //Contact recs have blank name type descriptions
											  s in ['LEGAL','RESERVATION','OTHER'] => true,
											  false);

			 RETURN if(isValidDesc,1,0);

		END;
		
		//*****************************************************************************
		//invalid_org_structure_cd: returns true or false based upon the incoming code.
		//*****************************************************************************	
		EXPORT invalid_org_structure_cd(STRING s) := FUNCTION

				isValidCD		:= map(s in [ '3LP','AUT','BNK','CAS','COP','CRU','FBS','FMA','FRA',
																	'GRG','INS','LLC','LLP','LTD','MAS','MIL','MIN','MMC',
																	'PBC','PLC','PLP','PRO','PUB','REG','REG','RFN','SAL','SOL',
																	'SPC','' ]	=> true,false);

			 RETURN if(isValidCD,1,0);
		
		END;
		
			         
		
END;