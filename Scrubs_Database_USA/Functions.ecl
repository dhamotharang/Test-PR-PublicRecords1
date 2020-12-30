IMPORT ut, Scrubs, Codes, std, NAICSCodes, SICCodes, Database_USA;

EXPORT Functions := MODULE

	//*******************************************************************************
	//fn_past_yyyymmdd:						Returns true if valid past date, else returns 
	//														false.
	//*******************************************************************************
	EXPORT fn_past_yyyymmdd(STRING sDate) := FUNCTION
		isValidDate := IF((STRING)sDate in ['',' '] or (LENGTH(sDate) = 8 and sDate < (STRING8)Std.Date.Today()), TRUE, FALSE);
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//*******************************************************************************
	//fn_general_date:						Returns true if valid date, else returns false.
	//*******************************************************************************
	EXPORT fn_general_date(STRING10 sDate) := FUNCTION
		isValidDate := IF(Scrubs.fn_valid_GeneralDate(sDate)>0 ,true ,false);
		RETURN IF(isValidDate, 1, 0);
	END;
	
	//********************************************************************************
	//fn_verify_state:  					Returns true if blank or valid state code, else  
	//                  					returns false. 
	//********************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		RETURN IF(TRIM(code,LEFT,RIGHT) = '' OR LENGTH(Codes.St2Name(code)) > 0, 1, 0);
	END;  

	//********************************************************************************
  //fn_numeric: 								Returns true if only populated with numbers, else 
	//                  					returns false. 
	//********************************************************************************
	EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

	//********************************************************************************
	//fn_verify_mail_score:				Returns true if blank or valid mail score, else 
	//														returns false. 
	//********************************************************************************
	EXPORT fn_verify_mail_score(STRING s) := FUNCTION
		MailScoreSet	:=	['M1','P1','B1','P2A','P2B','P3','M2A','1','2','3','4'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in MailScoreSet, 1, 0);
	END;	
	
	//********************************************************************************
  //fn_verify_optional_phone:  	Returns true if blank or valid phone number, else  
	//														returns false. 
  //********************************************************************************
	EXPORT fn_verify_optional_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
	END;
	
	//********************************************************************************
	//fn_url:											Returns true if all the characters are valid, 
  //														else returns false.
	//********************************************************************************
	EXPORT fn_url(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, ' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz\'-!#$%&*,./:;?@_{}~+=()') = '', 1, 0);
  END;	
	
	//********************************************************************************
	//fn_franchise:								Returns true if blank or valid franchise code, else
	//														returns false.
	//********************************************************************************
	EXPORT fn_franchise(STRING s) := function    
		FranchiseSet	:=	['CL','NS','T','BN','OB']; 
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in FranchiseSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_sic:											Returns true if blank, 2-digit, 4-digit or 
  //                 						7-digit value, else returns false.
	//****************************************************************************
	EXPORT fn_sic(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(TRIM(s, ALL)) in [2,4,7]) AND Stringlib.StringFilterOut(s, ' 0123456789') = '', 1, 0);
  END;
	

	//****************************************************************************
	//fn_valid_NAICSCode:					Returns valid naics code value, else returns false.
	//****************************************************************************	
  EXPORT integer fn_valid_NAICSCode(string code) := function

	  pNAICSLookup := DATASET('~thor_data400::base::naicscodes::qa::lookup',NAICSCodes.Layouts.NAICSLookup,THOR);

	  return ut.fn_NAICS_functions.fn_validate_NAICSCode(code);

  END;
	
	//****************************************************************************
	//fn_employee_code:						Returns true if valid location/corp employee    
	//														code, else returns false.
	//****************************************************************************
	EXPORT fn_employee_code(STRING s) := function    
		EmployeeSet	:=	['A','B','C','D','E','F','G','H','I','J','K','P','U'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in EmployeeSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_loc_sales_code:					Returns true if valid location sales code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_loc_sales_code(STRING s) := function    
		SalesSet	:=	['A','B','C','D','E','F','G','H','I','J','P','U'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in SalesSet, 1, 0);
	END;		
	
	//*******************************************************************************
  //fn_dt_yyyy:									Returns true if blank or valid year, else 
	//														returns false
  //*******************************************************************************
  EXPORT fn_dt_yyyy(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 4, Scrubs.fn_valid_pastDate(clean_date+'0101') > 0, FALSE);
    RETURN IF(isValidDate or clean_date='', 1, 0);
  END;
	
	//****************************************************************************
	//fn_sq_ft:										Returns true if valid square footage code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_sq_ft(STRING s) := function    
		SqFtSet	:=	['A','B','C','D','E']; 
		RETURN IF(ut.CleanSpacesAndUpper(s) in SqFtSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_credit_code:							Returns true if valid credit code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_credit_code(STRING s) := function    
		CreditSet	:=	['A+','A','B+','B','C+','C','D','U','I','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in CreditSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_credit_capacity_code:		Returns true if valid credit capacity code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_credit_capacity_code(STRING s) := function    
		CapacitySet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in CapacitySet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_advertising_code:				Returns true if valid advertising code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_advertising_code(STRING s) := function    
		AdvertisingSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in AdvertisingSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_technology_code:					Returns true if valid technology code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_technology_code(STRING s) := function    
		TechSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in TechSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_office_equip_code:				Returns true if valid office equipment code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_office_equip_code(STRING s) := function    
		OfficeSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in OfficeSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_rent_code:								Returns true if valid rent expense code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_rent_code(STRING s) := function    
		RentSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in RentSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_telecom_code:						Returns true if valid telecom expense code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_telecom_code(STRING s) := function    
		TelecomSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in TelecomSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_accounting_code:					Returns true if valid accounting expense code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_accounting_code(STRING s) := function    
		AccountSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in AccountSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_bus_insurance_code:			Returns true if valid business insurance 
	//														expense code, else returns false.
	//****************************************************************************
	EXPORT fn_bus_insurance_code(STRING s) := function    
		BusInsSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in BusInsSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_legal_code:							Returns true if valid legal expense code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_legal_code(STRING s) := function    
		LegalSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in LegalSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_utilities_code:					Returns true if valid utility expense code,
	//														else returns false.
	//****************************************************************************
	EXPORT fn_utilities_code(STRING s) := function    
		UtilSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in UtilSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_number_of_pcs_code:			Returns true if valid number of PCs code,
	//														else returns false.
	//****************************************************************************
	EXPORT fn_number_of_pcs_code(STRING s) := function    
		PCSet	:=	['A','B','C','D','E','F'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in PCSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_ethnic_code:							Returns true if valid ethnic code,
	//														else returns false.
	//****************************************************************************
	EXPORT fn_ethnic_code(STRING s) := function  
	  searchPattern := U8'\\u002A';
		string Ethnicity := Database_USA.Functions.fDBConsEthnicDesc(s);
		RETURN IF(REGEXFIND(searchPattern,Ethnicity) = FALSE, 1, 0);
	END;

	//****************************************************************************
	//fn_religious_affil:					Returns true if valid religious affiliation 
	//														code, else returns false.
	//****************************************************************************
	EXPORT fn_religious_affil(STRING s) := function 
		ReligiousCode	:=	[	'B','C','E','G','H','I','J','K','L','M','O','P','S','X'];  
		RETURN IF(ut.CleanSpacesAndUpper(s) in ReligiousCode, 1, 0);
	END;
	
	
	//****************************************************************************
	//fn_language:								Returns true if blank or valid language code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_language(STRING s) := function 
	  searchPattern := U8'\\u002A';
	  string Language := Database_USA.Functions.fDBConsLangPrefDesc(s);
		RETURN IF(REGEXFIND(searchPattern,Language) = FALSE, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_time_zone:								Returns true if valid time zone code, else 
	//														returns false.
	//****************************************************************************
	EXPORT fn_time_zone(STRING s) := function 
		TimeZoneCode	:=	[	'5','6','7','8','9','10'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in TimeZoneCode, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_home_value:							Returns true if valid home value code, else 
	//														returns false.
	//****************************************************************************
	EXPORT fn_home_value(STRING s) := function 
		HomeValueCode	:=	[	'A','B','C','D','E','F','G','H','I','J','K','L','M','N',
												'O','P','Q','R','S','T','U','V','W'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in HomeValueCode, 1, 0);
	END;		

	//****************************************************************************
	//fn_donor_code:							Returns true if valid donor capacity code, else 
	//														returns false.
	//****************************************************************************
	EXPORT fn_donor_code(STRING s) := function 
		DonorCode	:=	[	'A','B','C','D','E'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in DonorCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_home_owner_renter:				Returns true if valid home owner/renter code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_home_owner_renter(STRING s) := function 
		OwnerRenterCode	:=	[	'O','R'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in OwnerRenterCode, 1, 0);
	END;

	//****************************************************************************
	//fn_length_of_res:						Returns true if valid length of residence code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_length_of_res(STRING s) := function 
		LengthResCode	:=	[	'A','B','C','D','E','F','U'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in LengthResCode, 1, 0);
	END;

	//****************************************************************************
	//fn_dwelling_type:						Returns true if valid dwelling type code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_dwelling_type(STRING s) := function 
		DwellingCode	:=	[	'S','M'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in DwellingCode, 1, 0);
	END;

	//****************************************************************************
	//fn_income_code:							Returns true if valid income code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_income_code(STRING s) := function 
		IncomeCode	:=	[	'1','2','3','4','5','6','7','8','9','A','B','C','D','E',
											'F','G','H','I','J','K','L','M','N'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in IncomeCode, 1, 0);
	END;

	//****************************************************************************
	//fn_unsec_cap:								Returns true if valid unsecured capacity code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_unsec_cap(STRING s) := function 
		UnsecCapCode	:=	[	'A','B','C','D','E','F'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in UnsecCapCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_net_worth:								Returns true if valid net worth code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_net_worth(STRING s) := function 
		NetWorthCode	:=	[	'A','B','C','D','E'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in NetWorthCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_discret_income:					Returns true if valid discretionary income  
	//														code, else returns false.
	//****************************************************************************
	EXPORT fn_discret_income(STRING s) := function 
		DiscIncomeCode	:=	[	'A','B','C','D','E','F','G','H'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in DiscIncomeCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_marital_status:					Returns true if valid marital status code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_marital_status(STRING s) := function 
		MaritalStatusCode	:=	[	'A','B','M','S'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in MaritalStatusCode, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_new_parent:							Returns true if valid new parent code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_new_parent(STRING s) := function 
		NewParentCode	:=	[	'A','B','C'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in NewParentCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_teen_driver:							Returns true if valid teen driver code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_teen_driver(STRING s) := function
	  searchPattern := U8'\\u002A';
    TeenDesc := map(s = '1' => 'YES',
										s = ' ' or s = '' => '',
										'**|'+ s);
		RETURN IF(REGEXFIND(searchPattern,TeenDesc) = FALSE, 1, 0);
	END;
	
	//****************************************************************************
	//fn_home_sqft_ranges:				Returns true if valid home sqft status code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_home_sqft_ranges(STRING s) := function 
		HomeSqFtCode	:=	[	'A','B','C','D','E','F','G','H','I','J','K','L','M','N'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in HomeSqFtCode, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_poli_party_ind:					Returns true if valid political party code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_poli_party_ind(STRING s) := function 
		PoliPartyCode	:=	[	'D','I','R','V'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in PoliPartyCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_occupation_ind:					Returns true if valid occupation code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_occupation_ind(STRING s) := function 
		OccupationCode	:=	[	'1','2','3','4','5','6','7','8','9','A','B','C','D','E',
													'F','G','H','I','J','K','L','V','W','X','Y','Z'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in OccupationCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_home_property:						Returns true if valid home property type code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_home_property(STRING s) := function 
		HomePropCode	:=	[	'G','M','R','T'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in HomePropCode, 1, 0);
	END;

	//****************************************************************************
	//fn_education:								Returns true if valid education code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_education(STRING s) := function 
		EducationCode	:=	[	'A','B','C','D','E','F'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in EducationCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_city_population_code:		Returns true if valid city population code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_city_population_code(STRING s) := function 
		CityPopulationCode	:=	[	'A','B','C','D','E','F'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in CityPopulationCode, 1, 0);
	END;
	
  //****************************************************************************
  //fn_numeric_or_blank: 				Returns true if only populated with numbers or 
	//          									blanks, else returns false.
  //****************************************************************************  
	EXPORT fn_numeric_or_blank(STRING s) := FUNCTION
    RETURN if(LENGTH(TRIM(s, ALL)) = 0 or Stringlib.StringFilterOut(s, '0123456789') = '' ,1 ,0);
  END;
			
	//********************************************************************************
	//fn_verify_time_zone_desc:		Returns true if blank or valid time_zone_desc matches the proper code, else 
	//														returns false. 
	//********************************************************************************
	EXPORT fn_verify_time_zone_desc(STRING s) := FUNCTION
		timeZoneDescs := ['EASTERN TIME','CENTRAL TIME','MOUNTAIN TIME','PACIFIC TIME','ALASKA TIME','HAWAII TIME'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in timeZoneDescs, 1, 0);
	END;		
				
	//********************************************************************************
	//fn_verify_city_population_desc:		Returns true if blank or valid city_population_desc matches the proper code, else 
	//														returns false. 
	//********************************************************************************
	EXPORT fn_verify_city_population_desc(STRING s, STRING code) := FUNCTION
	  upperCasecity_population_desc := REGEXREPLACE(',',ut.CleanSpacesAndUpper(s),'');
		string city_population_descToCode := map(upperCasecity_population_desc = 'UP TO 24999'  => 'A',
										 upperCasecity_population_desc = '25000 TO 49999'  => 'B',
										 upperCasecity_population_desc = '50000 TO 99999'  => 'C',
										 upperCasecity_population_desc = '100000 TO 249999'  => 'D',
										 upperCasecity_population_desc = '250000 TO 499999'  => 'E',
										 upperCasecity_population_desc = '500000 OR MORE'  => 'F',
										 s);
		RETURN IF(city_population_descToCode = code, 1, 0);
	END;	
						
	//********************************************************************************
	//fn_verify_standardized_title:		Returns true if blank or valid standardized_title matches the proper code, else 
	//														returns false. 
	//********************************************************************************	
	EXPORT fn_verify_standardized_title(STRING s, STRING code) := FUNCTION
	  upperCasestandardizedTitle := ut.CleanSpacesAndUpper(s);
		string standardizedTitleToCode := map(upperCasestandardizedTitle = 'CHIEF EXECUTIVE OFFICER' => '1',
                                          upperCasestandardizedTitle = 'OWNER' => '2',
                                          upperCasestandardizedTitle = 'CHIEF FINANCIAL OFFICER' => '3',
                                          upperCasestandardizedTitle = 'CHIEF OPERATING OFFICER' => '4',
                                          upperCasestandardizedTitle = 'CHIEF TECHNOLOGY OFFICER/CHIEF INFORMATION OFFICER' => '5',
                                          upperCasestandardizedTitle = 'CHIEF MARKETING OFFICER' => '6',
                                          upperCasestandardizedTitle = 'CHAIRMAN' => '7',
                                          upperCasestandardizedTitle = 'OTHER CHIEF OFFICERS' => '8',
                                          upperCasestandardizedTitle = 'SUPERINTENDENT' => '9',
                                          upperCasestandardizedTitle = 'PRESIDENT' => '10',
                                          upperCasestandardizedTitle = 'EXECUTIVE OFFICER' => '11',
                                          upperCasestandardizedTitle = 'PARTNER' => '12',
                                          upperCasestandardizedTitle = 'CONTROLLER' => '13',
                                          upperCasestandardizedTitle = 'DIRECTOR' => '14',
                                          upperCasestandardizedTitle = 'VICE PRESIDENT' => '15',
                                          upperCasestandardizedTitle = 'PRINCIPAL' => '16',
                                          upperCasestandardizedTitle = 'GENERAL MANAGER' => '17',
                                          upperCasestandardizedTitle = 'RELIGIOUS DIRECTOR' => '18',
                                          upperCasestandardizedTitle = 'ADMINISTRATOR' => '19',
                                          upperCasestandardizedTitle = 'FINANCE EXECUTIVE' => '20',
                                          upperCasestandardizedTitle = 'SALES EXECUTIVE' => '21',
                                          upperCasestandardizedTitle = 'MARKETING EXECUTIVE' => '22',
                                          upperCasestandardizedTitle = 'INFORMATION TECHNOLOGY' => '23',
                                          upperCasestandardizedTitle = 'OPERATIONS EXECUTIVE' => '24',
                                          upperCasestandardizedTitle = 'MANUFACTURING EXECUTIVE' => '25',
                                          upperCasestandardizedTitle = 'HUMAN RESOURCES EXECUTIVE' => '26',
                                          upperCasestandardizedTitle = 'PUBLIC RELATIONS & SOCIAL MEDIA' => '27',
                                          upperCasestandardizedTitle = 'PURCHASING' => '28',
                                          upperCasestandardizedTitle = 'PRINCIPAL - EDUCATION' => '29',
                                          upperCasestandardizedTitle = 'OFFICE MANAGER' => '30',
                                          upperCasestandardizedTitle = 'MANAGER' => '31',
                                          upperCasestandardizedTitle = 'PUBLISHER/EDITOR' => '32',
                                          upperCasestandardizedTitle = 'BOARD MEMBER' => '33',
                                          upperCasestandardizedTitle = 'EDUCATOR' => '34',
                                          upperCasestandardizedTitle = 'ENGINEERING/TECHNICAL' => '35',
                                          upperCasestandardizedTitle = 'STRATEGIC PLANNING & BUSINESS DEVELOPMENT' => '36',
                                          upperCasestandardizedTitle = 'INTERNATIONAL RESPONSIBILITY' => '37',
                                          upperCasestandardizedTitle = 'PROFESSIONAL' => '39',
                                          upperCasestandardizedTitle = 'LIBRARY PROFESSIONAL' => '40',
                                          upperCasestandardizedTitle = 'GOVERNMENT PROFESSIONAL' => '41',
                                          upperCasestandardizedTitle = 'OTHER CONTACTS' => '99',                  
																					upperCasestandardizedTitle = ' ' => '',
										                      s);
		RETURN IF(standardizedTitleToCode = code, 1, 0);
	END;	
							
	//********************************************************************************
	//fn_verify_executive_level:		Returns true if blank or valid executive_level matches the proper code, else 
	//														returns false. 
	//********************************************************************************
	EXPORT fn_verify_executive_level(STRING s) := FUNCTION	 
		executive_level_Desc	:=	['TOP LEVEL EXECUTIVE','OTHER EXECUTIVE','OTHER CONTACT','UNKNOWN','SENIOR LEVEL EXECUTIVE'];
		RETURN IF(ut.CleanSpacesAndUpper(s) in executive_level_desc, 1, 0);
	END;		
	
	//****************************************************************************
	//fn_verify_location_employee_desc:							Returns true if valid location employee desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_location_employee_desc(STRING s, STRING code) := function	
	  upperCase_location_employee_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string location_employee_codeToDesc := map(code = 'A'  => 'UP TO 4',
																							 code = 'B'  => '5 TO 9',
																							 code = 'C'  => '10 TO 19',
																							 code = 'D'  => '20 TO 49',
																							 code = 'E'  => '50 TO 99',
																							 code = 'F'  => '100 TO 249',
																							 code = 'G'  => '250 TO 499',
																							 code = 'H'  => '500 TO 999',
																							 code = 'I'  => '1000 TO 4999',
																							 code = 'J'  => '5000 TO 9999',
																							 code = 'K'  => '10000 OR MORE',
																							 code = 'U'  => 'UNKNOWN',
																							 code = 'P'  => 'PROFESSIONAL',
																							 code);																							 
		RETURN IF(location_employee_codeToDesc = upperCase_location_employee_desc, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_verify_location_sales_desc:							Returns true if valid location sales desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_location_sales_desc(STRING s, STRING code) := function	
	  upperCase_location_sales_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string location_sales_codeToDesc := map(code = 'A'  => 'UP TO $500000',
																						code = 'B'  => '$500000 TO 1 MILLION',
																						code = 'C'  => '$1 TO 2.5 MILLION',
																						code = 'D'  => '$2.5 TO 5 MILLION',
																						code = 'E'  => '$5 TO 10 MILLION',
																						code = 'F'  => '$10 TO 50 MILLION',
																						code = 'G'  => '$50 TO 100 MILLION',
																						code = 'H'  => '$100 TO 500 MILLION',
																						code = 'I'  => '$500 MILLION TO 1 BILLION',
																						code = 'J'  => 'OVER $1 BILLION',
																						code = 'U'  => 'UNKNOWN',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(location_sales_codeToDesc = upperCase_location_sales_desc, 1, 0);	
  END;	

	//****************************************************************************
	//fn_verify_years_in_business_range:							Returns true if valid years_in_business_range,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_years_in_business_range(STRING s) := function	
	  upperCase_years_in_business_range := ['UP TO 2 YEARS','3 TO 5 YEARS','6 TO 9 YEARS','10 OR MORE YEARS'];		
		RETURN IF(ut.CleanSpacesAndUpper(s) in upperCase_years_in_business_range, 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_square_footage_desc:							Returns true if valid square_footage_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_square_footage_desc(STRING s, STRING code) := function	
	  upperCase_square_footage_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string square_footage_codeToDesc := map(code = 'A'  => 'UP TO 999',
																						code = 'B'  => '1000 TO 4999',
																						code = 'C'  => '5000 TO 9999',
																						code = 'D'  => '10000 TO 49999',
																						code = 'E'  => '50000 OR MORE',
																						code);																							 
		RETURN IF(square_footage_codeToDesc = upperCase_square_footage_desc, 1, 0);	
  END;		
	
	//****************************************************************************
	//fn_verify_credit_capacity_desc:							Returns true if valid credit_capacity_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_credit_capacity_desc(STRING s, STRING code) := function	
	  upperCase_credit_capacity_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string credit_capacity_codeToDesc := map(code = 'A'  => 'UP TO $1000',
																						code = 'B'  => '$1000 TO $4999',
																						code = 'C'  => '$5000 TO $9999',
																						code = 'D'  => '$10000 TO $49999',
																						code = 'E'  => '$50000 OR MORE',
																						code = 'F'  => 'NO SUGGESTION',
																						code = 'P'  => 'PROFESSIONAL',
																						code = '' or code = ' ' => '',
																						code);																							 
		RETURN IF(credit_capacity_codeToDesc = upperCase_credit_capacity_desc, 1, 0);	
  END;		
	
	//****************************************************************************
	//fn_verify_credit_desc:							Returns true if valid credit_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_credit_desc(STRING s, STRING code) := function	
	  upperCase_credit_desc := ut.CleanSpacesAndUpper(s);
		string credit_codeToDesc := map(code = 'A+'  => 'EXCELLENT',
																						code = 'A'  => 'EXCELLENT',
																						code = 'B+'  => 'VERY GOOD',
																						code = 'B'  => 'VERY GOOD',
																						code = 'C+'  => 'GOOD',
																						code = 'C'  => 'GOOD',
																						code = 'I'  => 'INSTITUTION',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(credit_codeToDesc = upperCase_credit_desc, 1, 0);	
  END;	

	//****************************************************************************
	//fn_verify_minority_type:							Returns true if valid minority_type,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_minority_type(STRING s) := function	
	  upperCase_minority_type := ['NATIVE AMERICAN','VIETNAMESE','JAPANESE','HISPANIC','CHINESE','INDIAN'];		
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in upperCase_minority_type, 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_number_of_pcs:							Returns true if valid number_of_pcs,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_number_of_pcs(STRING s, STRING code) := function	
	  upperCase_number_of_pcs := ut.CleanSpacesAndUpper(s);
		string number_of_pcsCodeToDesc := map(code = 'A'  => 'UP TO 4',
																						code = 'B'  => '5 TO 9',
																						code = 'C'  => '10 TO 24',
																						code = 'D'  => '25 TO 99',
																						code = 'E'  => '100 TO 499',
																						code = 'F'  => '500 OR MORE',
																						code);																							 
		RETURN IF(number_of_pcsCodeToDesc = upperCase_number_of_pcs, 1, 0);	
  END;	
	
	//****************************************************************************
	//fn_verify_business_status:							Returns true if valid business_status,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_business_status(STRING s, STRING code) := function	
	  upperCase_business_status := ut.CleanSpacesAndUpper(s);
		string business_statusCodeToDesc := map(code = '1'  => 'HEADQUARTERS',
																						code = '2'  => 'BRANCH',
																						code = '3'  => 'SUBSIDIARY',
																						code);																							 
		RETURN IF(business_statusCodeToDesc = upperCase_business_status, 1, 0);	
  END;			
	
	//****************************************************************************
	//fn_verify_advertising_expenses_desc:							Returns true if valid advertising_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_advertising_expenses_desc(STRING s, STRING code) := function	
	  upperCase_advertising_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string advertising_expenses_codeToDesc := map(code = 'A'  => 'UP TO $999',
																						code = 'B'  => '$1000 TO $4999',
																						code = 'C'  => '$5000 TO $14999',
																						code = 'D'  => '$15000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(advertising_expenses_codeToDesc = upperCase_advertising_expenses_desc, 1, 0);	
  END;				
	
	//****************************************************************************
	//fn_verify_technology_expenses_desc:							Returns true if valid technology_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_technology_expenses_desc(STRING s, STRING code) := function	
	  upperCase_technology_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string technology_expenses_codeToDesc := map(code = 'A'  => 'UP TO $2499',
																						code = 'B'  => '$2500 TO $4999',
																						code = 'C'  => '$5000 TO $9999',
																						code = 'D'  => '$10000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(technology_expenses_codeToDesc = upperCase_technology_expenses_desc, 1, 0);	
  END;						
	
	//****************************************************************************
	//fn_verify_office_equipment_expenses_desc:							Returns true if valid office_equipment_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_office_equipment_expenses_desc(STRING s, STRING code) := function	
	  upperCase_office_equipment_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string office_equipment_expenses_codeToDesc := map(code = 'A'  => 'UP TO $1999',
																						code = 'B'  => '$2000 TO $4999',
																						code = 'C'  => '$5000 TO $9999',
																						code = 'D'  => '$10000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(office_equipment_expenses_codeToDesc = upperCase_office_equipment_expenses_desc, 1, 0);	
  END;		
	
	//****************************************************************************
	//fn_verify_rent_expenses_desc:							Returns true if valid rent_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_rent_expenses_desc(STRING s, STRING code) := function	
	  upperCase_rent_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string rent_expenses_codeToDesc := map(code = 'A'  => 'UP TO $2499',
																						code = 'B'  => '$2500 TO $4999',
																						code = 'C'  => '$5000 TO $9999',
																						code = 'D'  => '$10000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(rent_expenses_codeToDesc = upperCase_rent_expenses_desc, 1, 0);	
  END;				
	
	//****************************************************************************
	//fn_verify_telecom_expenses_desc:							Returns true if valid telecom_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_telecom_expenses_desc(STRING s, STRING code) := function	
	  upperCase_telecom_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string telecom_expenses_codeToDesc := map(code = 'A'  => 'UP TO $1999',
																						code = 'B'  => '$2000 TO $4999',
																						code = 'C'  => '$5000 TO $9999',
																						code = 'D'  => '$10000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(telecom_expenses_codeToDesc = upperCase_telecom_expenses_desc, 1, 0);	
  END;				
	
	//****************************************************************************
	//fn_verify_accounting_expenses_desc:							Returns true if valid accounting_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_accounting_expenses_desc(STRING s, STRING code) := function	
	  upperCase_accounting_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string accounting_expenses_codeToDesc := map(code = 'A'  => 'UP TO $999',
																						code = 'B'  => '$1000 TO $2499',
																						code = 'C'  => '$2500 TO $4999',
																						code = 'D'  => '$5000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(accounting_expenses_codeToDesc = upperCase_accounting_expenses_desc, 1, 0);	
  END;					
	
	//****************************************************************************
	//fn_verify_business_insurance_expenses_desc:							Returns true if valid business_insurance_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_business_insurance_expenses_desc(STRING s, STRING code) := function	
	  upperCase_business_insurance_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string business_insurance_expenses_codeToDesc := map(code = 'A'  => 'UP TO $2499',
																						code = 'B'  => '$2500 TO $7499',
																						code = 'C'  => '$7500 TO $19999',
																						code = 'D'  => '$20000 TO $49999',
																						code = 'E'  => '$50000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(business_insurance_expenses_codeToDesc = upperCase_business_insurance_expenses_desc, 1, 0);	
  END;							
	
	//****************************************************************************
	//fn_verify_utilities_expenses_desc:							Returns true if valid utilities_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_utilities_expenses_desc(STRING s, STRING code) := function	
	  upperCase_utilities_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string utilities_expenses_codeToDesc := map(code = 'A'  => 'UP TO $2499',
																						code = 'B'  => '$2500 TO $7499',
																						code = 'C'  => '$7500 TO $19999',
																						code = 'D'  => '$20000 TO $49999',
																						code = 'E'  => '$50000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(utilities_expenses_codeToDesc = upperCase_utilities_expenses_desc, 1, 0);	
  END;									
	
	//****************************************************************************
	//fn_verify_legal_expenses_desc:							Returns true if valid legal_expenses_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_legal_expenses_desc(STRING s, STRING code) := function	
	  upperCase_legal_expenses_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string legal_expenses_codeToDesc := map(code = 'A'  => 'UP TO $2499',
																						code = 'B'  => '$2500 TO $7499',
																						code = 'C'  => '$7500 TO $14999',
																						code = 'D'  => '$15000 TO $24999',
																						code = 'E'  => '$25000 TO $99999',
																						code = 'F'  => '$100000 OR MORE',
																						code = 'P'  => 'PROFESSIONAL',
																						code);																							 
		RETURN IF(legal_expenses_codeToDesc = upperCase_legal_expenses_desc, 1, 0);	
  END;										
	
	//****************************************************************************
	//fn_verify_income_desc:							Returns true if valid income_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_income_desc(STRING s, STRING code) := function	
	  upperCase_income_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string income_codeToDesc := map(code = '1'  => 'UP TO $10000',
																						code = '2'  => '$10000 TO $14999',
																						code = '3'  => '$15000 TO $19999',
																						code = '4'  => '$20000 TO $24999',
																						code = '5'  => '$25000 TO $29999',
																						code = '6'  => '$30000 TO $34999',
																						code = '7'  => '$35000 TO $39999',
																						code = '8'  => '$40000 TO $44999',
																						code = '9'  => '$45000 TO $49999',
																						code = 'A'  => '$50000 TO $54999',
																						code = 'B'  => '$55000 TO $59999',
																						code = 'C'  => '$60000 TO $64999',
																						code = 'D'  => '$65000 TO $74999',
																						code = 'E'  => '$75000 TO $99999',
																						code = 'F'  => '$100000 TO $149999',
																						code = 'G'  => '$150000 TO $174999',
																						code = 'H'  => '$175000 TO $199999',
																						code = 'I'  => '$200000 TO $249999',
																						code = 'J'  => '$250000 TO $499999',
																						code = 'K'  => '$500000 TO $999999',
																						code = 'L'  => '$1000000 TO $1999999',
																						code = 'M'  => '$2000000 TO $4999999',
																						code = 'N'  => 'OVER $5000000',
																						code);																							 
		RETURN IF(income_codeToDesc = upperCase_income_desc, 1, 0);	
  END;														
	
	//****************************************************************************
	//fn_verify_networth_desc:							Returns true if valid networth_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_networth_desc(STRING s, STRING code) := function	
	  upperCase_networth_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string networth_codeToDesc := map(code = 'A'  => 'UP TO $30000',
																						code = 'B'  => '$30001 TO $100000',
																						code = 'C'  => '$100001 TO $500000',
																						code = 'D'  => '$500001 TO $1500000',
																						code = 'E'  => 'OVER $1500000',
																						code);																							 
		RETURN IF(networth_codeToDesc = upperCase_networth_desc, 1, 0);	
  END;														
	
	//****************************************************************************
	//fn_verify_discretionary_income_desc:							Returns true if valid discretionary_income_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_discretionary_income_desc(STRING s, STRING code) := function	
	  upperCase_discretionary_income_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string discretionary_income_codeToDesc := map(code = 'A'  => 'UP TO $9999',
																						code = 'B'  => '$10000 TO $29999',
																						code = 'C'  => '$30000 TO $49999',
																						code = 'D'  => '$50000 TO $69999',
																						code = 'E'  => '$70000 TO $99999',
																						code = 'F'  => '$100000 TO $124999',
																						code = 'G'  => '$125000 TO $149999',
																						code = 'H'  => 'OVER $150000',
																						code);																							 
		RETURN IF(discretionary_income_codeToDesc = upperCase_discretionary_income_desc, 1, 0);	
  END;															
	
	//****************************************************************************
	//fn_verify_unsecured_credit_capacity_desc:							Returns true if valid unsecured_credit_capacity_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_unsecured_credit_capacity_desc(STRING s, STRING code) := function	
	  upperCase_unsecured_credit_capacity_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string unsecured_credit_capacity_codeToDesc := map(code = 'A'  => 'UP TO $4999',
																						code = 'B'  => '$5000 TO $9999',
																						code = 'C'  => '$10000 TO $24999',
																						code = 'D'  => '$25000 TO $49999',
																						code = 'E'  => '$50000 TO $99999',
																						code = 'F'  => 'OVER $100000',
																						code);																							 
		RETURN IF(unsecured_credit_capacity_codeToDesc = upperCase_unsecured_credit_capacity_desc, 1, 0);	
  END;															
	
	//****************************************************************************
	//fn_verify_donor_capacity_desc:							Returns true if valid donor_capacity_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_donor_capacity_desc(STRING s, STRING code) := function	
	  upperCase_donor_capacity_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string donor_capacity_codeToDesc := map(code = 'A'  => 'UP TO $499',
																						code = 'B'  => '$500 TO $999',
																						code = 'C'  => '$1000 TO $2499',
																						code = 'D'  => '$2500 TO $4999',
																						code = 'E'  => 'OVER $5000',
																						code);																							 
		RETURN IF(donor_capacity_codeToDesc = upperCase_donor_capacity_desc, 1, 0);	
  END;	
	
	
	//****************************************************************************
	//fn_verify_home_value_desc:							Returns true if valid home_value_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_home_value_desc(STRING s, STRING code) := function	
	  upperCase_home_value_desc := ut.CleanSpacesAndUpper(REGEXREPLACE(',',s,''));
		string home_value_codeToDesc := map(code = 'A'  => 'UP TO $24999',
																					          	code = 'B'  => '$25000 TO $49999',
																					          	code = 'C'  => '$50000 TO $74999',
																					          	code = 'D'  => '$75000 TO $99999',
																					          	code = 'E'  => '$100000 TO $124999',
																					          	code = 'F'  => '$125000 TO $149999',
																					          	code = 'G'  => '$150000 TO $174999',
																					          	code = 'H'  => '$175000 TO $199999',
																					          	code = 'I'  => '$200000 TO $224999',
																					          	code = 'J'  => '$225000 TO $249999',
																					          	code = 'K'  => '$250000 TO $274999',
																					          	code = 'L'  => '$275000 TO $299999',
																					          	code = 'M'  => '$300000 TO $349999',
																					          	code = 'N'  => '$350000 TO $399999',
																					          	code = 'O'  => '$400000 TO $449999',
																					          	code = 'P'  => '$450000 TO $499999',
																					          	code = 'Q'  => '$500000 TO $749999',
																					          	code = 'R'  => '$750000 TO $999999',
																					          	code = 'S'  => '$1000000 TO $1499999',
																					          	code = 'T'  => '$1500000 TO $2499999',
																					          	code = 'U'  => '$2500000 TO $4999999',
																					          	code = 'V'  => '$5000000 TO $9999999',
																					          	code = 'W'  => 'OVER $10000000',
																											code);																							 
		RETURN IF(home_value_codeToDesc = upperCase_home_value_desc, 1, 0);	
  END;		
	
	//****************************************************************************
	//fn_verify_length_of_residence_desc:							Returns true if valid length_of_residence_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_length_of_residence_desc(STRING s, STRING code) := function	
	  upperCase_length_of_residence_desc := ut.CleanSpacesAndUpper(s);
		string length_of_residence_codeToDesc := map(code = 'A'  => 'LESS THAN 1 YEAR',
																					          	code = 'B'  => '1 TO 2 YEARS',
																					          	code = 'C'  => '3 TO 5 YEARS',
																					          	code = 'D'  => '6 TO 9 YEARS',
																					          	code = 'E'  => '10 TO 14 YEARS',
																					          	code = 'F'  => 'OVER 15 YEARS',
																											code);																							 
		RETURN IF(length_of_residence_codeToDesc = upperCase_length_of_residence_desc, 1, 0);	
  END;	
		
	//****************************************************************************
	//fn_verify_home_square_footage_desc:							Returns true if valid home_square_footage_desc,  
	//														                  else returns false.
	//****************************************************************************
	EXPORT fn_verify_home_square_footage_desc(STRING s) := function	 
	  searchPattern := U8'\\u002A';
		string home_square_footage_codeToDesc := map(s = 'A' => 'LESS THAN 750 FEET',
																								 s = 'B' => '750 - 999 FEET',
																								 s = 'C' => '1000 - 1249 FEET',
																								 s = 'D' => '1250 - 1499 FEET',
																								 s = 'E' => '1500 - 1749 FEET',
																								 s = 'F' => '1750 - 1999 FEET',
																								 s = 'G' => '2000 - 2499 FEET',
																								 s = 'H' => '2500 - 2999 FEET',
																								 s = 'I' => '3000 - 3499 FEET',
																								 s = 'J' => '3500 - 3999 FEET',
																								 s = 'K' => '4000 - 4999 FEET',
																								 s = 'L' => '5000 - 5999 FEET',
																								 s = 'M' => '6000 - 6999 FEET',
																								 s = 'N' => 'GREATER THAN 7000 FEET',	
																								 s = '' or s = ' ' => 'GREATER THAN 7000 FEET',	
																								 '**|'+ s);
		RETURN IF(REGEXFIND(searchPattern,home_square_footage_codeToDesc) = FALSE, 1, 0);
  END;				
		
	END;