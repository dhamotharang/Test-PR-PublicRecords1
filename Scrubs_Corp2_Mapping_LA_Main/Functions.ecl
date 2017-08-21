IMPORT corp2, corp2_raw_wy;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','03','04','05','07','P'] 								=> true,
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
		EXPORT invalid_ln_name_type_desc(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
					 
			isValidDesc := if(uc_ro = 'C',
												map(uc_s in ['LEGAL','PRIOR','RESERVED']						=> true,
														uc_s in ['SERVICEMARK','TRADEMARK','TRADENAME'] => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;


		//****************************************************************************
		//invalid_org_structure_cd: returns true or false based upon the incoming code
		//****************************************************************************
		EXPORT invalid_org_structure_cd(STRING s) := FUNCTION

			uc_s 			:= corp2.t2u(s);

			isValidCD := map(uc_s in ['A','B','C','D','E','F','G','H','I','J','K','L','M'] 	=> true,
											 uc_s in ['N','P','Q','R','S','T','U','V','W','X','Y','Z'] 			=> true,
											 uc_s in ['AA','BB','EE'] 																			=> true,
											 uc_s in ['']																										=> true,
											 false
										 );
										 
			 RETURN if(isValidCD,1,0);
		
		END;
		
END;