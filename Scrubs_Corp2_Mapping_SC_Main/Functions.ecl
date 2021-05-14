IMPORT corp2, corp2_raw_sc;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','02','06','07','09','F','P',''] => true,
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
												map(uc_s in ['ASSUMED','DBA','FBN','LEGAL','PRIOR']		=> true,
														uc_s in ['REGISTRATION','RESERVED',''] 						=> true,
														uc_s ='FICTITIOUS BUSINESS NAME'									=> true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );
											 
			 RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//invalid_corp_orig_org_structure_cd: 	returns true or false based upon the
		//																			 incoming code.
		//****************************************************************************
		EXPORT invalid_corp_orig_org_structure_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
					 
			isValidCode := if(uc_ro = 'C',
												map(uc_s in ['BEN','CORP','ELE','GPC','LLC','LLP','LP','']	=> true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidCode,1,0);

		END;
		
		//****************************************************************************
		//invalid_corp_orig_org_structure_desc: 	returns true or false based upon the
		//																			  incoming code.
		//****************************************************************************
		EXPORT invalid_corp_orig_org_structure_desc(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
					 
			isValidDesc := if(uc_ro = 'C',
												map(uc_s in ['','BUSINESS OPPORTUNITY','BUSINESS PROFIT ENTITY']		=> true,
														uc_s in ['BENEFIT CORPORATION','CORPORATION','NONPROFIT']				=> true,
														uc_s in ['CORPORATION FOR PROFIT','ELEEMOSYNARY NONPROFIT']			=> true,
														uc_s in ['ELEEMOSYNARY FOR PROFIT','LIMITED LIABILITY COMPANY']	=> true,
														uc_s in ['LIMITED LIABILITY PARTNERSHIP','LIMITED PARTNERSHIP']	=> true,
														uc_s in ['GENERAL PARTNERSHIP']	                                => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_corp_status_cd: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_corp_status_cd(STRING s) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
					 
			isValidCD := map(uc_s in ['','CNV','DIS','EXP','FOR','GDS','INT','MER','NAG','NAL','NOAFFECT','REG','REI','RES']	=> true,
											 false
										  );

			 RETURN if(isValidCD,1,0);

		END;		

END;