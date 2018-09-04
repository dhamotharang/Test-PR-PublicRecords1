import gong, iesp;

EXPORT WorkPlace_Layouts := MODULE

  // This layout is used for "looking up" dids in the POE did key file. 
	EXPORT POE_lookup := RECORD
		string20   acctno           := '';  
    unsigned6  lookupDid        := 0;
		unsigned6  subjectDid       := 0;
		unsigned6  spouseDid        := 0;
    string1    spouse_indicator := '';
	END;

  // This layout is used when getting the spouse did associated with a did
	EXPORT subjectSpouse := RECORD
		string20   acctno    := '';  
    unsigned6  did       := 0;
		unsigned6  spouseDid := 0;
	END;
	
	EXPORT Email_Info := RECORD
		string200 email1;
		string200 email2;
		string200 email3;
		STRING2 email_src1;
		STRING2 email_src2;
		STRING2 email_src3;
		string200 spouse_email1;
		string200 spouse_email2;
		string200 spouse_email3;
		STRING2 spouse_email_src1;
		STRING2 spouse_email_src2;
		STRING2 spouse_email_src3;	
	END;
	
  // When online WorkPlace search is created, revise this layout to use the same layout for the
	// batch service and all the needed online search service result fields (names, co addr, etc.)?
  EXPORT poe_didkey_slimmed := RECORD
    // The 6 fields below are not on the POE did key, 
		// but are needed to assist in internal processing
    string20   acctno             := '';
    unsigned1  source_order; // high value default in case source not found when do key lookup (default value is defined in BatchServices.WorkPlace_Constants.DEFAULT_SOURCE_ORDER)
    string1    spouse_indicator   := '';
	  string10   company_phone2     := '';    // phone# for the company from EDA/gong data
		string30   corp_key           := '';    // needed for corp data lookup
		string60   company_status     := '';    // needed when looking up corp status
		boolean    from_gong          := false; 
		// The rest of the fields below are the fields from the POE Did Key file that
		// are needed to determine the most complete/most current candidate records from 
		// all sources or fields used for other internal processing.
		// See POE.Layouts.Keybuild for POE Did key full layout. 
		string2    source              := '';
		unsigned4  dt_first_seen       :=  0;
		unsigned4  dt_last_seen		     :=  0;
    unsigned6  did                 :=  0;
		string20   subject_first_name  := '';
		string20   subject_last_name   := '';
		string9    subject_ssn			   := ''; // needed for gateway lookup
    unsigned6  bdid                :=  0;
    string120  company_name        := '';
		// company address fields stored in case there is no company name or addresss in the
		// poe data and the phone# is used to look up company info on the gong history file.
		string70   company_address     := '';
		string10   company_prim_range  := '',
		string2    company_predir      := '',		
		string28   company_prim_name   := '',
		string4    company_addr_suffix := '',		
		string2    company_postdir     := '',		
		string10   company_unit_desig  := '',
		string8    company_sec_range   := '',
		string5    company_zip5        := '',
		string4    company_zip4        := '',
    string25   company_city        := '';
    string2    company_state       := '';
    string10   company_zip         := '';
    string10   company_phone1      := ''; // Work/Company phone# from vendor data if present
		unsigned4  company_fein			   :=  0; // needed for self employed check
		BOOLEAN from_PAW := FALSE;
		Email_Info;
  END;

	// PSS slimmed layout
	export	PSS_DIDKey_Slimmed	:=
	record(POE_DIDKey_Slimmed)
		unsigned4	dt_vendor_last_reported;
	end;

	// This layout is used when getting the corp status
  EXPORT bdids_corpstat := RECORD
    unsigned6  bdid                 :=  0;
		string30 corp_key               := ''; 
    string60 corp_status_desc       := '';
    string8	 corp_status_date       := '';
    // Extra sos fields needed for the online Workplace_Services.ReportService
		string350 sos_comp_name         := '';
 		string8   sos_name_as_of_date   := '';
    string30  sos_name_type         := '';
		//string70  sos_comp_address      := ''; ???
		string10  sos_comp_prim_range   := '',
    string2   sos_comp_predir       := '',		
    string28  sos_comp_prim_name    := '',
    string4   sos_comp_addr_suffix  := '',		
    string2   sos_comp_postdir      := '',		
    string10  sos_comp_unit_desig   := '',
    string8   sos_comp_sec_range    := '',		
    string25  sos_comp_city         := '';
    string2   sos_comp_state        := '';
    string5   sos_comp_zip          := '';
		string4   sos_comp_zip4         := '',
		string60  sos_address_type      := '';
    string413 sos_status            := '';
		string60  sos_business_type     := '';
		string350 sos_purpose           := '';
		string8   sos_date_incorp       := '';
		string8   sos_filing_date       := '';
		string8   sos_for_incorp_date   := '';
		string60  sos_term              := '';
		string10  sos_igs               := '';  //length ???
		string100 sos_reg_agent_name        := ''; 
		//string70  sos_reg_agent_address     := ''; ???
		string10  sos_reg_agent_prim_range  := '',
    string2   sos_reg_agent_predir      := '',		
    string28  sos_reg_agent_prim_name   := '',
    string4   sos_reg_agent_addr_suffix := '',		
    string2   sos_reg_agent_postdir     := '',		
    string10  sos_reg_agent_unit_desig  := '',
    string8   sos_reg_agent_sec_range   := '',		
    string25  sos_reg_agent_city        := '';
    string2   sos_reg_agent_state       := '';
    string5   sos_reg_agent_zip         := '';
		string4   sos_reg_agent_zip4        := '',
		string60  sos_place_incorp      := ''; 
		string10  sos_fein              := '';  //length ???
  END;
	
  // This layout is used to combine the info on up to 2 additional (history) recs for 
	// an acctno/did onto 1 layout for ease of joining when the final output is created.
  EXPORT addl_info_slimmed := RECORD
    //ver1 string20  acctno                   := '';
    unsigned6 did                       :=  0;
    string12  addl_wpl_bdid_1           := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_1      := '';
		string70  addl_wpl_comp_address1_1  := '';
    string70  addl_wpl_comp_address2_1  := ''; 
		string10  addl_wpl_comp_prim_range1_1  := '',
		string2   addl_wpl_comp_predir1_1      := '',		
		string28  addl_wpl_comp_prim_name1_1   := '',
		string4   addl_wpl_comp_addr_suffix1_1 := '',		
		string2   addl_wpl_comp_postdir1_1     := '',		
		string10  addl_wpl_comp_unit_desig1_1  := '',
		string8   addl_wpl_comp_sec_range1_1   := '',
		string25  addl_wpl_comp_city_1       := '';
		string2   addl_wpl_comp_state_1      := '';
		string10  addl_wpl_comp_zip_1        := '';
		string5   addl_wpl_comp_zip5_1       := '',
		string4   addl_wpl_comp_zip4_1       := '',
    string17  addl_wpl_phone1_1         := ''; 
    string10  addl_wpl_phone2_1         := ''; 
    string60  addl_wpl_status_1         := '';
    string8   addl_wpl_last_seen_date_1 := ''; // For internal use only, not be returned to customer
    string12  addl_wpl_bdid_2           := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_2      := '';
		string70  addl_wpl_comp_address1_2   := '';
		string70  addl_wpl_comp_address2_2   := '';
		string10  addl_wpl_comp_prim_range1_2  := '',
		string2   addl_wpl_comp_predir1_2      := '',		
		string28  addl_wpl_comp_prim_name1_2   := '',
		string4   addl_wpl_comp_addr_suffix1_2 := '',		
		string2   addl_wpl_comp_postdir1_2     := '',		
		string10  addl_wpl_comp_unit_desig1_2  := '',
		string8   addl_wpl_comp_sec_range1_2   := '',
		string25  addl_wpl_comp_city_2       := '';
		string2   addl_wpl_comp_state_2      := '';
		string10  addl_wpl_comp_zip_2        := '';
		string5   addl_wpl_comp_zip5_2       := '',
		string4   addl_wpl_comp_zip4_2       := '',
    string17  addl_wpl_phone1_2         := ''; 
    string10  addl_wpl_phone2_2         := ''; 
    string60  addl_wpl_status_2         := '';
    string8   addl_wpl_last_seen_date_2 := ''; // For internal use only, not be returned to customer
		string12  addl_wpl_bdid_3            := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_3       := '';
		string70  addl_wpl_comp_address1_3   := '';
		string70  addl_wpl_comp_address2_3   := '';
		string10  addl_wpl_comp_prim_range1_3  := '',
		string2   addl_wpl_comp_predir1_3      := '',		
		string28  addl_wpl_comp_prim_name1_3   := '',
		string4   addl_wpl_comp_addr_suffix1_3 := '',		
		string2   addl_wpl_comp_postdir1_3     := '',		
		string10  addl_wpl_comp_unit_desig1_3  := '',
		string8   addl_wpl_comp_sec_range1_3   := '',
		string25  addl_wpl_comp_city_3       := '';
		string2   addl_wpl_comp_state_3      := '';
		string10  addl_wpl_comp_zip_3        := '';
		string5   addl_wpl_comp_zip5_3       := '',
		string4   addl_wpl_comp_zip4_3       := '',
		string17  addl_wpl_phone1_3          := ''; 
    string10  addl_wpl_phone2_3          := ''; 
    string60  addl_wpl_status_3          := '';
		string8   addl_wpl_last_seen_date_3 := ''; // For internal use only, not be returned to customer
		string12  addl_wpl_bdid_4            := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_4       := '';
		string70  addl_wpl_comp_address1_4   := '';
    string70  addl_wpl_comp_address2_4   := '';
		string10  addl_wpl_comp_prim_range1_4  := '',
	  string2   addl_wpl_comp_predir1_4      := '',		
	  string28  addl_wpl_comp_prim_name1_4   := '',
	  string4   addl_wpl_comp_addr_suffix1_4 := '',		
	  string2   addl_wpl_comp_postdir1_4     := '',		
	  string10  addl_wpl_comp_unit_desig1_4  := '',
	  string8   addl_wpl_comp_sec_range1_4   := '',
    string25  addl_wpl_comp_city_4       := '';
    string2   addl_wpl_comp_state_4      := '';
    string10  addl_wpl_comp_zip_4        := '';
		string5   addl_wpl_comp_zip5_4       := '',
		string4   addl_wpl_comp_zip4_4       := '',
    string17  addl_wpl_phone1_4          := ''; 
    string10  addl_wpl_phone2_4          := ''; 
    string60  addl_wpl_status_4          := '';
		string8   addl_wpl_last_seen_date_4 := ''; // For internal use only, not be returned to customer
  END;

  // This layout is used for "looking up" phone#s by bdid on the EDA/gong bdid key file
	EXPORT bdidPhoneBatch := RECORD
		string20 acctno;
		unsigned6 bdid;
		string10 phone;
  END;

  // This layout is used for "looking up" company name/address info for a phone# in the gong data
	EXPORT phoneListingBatch := RECORD
		STRING20 acctno;
		STRING10 phone ;
		Gong.Layout_history.prim_range ;
		Gong.Layout_history.predir ;
		Gong.Layout_history.prim_name ;
		Gong.Layout_history.suffix ;
		Gong.Layout_history.postdir ;
		Gong.Layout_history.unit_desig ;
		Gong.Layout_history.sec_range ;
		Gong.Layout_history.p_city_name ;
		Gong.Layout_history.st ;
		Gong.Layout_history.z5 ;
		Gong.Layout_history.z4 ;
		Gong.Layout_history.listed_name ;
	END;

  // This layout is used to keep certain DCA fields used in determining the parent company
  EXPORT dca_info := RECORD
    unsigned6 bdid; 
    string2   Level;
    string9   Root;
    string4   Sub;
    string15  Parent_Number;
    string12  parent_company_bdid    := '';
    string120 parent_company_name    := '';
		string70  parent_company_address := '';
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
		string4   parent_company_zip4        := '',
    string10  parent_company_phone   := '';
	END;
	
  // This layout is used to keep only the needed professional license data fields
	EXPORT prolic := RECORD
    string12 did            := '';
    string8  date_last_seen := '';
    string60 license_type   := '';
		string45 status         := '';
	END;

  // This layout is used to keep only the needed email data fields
	EXPORT email := RECORD
    string12  did            := '';
    string200 clean_email    := '';
		STRING2 email_src				 := '';
    string8   date_last_seen := '';
	END;

  // This layout is used to combine the info on up to 3 emails recs for a did
	// onto 1 layout for ease of joining when the final output is created.
  EXPORT email_combined := RECORD
    string12  did                   := '';
		string200 email_address1        := '';
		string200 email_address2        := '';
		string200 email_address3        := '';
		STRING2 email_src1        			:= '';
		STRING2 email_src2        			:= '';
		STRING2 email_src3        			:= '';
  END;

  // This is the final layout of the batch service
  EXPORT final := RECORD
    // Echo input fields here
    string20  acctno         := '';
    string20  in_name_first  := '';
    string20  in_name_middle := '';
    string20  in_name_last   := '';
    string5   in_name_suffix := '';
    string10  in_prim_range  := '';
    string2   in_predir      := '';
    string28  in_prim_name   := '';
    string4   in_addr_suffix := '';
    string2   in_postdir     := '';
    string10  in_unit_desig  := '';
    string8   in_sec_range   := '';
    string25  in_city_name   := ''; // NOTE: same as "p_city_name" on standard batch_in
    string2   in_st          := '';
    string5   in_z5          := '';
    string4   in_zip4        := '';
    string12  in_ssn         := '';

    // *** Main "searched for" subject info
    // Per Emilie Peterson on 08/23/10, use string for dates and numeric type fields 
		// so when they have a null value, a blank is output.
    string12  did                 := ''; // For internal use only, not be returned to customer
		string9   subject_ssn			    := ''; // For internal use only, not be returned to customer
    string1   spouse_indicator    := ''; // For internal use only, not be returned to customer
		string2   source              := ''; // For internal use only, not be returned to customer
    string20  subject_first_name  := '';
    string20  subject_last_name   := '';
    string12  company_bdid        := ''; // For internal use only, not be returned to customer
		unsigned4 company_fein			  :=  0; // For internal use only, not be returned to customer
    string120 company_name        := '';
		string70  company_address     := '';
		string25  company_city        := '';
    string2   company_state       := '';
    string10  company_zip         := '';
    string17  company_phone1      := ''; // expanded for phone# + ' x' + 5 digit extension from clarity
	  string10  company_phone2      := ''; // length 10 because only phone1 will have the work phone with an extension
    string60  company_status      := '';
    string255 company_description := '';
    string8   date_last_seen      := '';
    string12  parent_company_bdid     := ''; // For internal use only, not be returned to customer
    string120 parent_company_name     := '';
		string70  parent_company_address  := '';
    string25  parent_company_city     := '';
    string2   parent_company_state    := '';
    string10  parent_company_zip      := '';
    string10  parent_company_phone    := '';
    string60  parent_company_status   := '';
    string60  prof_license            := ''; 
    string45  prof_license_status     := '';
    // NOTE: additional workplacelocator (history) fields are populated only when requested.
    string12  addl_wpl_bdid_1          := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_1     := '';
		string70  addl_wpl_comp_address1_1 := '';
    string70  addl_wpl_comp_address2_1 := '';
    string25  addl_wpl_comp_city_1     := '';
    string2   addl_wpl_comp_state_1    := '';
    string10  addl_wpl_comp_zip_1      := '';
    string17  addl_wpl_phone1_1        := ''; 
    string10  addl_wpl_phone2_1        := ''; 
    string60  addl_wpl_status_1        := '';
    string12  addl_wpl_bdid_2          := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_2     := '';
		string70  addl_wpl_comp_address1_2 := '';
    string70  addl_wpl_comp_address2_2 := '';
    string25  addl_wpl_comp_city_2     := '';
    string2   addl_wpl_comp_state_2    := '';
    string10  addl_wpl_comp_zip_2      := '';
    string17  addl_wpl_phone1_2        := ''; 
    string10  addl_wpl_phone2_2        := ''; 
    string60  addl_wpl_status_2        := '';
		string12  addl_wpl_bdid_3            := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_3       := '';
		string70  addl_wpl_comp_address1_3   := '';
    string70  addl_wpl_comp_address2_3   := '';
    string25  addl_wpl_comp_city_3       := '';
    string2   addl_wpl_comp_state_3      := '';
    string10  addl_wpl_comp_zip_3        := '';
    string17  addl_wpl_phone1_3          := ''; 
    string10  addl_wpl_phone2_3          := ''; 
    string60  addl_wpl_status_3          := '';
		string12  addl_wpl_bdid_4            := ''; // For internal use only, not be returned to customer
    string120 addl_wpl_comp_name_4       := '';
		string70  addl_wpl_comp_address1_4   := '';
    string70  addl_wpl_comp_address2_4   := '';
    string25  addl_wpl_comp_city_4       := '';
    string2   addl_wpl_comp_state_4      := '';
    string10  addl_wpl_comp_zip_4        := '';
    string17  addl_wpl_phone1_4          := ''; 
    string10  addl_wpl_phone2_4          := ''; 
    string60  addl_wpl_status_4          := '';
		Email_Info;
    //subject future use fields
		// Product manager originally wanted these "reserved**" field names in the output, 
		// but that approach was changed effective 05/17/2011 roxie release.  
		// However field names from the original product specs were just commented out for use  
		// when/if the fields are populated or used in the future.
    //string120 reserved01 := ''; //company_headquarters_name    := ''; // per specs reserved for future use
		//string70  reserved02 := ''; //company_headquarters_address := ''; // per specs reserved for future use
    //string25  reserved03 := ''; //company_headquarters_city    := ''; // per specs reserved for future use
    //string2   reserved04 := ''; //company_headquarters_state   := ''; // per specs reserved for future use
    //string10  reserved05 := ''; //company_headquarters_zip     := ''; // per specs reserved for future use
    //string10  reserved06 := ''; //company_headquarters_phone   := ''; // per specs reserved for future use
    //string60  reserved07 := ''; //company_headquarters_status  := ''; // per specs reserved for future use
    //string130 reserved08 := ''; //job_title              := '';  // per specs reserved for future use
    //string100 reserved09 := ''; //line_of_work           := '';	 // per specs reserved for future use
    //string100 reserved10 := ''; //department             := '';	 // per specs reserved for future use
    //string8   reserved11 := ''; //start_date             := '';	 // per specs reserved for future use
    //string8   reserved12 := ''; //end_date               := '';	 // per specs reserved for future use
    //string3   reserved13 := ''; //months_at_curr_emp     := '';	 // per specs reserved for future use
    //string6   reserved14 := ''; //monthly_income         := '';	 // per specs reserved for future use
    //string8   reserved15 := ''; //annual_salary_income   := '';	 // per specs reserved for future use
    //string8   reserved16 := ''; //annual_bonus_income    := '';	 // per specs reserved for future use
    //string50  reserved17 := ''; //rate_type              := '';	 // per specs reserved for future use
    //string50  reserved18 := ''; // pay_frequency          := ''; // per specs reserved for future use
    //string1   reserved19 := ''; // full_part_time         := ''; // per specs reserved for future use
    //string1   reserved20 := ''; // permanent_temporary    := ''; // per specs reserved for future use
    //string1   reserved21 := ''; // seasonal_year_round    := ''; // per specs reserved for future use
    //string1   reserved22 := ''; // exempt_nonexempt       := ''; // per specs reserved for future use
    //string1   reserved23 := ''; // hsa_contributor        := ''; // per specs reserved for future use
    //string1   reserved24 := ''; // is_401K_contributor    := ''; // per specs reserved for future use
    //string30  reserved25 := ''; // boss_name              := ''; // per specs reserved for future use
    //string1   reserved26 := ''; // being_garnished        := ''; // per specs reserved for future use
    //string50  reserved27 := ''; // type_of_garnishment    := ''; // per specs reserved for future use
    //string8   reserved28 := ''; // garnishment_start_date := ''; // per specs reserved for future use
    //string8   reserved29 := ''; // garnishment_end_date   := ''; // per specs reserved for future use
	  //string1   reserved30 := ''; // self_employed          := ''; // per specs reserved for future use
	  //string10  reserved31 := ''; // per specs reserved for future use
	  //string10  reserved32 := ''; // per specs reserved for future use
	  //string10  reserved33 := ''; // per specs reserved for future use
	  //string10  reserved34 := ''; // per specs reserved for future use
	  //string10  reserved35 := ''; // per specs reserved for future use
	  //string10  reserved36 := ''; // per specs reserved for future use
	  //string10  reserved37 := ''; // per specs reserved for future use
	  //string10  reserved38 := ''; // per specs reserved for future use
	  //string10  reserved39 := ''; // per specs reserved for future use
	  //string10  reserved40 := ''; // per specs reserved for future use
		
    // *** Spouse (of the "searched for" subject) info; only included when requested.
    string12  spouse_did                    := ''; // For internal use only, not be returned to customer
		string2   spouse_source                 := ''; // For internal use only, not be returned to customer
    string20  spouse_first_name             := '';
    string20  spouse_last_name              := '';
    string12  spouse_company_bdid           := ''; // For internal use only, not be returned to customer
    string120 spouse_company_name           := '';
		string70  spouse_company_address        := '';
    string25  spouse_company_city           := '';
    string2   spouse_company_state          := '';
    string10  spouse_company_zip            := '';
    string17  spouse_company_phone1         := '';
	  string10  spouse_company_phone2         := '';
    string60  spouse_company_status         := '';
    string255 spouse_company_description    := '';
    string8   spouse_date_last_seen         := ''; 
    string12  spouse_parent_company_bdid    := ''; // For internal use only, not be returned to customer
    string120 spouse_parent_company_name    := '';
		string70  spouse_parent_company_address := '';
    string25  spouse_parent_company_city    := '';
    string2   spouse_parent_company_state   := '';
    string10  spouse_parent_company_zip     := '';
    string10  spouse_parent_company_phone   := '';
    string60  spouse_parent_company_status  := '';
    string60  spouse_prof_license           := '';
    string45  spouse_prof_license_status    := '';

		// NOTE: additional workplacelocator (history) fields are populated only when requested.
		string12  spouse_addl_wpl_bdid_1          := ''; // For internal use only, not be returned to customer
    string120 spouse_addl_wpl_comp_name_1     := '';
		string70  spouse_addl_wpl_comp_address1_1 := '';
    string70  spouse_addl_wpl_comp_address2_1 := '';
    string25  spouse_addl_wpl_comp_city_1     := '';
    string2   spouse_addl_wpl_comp_state_1    := '';
    string10  spouse_addl_wpl_comp_zip_1      := '';
    string17  spouse_addl_wpl_phone1_1        := ''; 
    string10  spouse_addl_wpl_phone2_1        := ''; 
    string60  spouse_addl_wpl_status_1        := '';
    string12  spouse_addl_wpl_bdid_2          := ''; // For internal use only, not be returned to customer
    string120 spouse_addl_wpl_comp_name_2     := '';
		string70  spouse_addl_wpl_comp_address1_2 := '';
    string70  spouse_addl_wpl_comp_address2_2 := '';
    string25  spouse_addl_wpl_comp_city_2     := '';
    string2   spouse_addl_wpl_comp_state_2    := '';
    string10  spouse_addl_wpl_comp_zip_2      := '';
    string17  spouse_addl_wpl_phone1_2        := ''; 
    string10  spouse_addl_wpl_phone2_2        := ''; 
    string60  spouse_addl_wpl_status_2        := '';
		string12  spouse_addl_wpl_bdid_3            := ''; // For internal use only, not be returned to customer
    string120 spouse_addl_wpl_comp_name_3       := '';
		string70  spouse_addl_wpl_comp_address1_3   := '';
    string70  spouse_addl_wpl_comp_address2_3   := '';
    string25  spouse_addl_wpl_comp_city_3       := '';
    string2   spouse_addl_wpl_comp_state_3      := '';
    string10  spouse_addl_wpl_comp_zip_3        := '';
    string17  spouse_addl_wpl_phone1_3          := ''; 
    string10  spouse_addl_wpl_phone2_3          := ''; 
    string60  spouse_addl_wpl_status_3          := '';
		string12  spouse_addl_wpl_bdid_4            := ''; // For internal use only, not be returned to customer
    string120 spouse_addl_wpl_comp_name_4       := '';
		string70  spouse_addl_wpl_comp_address1_4   := '';
    string70  spouse_addl_wpl_comp_address2_4   := '';
    string25  spouse_addl_wpl_comp_city_4       := '';
    string2   spouse_addl_wpl_comp_state_4      := '';
    string10  spouse_addl_wpl_comp_zip_4        := '';
    string17  spouse_addl_wpl_phone1_4          := ''; 
    string10  spouse_addl_wpl_phone2_4          := ''; 
    string60  spouse_addl_wpl_status_4          := '';
		//spouse future use fields
		// Product manager originally wanted these "reserved**" field names in the output, 
		// but that approach was changed effective 05/17/2011 roxie release.  
		// However field names from the original product specs were just commented out for use  
		// when/if the fields are populated or used in the future.
    //string120 reserved41 := ''; // spouse_company_headquarters_name    := ''; // per specs reserved for future use
		//string70  reserved42 := ''; // spouse_company_headquarters_address := ''; // per specs reserved for future use
    //string25  reserved43 := ''; // spouse_company_headquarters_city    := ''; // per specs reserved for future use
    //string2   reserved44 := ''; // spouse_company_headquarters_state   := ''; // per specs reserved for future use
    //string10  reserved45 := ''; // spouse_company_headquarters_zip     := ''; // per specs reserved for future use
    //string10  reserved46 := ''; // spouse_company_headquarters_phone   := ''; // per specs reserved for future use
    //string60  reserved47 := ''; // spouse_company_headquarters_status  := ''; // per specs reserved for future use
    //string130 reserved48 := ''; // spouse_job_title              := '';  // per specs reserved for future use
    //string100 reserved49 := ''; // spouse_line_of_work           := '';	 // per specs reserved for future use
    //string100 reserved50 := ''; // spouse_department             := '';	 // per specs reserved for future use
    //string8   reserved51 := ''; // spouse_start_date             := '';	 // per specs reserved for future use
    //string8   reserved52 := ''; // spouse_end_date               := '';	 // per specs reserved for future use
    //string3   reserved53 := ''; // spouse_months_at_curr_emp     := '';	 // per specs reserved for future use
    //string6   reserved54 := ''; // spouse_monthly_income         := '';	 // per specs reserved for future use
    //string8   reserved55 := ''; // spouse_annual_salary_income   := '';	 // per specs reserved for future use
    //string8   reserved56 := ''; // spouse_annual_bonus_income    := '';	 // per specs reserved for future use
    //string50  reserved57 := ''; // spouse_rate_type              := '';	 // per specs reserved for future use
    //string50  reserved58 := ''; // spouse_pay_frequency          := '';	 // per specs reserved for future use
    //string1   reserved59 := ''; // spouse_full_part_time         := '';	 // per specs reserved for future use
    //string1   reserved60 := ''; // spouse_permanent_temporary    := '';	 // per specs reserved for future use
    //string1   reserved61 := ''; // spouse_seasonal_year_round    := '';	 // per specs reserved for future use
    //string1   reserved62 := ''; // spouse_exempt_nonexempt       := '';	 // per specs reserved for future use
    //string1   reserved63 := ''; // spouse_hsa_contributor        := '';	 // per specs reserved for future use
    //string1   reserved64 := ''; // spouse_is_401K_contributor    := '';	 // per specs reserved for future use
    //string30  reserved65 := ''; // spouse_boss_name              := '';	 // per specs reserved for future use
    //string1   reserved66 := ''; // spouse_being_garnished        := '';	 // per specs reserved for future use
    //string50  reserved67 := ''; // spouse_type_of_garnishment    := '';	 // per specs reserved for future use
    //string8   reserved68 := ''; // spouse_garnishment_start_date := '';	 // per specs reserved for future use	
    //string8   reserved69 := ''; // spouse_garnishment_end_date   := '';	 // per specs reserved for future use
	  //string1   reserved70 := ''; // spouse_self_employed          := '';  // per specs reserved for future use
	  //string10  reserved71 := ''; // per specs reserved for future use
	  //string10  reserved72 := ''; // per specs reserved for future use
	  //string10  reserved73 := ''; // per specs reserved for future use
	  //string10  reserved74 := ''; // per specs reserved for future use
	  //string10  reserved75 := ''; // per specs reserved for future use
	  //string10  reserved76 := ''; // per specs reserved for future use
	  //string10  reserved77 := ''; // per specs reserved for future use
	  //string10  reserved78 := ''; // per specs reserved for future use
	  //string10  reserved79 := ''; // per specs reserved for future use
	  //string10  reserved80 := ''; // per specs reserved for future use
  END;

END; // END of the MODULE
