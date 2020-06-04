IMPORT ut, Scrubs, Codes, std;

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
		MailScoreSet	:=	['M1','P1','B1','P2A','P2B','P3','M2A','4'];
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
	//fn_naics:										Returns true if blank, 6-digit, or 7-digit 
	//														value, else returns false.
	//****************************************************************************
	EXPORT fn_naics(STRING s) := function    
	  RETURN IF((s = '' or LENGTH(s) in [6,7]) AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
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
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in SqFtSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_credit_code:							Returns true if valid credit code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_credit_code(STRING s) := function    
		CreditSet	:=	['A+','A','B+','B','C+','C','D','U','I','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in CreditSet, 1, 0);
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
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in AdvertisingSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_technology_code:					Returns true if valid technology code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_technology_code(STRING s) := function    
		TechSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in TechSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_office_equip_code:				Returns true if valid office equipment code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_office_equip_code(STRING s) := function    
		OfficeSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in OfficeSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_rent_code:								Returns true if valid rent expense code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_rent_code(STRING s) := function    
		RentSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in RentSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_telecom_code:						Returns true if valid telecom expense code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_telecom_code(STRING s) := function    
		TelecomSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in TelecomSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_accounting_code:					Returns true if valid accounting expense code,   
	//														else returns false.
	//****************************************************************************
	EXPORT fn_accounting_code(STRING s) := function    
		AccountSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in AccountSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_bus_insurance_code:			Returns true if valid business insurance 
	//														expense code, else returns false.
	//****************************************************************************
	EXPORT fn_bus_insurance_code(STRING s) := function    
		BusInsSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in BusInsSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_legal_code:							Returns true if valid legal expense code, else  
	//														returns false.
	//****************************************************************************
	EXPORT fn_legal_code(STRING s) := function    
		LegalSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in LegalSet, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_utilities_code:					Returns true if valid utility expense code,
	//														else returns false.
	//****************************************************************************
	EXPORT fn_utilities_code(STRING s) := function    
		UtilSet	:=	['A','B','C','D','E','F','P'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in UtilSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_number_of_pcs_code:			Returns true if valid number of PCs code,
	//														else returns false.
	//****************************************************************************
	EXPORT fn_number_of_pcs_code(STRING s) := function    
		PCSet	:=	['A','B','C','D','E','F'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in PCSet, 1, 0);
	END;
	
	//****************************************************************************
	//fn_ethnic_code:							Returns true if valid ethnic code,
	//														else returns false.
	//****************************************************************************
	EXPORT fn_ethnic_code(STRING s) := function    	
		EthnicCode	:=	[	'A1','A2','A3','A4','A5','D1','D2','D3','D4','D5','E1','E2','E3',
											'E4','E5','F1','F2','F3','F4','F5','I1','I2','I3','I4','I5','S1',
											'S2','S3','S4','S5','U1','U2','U3','U4','U5','UC','W1','W2','W3',
											'W4','W5','7B','7C','7D','7E','7F','7G','7H','7M','7N','8A','8B',
											'8C','8D','8E','8F','8G','8H','8I','8J','8K','8L','8M','8N','8O',
											'8P','8Q','8R','8S','8T','8U','8V','8W','8X','8Y','9A','9B','9C',
											'9D','9E','9F','9G','9H','9I','9J','9K','9L','9M','9N','9O','9P',
											'9Q','9R','9S','9T','9U','9V','9W','9X','9Y','9Z','01','02','03',
											'04','05','06','07','08','09','10','11','12','13','14','15','16',
											'17','18','19','20','21','22','23','24','25','26','27','28','29',
											'30','31','32','33','34','35','36','37','38','39','40','41','42',
											'43','44','45','46','47','48','49','50','51','52','53','55','56',
											'57','58','59','60','61','62','63','64','65','66','67','68','70',
											'71','72','73','74','75','76','77','78','79','80','81','82','83',
											'84','85','86','87','88','89','90','91','92','93','94','95','96',
											'97','98','99','00']; 
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in EthnicCode, 1, 0);
	END;

	//****************************************************************************
	//fn_religious_affil:					Returns true if valid religious affiliation 
	//														code, else returns false.
	//****************************************************************************
	EXPORT fn_religious_affil(STRING s) := function 
		ReligiousCode	:=	[	'B','C','E','G','H','I','J','K','L','M','O','P','S','X'];  
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in ReligiousCode, 1, 0);
	END;
	
	
	//****************************************************************************
	//fn_language:								Returns true if blank or valid language code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_language(STRING s) := function 	
		LanguageCode	:=	[	'01','03','04','05','06','07','08','09','10','12','13','14','17','19','20',
												'21','22','23','24','25','27','29','30','31','32','33','34','35','36','37',
												'38','40','41','44','45','46','47','48','49','50','51','52','53','54','56',
												'57','58','59','60','61','62','63','64','65','68','70','72','73','74','7A',
												'7E','7F','80','86','88','8G','8I','8J','8K','8M','92','8O','8S','8T','8X',
												'92','94','95','97','9E','9F','9J','9K','9L','9N','9O','9R','9S','9X','7H',
												'00']; 
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in LanguageCode, 1, 0);
	END;	
	
	//****************************************************************************
	//fn_time_zone:								Returns true if valid time zone code, else 
	//														returns false.
	//****************************************************************************
	EXPORT fn_time_zone(STRING s) := function 
		TimeZoneCode	:=	[	'A','C','E','H','M','P'];
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
		DonorCode	:=	[	'A','B','C','D'];
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
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in IncomeCode, 1, 0);
	END;

	//****************************************************************************
	//fn_unsec_cap:								Returns true if valid unsecured capacity code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_unsec_cap(STRING s) := function 
		UnsecCapCode	:=	[	'A','B','C','D'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in UnsecCapCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_net_worth:								Returns true if valid net worth code,  
	//														else returns false.
	//****************************************************************************
	EXPORT fn_net_worth(STRING s) := function 
		NetWorthCode	:=	[	'A','B','C','D','E'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in NetWorthCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_discret_income:					Returns true if valid discretionary income  
	//														code, else returns false.
	//****************************************************************************
	EXPORT fn_discret_income(STRING s) := function 
		DiscIncomeCode	:=	[	'A','B','C','D'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in DiscIncomeCode, 1, 0);
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
		TeenDriverCode	:=	['A','B'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in TeenDriverCode, 1, 0);
	END;
	
	//****************************************************************************
	//fn_home_sqft_ranges:				Returns true if valid marital status code,  
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
		EducationCode	:=	[	'1','2','3','4'];
		RETURN IF(ut.CleanSpacesAndUpper(s) = '' or ut.CleanSpacesAndUpper(s) in EducationCode, 1, 0);
	END;
	
  //****************************************************************************
  //fn_numeric_or_blank: 				Returns true if only populated with numbers or 
	//          									blanks, else returns false.
  //****************************************************************************  
	EXPORT fn_numeric_or_blank(STRING s) := FUNCTION
    RETURN if(LENGTH(TRIM(s, ALL)) = 0 or Stringlib.StringFilterOut(s, '0123456789') = '' ,1 ,0);
  END;

END;