IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','02','07','06','09','P'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;
		
		//Below table needs to be updated when we see new Org_Struc codes in Raw updates!
		EXPORT set_valid_org_cd := ['1','2','3','4','5','6','7','8','9','10','11','12','13','14',
																'15','16','17','18','19','20','21','22',''];
																
		//Below table needs to be updated when we see new status codes in Raw updates!
		EXPORT set_valid_status_cd:= ['1','2','3','4','5','6','7','8','9','10','11','']; 
													 
END;