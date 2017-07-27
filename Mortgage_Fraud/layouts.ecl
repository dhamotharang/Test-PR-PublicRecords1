IMPORT Mortgage_Fraud, didville, Risk_Indicators;

EXPORT layouts := module;

export MRR_input := record
		Risk_Indicators.Layout_Input  Borrowers_in;
	end;

//=============================================
//===  define all the layouts with 2 borrowers
//=============================================

export Layout_CIID_BtSt_In := record
	Risk_Indicators.Layout_Input Borrower1_In;
	Risk_Indicators.Layout_Input Borrower2_In;
end;

export Layout_CIID_BtSt_Output := record
	risk_indicators.layout_output Borrower1_Output;
	risk_indicators.Layout_output Borrower2_Output;
end;

export Layout_BocaShell_Out := record
	risk_indicators.layout_boca_Shell Borrower1_Boca_out;
	risk_indicators.layout_boca_Shell Borrower2_Boca_Out;            
end;


//===define all of the "common" sections as layouts first and re-use them in other layouts   ===
//=== the following record layouts are for future versions of the Mortgage Shell             ===

 EXPORT common_name_PII := Record
			STRING20 		fname         := '';
			STRING20 		lname         := '';
			STRING10    phone10; 
			STRING9	    ssn;
		  STRING8     dob;
			
 END;
 
 EXPORT common_profess_info := Record
			STRING20 		pr_fname         := '';
			STRING20 		pr_lname         := '';
			STRING10    pr_phone10; 
			STRING9	    pr_license;	
 END;						
 
  EXPORT input_address_section := RECORD 
	    STRING120   streetAddress;
	    STRING25    city;
	    STRING2     state;
	    STRING5     zipCode;
	    STRING25    country;	
	END;		
	
	EXPORT standard_address_section := Record
			STRING10  	prim_range 		:= '';
			STRING2   	predir     		:= '';
			STRING28  	prim_name  		:= '';
			STRING4   	addr_suffix 	:= '';
			STRING2   	postdir     	:= '';
			STRING10  	unit_desig  	:= '';
			STRING8   	sec_range  	 	:= '';
			STRING25  	p_city_name		:= '';
			STRING2   	st          	:= '';
			STRING5   	z5      		  := '';
			STRING4   	zip4        	:= '';
			STRING10    lat           := '';
			STRING11    long          := '';
			STRING3 		county        := '';
			STRING7     geo_blk       := '';
			STRING1     addr_type     := '';
			STRING4     addr_status   := '';
			STRING25    o_country     := '';
	END; 
	
  EXPORT common_DID_lookup_in        := Record
			unsigned2   d_seq;
			UNSIGNED6   this_DID; 
	    common_name_PII                DID_Lookup;
			standard_address_section       DID_Lookup_addr; 
  END;	
	
	EXPORT LIST_of_People              := RECORD
	    DATASET(common_DID_lookup_in)  Lookup_People {MAXCOUNT(Mortgage_Fraud.constants.maxborrowers)};
	END;
	
  EXPORT employment_info             := RECORD 
	   BOOLEAN     self_employed;
		 STRING100   company_name;
		 STRING50    position;   
		 STRING10    business_phone10;
	END;			
	
	EXPORT Professionals_involved      := RECORD
			unsigned2 p_seq;   
			common_profess_info; 
			input_address_section         prf;
			standard_address_section      prf_cln;
	END;
	
  EXPORT Sellers_involved          := RECORD
	    unsigned2   s_seq;	 
	    common_name_PII;
			input_address_section        seller_in;
			standard_address_section     cl_seller_in;
	END;  
	  
 EXPORT Borrowers_involved         := RECORD
      unsigned2   b_seq;
	    UNSIGNED6   DID;
			common_name_PII;
			UNSIGNED3   addr_rentlength;
			input_address_section        borrower_in;
			standard_address_section     cl_borrower_in;
			input_address_section        mail_in;
			input_address_section        prior_in;
			UNSIGNED3   years_of_school;
			STRING1     marital_status;
			UNSIGNED3   dependents;  
			STRING20    dependent_ages;
			STRING10    monthly_income; 
			employment_info             employer;
			input_address_section       empl; 
			standard_address_section    cl_empl;
			employment_info             alt_empl;
			input_address_section       alt_e;
			BOOLEAN     declaration_judgement; 
			BOOLEAN     declaration_bankruptcy7;
			BOOLEAN     declaration_foreclosure7;
			BOOLEAN     declaration_fc_jgt_ever;
			BOOLEAN     declaration_occupancy;
			BOOLEAN     declaration_propertyint;
			unsigned2 score := 0;
	    // unsigned6 hhid := 0;
	    //didville.layout_did_inbatch   borrower_did_inbatch;
	    // didville.layout_best_append   borrower_did_append;
	    // patriot.Layout_PatriotAppend;
	    // didville.layout_lookups;
	    // didville.layout_livingsits;
			
	END;   	
	
	
	EXPORT Loan_application_input := RECORD
      UNSIGNED6   account;
			UNSIGNED4   a_seq;
	    STRING10    application_date;  
	    STRING5     mortgage_type;
	    STRING10    loan_amt;
	    DECIMAL3    interest_rate;
	    UNSIGNED4   loan_length;
	    DECIMAL2    purchase_price;
	    INTEGER     lender_calc_LTV;
	    INTEGER     lender_calc_DTI;
	    input_address_section               sub_prop;
			standard_address_section            sub_prop_clean;  
	    UNSIGNED3   subject_property_units;
	    UNSIGNED4   subject_property_year_built; 
			STRING10    loan_purpose;
			STRING10    dwelling_intention;
			INTEGER     total_monthly_expense_present;
			INTEGER     total_monthly_expense_propose;
			INTEGER     total_assets;
			INTEGER     total_liabilities;
			INTEGER     gross_monthly_income;
	END;
 
 EXPORT Mortgage_Shell_prep := RECORD
      Loan_application_input;
	    DATASET(Borrowers_involved)          borrowers {MAXCOUNT(Mortgage_Fraud.constants.maxborrowers)};
	    DATASET(Sellers_involved)            sellers   {MAXCOUNT(Mortgage_Fraud.constants.maxsellers)}; 
			DATASET(Professionals_involved)      agents    {MAXCOUNT(Mortgage_Fraud.constants.maxprof)};  
	 END; 
	
	// EXPORT Borrower_LookUp := RECORD
	    // Borrowers_involved                    borrower_input_echo;
			// standard_address_section               
		  // BOOLEAN trueDID := false;
		  // unsigned3 historydate := 999999;  
	    // UNSIGNED6 B_DID := 0; 
		  // BOOLEAN fnamepop;  
	// END;  
	
	// EXPORT Borrower_prep := RECORD
	  // DATASET(Borrower_LookUp)              borrower_int_var  {MAXCOUNT(Mortgage_Fraud.constants.maxborrowers)};   
	// END; 
	
		
 END;
