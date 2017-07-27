EXPORT layout_FAB_Statewide_out := RECORD

		STRING20  source_doc_type := '';
		unsigned2	penalt          := 0;		
		boolean   isDeepDive      := false;
		STRING3   jurisdiction    := '';
		STRING62  record_id       := '';
		unsigned6 id              := 0;
		STRING120 full_name       := '';		
		STRING120 company_name    := '';		
		
		// Name Info:
		String30 fname          := '';
		String30 mname          := '';
		String30 lname          := '';
	
		
		// Address info:
		STRING10  prim_range    := '';
		STRING2   predir        := '';
		STRING28  prim_name     := '';
		STRING4   addr_suffix   := '';
		STRING2   postdir       := '';
		STRING8   unit_desig    := ''; 
		STRING8   sec_range     := '';
		STRING25  v_city_name   := '';
		STRING25  p_city_name   := '';
		STRING2   st            := '';
		STRING5   zip5          := '';
		STRING4   zip4          := '';

		STRING10  phone           := '';
		STRING9   ssn             := '';
		STRING9   fein            := '';
		STRING8   dob             := '';	
		BOOLEAN   is_bdid         := FALSE;
    // NOTE: The following 5 hf_* (Hunting_Fishing license) fields are used in the 
		// FAP SearchService not the FAB SearchService.  
		// However they were added here since this is really a common interim layout used 
		// in multiple FAB_Statewide, FAP_Statewide & Statewide_Services attributes.
		// They will be stripped off in Statewide_Services.FAB_SearchService.
	  STRING15  hf_lic_num      := '';
	  STRING8   hf_lic_date     := '';
	  STRING20  hf_lic_type     := '';
	  STRING20  hf_lic_st       := '';
	  STRING20  hf_home_st      := '';
END;
