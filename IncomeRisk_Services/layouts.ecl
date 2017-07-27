import business_risk, Models, iesp;
export layouts := module
	
	export biid_output_layout := record
		business_risk.Layout_Final_Denorm - Attributes;
		DATASET(Models.Layout_Model) models;
  end;			
	
	export income_risk_batch_output := record	
	  string30 acctno;
		business_risk.Layout_Final_Denorm - Attributes;			
		string4	  DOBRiskCode;
		string100	DOBRiskCode_Desc;
		string4	  MilesRiskCode;
		string100	MilesRiskCode_Desc;
		string4	  SalaryRiskCode;
		string100	SalaryRiskCode_Desc;
		 
		string11 EmployerTaxId;
		string120 Employer;
		string65 EmployerAddress;
		string25 EmployerCity;
		string2  EmployerState;
		string10 EmployerPostalCode;
		string10 EmployerEstrev;
		string10 EmployerEsTempCount;
		integer  EmploymentMiles;
		string15 PositionPercentile;
		string15 NationalMean;
		string15 NationalMedian;
		string15 NationalHigh;
		string15 NationalLow;
		string20 National90Percentile;
		string20 National75Percentile;
		string20 National25Percentile;
		string20 National10Percentile;
		string20 NationalTotalCompensation;
		string20 NationalStandardError;
		string20 LocalMean;
		string20 LocalMedian;
		string20 LocalHigh;
		string20 LocalLow;
		string20 Local90Percentile;
		string20 Local75Percentile;
		string20 Local25Percentile;
		string20 Local10Percentile;
		string20 LocalTotalCompensation;
		string20 LocalStandardError;
		string20 LocalBonusPercentage;
		string20 LocalBenefitsPercentage;
		string20 SicDescription;
		string10 Authorized;
		string30 JobFamily;
		string20 JobFamilyNationalMax;
		string20 JobFamilyNationalMin;
		string20 JobFamilyLocalMax;
		string20 JobFamilyLocalMin;
		string50 JobTitle;
		string10 PostalCode;
		string50 ErrorMessage;
		string50 ErrorsReported;
		string50 SizeSensitive;
	end;

  // these fields needed to be kept around before and after the ERI
	// gateway call.  the non-address fields in this record used
	// in calculating risk codes against information coming back 
	// from ERI gateway so needed to append them to the output structure
	// of the ERI gateway.  Encapsulating them here in a single layout
	// so as to keep them consistent.
	// the 3 address field comp* below are defined as from the
	// iesp.share.address structure but named differently
	// to keep separate from person information
	export income_risk_fields := record		
		integer  ProfessionalExperience;
		integer  annualIncome; // this is what was input by user
		string11 TaxId;
		string18 comp_County;
		string9  comp_PostalCode;
		string50 comp_StateCityZip;
	end;
	
	export income_risk_batch_input := record	
	  // standard batch input fields.
		unsigned8   seq := 0;
		string20	 	acctno := '';
	
		string20		name_first := '';
		string20		name_middle := '';
		string20		name_last := '';
		string5			name_suffix := '';

    string100   addr1;
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	p_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
		string4   	zip4 := '';

		string12		ssn := '';
		string8			dob := '';
		string10  	homephone := '';
		string16		workphone := '';

		string25		dl:= '';
		string2			dlstate := '';
	  
		//t_Employer - specific to income risk Assessment.
		string50 JobTitle;	
		integer YearsInJob;	
		string120 comp_name;
		string120 DBA;
		string100   comp_addr1;
		string10  	Comp_prim_range := '';
		string2   	comp_predir := '';
		string28  	comp_prim_name := '';
		string4   	comp_addr_suffix := '';		
		string2   	comp_postdir := '';
		string10  	comp_unit_desig := '';
		string8   	comp_sec_range := '';
		string25  	comp_p_city_name := '';
		string2   	comp_st := '';
		string5   	comp_z5 := '';
		string4   	comp_zip4 := '';		
		string10    Company_PhoneNumber;		
		income_risk_fields;
		// integer EstRevenueThousands;
		// integer EstEmployees;
		string2   glb;
		string2   dppa;
		boolean JobMatch;
	  boolean EmployerMatch;
	  string30 SIC;    
	  string30 NAICS;
	  string30 SOC;
		string4		 	max_results := ''; 
		// SIC	 No		Standard Industry Classification Code
		// NAICS No		North American Industry Classification System Code
		// SOC	 No		Standard Occupational Classification Code
	end;
	
  export t_ERISalaryReportRequest_acctno := record
		string30 acctno;
		income_risk_fields;
		iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest;
	end;
	
	export t_ERISalaryReportResponse_acctno := record
	  string30 acctno;
		income_risk_fields;
	  iesp.gateway_eri_salaryreport.t_ERISalaryReportResponse;
  end;   	
	
	export z_input_layout_rec := record
		// most fields in this rec named after this layout business_risk.Layout_Input_Moxie_2
		// in order to make project statement easier.
			string30 acctno;			       							
		  // company fields	 
			string10    phoneNo_company;
			string120   name_company;
			string65	  street_addr;
			string10  	prim_range;
			string2   	predir;
			string28  	prim_name;
			string4   	addr_suffix;
			string2   	postdir;
			string10  	unit_desig;
			string8   	sec_range;
			string25  	p_city_name;
			string2   	st;
			string5   	z5;
			string4   	zip4;
			// these are name fields 
	    string9		  ssn;
			string20		name_Fst_in;
			string20		name_Md_in;
			string20		name_Lst_in;
			string65    street_addr2;
			string10  	prim_range_2;
			string2   	predir_2;
			string28  	prim_name_2;
			string4   	addr_suffix_2;
			string2   	postdir_2;
			string10  	unit_desig_2;
			string8   	sec_range_2;
			string25  	p_city_name_2;
			string2   	st_2;							
			string5     z5_2; // user zip
			string4     zip44_2;
			string8     dob;
			string10    phone_2;
			string3     rep_age;
			string15    dl_number;
			string2     dl_state;							
			string9     fein;
    end;							
end;	