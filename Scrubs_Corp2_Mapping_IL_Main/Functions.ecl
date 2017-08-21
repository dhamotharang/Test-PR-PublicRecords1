IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','06','09','I','P'] 								=> true,
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
												map(uc_s in ['ASSUMED','EXPIRED'] 																			=> true,
														uc_s in ['FOREIGN ASSUMED','FORGN ASSUMED VOL CANCELLATION']			 	=> true,
														uc_s in ['INVOLUNTARY CANCELLATION','LEGAL'] 												=> true,
														uc_s in ['NOT-FOR-PROFIT ASSUMED','NOT-FOR-PROFIT FOREIGN ASSUMED'] => true,
														uc_s in ['OLD NAME'] 																								=> true,
														uc_s in ['REGISTRATION'] 																						=> true,
														uc_s in ['VOLUNTARY CANCELLATION'] 																	=> true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_corp_types: 	returns true or false based upon the incoming code.
		//The description of the following codes are as follows:
		//						int_s = 2 => 'SUMMONS-NOT QUALIFIED',
		//						int_s = 3 => 'REGISTRATION NAME ONLY',
		//						int_s = 4 => 'DOMESTIC BCA',
		//						int_s = 5 => 'NOT FOR PROFIT',
		//						int_s = 6 => 'FOREIGN BCA',
		//						int_s in [1,7,8,9] (is for assumed names)
		//						'' 		
		//****************************************************************************
		EXPORT invalid_corp_types(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);

			 isValidCD := if(uc_ro = 'C',
											 map(uc_s in ['1','2','3','4','5','6','7','8','9']		=> true,
													 false
												  ),
											 true //For contact records, corp_orig_org_structure_cd doesn't have to exist
										  );

			 RETURN if(isValidCD,1,0);

		END;	
		
		//****************************************************************************
		//invalid_orig_org_structure_desc: 	returns true or false based upon the 
		//																	incoming code.
		//****************************************************************************
		EXPORT invalid_orig_org_structure_desc(STRING s, STRING recordorigin) := FUNCTION

			uc_s 			:= corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);

			isValidDesc := if(uc_ro = 'C',
												map(uc_s in ['','DOMESTIC BCA','FOREIGN BCA']						=> true,
														uc_s in ['NOT FOR PROFIT','REGISTRATION NAME ONLY']	=> true,
														uc_s in ['SUMMONS-NOT QUALIFIED']										=> true,
														false
													 ),
												true //For contact records, corp_orig_org_structure_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_orig_bus_type_desc: returns true or false based upon the incoming
		//														code. 
		//****************************************************************************
		EXPORT invalid_orig_bus_type_desc(STRING s, STRING recordorigin) := FUNCTION
			
			uc_s    	:= corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			filter		:= ' ABCDEFGHIJKLMNOPQRSTUVWXYZ.,;-()/';
			isValidCD := if(uc_ro = 'C',
											map(corp2.t2u(s) = ''																								=> true,
													corp2.t2u(stringlib.stringfilterout(corp2.t2u(s),filter)) = ''  => true,
													false
												 ),
											true //For contact records, corp_orig_org_bus_type_cd doesn't have to exist
										 );

			 RETURN if(isValidCD,1,0);

		END;
		
END;