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
											map(uc_s in ['01','06','09'] => true,
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
												map(uc_s in ['ASSUMED','LEGAL','REGISTRATION'] => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;


		//****************************************************************************
		//invalid_org_structure_desc: returns true or false based upon the incoming code
		//****************************************************************************
		EXPORT invalid_org_structure_desc(STRING s) := FUNCTION

			uc_s 				:= corp2.t2u(s);

			isValidDesc := map(uc_s in ['DOMESTIC NONPROFIT CORPORATION','DOMESTIC PROFIT CORPORATION'] 				                => true,
												 uc_s in ['DOMESTIC LIMITED LIABILITY COMPANY','DOMESTIC LIMITED PARTNERSHIP']		                => true,
												 uc_s in ['FOREIGN LIMITED LIABILITY COMPANY ','FOREIGN LIMITED PARTNERSHIP '] 		                => true,
												 uc_s in ['FOREIGN NONPROFIT CORPORATION','FOREIGN PROFIT CORPORATION'] 				                	=> true,
												 uc_s in ['DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY','DOMESTIC PROFESSIONAL CORPORATION']  => true,
												 uc_s in ['FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY','FOREIGN PROFESSIONAL CORPORATION']    => true,
												 uc_s in ['PARTNERSHIP ASSOCIATIONS LIMITED','FOREIGN TRUST']                                     => true,
												 uc_s in ['']																																			                => true,
												 false
												);
										 
			 RETURN if(isValidDesc,1,0);
		
		END;

		//****************************************************************************
		//invalid_forgn_state: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_forgn_state(STRING s) := FUNCTION
					 uc_s				 := corp2.t2u(s);
					 isValidDesc := if(stringlib.stringfilterout(uc_s,' 0.,&ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',true,false);
					 RETURN if(isValidDesc,1,0);
		END;
		
END;