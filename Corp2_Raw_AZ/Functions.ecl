IMPORT corp2, corp2_raw_az, ut;

EXPORT Functions := Module
	
  //**************************************************************************************************
	// FixAddrField - Address fields sometimes begins with a percent (%) which we want to blank out.
	//                Also, sometimes address fields contain only Xs, like 'XXXXX', 'XX', etc. so we 
	//                also want to blank those invalid values.
	//**************************************************************************************************
	EXPORT FixAddrField(string s) := FUNCTION    		

		ucS := corp2.t2u(s);
		stripPct := corp2.t2u(StringLib.StringFindReplace(ucS,'%',''));
		
		RETURN  if (LENGTH(stringlib.stringfilterout(corp2.t2u(stripPct),'X')) < 1
                 ,'' ,corp2.t2u(stripPct));
  END;
	
	
	//**************************************************************************************************
	// GetOrgStrucDesc: Returns org structure description (CORP_ORIG_ORG_STRUCTURE_DESC)
	// 
	// ** Note ** If a new type is added, add it to GetForProfit -AND- also check coding of 
	//                         corp_foreign_domestic_ind to be sure it doesn't need changed
	//
	//**************************************************************************************************
	EXPORT GetOrgStrucDesc(string s) 
							 := map(s in ['DOMESTIC BENEFIT CORPORATION',
														'DOMESTIC BUSINESS TRUST',
														'DOMESTIC CLOSE CORPORATION',
														'DOMESTIC COOPERATIVE MARKETING ASSOCIATION NONPROFIT',
														'DOMESTIC CORPORATION SOLE',
														'DOMESTIC CREDIT UNION',
														'DOMESTIC FOR-PROFIT (BUSINESS) CORPORATION',
														'DOMESTIC LLC',
														'DOMESTIC NONPROFIT CORPORATION',
														'DOMESTIC PROFESSIONAL BENEFIT CORPORATION',
														'DOMESTIC PROFESSIONAL CORPORATION',
														'DOMESTIC PROFESSIONAL LLC',
														'FOREIGN BENEFIT CORPORATION',
														'FOREIGN BUSINESS TRUST',
														'FOREIGN CLOSE CORPORATION',
														'FOREIGN COOPERATIVE MARKETING ASSOCIATION NONPROFIT',
  													'FOREIGN CORPORATION SOLE',
														'FOREIGN CREDIT UNION',
														'FOREIGN FOR-PROFIT (BUSINESS) CORPORATION',
														'FOREIGN LLC',
														'FOREIGN NONPROFIT CORPORATION',
														'FOREIGN PROFESSIONAL CORPORATION',
														'FOREIGN PROFESSIONAL LLC',
														'FOREIGN SERIES LLC'] 		                                                => s,
														s = 'DOMESTIC ELECTRIC COOPERATIVE NONPROFIT MEMBERSHIP CORPORATION'      => 'DOMESTIC ELECTRIC COOPERATIVE NONPROFIT MEMBERSHIP CORP',      //shorten to fit in 60-chars
														s = 'FOREIGN ELECTRIC COOPERATIVE NONPROFIT MEMBERSHIP CORPORATION'       => 'FOREIGN ELECTRIC COOPERATIVE NONPROFIT MEMBERSHIP CORP',       //shorten to fit in 60-chars
														s = 'DOMESTIC NONPROFIT ELECTRIC GENERATION AND TRANSMISSION COOPERATIVE' => 'DOMESTIC NONPROFIT ELECTRIC GENERATION AND TRANSMISSION COOP', //shorten to fit in 60-chars
														'**|' + s); // Scrub for new or invalid types							
								
	//**************************************************************************************************
	// GetForProfit: Returns Y or N (CORP_FOR_PROFIT_IND)
	//**************************************************************************************************
	EXPORT GetForProfit(string s) 
							 := map(s in ['DOMESTIC COOPERATIVE MARKETING ASSOCIATION NONPROFIT',
														'DOMESTIC ELECTRIC COOPERATIVE NONPROFIT MEMBERSHIP CORPORATION',
														'DOMESTIC NONPROFIT CORPORATION',
														'DOMESTIC NONPROFIT ELECTRIC GENERATION AND TRANSMISSION COOPERATIVE',
														'FOREIGN COOPERATIVE MARKETING ASSOCIATION NONPROFIT',
														'FOREIGN ELECTRIC COOPERATIVE NONPROFIT MEMBERSHIP CORPORATION',
														'FOREIGN NONPROFIT CORPORATION'] 		            => 'N',
											s in ['DOMESTIC FOR-PROFIT (BUSINESS) CORPORATION',
														'FOREIGN FOR-PROFIT (BUSINESS) CORPORATION']    => 'Y',
											'');


	 //**************************************************************************************************
	 // GetStateCode: Returns state code (CORP_FORGN_STATE_CD)
	 //**************************************************************************************************
	 EXPORT GetStateCode(string s)
		        := case(corp2.t2u(s),	
				          ''                      => '', 
				 					'ARIZONA' 							=> '',   // Blank for ARIZONA 
									'ALABAMA' 							=> 'AL',
									'ALASKA' 								=> 'AK',
									'AMERICAN SAMOA' 				=> 'AS',
									'ARKANSAS' 							=> 'AR',
									'CALIFORNIA' 						=> 'CA',
									'COLORADO' 							=> 'CO',
									'CONNECTICUT' 					=> 'CT',
									'DELAWARE' 							=> 'DE',
									'DISTRICT OF COLUMBIA' 	=> 'DC',
									'FLORIDA' 							=> 'FL',
									'GEORGIA' 							=> 'GA',
									'GUAM' 									=> 'GU',
									'HAWAII' 								=> 'HI',
									'IDAHO' 								=> 'ID',
									'ILLINOIS' 							=> 'IL',
									'INDIANA' 							=> 'IN',
									'IOWA' 									=> 'IA',
									'KANSAS' 								=> 'KS',
									'KENTUCKY' 							=> 'KY',
									'LOUISIANA' 						=> 'LA',
									'MAINE' 								=> 'ME',
									'MARYLAND' 							=> 'MD',
									'MASSACHUSETTS' 				=> 'MA',
									'MICHIGAN' 							=> 'MI',
									'MINNESOTA' 						=> 'MN',
									'MISSISSIPPI' 					=> 'MS',
									'MISSOURI' 							=> 'MO',
									'MONTANA' 							=> 'MT',
									'NEBRASKA' 							=> 'NE',
									'NEVADA' 								=> 'NV',
									'NEW HAMPSHIRE' 				=> 'NH',
									'NEW JERSEY' 						=> 'NJ',
									'NEW MEXICO' 						=> 'NM',
									'NEW YORK' 							=> 'NY',
									'NORTH CAROLINA' 				=> 'NC',
									'NORTH DAKOTA' 					=> 'ND',
									'OHIO' 									=> 'OH',
									'OKLAHOMA' 							=> 'OK',
									'OREGON' 								=> 'OR',
									'PENNSYLVANIA' 					=> 'PA',
									'PUERTO RICO' 					=> 'PR',
									'RHODE ISLAND' 					=> 'RI',
									'SOUTH CAROLINA' 				=> 'SC',
									'SOUTH DAKOTA' 					=> 'SD',
									'TENNESSEE' 						=> 'TN',
									'TEXAS' 								=> 'TX',
									'U.S. VIRGIN ISLANDS' 	=> 'VI',
									'UTAH' 									=> 'UT',
									'VERMONT' 							=> 'VT',
									'VIRGINIA' 							=> 'VA',
									'WASHINGTON' 						=> 'WA',
									'WEST VIRGINIA' 				=> 'WV',
									'WISCONSIN' 						=> 'WI',
									'WYOMING' 							=> 'WY',
									'');

	 //**************************************************************************************************
	 // GetStateDesc: Returns state description (CORP_FORGN_STATE_DESC)
	 //**************************************************************************************************
	 EXPORT GetStateDesc(string s)
		     := map(corp2.t2u(s) in ['','ARIZONA'] 	  					   					                      => '', // Blank for ARIZONA
				        corp2.t2u(s) in ['ALABAMA', 				'ALASKA', 						'AMERICAN SAMOA',
																 'ARKANSAS', 				'CALIFORNIA', 				'COLORADO',
																 'CONNECTICUT', 		'DELAWARE', 					'DISTRICT OF COLUMBIA',
																 'FLORIDA', 				'GEORGIA', 						'GUAM',
																 'HAWAII', 					'IDAHO', 							'ILLINOIS', 
																 'INDIANA', 				'IOWA',	 							'KANSAS', 
																 'KENTUCKY', 				'LOUISIANA', 					'MAINE',
																 'MARYLAND', 				'MASSACHUSETTS', 			'MICHIGAN', 
																 'MINNESOTA', 			'MISSISSIPPI', 				'MISSOURI', 
																 'MONTANA', 				'NEBRASKA', 					'NEVADA',
																 'NEW HAMPSHIRE',		'NEW JERSEY', 				'NEW MEXICO', 
																 'NEW YORK', 				'NORTH CAROLINA', 		'NORTH DAKOTA',
																 'OHIO', 						'OKLAHOMA', 					'OREGON',
																 'PENNSYLVANIA',		'PUERTO RICO',				'RHODE ISLAND',
																 'SOUTH CAROLINA',	'SOUTH DAKOTA',				'TENNESSEE',
																 'TEXAS', 					'U.S. VIRGIN ISLANDS','UTAH',
																 'VERMONT',					'VIRGINIA', 					'WASHINGTON',
																 'WEST VIRGINIA',		'WISCONSIN',					'WYOMING'] 					=> corp2.t2u(s),
								'**|' + corp2.t2u(s));

END;
