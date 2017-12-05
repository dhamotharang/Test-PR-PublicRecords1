IMPORT corp2;   
	
EXPORT Functions := MODULE
      
		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
												map(uc_s in ['01','2','5','9'] => true,
														false
												),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;     
		
		EXPORT set_valid_Org_struct_cd :=['4','6','7','8','10','11','13','14','15','26','1002','1003','1004','1005',
																			'1006','1007','1008','1009','1010','1012','1013','1014','1015','1016','1017',
																			'1018','1019','1020','1021','1022','1023','1024','1025','1026','1027','1028',
																			'1029','1030',''];
																			
		EXPORT set_valid_Status_cd := ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15',
																	 '16','19','20','21','22','23','24','25','1001','1003','1002','1004',
																	 '1005','1006','1007','1008','1009','1010','1011','1012','1013',''];


																	
END;