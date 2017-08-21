IMPORT corp2, corp2_raw_me;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','06','07','09','P']	=> true,
												  false
											),
											true //For non-corp records, corp_ln_name_type_cd doesn't have to exist
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
												map(uc_s in ['ASSUMED','COOPERATIVE','LEGAL','PRIOR','REGISTRATION','RESERVED'] => true,
														false
													 ),
												true //For non-corp records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_ln_name_type_desc: 	returns true or false based upon the incoming
		//														code.
		//****************************************************************************
		EXPORT invalid_orig_org_structure_desc(STRING s, STRING recordorigin) := FUNCTION

					 uc_s 		:= corp2.t2u(s);
					 uc_ro 		:= corp2.t2u(recordorigin);
							 
					 isValidDesc := if(uc_ro = 'C',
														 map(stringlib.stringfind(uc_s,'*',1)=0 => true,
																 false
															  ),
														 true //For non-corp records, corp_ln_name_type_desc doesn't have to exist
													  );

					 RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_corp_status_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_corp_status_cd(STRING code, STRING recordorigin) := FUNCTION
					 
					 isValidStatusCD := if(corp2.t2u(recordorigin) = 'C',
																 map(stringlib.stringfind(corp2.t2u(code),'*',1)=0 => true,
																		 false
																	  ),
																 true //For non-corp records, corp_status_cd doesn't have to exist
															  );

					 RETURN if(isValidStatusCD,1,0);
					
		END;
		
		//****************************************************************************
		//invalid_corp_status_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_corp_status_desc(STRING code, STRING recordorigin) := FUNCTION

					 isValidStatusDesc := if(corp2.t2u(recordorigin) = 'C',
																	 map(stringlib.stringfind(corp2.t2u(code),'*',1)=0 => true,
																			 false
																			),
																	 true //For non-corp records, corp_status_cd doesn't have to exist
																	);

					 RETURN if(isValidStatusDesc,1,0);
					 
		END;

		//****************************************************************************
		//invalid_name_type_cd: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_name_type_cd(STRING code, STRING recordorigin) := FUNCTION
		
					 isValidCD := if(corp2.t2u(recordorigin) = 'C',
													 map(corp2.t2u(code) in ['A','F','G','L','N','R'] => true,
															 false
															),
													 true //For non-corp records, corp_status_cd doesn't have to exist
													);

					 RETURN if(isValidCD,1,0);
		END;
		
END;		