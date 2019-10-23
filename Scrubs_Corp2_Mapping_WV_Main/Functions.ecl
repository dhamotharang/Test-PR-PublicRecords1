IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			//Per CI  : 'FDA','F','FD','TMO' -No code descriptions - leave blank 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','03','04','07','09','I','P','SU','F','FN','GN','SN',''] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;
		
		//Below table needs to be updated when we see new Org_Struc codes in Raw updates!	
		EXPORT valid_org_structure_codes :=['BC','BT','C','CA','CD','CSO','DC','EC','ECS','ELC','ELP','EMB',
																				'FN','GP','I','LLC','LLP','LP','NRG','NRS','PC','PFP','PLC','SP',
																				'TM','TMO','UNA','VA','Z',''];
																				
		//Below table needs to be updated when we see new Termination_codes in Raw updates!																			
    EXPORT valid_Termination_codes :=['B','C','L','M','N','P','R','T','V','W','X','Z',''];																				
																		
END;