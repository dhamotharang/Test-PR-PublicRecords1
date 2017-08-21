IMPORT corp2;

EXPORT Functions := Module		
		//****************************************************************************
		//Valid_US_State_Codes: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT Valid_US_State_Codes(string s) := FUNCTION
					 RETURN map (corp2.t2u(s) in ['AK','AL','AR','AS','AZ','CA','CO','CT','CZ','DC','DE','FL','FN','GA','GU','HI',
																						  'IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC',
																						  'NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC','SD','TN','TT',
																						  'ND','NE','TX','US','UT','VA','VI','VT','WA','WI','WV','WY',''] => true,false);
		END;
		
		//****************************************************************************
		//Valid_US_State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT Valid_US_State_Description(string s) := FUNCTION
					 RETURN map (corp2.t2u(s) in ['ALASKA','ALABAMA','ARKANSAS','AMERICAN SAMOA','ARIZONA','CALIFORNIA',    
																							'COLORADO','CONNECTICUT','CANAL ZONE','WASHINGTON, D.C.','DELAWARE','FLORIDA', 
																							'FOREIGN','GEORGIA','GUAM','HAWAII','IOWA','IDAHO','ILLINOIS',
																							'INDIANA','KANSAS','KENTUCKY','LOUISIANA','MASSACHUSETTS','MARYLAND',
																							'MAINE','MICHIGAN','MINNESOTA','MISSOURI','MISSISSIPPI','MONTANA', 
																							'NORTH CAROLINA','NORTH DAKOTA','NEBRASKA','NEW HAMPSHIRE','NEW JERSEY',
																							'NEW MEXICO','NEVADA','NEW YORK','OHIO','OKLAHOMA','OREGON','PENNSYLVANIA',  
																							'PUERTO RICO','RHODE ISLAND','SOUTH CAROLINA','SOUTH DAKOTA','TENNESSEE',
																							'TRUST TERRITORIES','TEXAS','UNITED STATES','UTAH','VIRGINIA','VIRGIN ISLANDS',
																							'VERMONT','WASHINGTON','WISCONSIN','WEST VIRGINIA','WYOMING',''] => true,false);
		END;

		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Code_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
											uc_s = 'AR' => 'ARKANSAS', 
											uc_s = 'AS' => 'AMERICAN SAMOA', 
											uc_s = 'AZ' => 'ARIZONA', 
											uc_s = 'CA' => 'CALIFORNIA', 
											uc_s = 'CO' => 'COLORADO', 
											uc_s = 'CT' => 'CONNECTICUT',
											uc_s = 'CZ' => 'CANAL ZONE',										
											uc_s = 'DC' => 'DISTRICT OF COLUMBIA', 
											uc_s = 'DE' => 'DELAWARE', 
											uc_s = 'FL' => 'FLORIDA',
											uc_s = 'FN' => 'FOREIGN',
											uc_s = 'GA' => 'GEORGIA', 
											uc_s = 'GU' => 'GUAM', 
											uc_s = 'HI' => 'HAWAII', 
											uc_s = 'IA' => 'IOWA', 
											uc_s = 'ID' => 'IDAHO', 
											uc_s = 'IL' => 'ILLINOIS', 
											uc_s = 'IN' => 'INDIANA', 
											uc_s = 'KS' => 'KANSAS', 
											uc_s = 'KY' => 'KENTUCKY', 
											uc_s = 'LA' => 'LOUISIANA', 
											uc_s = 'MA' => 'MASSACHUSETTS', 
											uc_s = 'MD' => 'MARYLAND', 
											uc_s = 'ME' => 'MAINE' , 
											uc_s = 'MI' => 'MICHIGAN', 
											uc_s = 'MN' => 'MINNESOTA', 
											uc_s = 'MO' => 'MISSOURI', 
											uc_s = 'MS' => 'MISSISSIPPI', 
											uc_s = 'MT' => 'MONTANA', 
											uc_s = 'NC' => 'NORTH CAROLINA', 
											uc_s = 'ND' => 'NORTH DAKOTA', 
											uc_s = 'NE' => 'NEBRASKA', 
											uc_s = 'NH' => 'NEW HAMPSHIRE', 
											uc_s = 'NJ' => 'NEW JERSEY', 
											uc_s = 'NM' => 'NEW MEXICO', 
											uc_s = 'NV' => 'NEVADA', 
											uc_s = 'NY' => 'NEW YORK', 
											uc_s = 'OH' => 'OHIO', 
											uc_s = 'OK' => 'OKLAHOMA', 
											uc_s = 'OR' => 'OREGON', 
											uc_s = 'PA' => 'PENNSYLVANIA', 
											uc_s = 'PR' => 'PUERTO RICO', 
											uc_s = 'RI' => 'RHODE ISLAND', 
											uc_s = 'SC' => 'SOUTH CAROLINA', 
											uc_s = 'SD' => 'SOUTH DAKOTA', 
											uc_s = 'TN' => 'TENNESSEE', 
											uc_s = 'TT' => 'TRUST TERRITORIES',
											uc_s = 'TX' => 'TEXAS',
											uc_s = 'US' => 'UNITED STATES', 
											uc_s = 'UT' => 'UTAH', 
											uc_s = 'VA' => 'VIRGINIA', 
											uc_s = 'VI' => 'VIRGIN ISLANDS', 
											uc_s = 'VT' => 'VERMONT', 
											uc_s = 'WA' => 'WASHINGTON', 
											uc_s = 'WI' => 'WISCONSIN', 
											uc_s = 'WV' => 'WEST VIRGINIA', 
											uc_s = 'WY' => 'WYOMING',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpStatusDesc: returns the corp_status_desc.
		//****************************************************************************
		//Please note:  We are no longer using the table_id = '01' which 
		//							contains the status desciption for the Corps,
		//							LLC & LP file.  The value is now being derived to 
		//							match the vendor's website. 	
		//****************************************************************************
		EXPORT CorpStatusDesc(string s) := FUNCTION
					 uc_s := corp2.t2u(s);
	         RETURN map(uc_s = '00' => 'ACTIVE',
											uc_s = '01' => 'FEE DELINQUENT',
											uc_s = '02' => 'FEE DELINQUENT',
											uc_s = '08' => 'CANCELED',    
											uc_s = '09' => 'TERMINATED',    
											uc_s = '10' => 'TERMINATED',
											uc_s = '11' => 'TERMINATED',
											uc_s = '12' => 'TERMINATED',
											uc_s = '13' => 'TERMINATED',
											uc_s = '14' => 'DISSOLVING',
											uc_s = '15' => 'CANCELED',
											uc_s = '16' => 'DISSOLUTION',
											uc_s = '17' => 'CANCELED',
											uc_s = '18' => 'SURRENDERED',
											uc_s = '19' => 'CANCELED',
											uc_s = '20' => 'MERGED',
											uc_s = '21' => 'MERGED',
											uc_s = '22' => 'CONVERTED',
											uc_s = '23' => 'EXPIRED',
											uc_s = '24' => 'CANCELED',
											uc_s = '25' => 'CANCELED',
											uc_s = '26' => 'SURRENDERED',
											uc_s = '30' => 'REVOKED',
											uc_s = '31' => 'REVOKED',
											uc_s = '32' => 'REVOKED',
											uc_s = '40' => 'WITHDRAWN',
											uc_s = '42' => 'WITHDRAWN',
											uc_s = '43' => 'WITHDRAWN',
											uc_s = '44' => 'CANCELED',
											uc_s = '45' => 'CONVERTED',
											uc_s = '46' => 'CONVERTED',
											uc_s = '50' => 'LLP STATUS ONLY',
											uc_s = '51' => 'LLP STATUS CANCELLED',
											uc_s = '67' => 'REPEALED',
											uc_s = '76' => 'CANCELED',
											uc_s = '98' => 'CONVERTED',
											uc_s = '99' => 'VOID',
											uc_s
								);
		END;

		//****************************************************************************
		//Stock_Class_Translation: returns the stock_class.
		//Note: The stock_class field in corp2_mapping.layouts_common.stock only can
		//			hold 20 characters. Therefore, we cannot use the vendor's table to 
		//      translate the stock class.  An abbreviated stock class is done here
		// 			ONLY if the stock description exceeded 20 characters.
		//****************************************************************************
		EXPORT Stock_Class_Translation(string code, string desc) := FUNCTION

					 uc_code := corp2.t2u(stringlib.stringfilter(corp2.t2u(code),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 uc_desc := corp2.t2u(stringlib.stringfilter(corp2.t2u(desc),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_code = 'CUMPNV' 	=> 'CUM PREF NONVOTING',
											uc_code = 'CONVPA' 	=> 'CONV PREF A',
											uc_code = 'CONVPB' 	=> 'CONV PREF B',
											uc_code = 'CONVPC'  => 'CONV PREF C',
											uc_code = 'CONVPD'  => 'CONV PREF D',
											uc_code = 'CONVP'   => 'CON PREF',
											uc_code = 'PREFCC'  => 'CUM CONV PREF',
											uc_code = 'CUMPA'   => 'CUM PREF A',
											uc_code = 'CUMPB'   => 'CUM PREF B',
											uc_code = 'CUMPV'   => 'CUM PREF VOTING',
											uc_code = 'NCPREF'  => 'NON CUM PREF',
											uc_code = 'NRCOM'   => 'NON-REDEEM COMMON',
											uc_code = 'PREFANV' => 'PREF A NONVOTING',
											uc_code = 'PREFBNV' => 'PREF CL B NONVOTING',
											uc_code = 'PREFCNV' => 'PREF CL C NONVOTING',
											uc_desc
										);
		END;

END;