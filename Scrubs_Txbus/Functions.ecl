IMPORT Scrubs_Txbus, Scrubs, ut, Codes,  _validate;
	
EXPORT Functions := MODULE

  //****************************************************************************
  //fn_chk_blanks: returns true if the value is populated
  //****************************************************************************
  EXPORT fn_chk_blanks(STRING name) := FUNCTION
    RETURN IF(LENGTH(TRIM(name, ALL)) > 0, 1, 0);
  END;

  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
	//fn_verify_zip5: returns true or false based upon whether or not there is
	// a 5-digit numeric value.
	//****************************************************************************
	EXPORT fn_verify_zip5(STRING zip5) := function 
		RETURN IF(LENGTH(trim(zip5, all)) = 5 AND Stringlib.StringFilterOut(trim(zip5, all), '0123456789') = '', 1, 0);
	END;

	//****************************************************************************
  //fn_verify_phone:  returns true or false based upon whether it contains an
  //                  empty or valid phone #
  //****************************************************************************
	EXPORT fn_verify_phone(STRING phone) := function    
    clean_phone := TRIM(phone, ALL);
    RETURN IF(clean_phone = '' OR ut.CleanPhone(clean_phone) != '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
		  RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;  
	
	//*******************************************************************************
	//fn_general_date: returns true or false based upon the incoming date.
	//Returns true if it's a valid date
	//*******************************************************************************
	EXPORT fn_general_date(STRING10 sDate) := FUNCTION

		isValidDate := IF(Scrubs.fn_valid_GeneralDate(sDate)>0 ,true ,false);
		RETURN IF(isValidDate, 1, 0);

	END;
		
	//****************************************************************************
	//fn_naics_code: returns true if naics codes are numberic digits in [0,6] length!
	//****************************************************************************
	EXPORT fn_naics_code(STRING naics_cd) := FUNCTION
		RETURN IF(LENGTH(TRIM(naics_cd, ALL))in [0,6] AND
							Stringlib.StringFilterOut(naics_cd, '0123456789') = '' , 1, 0);
	END;
	
	//****************************************************************************
  //fn_check_taxpayer_org_type: 	returns true or false based upon the incoming
  //					                  	code.
  // Taxpayer_Org_Type ():
  // AB:   Texas Business Association           
	// AC:   Foreign Business Association             
	// AF:   Foreign Professional Association
	// AP:   Texas Professional Association  
	// AR:   Other Association               
	// C:    Corporation                     
	// CF:   Foreign Profit Corporation      
	// CI:   Foreign Limited Liability Company - OUT OF STATE      
	// CL:   Texas Limited Liability Company 
	// CM:   Foreign Non-Profit Corp - OUT OF STATE   
	// CN:   Texas Non-Profit Corporation    
	// CP:   Professional Corporation  
	// CR:   Texas Insurance Corporation      
	// CS:   Foreign Insurance Corp - OUT OF STATE    
	// CT:   Texas Profit Corporation         
	// CU:   Foreign Professional Corporation
	// CW:   Texas Railroad Corporation                          
	// CX:   Foreign Railroad Corporation                        
	// ES:   Estate                                              
	// FA:   Financial Institution - State Savings & Loan - OUT OF STATE  
	// FB:   Financial Institution - State Savings Bank - TEXAS    
	// FC:   Financial Institution - Federal Credit Union        
	// FD:   Financial Institution - State Savings & Loan - TEXAS   
	// FE:   Financial Institution - Federal Savings & Loan- TEXAS  
	// FF:   Financial Institution - Federal Bank - TEXAS           
	// FG:   Financial Institution - Federal Savings Bank - TEXAS   
	// FH:   Financial Institution - State Savings Bank - OUT OF STATE    
	// FI:   Financial Institution - State Credit Union - TEXAS     
	// FJ:   Financial Institution - Federal Bank - OUT OF STATE          
	// FK:   Financial Institution - Federal Savings Bank - OUT OF STATE   
	// FL:   Financial Institution - State Limited Bank Association    
	// FM:   Financial Institution - Trust Company               
	// FN:   Financial Institution - Federal Savings & Loan-OUT OF STATE 
	// FO:   Financial Institution - State Bank - OUT OF STATE           
	// FP:   Financial Institution                              
	// FR:   Financial Institution - Foreign Country Bank       
	// FS:   Financial Institution - State Bank - TX            
	// FT:   Financial Institution - State Credit Union - OUT OF STATE    
	// GC:   City                                               
	// GD:   Federal Agency                                     
	// GF:   State Agency - OUT OF STATE                                 
	// GJ:   Junior College                                     
	// GL:   Local Official                                     
	// GM:   Mass Transit                                        
	// GO:   County                                             
	// GP:   Special Purpose District                           
	// GR:   Rapid Transit              
	// GS:   School District             
	// GT:   State Agency - Texas                                                                                                                                                                                                                                                                                                                      
  // GU:   State College/University                                                                                                                                                                                                                                                                                                                  
  // GY:   Community College                                                                                                                                                                                                                                                                                                                         
	// HF:   Foreign Holding Company       
	// IS:   Individual - Sole Owner    
	// J:    Joint Venture              
	// L:    Limited Liability Company
	// M:    Limited Liability Partnership 
	// O:    Other                           
	// P:    General Partnership             
	// PB:   Business General Partnership             
	// PF:   Foreign Liability Partnership           
	// PI:   Individual General Partnership             
	// PL:   Limited Partnership - Texas                
	// PO:   Oil & Gas Special   
	// PR:   Registered Limited Liability Partnership                                                                                                                                                                                                                                                                                                  
  // PS:   Registered Limited Liability Partnership - OUT OF STATE                                                                                                                                                                                                                                                                                   
	// PV:   Texas Joint Venture             
	// PW:   Foreign Joint Venture              
	// PX:   Texas LLP Registration             
	// PY:   Foreign LLP Registration           
	// PZ:   Individual Successor Partnership            
	// S:    Sole Proprietorship             
	// SF:   Foreign Joint Stock Ccompany             
	// ST:   Texas Joint Stock Ccompany            
	// TF:   Foreign Business Trust               
	// TH:   Texas Real Estate Investment Trust                   
	// TI:   Foreign Real Estate Investment Trust 
	// TR:   Trust                                
	// UF:   Unknown - Franchise                  
	// UK:   Unknown
  //****************************************************************************
  EXPORT fn_check_taxpayer_org_type(STRING code) := FUNCTION
	  uc_code := ut.CleanSpacesAndUpper(code);
		isValidCode := CASE(uc_code,
                        'A'  => TRUE,
                        'AB' => TRUE,       
											  'AC' => TRUE,           
											  'AF' => TRUE,
												'AP' => TRUE,  
											  'AR' => TRUE,               
											  'C'  => TRUE,                   
											  'CF' => TRUE,      
											  'CI' => TRUE,      
											  'CL' => TRUE, 
											  'CM' => TRUE,   
											  'CN' => TRUE,    
											  'CP' => TRUE,  
											  'CR' => TRUE,      
											  'CS' => TRUE,    
											  'CT' => TRUE,         
											  'CU' => TRUE,
											  'CW' => TRUE,                          
											  'CX' => TRUE,                        
											  'ES' => TRUE,                                              
											  'FA' => TRUE,  
											  'FB' => TRUE,    
											  'FC' => TRUE,        
											  'FD' => TRUE,   
											  'FE' => TRUE,  
											  'FF' => TRUE,           
											  'FG' => TRUE,   
											  'FH' => TRUE,    
											  'FI' => TRUE,     
											  'FJ' => TRUE,          
											  'FK' => TRUE,   
											  'FL' => TRUE,    
											  'FM' => TRUE,               
											  'FN' => TRUE, 
											  'FO' => TRUE,           
											  'FP' => TRUE,                              
											  'FR' => TRUE,       
											  'FS' => TRUE,            
											  'FT' => TRUE,    
											  'GC' => TRUE,                                               
											  'GD' => TRUE,                                     
										    'GF' => TRUE,                                 
											  'GJ' => TRUE,                                     
											  'GL' => TRUE,                                     
											  'GM' => TRUE,                                        
											  'GO' => TRUE,                                             
											  'GP' => TRUE,                           
											  'GR' => TRUE,              
											  'GS' => TRUE,             
											  'GT' => TRUE,                                                                                                                                                                                                                                                                                                                      
											  'GU' => TRUE,                                                                                                                                                                                                                                                                                                                  
											  'GY' => TRUE,                                                                                                                                                                                                                                                                                                                         
											  'HF' => TRUE,       
											  'IS' => TRUE,    
											  'J'  => TRUE,              
											  'L'  => TRUE,
											  'M'  => TRUE, 
											  'O'  => TRUE,                           
											  'P'  => TRUE,             
											  'PB' => TRUE,             
											  'PF' => TRUE,           
											  'PI' => TRUE,             
											  'PL' => TRUE,                
											  'PO' => TRUE,   
											  'PR' => TRUE,                                                                                                                                                                                                                                                                                                  
											  'PS' => TRUE,                                                                                                                                                                                                                                                                                   
											  'PV' => TRUE,             
											  'PW' => TRUE,              
											  'PX' => TRUE,             
											  'PY' => TRUE,           
											  'PZ' => TRUE,            
											  'S'  => TRUE,             
											  'SF' => TRUE,             
											  'ST' => TRUE,            
											  'TF' => TRUE,               
											  'TH' => TRUE,                   
											  'TI' => TRUE, 
											  'TR' => TRUE,                                
											  'UF' => TRUE,                  
											  'UK' => TRUE,
                        FALSE);
    RETURN IF(isValidCode,1,0);
  END;
END;
