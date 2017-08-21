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
											map( uc_s in ['01','09','07'] => true, 
													 false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;
		
		//Below table needs to be updated when we see new Org_Struc codes in Raw updates!

		EXPORT set_valid_orgStruc_codes := ['BK','BL' ,'CH' ,'CI','CO','DA','DB','DF','DL','DP','DR','DT'
																				,'DM','FA','FB','FC','FF','FG','FK','FL','FM','FN','FP'
																				,'FR' ,'FT','GP','ID','IN','MP','NS','PF','PU','RA','RN','SD','WD',''];																	
																		
END;