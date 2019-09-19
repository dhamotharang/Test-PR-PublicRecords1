EXPORT layout_UCCLiens_Batch_out := MODULE

export filing_1_rec := RECORD
	STRING25 filing_1_filing_number := '';
	STRING40 filing_1_filing_type := '';
	STRING8  filing_1_filing_date := '';
	STRING8  filing_1_expiration_date := '';
	STRING9  filing_1_contract_type := '';
	STRING17 filing_1_amount := '';
END;

export filing_2_rec := RECORD
	STRING25 filing_2_filing_number := '';
	STRING40 filing_2_filing_type := '';
	STRING8  filing_2_filing_date := '';
	STRING8  filing_2_expiration_date := '';
	STRING9  filing_2_contract_type := '';
	STRING17 filing_2_amount := '';
END;

export filing_3_rec := RECORD
	STRING25 filing_3_filing_number := '';
	STRING40 filing_3_filing_type := '';
	STRING8  filing_3_filing_date := '';
	STRING8  filing_3_expiration_date := '';
	STRING9  filing_3_contract_type := '';
	STRING17 filing_3_amount := '';
END;		

export filing_4_rec := RECORD
	STRING25 filing_4_filing_number := '';
	STRING40 filing_4_filing_type := '';
	STRING8  filing_4_filing_date := '';
	STRING8  filing_4_expiration_date := '';
	STRING9  filing_4_contract_type := '';
	STRING17 filing_4_amount := '';
END;		

export filing_5_rec := RECORD
	STRING25 filing_5_filing_number := '';
	STRING40 filing_5_filing_type := '';
	STRING8  filing_5_filing_date := '';
	STRING8  filing_5_expiration_date := '';
	STRING9  filing_5_contract_type := '';
	STRING17 filing_5_amount := '';
END;			

export filing_6_rec := RECORD
	STRING25 filing_6_filing_number := '';
	STRING40 filing_6_filing_type := '';
	STRING8  filing_6_filing_date := '';
	STRING8  filing_6_expiration_date := '';
	STRING9  filing_6_contract_type := '';
	STRING17 filing_6_amount := '';
END;	


export debtor_1_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_1_party_1_orig_name := '';
	STRING60  debtor_1_party_1_addr_1 := '';
	STRING60  debtor_1_party_1_addr_2 := '';
	STRING30  debtor_1_party_1_v_city_name := '';
	STRING2   debtor_1_party_1_st := '';
	STRING5   debtor_1_party_1_zip := '';
	STRING60  debtor_1_party_2_addr_1 := '';
	STRING60  debtor_1_party_2_addr_2 := '';
	STRING30  debtor_1_party_2_v_city_name := '';
	STRING2   debtor_1_party_2_st := '';
	STRING5   debtor_1_party_2_zip := '';
	UNSIGNED6 debtor_1_party_UltID := 0;
	UNSIGNED6 debtor_1_party_OrgID := 0;
  UNSIGNED6 debtor_1_party_SeleID := 0; 
  UNSIGNED6 debtor_1_party_ProxID := 0;
  UNSIGNED6 debtor_1_party_PowID := 0;
  UNSIGNED6 debtor_1_party_EmpID := 0;
  UNSIGNED6 debtor_1_party_DotID := 0;
END;


export debtor_2_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_2_party_1_orig_name := '';
	STRING60  debtor_2_party_1_addr_1 := '';
	STRING60  debtor_2_party_1_addr_2 := '';
	STRING30  debtor_2_party_1_v_city_name := '';
	STRING2   debtor_2_party_1_st := '';
	STRING5   debtor_2_party_1_zip := '';
	STRING60  debtor_2_party_2_addr_1 := '';
	STRING60  debtor_2_party_2_addr_2 := '';
	STRING30  debtor_2_party_2_v_city_name := '';
	STRING2   debtor_2_party_2_st := '';
	STRING5   debtor_2_party_2_zip := '';
	UNSIGNED6 debtor_2_party_UltID := 0;
	UNSIGNED6 debtor_2_party_OrgID := 0;
  UNSIGNED6 debtor_2_party_SeleID := 0; 
  UNSIGNED6 debtor_2_party_ProxID := 0;
  UNSIGNED6 debtor_2_party_PowID := 0;
  UNSIGNED6 debtor_2_party_EmpID := 0;
  UNSIGNED6 debtor_2_party_DotID := 0;
