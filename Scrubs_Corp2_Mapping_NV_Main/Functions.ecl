IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION
					 uc_s							:= corp2.t2u(s);
					 uc_ro 						:= corp2.t2u(recordorigin);

					 isValidCode			:= if(uc_ro = 'C',
																	map(uc_s in ['01','03','04','05','07','10'] => true,
																			false),
																	true); //For contact records, corp_ln_name_type_cd doesn't have to exist
					 RETURN if(isValidCode,1,0);
					 
		END;

		//****************************************************************************
		//invalid_ln_name_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_desc(STRING s, STRING recordorigin) := FUNCTION
					 uc_s 			 := corp2.t2u(s);
					 uc_ro 			 := corp2.t2u(recordorigin);                 

					 isValidDesc := if(uc_ro = 'C',
														 map(uc_s in ['LEGAL','TRADEMARK','TRADENAME','SERVICEMARK','RESERVED','FOREIGN']		 => true,
																 false),
														 true); //For contact records, corp_ln_name_type_desc doesn't have to exist
														
					 RETURN if(isValidDesc,1,0);
					 
		END;
		
		
		EXPORT set_valid_RA_AddrType := ['REGISTERED OFFICE','COMMERCIAL REGISTERED AGENT AUTHORITY\'S ADDRESS','REGISTERED AGENT MAILING ADDRESS',''];
		

END;












