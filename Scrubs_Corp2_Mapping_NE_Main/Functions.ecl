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
											map(uc_s in ['01','03','04','05','07','09','10','I'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;
		
		//Below table needs to be updated when we see new org type structure codes in Raw updates!
		EXPORT set_valid_org_cd := ['A','AA','B','BK','D','DF','DFPC','DLLC','DLPC','DPC',
																'DPLC','F','FLCA','FLLC','FLPC','FPC','FPLC','FS','G',
																'H','HA','IC','J','JPA','K','L','LCA','N','NBC','NDF',
																'NF','NFLC','NLCA','NS','NT','P','PN','RAD','SID',''];
													 
END;