END;


export debtor_3_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_3_party_1_orig_name := '';
	STRING60  debtor_3_party_1_addr_1 := '';
	STRING60  debtor_3_party_1_addr_2 := '';
	STRING30  debtor_3_party_1_v_city_name := '';
	STRING2   debtor_3_party_1_st := '';
	STRING5   debtor_3_party_1_zip := '';
	STRING60  debtor_3_party_2_addr_1 := '';
	STRING60  debtor_3_party_2_addr_2 := '';
	STRING30  debtor_3_party_2_v_city_name := '';
	STRING2   debtor_3_party_2_st := '';
	STRING5   debtor_3_party_2_zip := '';
	UNSIGNED6 debtor_3_party_UltID := 0;
	UNSIGNED6 debtor_3_party_OrgID := 0;
  UNSIGNED6 debtor_3_party_SeleID := 0; 
  UNSIGNED6 debtor_3_party_ProxID := 0;
  UNSIGNED6 debtor_3_party_PowID := 0;
  UNSIGNED6 debtor_3_party_EmpID := 0;
  UNSIGNED6 debtor_3_party_DotID := 0;
END;

export debtor_4_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_4_party_1_orig_name := '';
	STRING60  debtor_4_party_1_addr_1 := '';
	STRING60  debtor_4_party_1_addr_2 := '';
	STRING30  debtor_4_party_1_v_city_name := '';
	STRING2   debtor_4_party_1_st := '';
	STRING5   debtor_4_party_1_zip := '';
	STRING60  debtor_4_party_2_addr_1 := '';
	STRING60  debtor_4_party_2_addr_2 := '';
	STRING30  debtor_4_party_2_v_city_name := '';
	STRING2   debtor_4_party_2_st := '';
	STRING5   debtor_4_party_2_zip := '';
	UNSIGNED6 debtor_4_party_UltID := 0;
	UNSIGNED6 debtor_4_party_OrgID := 0;
  UNSIGNED6 debtor_4_party_SeleID := 0; 
  UNSIGNED6 debtor_4_party_ProxID := 0;
  UNSIGNED6 debtor_4_party_PowID := 0;
  UNSIGNED6 debtor_4_party_EmpID := 0;
  UNSIGNED6 debtor_4_party_DotID := 0;
END;

export debtor_5_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_5_party_1_orig_name := '';
	STRING60  debtor_5_party_1_addr_1 := '';
	STRING60  debtor_5_party_1_addr_2 := '';
	STRING30  debtor_5_party_1_v_city_name := '';
	STRING2   debtor_5_party_1_st := '';
	STRING5   debtor_5_party_1_zip := '';
	STRING60  debtor_5_party_2_addr_1 := '';
	STRING60  debtor_5_party_2_addr_2 := '';
	STRING30  debtor_5_party_2_v_city_name := '';
	STRING2   debtor_5_party_2_st := '';
	STRING5   debtor_5_party_2_zip := '';
	UNSIGNED6 debtor_5_party_UltID := 0;
	UNSIGNED6 debtor_5_party_OrgID := 0;
  UNSIGNED6 debtor_5_party_SeleID := 0; 
  UNSIGNED6 debtor_5_party_ProxID := 0;
  UNSIGNED6 debtor_5_party_PowID := 0;
  UNSIGNED6 debtor_5_party_EmpID := 0;
  UNSIGNED6 debtor_5_party_DotID := 0;
END;

