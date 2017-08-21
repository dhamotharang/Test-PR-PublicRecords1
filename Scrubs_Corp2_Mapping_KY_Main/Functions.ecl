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
											map(uc_s in ['01','06','07','09','I'] => true,
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
												map(uc_s in ['LEGAL','ASSUMED','REGISTRATION','RESERVED','OTHER'] => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//invalid_status_cd: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_status_cd(STRING s) := FUNCTION

			uc_s 		:= corp2.t2u(s);
					 
			isValidCD := if(uc_s in ['A','C','D','F','G','I','N','V','X',''],true,false);

			RETURN if(isValidCD,1,0);

		END;

		//****************************************************************************
		//invalid_status_desc: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_status_desc(STRING s) := FUNCTION

			uc_s 				:= corp2.t2u(s);

			isValidDesc := map(uc_s in ['ACTIVE','DELETED','INACTIVE','NOT VERIFIED','ON FILE','PENDING DISSOLUTION',
																	'REAL NAME OF FOREIGN ORG. FILED UNDER A FICTITIOUS NAME',
																	'FILING VOIDED FOR BAD PAYMENT','UNKNOWN',''] => true,
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

					 isValidDesc := if(stringlib.stringfilterout(uc_s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',true,false);

					 RETURN if(isValidDesc,1,0);
		END;

		//********************************************************************
		//invalid_org_structure_cd: returns true or false based upon the
		//													incoming code.
		//********************************************************************	
		EXPORT invalid_org_structure_cd(STRING s) := FUNCTION

				uc_s  			:= corp2.t2u(s);
				
				isValidCD		:= map(uc_s in ['ACA','ACC','AKL','ALC','ALL','ANN','ASC','ASP',
																	'AST','CRU','FCA','FCC','FBT','FCO','FCP','FGP',
																	'FLC','FLL','FLP','FMI','FNB','FNG','FNL','FNP',
																	'FNT','FPS','FSP','FST','GPA','KBT','KCA','KCO',
																	'KCP','KLA','KLC','KLL','KLP','KMI','KNG','KNL',
																	'KNP','KPS','KRR','KSP','KST','KUN','LPA','NCR',
																	'REG','RES','']	=> true,false);

			 RETURN if(isValidCD,1,0);
		
		END;

		//********************************************************************
		//invalid_comptype: returns true or false based upon the incoming code.
		//********************************************************************	
		EXPORT invalid_comptype(STRING s) := FUNCTION

				uc_s  			:= corp2.t2u(s);
				isValidCD		:= map(uc_s in ['00','01','02','03','04','05','06','07','08','09',
																		'10','11','12','13','14','15','16','17','18','19',
																		'20','21','22','23','24','25','26','']	=> true,false);

			 RETURN if(isValidCD,1,0);
		
		END;

		//********************************************************************
		//invalid_type1: returns true or false based upon the incoming code.
		//********************************************************************	
		EXPORT invalid_type1(STRING s) := FUNCTION

				uc_s 			 			:= corp2.t2u(s);
				known_bad_codes := ['KY'];

				isValidCD		:= map(uc_s in ['ACA','ACC','AKL','ALC','ALL','ANN','ASC','ASP',
																		'AST','BDC','BTR','COP','CRU','FBT','FCA','FCC',
																		'FCO','FCP','FGP','FLC','FLL','FLP','FMI','FNB',
																		'FNG','FNL','FNP','FNT','FPS','FSP','FST','GPA',
																		'KBT','KCA','KCO','KCP','KLA','KLC','KLL','KLP',
																		'KMI','KNG','KNL','KNP','KPS','KRR','KSP','KST',
																		'KUN','LPA','NCR','PSC','REG','RES','']	=> true,
													 uc_s in [known_bad_codes] 												=> true,
													 false
													);
													
			 RETURN if(isValidCD,1,0);
		
		END;
		
END;