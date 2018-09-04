import BatchServices;

// NOTE: Within this module a certain BatchServices.Workplace_Layouts is used.
//       This is because the BatchServices.WorkPlace_BatchService attributes were 
//       created first, then after that the online Search & Report Services were created.

EXPORT Layouts := MODULE

  // This layout is used for storing the fields needed from the POE key did file
  EXPORT poe_didkey_plus := RECORD
	  BatchServices.WorkPlace_Layouts.poe_didkey_slimmed;
	  BatchServices.WorkPlace_Layouts.addl_info_slimmed;
		// name parts not already on BatchServices.WorkPlace_Layouts.poe_didkey_slimmed
   	string5  name_title	         := '',	
	  string20 middle_name	       := '',	
	  string5  name_suffix         := '',
		// additional fields to be included in the report service results
		string255 company_description        := '';
    string12  parent_company_bdid        := ''; // For internal use only, not be returned to customer
    string120 parent_company_name        := '';
    string120 parent_company_address     := '';		
    string10  parent_company_prim_range  := '',
    string2   parent_company_predir      := '',		
    string28  parent_company_prim_name   := '',
    string4   parent_company_addr_suffix := '',		
    string2   parent_company_postdir     := '',		
    string10  parent_company_unit_desig  := '',
    string8   parent_company_sec_range   := '',		
    string25  parent_company_city        := '';
    string2   parent_company_state       := '';
    string10  parent_company_zip         := '';
		string5   parent_company_zip5        := '';
		string4   parent_company_zip4        := '';
    string10  parent_company_phone       := '';
    string60  parent_company_status      := '';
    string60  prof_license               := ''; 
    string45  prof_license_status        := '';

		// Optional Secretary of State additional info fields
		string350 sos_comp_name         := '';
 		string8   sos_name_as_of_date   := '';
    string30  sos_name_type         := '';
		string10  sos_comp_prim_range   := '',
    string2   sos_comp_predir       := '',		
    string28  sos_comp_prim_name    := '',
    string4   sos_comp_addr_suffix  := '',		
    string2   sos_comp_postdir      := '',		
    string10  sos_comp_unit_desig   := '',
    string8   sos_comp_sec_range    := '',		
    string25  sos_comp_city         := '';
    string2   sos_comp_state        := '';
    string10  sos_comp_zip          := '';
		string5   sos_comp_zip5         := '',
		string4   sos_comp_zip4         := '',
		string60  sos_address_type      := '';
    string413 sos_status            := '';	
		string60  sos_business_type     := '';
		string350 sos_purpose           := '';
		string8   sos_date_incorp       := '';
		string8   sos_filing_date       := '';
		string8   sos_for_incorp_date   := '';
		string60  sos_term              := '';
		string10  sos_igs               := ''; 
		string50  sos_reg_agent_name    := '';
		string10  sos_reg_agent_prim_range  := '',
    string2   sos_reg_agent_predir      := '',		
    string28  sos_reg_agent_prim_name   := '',
    string4   sos_reg_agent_addr_suffix := '',		
    string2   sos_reg_agent_postdir     := '',		
    string10  sos_reg_agent_unit_desig  := '',
    string8   sos_reg_agent_sec_range   := '',		
    string25  sos_reg_agent_city    := '';
    string2   sos_reg_agent_state   := '';
    string10  sos_reg_agent_zip     := '';
		string5   sos_reg_agent_zip5    := '',
		string4   sos_reg_agent_zip4    := '',
		string60  sos_place_incorp      := '';
		string10  sos_fein              := '';
  END;

	export poe_crim_ind :=
  record(poe_didkey_plus)
		boolean hasCriminalConviction := false;
		boolean isSexualOffender := false;		
	end;

	export	PSS_DID_Plus	:=
	record(poe_didkey_plus)
		unsigned4	dt_vendor_last_reported;
	end;
	
	EXPORT Email_Layout:= RECORD
		STRING200 EmailAddress;
		STRING2 EmailSource;
	END;
	
  // This layout is used to slim down the SearchService or ReportService results to 
	// just the source field which will be checked/counted for royalties.
  EXPORT result_sources := RECORD
    string2 source;
  END;

END;