export debtor_6_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_6_party_1_orig_name := '';
	STRING60  debtor_6_party_1_addr_1 := '';
	STRING60  debtor_6_party_1_addr_2 := '';
	STRING30  debtor_6_party_1_v_city_name := '';
	STRING2   debtor_6_party_1_st := '';
	STRING5   debtor_6_party_1_zip := '';
	STRING60  debtor_6_party_2_addr_1 := '';
	STRING60  debtor_6_party_2_addr_2 := '';
	STRING30  debtor_6_party_2_v_city_name := '';
	STRING2   debtor_6_party_2_st := '';
	STRING5   debtor_6_party_2_zip := '';
	UNSIGNED6 debtor_6_party_UltID := 0;
	UNSIGNED6 debtor_6_party_OrgID := 0;
  UNSIGNED6 debtor_6_party_SeleID := 0; 
  UNSIGNED6 debtor_6_party_ProxID := 0;
  UNSIGNED6 debtor_6_party_PowID := 0;
  UNSIGNED6 debtor_6_party_EmpID := 0;
  UNSIGNED6 debtor_6_party_DotID := 0;
END;


export debtor_7_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_7_party_1_orig_name := '';
	STRING60  debtor_7_party_1_addr_1 := '';
	STRING60  debtor_7_party_1_addr_2 := '';
	STRING30  debtor_7_party_1_v_city_name := '';
	STRING2   debtor_7_party_1_st := '';
	STRING5   debtor_7_party_1_zip := '';
	STRING60  debtor_7_party_2_addr_1 := '';
	STRING60  debtor_7_party_2_addr_2 := '';
	STRING30  debtor_7_party_2_v_city_name := '';
	STRING2   debtor_7_party_2_st := '';
	STRING5   debtor_7_party_2_zip := '';
	UNSIGNED6 debtor_7_party_UltID := 0;
	UNSIGNED6 debtor_7_party_OrgID := 0;
  UNSIGNED6 debtor_7_party_SeleID := 0; 
  UNSIGNED6 debtor_7_party_ProxID := 0;
  UNSIGNED6 debtor_7_party_PowID := 0;
  UNSIGNED6 debtor_7_party_EmpID := 0;
  UNSIGNED6 debtor_7_party_DotID := 0;
END;


export debtor_8_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_8_party_1_orig_name := '';
	STRING60  debtor_8_party_1_addr_1 := '';
	STRING60  debtor_8_party_1_addr_2 := '';
	STRING30  debtor_8_party_1_v_city_name := '';
	STRING2   debtor_8_party_1_st := '';
	STRING5   debtor_8_party_1_zip := '';
	STRING60  debtor_8_party_2_addr_1 := '';
	STRING60  debtor_8_party_2_addr_2 := '';
	STRING30  debtor_8_party_2_v_city_name := '';
	STRING2   debtor_8_party_2_st := '';
	STRING5   debtor_8_party_2_zip := '';
	UNSIGNED6 debtor_8_party_UltID := 0;
	UNSIGNED6 debtor_8_party_OrgID := 0;
  UNSIGNED6 debtor_8_party_SeleID := 0; 
  UNSIGNED6 debtor_8_party_ProxID := 0;
  UNSIGNED6 debtor_8_party_PowID := 0;
  UNSIGNED6 debtor_8_party_EmpID := 0;
  UNSIGNED6 debtor_8_party_DotID := 0;
END;

export debtor_9_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_9_party_1_orig_name := '';
	STRING60  debtor_9_party_1_addr_1 := '';
	STRING60  debtor_9_party_1_addr_2 := '';
	STRING30  debtor_9_party_1_v_city_name := '';
	STRING2   debtor_9_party_1_st := '';
	STRING5   debtor_9_party_1_zip := '';
	STRING60  debtor_9_party_2_addr_1 := '';
	STRING60  debtor_9_party_2_addr_2 := '';
	STRING30  debtor_9_party_2_v_city_name := '';
	STRING2   debtor_9_party_2_st := '';
	STRING5   debtor_9_party_2_zip := '';
	UNSIGNED6 debtor_9_party_UltID := 0;
	UNSIGNED6 debtor_9_party_OrgID := 0;
  UNSIGNED6 debtor_9_party_SeleID := 0; 
  UNSIGNED6 debtor_9_party_ProxID := 0;
  UNSIGNED6 debtor_9_party_PowID := 0;
  UNSIGNED6 debtor_9_party_EmpID := 0;
  UNSIGNED6 debtor_9_party_DotID := 0;
