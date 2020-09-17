IMPORT Scrubs_OSHAIR, Scrubs, ut, Codes;
	
EXPORT Functions := MODULE	

	//****************************************************************************
	//fn_adv_notice:  returns true if valid advance notice code 
	//****************************************************************************
	EXPORT fn_adv_notice(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'NY') = '' ,1 ,0);
	END;

	//********************************************************************************
	//fn_alpha_blank:  returns true if all the characters are alpha, blank or &
	//********************************************************************************
	EXPORT fn_alpha_blank(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, ' &ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '', 1, 0);
  END;

	//********************************************************************************
	//fn_const_end_use:  returns true if a valid code, else returns false
	//********************************************************************************
	EXPORT fn_const_end_use(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, 'ABCDEFGHIJKLMNOPQ') = '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_dash_numeric:  returns true if the field contains dashes or numeric values
	//****************************************************************************
	EXPORT fn_dash_numeric(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, '-0123456789') = '' ,1 ,0);
	END;	

	//*******************************************************************************
  //fn_date_ccyymm: 	Returns true if valid CCYYMM or blank
  //*******************************************************************************
  EXPORT fn_date_ccyymm(STRING sDate) := FUNCTION
    ccyy := sDate[1..4];
		mm   := sDate[6..7];
		clean_date := ccyy + mm;
    isValidDate := IF(LENGTH(trim(clean_date)) = 6, Scrubs.fn_valid_pastDate(clean_date+'01') > 0, FALSE);
    RETURN IF(isValidDate or LENGTH(trim(sDate)) = 0, 1, 0);
  END;

	//*******************************************************************************
  //fn_date_time: 	returns true if valid past date, else false
  //*******************************************************************************
  EXPORT fn_date_time(STRING sDate, STRING DateType = '') := FUNCTION
    ccyy := sDate[1..4];
		mm   := sDate[6..7];
		dd   := sDate[9..10];
		clean_date := if (trim(dd)='',ccyy + mm + '01',ccyy + mm + dd);
		isValidDate := IF(LENGTH(clean_date) >= 8 and DateType = '', 
												Scrubs.fn_valid_pastDate(clean_date) > 0, 
												IF(LENGTH(clean_date) >= 8 and DateType = 'FUTURE',
															Scrubs.fn_valid_Date(clean_date,DateType) > 0, 
															FALSE
													 )
											);
    RETURN IF(isValidDate or LENGTH(trim(sDate)) = 0, 1, 0);
  END;
	
	//****************************************************************************
	//fn_degree_inj:  returns true if valid degree of injury code 
	//****************************************************************************
	EXPORT fn_degree_inj(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, ' 0123') = '' ,1 ,0);
	END;		
	
	//*******************************************************************************
  //fn_dt_yy: 	Returns true if valid year
  //*******************************************************************************
  EXPORT fn_dt_yy(STRING sDate) := FUNCTION
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 4, Scrubs.fn_valid_pastDate(clean_date+'0101') > 0, FALSE);
    RETURN IF(isValidDate or LENGTH(clean_date) = 0, 1, 0);
  END;
	
  //****************************************************************************
  //fn_fatality:  returns true if valid fatality code 
  //****************************************************************************
	EXPORT fn_fatality(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'X') = '' ,1 ,0);
	END;	
	
	//****************************************************************************
	//fn_host_est_key:  returns true if the host est key code is valid 
	//****************************************************************************
	EXPORT fn_host_est_key(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_') = '' ,1 ,0);
	END;	
	
	//****************************************************************************
	//fn_insp_scope:  returns true if valid inspection scope code 
	//****************************************************************************
	EXPORT fn_insp_scope(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'ABCD') = '' ,1 ,0);
	END;	
	
	//****************************************************************************
	//fn_insp_type:  returns true if valid inspection type code 
	//****************************************************************************
	EXPORT fn_insp_type(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'ABCDEFGHIJKLM') = '' ,1 ,0);
	END;
	
  //****************************************************************************
  //fn_numeric_or_blank: 	returns true if only populated with numbers or blanks
  //****************************************************************************  
	EXPORT fn_numeric_or_blank(STRING nmbr) := FUNCTION
    RETURN if(Stringlib.StringFilterOut(nmbr, ' 0123456789') = '' ,1 ,0);
  END;
	
  //****************************************************************************
  //fn_numeric_or_comma: 	returns true if only populated with numbers or commas
  //****************************************************************************  
	EXPORT fn_numeric_or_comma(STRING nmbr) := FUNCTION
    RETURN if(Stringlib.StringFilterOut(nmbr, ',0123456789') = '' ,1 ,0);
  END;

  //****************************************************************************
  //fn_numeric_or_period: 	returns true if only populated with numbers or periods
  //****************************************************************************  
	EXPORT fn_numeric_or_period(STRING nmbr) := FUNCTION
    RETURN if(Stringlib.StringFilterOut(nmbr, '.0123456789') = '' ,1 ,0);
  END;	
	
	//****************************************************************************
	//fn_owner_code:  returns true if valid owner type code 
	//****************************************************************************
	EXPORT fn_owner_code(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'ABCD') = '' ,1 ,0);
	END;	
	
	//****************************************************************************
	//fn_owner_type:  returns true if valid owner type code 
	//****************************************************************************
	EXPORT fn_owner_type(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'ABCD') = '' ,1 ,0);
	END;	
	
	//********************************************************************************
	//fn_project_cost:  returns true if a valid code, else returns false
	//********************************************************************************
	EXPORT fn_project_cost(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, 'ABCDEFG') = '', 1, 0);
  END;
	
	//********************************************************************************
	//fn_project_type:  returns true if a valid code, else returns false
	//********************************************************************************
	EXPORT fn_project_type(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, 'ABCDE') = '', 1, 0);
  END;
	
	//****************************************************************************
	//fn_safety_hlth:  returns true if valid safety health code 
	//****************************************************************************
	EXPORT fn_safety_hlth(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'HS') = '' ,1 ,0);
	END;	
	
	//****************************************************************************
	//fn_sex_code:  returns true if valid sex code 
	//****************************************************************************
	EXPORT fn_sex_code(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'FM') = '' ,1 ,0);
	END;	
	
  //****************************************************************************
	//fn_state_flag:  returns true if valid state flag code 
	//****************************************************************************
	EXPORT fn_state_flag(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, 'Ss') = '' ,1 ,0);
	END;
		
	//****************************************************************************
	//fn_task_assigned:  returns true if valid task assigned code 
	//****************************************************************************
	EXPORT fn_task_assigned(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, '012') = '' ,1 ,0);
	END;
	
	//****************************************************************************
	//fn_union_status:  returns true if valid union status code 
	//****************************************************************************
	EXPORT fn_union_status(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, ' AaBbNnUuYy') = '' ,1 ,0);
	END;	
	
  //****************************************************************************
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation. A blank state is also allowed.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
	  RETURN IF(LENGTH(Codes.St2Name(code)) > 0 or length(TRIM(code, ALL))=0, 1, 0);
  END;
	
	//****************************************************************************
	//fn_why_no_insp:  returns true if valid why_no_insp code 
	//****************************************************************************
	EXPORT fn_why_no_insp(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, ' ABCDEFGHIJ') = '' ,1 ,0);
	END;
		
	//****************************************************************************
	//fn_X_blank:  returns true if code is a X or blank 
	//****************************************************************************
	EXPORT fn_X_blank(STRING code) := function    
	  RETURN IF(Stringlib.StringFilterOut(code, ' X') = '' ,1 ,0);
	END;

end;