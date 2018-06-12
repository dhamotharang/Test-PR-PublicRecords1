IMPORT corp2, corp2_raw_wy;
	
EXPORT Functions := MODULE
	
		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','02','06','07','09','10','I'] => true,
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
												map(uc_s in ['ASSUMED','DBA','FOREIGN','LEGAL'] 	=> true,
														uc_s in ['REGISTRATION','RESERVED','OTHER'] 	=> true,
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

		  isValidDesc := map(uc_s = 'DOMESTIC LIMITED LIABILITY COMPANY'								=> true,
												 uc_s = 'DOMESTIC BUSINESS CORPORATION'											=> true,
												 uc_s = 'DOMESTIC NONPROFIT CORPORATION'										=> true,
												 uc_s = 'FOREIGN BUSINESS CORPORATION'											=> true,
												 uc_s = 'FOREIGN LIMITED LIABILITY COMPANY'									=> true,
												 uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'									=> true,
												 uc_s = 'DOMESTIC LIMITED PARTNERSHIP'											=> true,
												 uc_s = 'FOREIGN LIMITED PARTNERSHIP'												=> true,
												 uc_s = 'FOREIGN NONPROFIT CORPORATION'											=> true,
												 uc_s = 'DOMESTIC REGISTERED LIMITED LIABILITY PARTNERSHIP'	=> true,
												 uc_s = 'COOPERATIVE'																				=> true,
												 uc_s = 'DOMESTIC BUSINESS TRUST'														=> true,
												 uc_s = 'FOREIGN PROFESSIONAL CORPORATION'									=> true,
												 uc_s = 'FOREIGN REGISTERED LIMITED LIABILITY PARTNERSHIP'	=> true,
												 uc_s = 'DISTRICT IMPROVEMENT NONPROFIT'										=> true,
												 uc_s = 'FOREIGN BUSINESS TRUST'														=> true,
												 uc_s = 'ACT OF GOVERNMENT'																	=> true,
												 uc_s = 'DISTRICT IMPROVEMENT PROFIT'												=> true,
												 uc_s = 'FOREIGN INDUSTRIAL LOAN'														=> true,
												 uc_s = 'DOMESTIC INDUSTRIAL LOAN'													=> true,
												 uc_s = ''																									=> true,
												 false
												 );
												
			 RETURN if(isValidDesc,1,0);
		
		END;

		//****************************************************************************
		//invalid_cont_title1_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_cont_title1_desc(STRING s, STRING recordorigin) := FUNCTION
			 uc_s 		 		:= corp2.t2u(s);
			 uc_ro 		 		:= corp2.t2u(recordorigin);
			 
			 isValidDesc  := if(uc_ro = 'T',
													map(uc_s = 'APPLICANT'															=> true,
														  uc_s = 'AUTHORIZED REPRESENTATIVE'							=> true,
															uc_s = 'CONTACT'																=> true,
															uc_s = 'CORRESPONDENT'													=> true,
															uc_s = 'GENERAL PARTNER'												=> true,
															uc_s = 'INDIVIDUAL WITH DIRECT KNOWLEDGE'		  	=> true,
															uc_s = 'MANAGER'																=> true,
															uc_s = 'MANAGING PARTNER'												=> true,
															uc_s = 'MEMBER'																	=> true,
															uc_s = 'NONFILEABLE CORRESPONDENT'							=> true,
															uc_s = 'PARTNER'																=> true,
															uc_s = 'PRESIDENT'															=> true,
															uc_s = 'REGISTRANT'															=> true,
															uc_s = 'SECRETARY'															=> true,
															uc_s = 'TRUSTEE'																=> true,
															false
														 ),													 
													true //For corporation records, contact title doesn't have to exist
												 );
																 
					RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_associated_name_type: returns true or false based upon the incoming
		//															code.
		//NOTE: This is the associated_name_type in the raw data and is critical in
		//      evaluating IF and WHERE records are written to (e.g. main, event, and
		//			ar).  If a new associated_name_type is sent from the vendor, this 
		//			function will cause the scrubs to fail.  We are using "internalfield1"
		//			to capture this information. 
		//****************************************************************************
		EXPORT invalid_associated_name_type(STRING s) := FUNCTION

					 isValidDesc  	:= case(corp2.t2u(s),
																	'AMENDED ANNUAL REPORT'									=> true,
																	'AMNDMT TO ANNUAL RPT/INFO STATEMENT' 	=> true,
																	'ANNUAL REPORT'													=> true,
																	'ANNUAL REPORT PAYMENT'									=> true,
																	'APPLICANT'															=> true,
																	'AUTHORIZED REPRESENTATIVE'							=> true,
																	'CONTACT'																=> true,
																	'CORRECTION OF ANNUAL'									=> true,
																	'CORRESPONDENT'													=> true,
																	'GENERAL PARTNER'												=> true,
																	'IMAGE ANNUAL REPORT'										=> true,
																	'INDIVIDUAL WITH DIRECT KNOWLEDGE'			=> true,
																	'MAILING ADDRESS'												=> true,
																	'MANAGER'																=> true,
																	'MANAGING PARTNER'											=> true,
																	'MEMBER'																=> true,
																	'NONFILEABLE CORRESPONDENT'							=> true,
																	'NOTICE LATE ANNUAL'										=> true,
																	'PARTNER'																=> true,
																	'PRESIDENT'															=> true,
																	'PRINCIPAL PLACE OF BUSINESS'						=> true,
																	'RECORDS OFFICE'												=> true,
																	'REGISTERED AGENT'											=> true,
																	'REGISTERED NAME'												=> true,
																	'REGISTRANT'														=> true,
																	'RESERVED NAME'													=> true,
																	'SECRETARY'															=> true,
																	'TRUSTEE'																=> true,
																	'VALID RECORD'													=> true,
																	 false
																 );
																 
					RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//invalid_name_type: returns true or false based upon the incoming code.
		//NOTE: This is the name_type in the raw data and is critical in
		//      evaluating IF and WHERE records are written to (e.g. main, event, and
		//			ar).  If a new associated_name_type is sent from the vendor, this 
		//			function will cause the scrubs to fail.  We are using "internalfield2"
		//			to capture this information. 
		//****************************************************************************
		EXPORT invalid_name_type(STRING s) := FUNCTION

					 isValidDesc  	:= case(corp2.t2u(s),		
																	'ASSUMED BUSINESS NAME'									=> true,
																	'RESERVED NAME'													=> true,
																	'REGISTERED NAME'												=> true,
																	'ENTITY NAME'														=> true,
																	'DOING BUSINESS AS'											=> true,
																	'FOREIGN NAME'													=> true,
																	'MISFILED NAME'													=> true,
																	''																			=> true,
																	 false
																 );
																 
					RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//invalid_bus_type: returns true or false based upon the incoming code.
		//NOTE: This is the bus_type in the raw data and is critical in
		//      evaluating IF and WHERE records are written to (e.g. main, event, and
		//			ar).  If a new associated_name_type is sent from the vendor, this 
		//			function will cause the scrubs to fail.  We are using "internalfield3"
		//			to capture this information. 
		//****************************************************************************
		EXPORT invalid_bus_type(STRING s) := FUNCTION

					 isValidDesc  	:= case(corp2.t2u(s),		
																	'ASSUMED BUSINESS NAME'																		=> true,
																	'DOMESTIC LIMITED LIABILITY COMPANY'											=> true,
																	'DOMESTIC BUSINESS CORPORATION'														=> true,
																	'DOMESTIC NONPROFIT CORPORATION'													=> true,
																	'FOREIGN BUSINESS CORPORATION'														=> true,
																	'FOREIGN LIMITED LIABILITY COMPANY'												=> true,
																	'DOMESTIC PROFESSIONAL CORPORATION'												=> true,
																	'DOMESTIC LIMITED PARTNERSHIP'														=> true,
																	'FOREIGN LIMITED PARTNERSHIP'															=> true,
																	'FOREIGN NONPROFIT CORPORATION'														=> true,
																	'DOMESTIC REGISTERED LIMITED LIABILITY PARTNERSHIP'				=> true,
																	'COOPERATIVE'																							=> true,
																	'DOMESTIC BUSINESS TRUST'																	=> true,
																	'FOREIGN PROFESSIONAL CORPORATION'												=> true,
																	'FOREIGN REGISTERED LIMITED LIABILITY PARTNERSHIP'				=> true,
																	'DISTRICT IMPROVEMENT NONPROFIT'													=> true,
																	'FOREIGN BUSINESS TRUST'																	=> true,
																	'RESERVED NAME'																						=> true,
																	'REGISTERED NAME'																					=> true,
																	'ACT OF GOVERNMENT'																				=> true,
																	'DISTRICT IMPROVEMENT PROFIT'															=> true,
																	'FOREIGN INDUSTRIAL LOAN'																	=> true,
																	'DOMESTIC INDUSTRIAL LOAN'																=> true,
																	 false
																 );
																 
					RETURN if(isValidDesc,1,0);

		END;

END;