END;

export debtor_10_rec := RECORD
	// Debtor 1
	
	STRING120 debtor_10_party_1_orig_name := '';
	STRING60  debtor_10_party_1_addr_1 := '';
	STRING60  debtor_10_party_1_addr_2 := '';
	STRING30  debtor_10_party_1_v_city_name := '';
	STRING2   debtor_10_party_1_st := '';
	STRING5   debtor_10_party_1_zip := '';
	STRING60  debtor_10_party_2_addr_1 := '';
	STRING60  debtor_10_party_2_addr_2 := '';
	STRING30  debtor_10_party_2_v_city_name := '';
	STRING2   debtor_10_party_2_st := '';
	STRING5   debtor_10_party_2_zip := '';
	UNSIGNED6 debtor_10_party_UltID := 0;
	UNSIGNED6 debtor_10_party_OrgID := 0;
  UNSIGNED6 debtor_10_party_SeleID := 0; 
  UNSIGNED6 debtor_10_party_ProxID := 0;
  UNSIGNED6 debtor_10_party_PowID := 0;
  UNSIGNED6 debtor_10_party_EmpID := 0;
  UNSIGNED6 debtor_10_party_DotID := 0;
END;

  export secured_1_rec := RECORD
		// Secured 1
		
		STRING120 Secured_1_orig_name := '';
		STRING60  Secured_1_addr_1 := '';
		STRING60  Secured_1_addr_2 := '';
		STRING30  Secured_1_v_city_name := '';
		STRING2   Secured_1_st := '';
		STRING5   Secured_1_zip := '';
		UNSIGNED6 Secured_1_UltID := 0;
		UNSIGNED6 Secured_1_OrgID := 0;
		UNSIGNED6 Secured_1_SeleID := 0; 
		UNSIGNED6 Secured_1_ProxID := 0;
		UNSIGNED6 Secured_1_PowID := 0;
		UNSIGNED6 Secured_1_EmpID := 0;
		UNSIGNED6 Secured_1_DotID := 0;
		
	END;	
	
	export secured_2_rec := RECORD
		// Secured 2
		
		STRING120 Secured_2_orig_name := '';
		STRING60  Secured_2_addr_1 := '';
		STRING60  Secured_2_addr_2 := '';
		STRING30  Secured_2_v_city_name := '';
		STRING2   Secured_2_st := '';
		STRING5   Secured_2_zip := '';
		UNSIGNED6 Secured_2_UltID := 0;
		UNSIGNED6 Secured_2_OrgID := 0;
		UNSIGNED6 Secured_2_SeleID := 0; 
		UNSIGNED6 Secured_2_ProxID := 0;
		UNSIGNED6 Secured_2_PowID := 0;
		UNSIGNED6 Secured_2_EmpID := 0;
		UNSIGNED6 Secured_2_DotID := 0;
  END;
	
	export secured_3_rec := RECORD
		// Secured 3
		
		STRING120 Secured_3_orig_name := '';
		STRING60  Secured_3_addr_1 := '';
		STRING60  Secured_3_addr_2 := '';
		STRING30  Secured_3_v_city_name := '';
		STRING2   Secured_3_st := '';
		STRING5   Secured_3_zip := '';
		UNSIGNED6 Secured_3_UltID := 0;
		UNSIGNED6 Secured_3_OrgID := 0;
		UNSIGNED6 Secured_3_SeleID := 0; 
		UNSIGNED6 Secured_3_ProxID := 0;
		UNSIGNED6 Secured_3_PowID := 0;
		UNSIGNED6 Secured_3_EmpID := 0;
		UNSIGNED6 Secured_3_DotID := 0;
	END;	
	
	export secured_4_rec := RECORD
		// Secured 4
		
		STRING120 Secured_4_orig_name := '';
		STRING60  Secured_4_addr_1 := '';
		STRING60  Secured_4_addr_2 := '';
		STRING30  Secured_4_v_city_name := '';
		STRING2   Secured_4_st := '';
		STRING5   Secured_4_zip := '';
		UNSIGNED6 Secured_4_UltID := 0;
		UNSIGNED6 Secured_4_OrgID := 0;
		UNSIGNED6 Secured_4_SeleID := 0; 
		UNSIGNED6 Secured_4_ProxID := 0;
		UNSIGNED6 Secured_4_PowID := 0;
		UNSIGNED6 Secured_4_EmpID := 0;
		UNSIGNED6 Secured_4_DotID := 0;
	END;	
		
	export secured_5_rec := RECORD
		// Secured 5
	
		STRING120 Secured_5_orig_name := '';
		STRING60  Secured_5_addr_1 := '';
		STRING60  Secured_5_addr_2 := '';
		STRING30  Secured_5_v_city_name := '';
		STRING2   Secured_5_st := '';
		STRING5   Secured_5_zip := '';
		UNSIGNED6 Secured_5_UltID := 0;
		UNSIGNED6 Secured_5_OrgID := 0;
		UNSIGNED6 Secured_5_SeleID := 0; 
		UNSIGNED6 Secured_5_ProxID := 0;
		UNSIGNED6 Secured_5_PowID := 0;
		UNSIGNED6 Secured_5_EmpID := 0;
		UNSIGNED6 Secured_5_DotID := 0;
 END;
