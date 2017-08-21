IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
												map(uc_s in ['01','06','07','09'] => true,
														false
												),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;

		//****************************************************************************
		//invalid_ln_name_type_desc: 	returns true or false based upon the incoming
		//														code.
		//****************************************************************************
		EXPORT invalid_name_type_desc(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
					 
			isValidDesc := if(uc_ro = 'C',
												map(uc_s in ['LEGAL','ASSUMED','RESERVED','REGISTRATION'] => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;
		
	//Below table needs to be updated when we see new Agent_Status codes in Raw updates!	
	EXPORT Agent_Status_Codes :=['A','C','D','P','R',''];
	
	//Below table needs to be updated when we see new Org_Struc codes in Raw updates!	
	EXPORT Org_Struc_Codes := ['B','C','E','F','G','H','I','J','K','L','M','N','O','P',
														 'Q','R','S','T','U','V','W','X',''];
														 
	//Below table needs to be updated when we see new Status Codes in Raw updates!	
	EXPORT Corp_Status_Codes := ['A','B','C','D','E','F','G','H','J','K','L','P','O','R',
															 'S','T','W','X','Y','Z',''];
													 
END;