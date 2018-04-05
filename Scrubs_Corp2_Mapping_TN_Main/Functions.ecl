IMPORT corp2;
	
EXPORT Functions := MODULE
							
		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s) := FUNCTION

			uc_s 		:= corp2.t2u(s);

			isValidCD := map(uc_s in ['01','06','07','11','12','F'] => true,
											 false
											);
											
			RETURN if(isValidCD,1,0);

		END;

		//****************************************************************************
		//invalid_ln_name_type_desc: 	returns true or false based upon the incoming
		//														code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_desc(STRING s) := FUNCTION

			uc_s 		:= corp2.t2u(s);

			isValidDesc := map(uc_s in ['ASSUMED']									=> true,
												 uc_s in ['FOREIGN NAME']							=> true,
												 uc_s in ['FOREIGN REGISTERED NAME']	=> true,
												 uc_s in ['LEGAL']										=> true,
												 uc_s in ['RESERVED']									=> true,
												 false
											  );

			RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//invalid_corp_forgn_state_cd: 	returns true or false based upon the incoming
		//															code.
		//****************************************************************************
		EXPORT invalid_corp_forgn_state_cd(STRING s) := FUNCTION

					 uc_s			 	:= corp2.t2u(s);

					 isValidCD 	:= if(stringlib.stringfilterout(uc_s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',true,false);

					 RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//invalid_forgn_state_desc: 	returns true or false based upon the incoming
		//														code.
		//****************************************************************************
		EXPORT invalid_corp_forgn_state_desc(STRING s) := FUNCTION

					 uc_s				 := corp2.t2u(s);

					 isValidDesc := if(stringlib.stringfilterout(uc_s,' ,()ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',true,false);

					 RETURN if(isValidDesc,1,0);
		END;

		//********************************************************************
		//invalid_org_structure_desc: returns true or false based upon the
		//														incoming code.
		//********************************************************************	
		EXPORT invalid_org_structure_desc(STRING s) := FUNCTION

				uc_s		:= corp2.t2u(s);
				
				isValidDesc 	:= map(uc_s = ''															=> true,
														 uc_s = 'LIMITED LIABILITY COMPANY'			=> true,
														 uc_s = 'FOR-PROFIT CORPORATION' 				=> true,
														 uc_s = 'NONPROFIT CORPORATION' 				=> true,
														 uc_s = 'RESERVED NAME' 								=> false,
														 uc_s = 'LIMITED LIABILITY PARTNERSHIP' => true,
														 uc_s = 'GENERAL PARTNERSHIP' 					=> true,
														 uc_s = 'LIMITED PARTNERSHIP' 					=> true,
														 uc_s = 'LP 1988 ACT' 									=> true,
														 uc_s = 'FOREIGN NAME' 									=> false,
														 uc_s = 'FOREIGN REGISTERED NAME' 			=> false,
														 false
													  );

			 RETURN if(isValidDesc,1,0);
		
		END;
		
END;