IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE

  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5, ALL)) > 0,1,0);
  END;
	
	//*******************************************************************************
	//fn_past_withslashes: 	Returns true if valid past date
	//*******************************************************************************
	EXPORT fn_past_withslashes(STRING sDate) := FUNCTION
    pdate   := TRIM(sDate,ALL);
    FmtDate	:= '20' + pdate[7..8] + pdate[1..2] + pdate[4..5];	
		isValidDate := IF(LENGTH(FmtDate) = 8, Scrubs.fn_valid_pastDate(FmtDate) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);
	END;
	
	//*******************************************************************************
  //fn_past_yyyymmdd: 	Returns true if valid past date
  //*******************************************************************************
  EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_general_yyyymmdd: 	Returns true if valid past date
  //*******************************************************************************
  EXPORT fn_general_yyyymmdd(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_GeneralDate(clean_date) > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_dt_first_seen: 	Returns true if valid past date (ccyymm00)
  //*******************************************************************************
  EXPORT fn_dt_first_seen(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date[1..6]+'01') > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_dt_yymmdd: 	Returns true if valid date (yymmdd)
  //*******************************************************************************
  EXPORT fn_dt_yymmdd(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 6, Scrubs.fn_valid_pastDate('19'+clean_date) > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;

	//*******************************************************************************
  //fn_dt_mmddyy: 	Returns true if valid date (mmddyy)
  //*******************************************************************************
  EXPORT fn_dt_mmddyy(STRING sDate) := FUNCTION
    dt  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(dt) = 6, Scrubs.fn_valid_pastDate('19'+dt[5..6]+dt[1..2]+dt[3..4]) > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_dt_ccyymm_or_200000: 	Returns true if valid past date (ccyymm) or 200000
  //*******************************************************************************
  EXPORT fn_dt_ccyymm_or_200000(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 6, Scrubs.fn_valid_pastDate(clean_date+'01') > 0 or clean_date = '200000', FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_dt_yymm_or_0000: 	Returns true if valid date (yymm) or 0000
  //*******************************************************************************
  EXPORT fn_dt_yymm_or_0000(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 4, Scrubs.fn_valid_pastDate('19'+clean_date+'01') > 0 or clean_date = '0000', FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
  //fn_dt_yy: 	Returns true if valid year
  //*******************************************************************************
  EXPORT fn_dt_yy(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 2, Scrubs.fn_valid_pastDate('19'+clean_date+'0101') > 0, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_phone:  Returns true if valid phone number or blank 
	//****************************************************************************
	 EXPORT fn_verify_phone(STRING phone) := function    
    trim_phone := TRIM(phone, ALL);
    RETURN IF(ut.CleanPhone(trim_phone) != '' or trim_phone = '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_sic_code:  Returns true if empty or 4-digit value.
	//****************************************************************************
	 EXPORT fn_sic_code(STRING sic) := function    
		  RETURN IF((sic = '' OR LENGTH(sic) = 4) AND
              Stringlib.StringFilterOut(sic, '0123456789') = '', 1, 0);
  END;

	//****************************************************************************
	//fn_numeric: returns true if only populated with numbers 
	//****************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr, '0123456789') = '' and (integer)nmbr<>0, 1, 0);
	END;
	
	//****************************************************************************
	//fn_numeric_or_allzeros: returns true if only populated with numbers 
	//****************************************************************************
	EXPORT fn_numeric_or_allzeros(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
		RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
		Stringlib.StringFilterOut(nmbr, '0123456789') = '' , 1, 0);
	END;
	
	//****************************************************************************
	//fn_account_balance: returns true if only populated with 0-9, A-H, and { 
	//****************************************************************************
	EXPORT fn_account_balance(STRING nmbr) := FUNCTION
		RETURN IF(Stringlib.StringFilterOut(nmbr, '0123456789ABCDEFGHI{') = '' , 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_state: returns true if a valid state abbreviation
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function
		RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_verify_state_desc: returns true if a valid state description
	//********************************************************************************************
	EXPORT fn_verify_state_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['ALABAMA',				     'ALASKA',					'ARKANSAS', 		'AMERICAN SAMOA',	
												  'ARIZONA', 				     'CALIFORNIA', 		  'COLORADO', 	  'CONNECTICUT', 
													'DISTRICT OF COLUMBIA','DELAWARE',        'FLORIDA',      'GEORGIA', 
													'GUAM', 						   'HAWAII',          'IOWA',         'IDAHO', 
													'ILLINOIS',            'INDIANA',         'KANSAS',       'KENTUCKY', 
													'LOUISIANA', 					 'MASSACHUSETTS', 	'MARYLAND',  	  'MAINE', 
													'MICHIGAN', 					 'MINNESOTA', 		  'MISSOURI', 	  'MISSISSIPPI', 
													'MONTANA',  					 'NORTH CAROLINA',  'NORTH DAKOTA', 'NEBRASKA', 
													'NEW HAMPSHIRE',			 'NEW JERSEY', 		  'NEW MEXICO',   'NEVADA', 
													'NEW YORK', 					 'OHIO', 						'OKLAHOMA', 	  'OREGON', 
													'PENNSYLVANIA', 			 'PUERTO RICO', 	  'RHODE ISLAND', 'SOUTH CAROLINA', 
													'SOUTH DAKOTA', 			 'TENNESSEE', 			'TEXAS', 				'UTAH', 
													'VIRGINIA', 					 'VIRGIN ISLANDS',  'VERMONT', 			'WASHINGTON', 
													'WISCONSIN', 					 'WEST VIRGINIA',   'WYOMING' 
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_zip5: returns true if a 5-digit numeric value
	//****************************************************************************
	EXPORT fn_verify_zip5(STRING zip5) := function 
		RETURN IF(LENGTH(trim(zip5, all)) = 5 AND Stringlib.StringFilterOut(trim(zip5, all), '0123456789') = '', 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_mmddyy_Date: returns true or false based upon whether or not there is a valid date.
	//********************************************************************************************
	EXPORT fn_valid_mmddyy_Date(STRING sDate) := FUNCTION
    pdate   := TRIM(sDate,ALL);
    FmtDate	:= '19' + pdate[5..6] + pdate[1..2] + pdate[3..4];	
		isValidDate := IF(LENGTH(FmtDate) = 8, Scrubs.fn_valid_generalDate(FmtDate) > 0, FALSE);
		RETURN IF(isValidDate, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_tax_lien_code: returns true if a valid tax lien code
	//********************************************************************************************
	EXPORT fn_valid_tax_lien_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['','A','B','C','E','1','2','3','4','5'], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_tax_lien_desc: returns true if a valid tax lien desc
	//********************************************************************************************
	EXPORT fn_valid_tax_lien_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
												  'FD-AGRI-TAX',
												  'FD-UNEMPL-TAX',
													'SALES-TAX',
													'STATE-CTRB-TAX',
													'STATE-CTRB-TAX, SALES-TAX',     
													'STATE-FRANCHISE',
													'WITH-TAX',
													'WITH-TAX & FICA',               
													'WITH-TAX & FICA, FD-UNEMPL-TAX' 
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_bustyp_code: returns true if a valid bus type code
	//********************************************************************************************
	EXPORT fn_bustyp_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['','C','S','P','R','N','F','I','G'], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_bustyp_desc: returns true if a valid bus type desc
	//********************************************************************************************
	EXPORT fn_bustyp_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
												  'CORPORATION',
												  'SOLE PROPRIETOR',
													'PARTNERSHIPS',
													'INSTITUTIONS'
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;

	//********************************************************************************************
	//fn_agency_code: returns true if a valid agency code
	//********************************************************************************************
	EXPORT fn_agency_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in 
											 ['AF',
												'AID',
												'ARMY',
												'DLA',
												'DOE',
												'DOI',
												'DOJ',
												'DOL',
												'DOT',
												'EPA',
												'GPO',
												'GSA',
												'HHS',
												'NAVY',
												'PS',
												'USDA',
												'VA'
												], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_agency_desc: returns true if a valid agency desc
	//********************************************************************************************
	EXPORT fn_agency_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['AGENCY FOR INTERNAL DEVELOPMENT',
													'DEFENSE LOGISTICS AGENCY',
													'DEPARTMENT OF AGRICULTURE',
													'DEPARTMENT OF ENERGY',
													'DEPARTMENT OF INTERIOR',
													'DEPARTMENT OF JUSTICE',
													'DEPARTMENT OF LABOR',
													'DEPARTMENT OF THE AIR FORCE',
													'DEPARTMENT OF THE ARMY',
													'DEPARTMENT OF THE NAVY',
													'DEPARTMENT OF TRANSPORTATION',
													'DEPT OF HEALTH & HUMAN SERVICES',
													'ENVIRONMENTAL PROTECTION AGENCY',
													'GENERAL SERVICES ADMINISTRATION',
													'GOVERNMENT PRINTING OFFICE',
													'POSTAL SERVICE',
													'VETERANS ADMINISTRATION'
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_ownertyp_code: returns true if a valid owner type code
	//********************************************************************************************
	EXPORT fn_ownertyp_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['','0','1','2','3','4','5','6','C'], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_ownertyp_desc: returns true if a valid owner type desc
	//********************************************************************************************
	EXPORT fn_ownertyp_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
												  'UNKNOWN',
												  'PRIVATELY HELD',
													'PUBLICLY HELD',
													'NON-PROFIT',
													'FOREIGN OWNERSHIP'
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;


	//********************************************************************************************
	//fn_location_code: returns true if a valid location code
	//********************************************************************************************
	EXPORT fn_location_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['','S','M','P','X','H','F','B','N','D'], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_location_desc: returns true if a valid location desc
	//********************************************************************************************
	EXPORT fn_location_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
												  'SINGLE LOCATION',
												  'MULTI-NAME OCCURS',
													'HEADQUARTER',
													'FRANCHISE',
													'BRANCH',
													'DIVISION',
													'DEPARTMENT STORE'
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_coll_code: returns true if a valid coll code
	//********************************************************************************************
	EXPORT fn_valid_coll_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['','1','6','9','D','E','F','L','U'], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_coll_desc: returns true if a valid coll desc
	//********************************************************************************************
	EXPORT fn_valid_coll_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
												  'ACCTS',
												  'ACCTS REC',
													'CONTRACT RIGHTS',
													'HEREAFTER ACQUIRED PROP',
													'INVENTORY',     
													'LEASES',
													'NOTES RECEIVABLE',
													'PROCEEDS'
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;

	//********************************************************************************************
	//fn_valid_4510_coll_code: returns true if a valid 4510 coll code
	//********************************************************************************************
	EXPORT fn_valid_4510_coll_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['','0','1','2','3','4','5','6','7','8','9',
																				 'A','B','C','D','E','F','G','H','I','J','K',
																				 'L','M','N','O','Q','R','S','T','U','V','Y','Z'
																				 ], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_4510_coll_desc: returns true if a valid 4510 coll desc
	//********************************************************************************************
	EXPORT fn_valid_4510_coll_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
												  'ACCTS',
													'ACCTS REC',
													'APPLIANCES',
													'ASSIGN OF CERT R/E CONTRACT',
													'ASSIGN OF CERTAIN LEASE',
													'BUILDINGS',
													'CERT DESCR COMPUTER EQUIP',
													'CERT DESCR INVENTORY',
													'CERT DESCR TIRES, TUBES, WHEELS, ETC',
													'CHATTEL PAPER',
													'CONTRACT RIGHTS',
													'CROPS',
													'EQUIP',
													'ETC.',
													'FARM PRODUCTS',
													'FISHING GEAR',
													'FISHING VESSELS',
													'FURN & FIX',
													'FURNISHINGS',
													'HEREAFTER ACQUIRED PROP',
													'INVENTORY',
													'LEASES',
													'LIVESTOCK',
													'LOCATED ON CERT REAL PROPERTY',
													'MACHINERY',
													'NOTES RECEIVABLE',
													'PROCEEDS',
													'PRODUCTS',
													'REAL PROPERTY',
													'SIGN',
													'TOOLS',
													'UNDEFINED',
													'VEHICLES'
												  ], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_relationship_code: returns true if a valid relationship code
	//********************************************************************************************
	EXPORT fn_valid_relationship_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['0','1','2','3','5','6','7','8','9','A','Z'
																				 ], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
 
	//********************************************************************************************
	//fn_valid_relationship_desc: returns true if a valid relationship desc
	//********************************************************************************************
	EXPORT fn_valid_relationship_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['ASSET BASED LOAN',
												  'BORROWER',
													'CHECKING ACCOUNT',
													'CURRENCY EXCHANGE',
													'LINE OF CREDIT',
													'MERCHANT BANK CARD',
													'PRIVATE LOAN',
													'RECEIVABLES FINANCING',
													'RETAIL LOAN',
													'SMALL BUSINESS LOAN',
													'UNSPECIFIED'											  
												  ], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;	

	//********************************************************************************************
	//fn_valid_action_code: returns true if a valid action code
	//********************************************************************************************
	EXPORT fn_valid_action_code(STRING code) := FUNCTION
   	isValidCode := IF(TRIM(code,ALL) in ['00','01','02','03','04','05','07','08','09','10'], TRUE, FALSE);
		RETURN IF(isValidCode, 1, 0);
	END;
	
	//********************************************************************************************
	//fn_valid_action_desc: returns true if a valid action desc
	//********************************************************************************************
	EXPORT fn_valid_action_desc(STRING desc) := FUNCTION
   	isValidDesc := IF(desc in 
												 ['',
													'AMENDED',
													'ASSIGN',	
													'CONT',
													'F-REL',
													'FILED',
													'P-REL',
													'REL',
													'SAT',
													'TERM'
													], TRUE, FALSE);
		RETURN IF(isValidDesc, 1, 0);
	END;
	
////////////////////////////////////////////////////////////////////	



	
  //****************************************************************************
	//fn_alpha: returns true if only populated with letters
	//****************************************************************************
	// EXPORT fn_alpha(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION

		// RETURN IF(IF(size = 0, LENGTH(TRIM(alphanum, ALL)) > 0, LENGTH(TRIM(alphanum, ALL)) = size) AND
		// Stringlib.StringFilterOut(alphanum, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '', 1, 0);

	// END;
 
	//****************************************************************************
	//fn_alphanumeric: returns true if only populated with numbers or letters
	//****************************************************************************
	// EXPORT fn_alphanumeric(STRING alphanum, UNSIGNED1 size = 0) := FUNCTION

		// RETURN IF(IF(size = 0, LENGTH(TRIM(alphanum, ALL)) > 0, LENGTH(TRIM(alphanum, ALL)) = size) AND
		// Stringlib.StringFilterOut(alphanum, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') = '', 1, 0);

	// END;

	//****************************************************************************
	//fn_chk_blanks: returns true if the value is populated
	//****************************************************************************
	// EXPORT fn_chk_blanks(STRING Busname) := FUNCTION
	
		// RETURN IF(LENGTH(TRIM(Busname, ALL)) > 0, 1, 0);
	
	// END;

	//****************************************************************************
	//fn_full_zip: returns true or false based upon whether or not there is
	// a 9-digit or 5-digit numeric value.
	//****************************************************************************
	// EXPORT fn_full_zip(STRING mzip) := function 

		// RETURN IF(LENGTH(trim(mzip, all)) in [ 5,9] AND Stringlib.StringFilterOut(trim(mzip, all), '0123456789') = '', 1, 0);

	// END;


	//****************************************************************************
	//fn_verify_zip4: returns true or false based upon whether or not there is
	// a 4-digit value.
	//****************************************************************************
	// EXPORT fn_verify_zip4(STRING zip4) := function  

		// RETURN IF(LENGTH(trim(zip4, all)) = 4 AND Stringlib.StringFilterOut(trim(zip4, all), '0123456789') = '', 1, 0);

	// END;

  //****************************************************************************
	//fn_chk_people_names: returns true only for names of alpha and with special characters 
	// returns false** for blank Or only allowed special[-.'&]characters in names,nothing else!
	//****************************************************************************
	// EXPORT fn_chk_people_names(STRING f, STRING m= '', STRING l= '' ) := FUNCTION

		// PatternValidChar		:= '[A-Z]|\\x2D|\\x2E|\\x27|\\x26|\\x20';//alpha or with [-.'& space] these characters allowed
		// name								:= ut.CleanSpacesAndUpper(f) + ut.CleanSpacesAndUpper(m) + ut.CleanSpacesAndUpper(l);	
		// RETURN IF(regexreplace(PatternValidChar, name, '')!='' or regexreplace('\\x2D|\\x2E|\\x27|\\x26', name, '')='', 0, 1);

	// END;

	//****************************************************************************
	//fn_geo_coord: returns true or false based upon the lat/long value.
	//****************************************************************************
	// EXPORT fn_geo_coord(STRING geo) := FUNCTION

		// geo_clean := TRIM(geo, ALL);
		//Verifying the pattern for coordinates is an optional negative sign (-), 
		//followed by at least 1 digit, followed by decimal (.), and ending
		//with at least 1 digit
		// RETURN IF(regexfind('^-?\\d+.\\d+$', geo_clean), 1, 0);

	// END;
	                                         
  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  // EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    // RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              // Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  // END;

  //****************************************************************************
  //fn_range_numeric: 	returns true if number in range
  //****************************************************************************
  // EXPORT fn_range_numeric(STRING nmbr, UNSIGNED6 lbound, UNSIGNED6 ubound) := FUNCTION
    // RETURN IF((UNSIGNED6)nmbr >= lbound AND (UNSIGNED6)nmbr <= ubound,1,0);
  // END;

  //****************************************************************************
  //fn_populated_strings: 	returns true if one of the strings is populated
  //****************************************************************************
  // EXPORT fn_populated_strings(STRING str1, STRING str2 = '', STRING str3 = '', STRING str4 = '', STRING str5 = '') := FUNCTION
    // RETURN IF(LENGTH(TRIM(str1 + str2 + str3 + str4 + str5, ALL)) > 0,1,0);
  // END;


  //****************************************************************************
	 //fn_sic_code:  returns true or false based upon whether or not there is
  //              an empty, 4-digit, or 8-digit value.
	 //****************************************************************************
	 // EXPORT fn_sic_code(STRING sic) := function    
		  // RETURN IF((sic = '' OR LENGTH(sic) = 4 OR LENGTH(sic) = 8) AND
              // Stringlib.StringFilterOut(sic, '0123456789') = '', 1, 0);
  // END;

  //****************************************************************************
	 //fn_duns:  returns true or false based upon whether or not there is
  //          an empty or 9-digit value.
	 //****************************************************************************
	 // EXPORT fn_duns(STRING duns) := function    
		  // RETURN IF((duns = '' OR LENGTH(duns) = 9) AND
              // Stringlib.StringFilterOut(duns, '0123456789') = '', 1, 0);
  // END;

  //****************************************************************************
	 //fn_valid_name:  returns true or false based upon whether the name was 
  //                was cleaned successfully.
	 //****************************************************************************
	 // EXPORT fn_valid_name(STRING lname, STRING mname, STRING fname, STRING raw_name) := function    
		  // RETURN IF(fn_populated_strings(raw_name) = 1, 
              // IF(fn_populated_strings(fname, mname, lname) = 1, 1, 0),
              // 1);
  // END;

    
END; //End Functions Module