EXPORT assignee_1_rec := RECORD 
	// Assignee 1
	
	STRING120 assignee_1_orig_name := '';
	STRING60  assignee_1_addr_1 := '';
	STRING60  assignee_1_addr_2 := '';
	STRING30  assignee_1_v_city_name := '';
	STRING2   assignee_1_st := '';
	STRING5   assignee_1_zip := '';
	UNSIGNED6 assignee_1_UltID := 0;
	UNSIGNED6 assignee_1_OrgID := 0;
	UNSIGNED6 assignee_1_SeleID := 0; 
	UNSIGNED6 assignee_1_ProxID := 0;
	UNSIGNED6 assignee_1_PowID := 0;
	UNSIGNED6 assignee_1_EmpID := 0;
	UNSIGNED6 assignee_1_DotID := 0;
END;	
EXPORT assignee_2_rec := RECORD 
	// Assignee 2
	
	STRING120 assignee_2_orig_name := '';
	STRING60  assignee_2_addr_1 := '';
	STRING60  assignee_2_addr_2 := '';
	STRING30  assignee_2_v_city_name := '';
	STRING2   assignee_2_st := '';
	STRING5   assignee_2_zip := '';
	UNSIGNED6 assignee_2_UltID := 0;
	UNSIGNED6 assignee_2_OrgID := 0;
	UNSIGNED6 assignee_2_SeleID := 0; 
	UNSIGNED6 assignee_2_ProxID := 0;
	UNSIGNED6 assignee_2_PowID := 0;
	UNSIGNED6 assignee_2_EmpID := 0;
	UNSIGNED6 assignee_2_DotID := 0;
END;	
EXPORT assignee_3_rec := RECORD 	
	// Assignee 3
	
	STRING120 assignee_3_orig_name := '';
	STRING60  assignee_3_addr_1 := '';
	STRING60  assignee_3_addr_2 := '';
	STRING30  assignee_3_v_city_name := '';
	STRING2   assignee_3_st := '';
	STRING5   assignee_3_zip := '';
	UNSIGNED6 assignee_3_UltID := 0;
	UNSIGNED6 assignee_3_OrgID := 0;
	UNSIGNED6 assignee_3_SeleID := 0; 
	UNSIGNED6 assignee_3_ProxID := 0;
	UNSIGNED6 assignee_3_PowID := 0;
	UNSIGNED6 assignee_3_EmpID := 0;
	UNSIGNED6 assignee_3_DotID := 0;
