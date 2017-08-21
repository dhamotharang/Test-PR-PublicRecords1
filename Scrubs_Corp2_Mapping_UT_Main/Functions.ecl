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
											map(uc_s in ['01','02','03','07','09','10'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;


		
		//Below table needs to be updated when we see new Org_Struc desc in Raw updates!
		EXPORT set_valid_org_desc := ['BUSINESS TRUST','COLLECTION AGENCY - DOMESTIC','COLLECTION AGENCY - FOREIGN','COMMERCIAL REGISTERED AGENT ENTITY',
																	'CORPORATION - DOMESTIC - NON-PROFIT','CORPORATION - DOMESTIC - PROFIT','CORPORATION - FOREIGN - NON-PROFIT',
																	'CORPORATION - FOREIGN - PROFIT','CORPORATION - PROFESSIONAL','LIMITED COOPERATIVE ASSOC - DOMESTIC',
																	'LIMITED PARTNERSHIP - DOMESTIC','LIMITED PARTNERSHIP - FOREIGN','LLC - DOMESTIC','LLC - FOREIGN',
																	'LLC - PROFESSIONAL','LLC - SERIES DOMESTIC','LLC - SERIES FOREIGN','LLP - DOMESTIC','LLP - FOREIGN',
																	'COMMERCIAL REGISTERED AGENT INDIVIDUAL','CORPORATION - SOLE','CORPORATION - BENEFIT CORPORATION',
																	'LTD LIABILITY LTD PARTNERSHIP - DOMESTIC','LLC - TRIBAL','LLC - PROFESSIONAL FOREIGN',
																	'CERTIFICATION AUTHORITY','LTD LIABILITY LTD PARTNERSHIP - FOREIGN','REPOSITORY',
																	'CORPORATION - TRIBAL - PROFIT','CORPORATION - TRIBAL - NON-PROFIT','LIMITED COOPERATIVE ASSOC - FOREIGN',
																	'LLC - SERIES TRIBAL','GENERAL PARTNERSHIP - DOMESTIC','LLC - LOW-PROFIT',''];
													 
END;