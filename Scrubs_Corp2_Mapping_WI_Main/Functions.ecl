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
											map(uc_s in ['01','07','09','I'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;


		
		//Below table needs to be updated when we see new Org_Struc codes in Raw updates!
		EXPORT set_valid_org_structure_cd := ['01','02','03','04','05','06','07','08','09','10','11',
																					'12','13','14','15','16','17','18','24','25','96',''];
																					
		//Below table needs to be updated when we see new status codes in Raw updates!	
		EXPORT set_valid_status_cd := [ 'ADS','CAN','CMC','CNF','CNS','COM','DEL','DIS','DLQ','DNP','EXP','FDE',
																		'IBS','IGS','IDS','INC','MGD','ORG','PND','RCA','RES','RGD','RGL','RLT',
																		'TER','WTD' ,''];
													 
END;