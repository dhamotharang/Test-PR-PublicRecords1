IMPORT corp2, corp2_mapping, corp2_raw_ks;

EXPORT Functions := Module

		//****************************************************************************
		//fGetCorpFedTaxID: returns the "corp_fed_tax_id"
		//****************************************************************************
		EXPORT CorpFedTaxID(string s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 
					 //The search pattern is looking for the following:
					 //1) A string of nine numbers of the same digit.  E.g. 000000000 or 111111111
					 //2) A string of "123456789" (which is also an invalid federal tax id 
					 searchpattern := '^(0{9})*(1{9})*(2{9})*(3{9})*(4{9})*(5{9})*(6{9})*(7{9})*(8{9})*(9{9})*(123456789)*$';
					 cleaned_fein := if(regexfind(searchpattern,uc_s,0) <> '' or (integer)uc_s = 0,'',uc_s);
					 return if(length(cleaned_fein) <> 9,'',cleaned_fein[1..2]+'-'+cleaned_fein[3..]);
		END;

		//****************************************************************************
		//CorpRAFullName: returns the "corp_ra_full_name".
		//****************************************************************************
		EXPORT CorpRAFullName(string s) := FUNCTION
					 uc_s 	:= corp2.t2u(s);
					 RETURN regexreplace(corp2_raw_ks.fGetRegExPattern.FullName.InvalidWords,uc_s,'');
		END;

		//****************************************************************************
		//ForeignDomesticInd: returns "F"-Foreign or "D"-Domestic.
		//****************************************************************************
		EXPORT ForeignDomesticInd(STRING code) := FUNCTION
					 uc_code := corp2.t2u(code);
					 RETURN MAP(uc_code in ['BI','BT','CP','CS','DC','DF','DL','DS','EC','FD',
																	'GC','GP','HC','JC','LL','LP','LS','MF','NP','PA',
																	'PL','PN','SA','TP','VD','VL'] 											=> 'D',
											uc_code in ['FC','FF','FL','FN','FP','FS','FT','LF','VF','VP'] 	=> 'F',
											''
										 ); 
		END;
		
		//****************************************************************************
		//State_Codes: returns the state code.
		//****************************************************************************
		EXPORT State_Codes(string s) := FUNCTION
					 
					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'ALABAMA' 							=> 'AL',
											uc_s = 'ALASKA' 							=> 'AK', 
											uc_s = 'ARKANSAS' 						=> 'AR', 
											uc_s = 'AMERICAN SAMOA' 			=> 'AS', 
											uc_s = 'ARIZONA' 							=> 'AZ', 
											uc_s = 'CALIFORNIA' 					=> 'CA', 
											uc_s = 'COLORADO' 						=> 'CO', 
											uc_s = 'CONNECTICUT' 					=> 'CT', 
											uc_s = 'DISTRICT OF COLUMBIA' => 'DC', 
											uc_s = 'DELAWARE' 						=> 'DE', 
											uc_s = 'FLORIDA' 							=> 'FL', 
											uc_s = 'GEORGIA' 							=> 'GA', 
											uc_s = 'GUAM' 								=> 'GU', 
											uc_s = 'HAWAII' 							=> 'HI', 
											uc_s = 'IOWA' 								=> 'IA', 
											uc_s = 'IDAHO' 								=> 'ID', 
											uc_s = 'ILLINOIS' 						=> 'IL', 
											uc_s = 'INDIANA'	 						=> 'IN', 
											uc_s = 'KANSAS' 							=> 'KS', 
											uc_s = 'KENTUCKY' 						=> 'KY', 
											uc_s = 'LOUISIANA' 						=> 'LA', 
											uc_s = 'MASSACHUSETTS' 				=> 'MA', 
											uc_s = 'MARYLAND'							=> 'MD', 
											uc_s = 'MAINE' 								=> 'ME', 
											uc_s = 'MICHIGAN' 						=> 'MI', 
											uc_s = 'MINNESOTA' 						=> 'MN', 
											uc_s = 'MISSOURI' 						=> 'MO', 
											uc_s = 'MISSISSIPPI' 					=> 'MS', 
											uc_s = 'MONTANA' 							=> 'MT', 
											uc_s = 'NORTH CAROLINA' 			=> 'NC', 
											uc_s = 'NORTH DAKOTA' 				=> 'ND', 
											uc_s = 'NEBRASKA' 						=> 'NE', 
											uc_s = 'NEW HAMPSHIRE' 				=> 'NH', 
											uc_s = 'NEW JERSEY' 					=> 'NJ', 
											uc_s = 'NEW MEXICO' 					=> 'NM', 
											uc_s = 'NEVADA' 							=> 'NV', 
											uc_s = 'NEW YORK' 						=> 'NY', 
											uc_s = 'OHIO' 								=> 'OH', 
											uc_s = 'OKLAHOMA' 						=> 'OK', 
											uc_s = 'OREGON' 							=> 'OR', 
											uc_s = 'PENNSYLVANIA' 				=> 'PA', 
											uc_s = 'PUERTO RICO'					=> 'PR', 
											uc_s = 'RHODE ISLAND' 				=> 'RI', 
											uc_s = 'SOUTH CAROLINA' 			=> 'SC', 
											uc_s = 'SOUTH DAKOTA'		 			=> 'SD', 
											uc_s = 'TENNESSEE' 						=> 'TN', 
											uc_s = 'TEXAS' 								=> 'TX', 
											uc_s = 'UNITED STATES' 				=> 'US', 
											uc_s = 'UTAH' 								=> 'UT', 
											uc_s = 'VIRGINIA' 						=> 'VA', 
											uc_s = 'VIRGIN ISLAND'				=> 'VI',
											uc_s = 'VIRGIN ISLANDS' 			=> 'VI',		
											uc_s = 'VERMONT' 							=> 'VT', 
											uc_s = 'WASHINGTON' 					=> 'WA', 
											uc_s = 'WISCONSIN' 						=> 'WI', 
											uc_s = 'WEST VIRGINIA' 				=> 'WV', 
											uc_s = 'WYOMING' 							=> 'WY',
											''
										 );
		END;
				
		//****************************************************************************
		//Country_Code_Translation: returns the country description.
		//****************************************************************************
		EXPORT Country_Code_Translation(string s) := FUNCTION
					 
					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AUT' 							=> 'AUSTRIA',
											uc_s = 'NLD' 							=> 'NETHERLANDS',
											uc_s = 'KSA'							=> 'SAUDI ARABIA',
											'**|'+uc_s
										 );
		END;
		
		//****************************************************************************
		//CorpOrigOrgStructureCD: returns corp_orig_org_structure_cd.
		//****************************************************************************
		EXPORT CorpOrigOrgStructureCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);		
	         
					 RETURN map(uc_s in [''] 																			=> uc_s,
											uc_s in ['BI','BT','CP','CS'] 										=> uc_s,
										  uc_s in ['DC','DF','DL','DS'] 										=> uc_s,
										  uc_s in ['EC'] 																		=> uc_s,
										  uc_s in ['FC','FD','FF','FL','FN','FP','FS','FT'] => uc_s,
										  uc_s in ['GC','GP'] 															=> uc_s,
										  uc_s in ['HC'] 																		=> uc_s,
										  uc_s in ['JC']	 																	=> uc_s,
										  uc_s in ['LF','LL','LP','LS'] 										=> uc_s,
										  uc_s in ['MF'] 																		=> uc_s,
										  uc_s in ['NP'] 																		=> uc_s,
										  uc_s in ['PA','PL','PN'] 													=> uc_s,
										  uc_s in ['SA','SD'] 															=> uc_s,
										  uc_s in ['TP'] 																		=> uc_s,
										  uc_s in ['VD','VF','VL','VP'] 										=> uc_s,
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns corp_orig_org_structure_desc.
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION

						uc_s := corp2.t2u(s);
	
						RETURN MAP(uc_s = 'BI' =>	'BANK, INSURANCE. . .',
											 uc_s = 'BT' =>	'BUSINESS TRUST',
											 uc_s = 'CP' =>	'COOPERATIVE MARKETING ACT',
											 uc_s = 'CS' =>	'COOPERATIVE SOCIETY',
											 uc_s = 'DC' =>	'DISCOUNT CARD PROVIDERS',
											 uc_s = 'DF' =>	'DOMESTIC FOR PROFIT CORPORATION',
											 uc_s = 'DL' =>	'DOMESTIC LTD LIABILITY COMPANY',
											 uc_s = 'DS' =>	'DISC DOMESTIC INTERNATIONAL',
											 uc_s = 'EC' =>	'ELECTRIC COOPERATIVE',
											 uc_s = 'FC' =>	'FOREIGN COOPERATIVE',
											 uc_s = 'FD' =>	'FEDERALLY CHARTERED',
											 uc_s = 'FF' =>	'FOREIGN FOR PROFIT',
											 uc_s = 'FL' =>	'FOREIGN LTD LIABILITY COMPANY',
											 uc_s = 'FN' =>	'FOREIGN NOT FOR PROFIT',
											 uc_s = 'FP' =>	'FOREIGN LIMITED PARTNERSHIP',
											 uc_s = 'FS' =>	'FOREIGN SERIES LTD LIABILITY CO',
											 uc_s = 'FT' =>	'FOREIGN BUSINESS TRUST',
											 uc_s = 'GC' =>	'GAMING CONSENT TO JURISDICTION',
											 uc_s = 'GP' =>	'GENERAL PARTNERSHIP',
											 uc_s = 'HC' =>	'HEALTH CARE CARD SUPPLIER',
											 uc_s = 'JC' =>	'CONSENT TO JURISDICTION',
											 uc_s = 'LF' =>	'FOREIGN LTD LIABILITY PARTNERSHIP',
											 uc_s = 'LL' =>	'DOMESTIC LTD LIABILITY PARTNERSHIP',
											 uc_s = 'LP' =>	'DOMESTIC LIMITED PARTNERSHIP',
											 uc_s = 'LS' =>	'DOMESTIC SERIES LTD LIABILITY CO',
											 uc_s = 'MF' =>	'MANUFACTURER TOBACCO AGENT',
											 uc_s = 'NP' =>	'DOMESTIC NOT FOR PROFIT CORPORATION',
											 uc_s = 'PA' =>	'PROFESSIONAL ASSOCIATION',
											 uc_s = 'PL' =>	'PROFESSIONAL LLC',
											 uc_s = 'PN' =>	'PROFESSIONAL:NP CORPORATION',
											 uc_s = 'SA' =>	'SERVICE AGENT',
											 uc_s = 'SD' =>	'SERIES DOMESTIC',
											 uc_s = 'TP' =>	'TOBACCO PRODUCTS',
											 uc_s = 'VD' =>	'DOMESTIC VENTURE CAPITOL CORP.',
											 uc_s = 'VF' =>	'FOREIGN VENTURE CAPITOL CORP.',
											 uc_s = 'VL' =>	'DOMESTIC VENTURE CAPITOL L.P.',
											 uc_s = 'VP' =>	'FOREIGN VENTURE CAPITOL L.P.',
											 ''
											);
		END;
		
END;		