END;
EXPORT assignee_4_rec := RECORD 	
	// Assignee 4
	
	STRING120 assignee_4_orig_name := '';
	STRING60  assignee_4_addr_1 := '';
	STRING60  assignee_4_addr_2 := '';
	STRING30  assignee_4_v_city_name := '';
	STRING2   assignee_4_st := '';
	STRING5   assignee_4_zip := '';
	UNSIGNED6 assignee_4_UltID := 0;
	UNSIGNED6 assignee_4_OrgID := 0;
	UNSIGNED6 assignee_4_SeleID := 0; 
	UNSIGNED6 assignee_4_ProxID := 0;
	UNSIGNED6 assignee_4_PowID := 0;
	UNSIGNED6 assignee_4_EmpID := 0;
	UNSIGNED6 assignee_4_DotID := 0;
END;
EXPORT assignee_5_rec := RECORD 	
	// Assignee 5
	
	STRING120 assignee_5_orig_name := '';
	STRING60  assignee_5_addr_1 := '';
	STRING60  assignee_5_addr_2 := '';
	STRING30  assignee_5_v_city_name := '';
	STRING2   assignee_5_st := '';
	STRING5   assignee_5_zip := '';
	UNSIGNED6 assignee_5_UltID := 0;
	UNSIGNED6 assignee_5_OrgID := 0;
	UNSIGNED6 assignee_5_SeleID := 0; 
	UNSIGNED6 assignee_5_ProxID := 0;
	UNSIGNED6 assignee_5_PowID := 0;
	UNSIGNED6 assignee_5_EmpID := 0;
	UNSIGNED6 assignee_5_DotID := 0;
END;
EXPORT final_out := RECORD

	STRING30 acctno                     := '';
	STRING50 TMSID := '';
	STRING50 RMSID := '';
	
// Core section:

	STRING3  filing_jurisdiction := '';
	STRING25 filing_jurisdiction_name := '';
	STRING25 orig_filing_number := '';
	STRING40 orig_filing_type := '';
	STRING8  orig_filing_date := '';
	STRING8  filing_status := '';         
	STRING20 filing_status_desc := '';    
	STRING4  total_debtors_count := '';   
	STRING4  total_secureds_count := '';  
	STRING4  total_assignees_count := ''; 

// ***** FILINGS (6 most recent Filings, sorted by filing_date descending) *****

  filing_1_rec;
  filing_2_rec;
  filing_3_rec;
  filing_4_rec;
  filing_5_rec;
  filing_6_rec;
	
	
	
// ***** DEBTORS (10) *****
  debtor_1_rec;
  debtor_2_rec;
  debtor_3_rec;
  debtor_4_rec;
  debtor_5_rec;
  debtor_6_rec;
  debtor_7_rec;
  debtor_8_rec;
  debtor_9_rec;
  debtor_10_rec;

	

// ***** SECUREDS (5) *****
  secured_1_rec;
  secured_2_rec;
  secured_3_rec;
  secured_4_rec;
  secured_5_rec;
// ***** ASSIGNEES (5) *****
  assignee_1_rec;
  assignee_2_rec;
  assignee_3_rec;
  assignee_4_rec;
  assignee_5_rec;

// ***** FILING OFFICE (1) *****

	STRING120 filing_agency := '';
	STRING64  address := '';
	STRING30  city := '';
	STRING2   state := '';
	STRING30  county := '';
	STRING9   zip := '';
	
// A description of the collateralÃ‚â€”up to 512 characters
	STRING512 collateral_desc := '';
	STRING9   borough := '';
 
END;

END;