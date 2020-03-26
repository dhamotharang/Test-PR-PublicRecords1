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
											map(uc_s in ['01','03','04','05','07','09','10'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;
		
		//Below table needs to be updated when we see new org type structure codes in Raw updates!
		EXPORT set_valid_org_cd := ['7','19','10115','10129','10134','10139','10140','10141','10142','10143','10146',
																'10148','10149','10151','10154','10156','10158','10159','10160','10162','10171',
																'10196','10197','10198','10199','10200','10201','10202','10203','10204','10205',
																'10206','10207','10208','10209','10210','10211','10212','10213','10214','10215',
																'10216','10217','10218','10219','10220','10221','10222','10224','10226','10227',''];
													 
END;