IMPORT doxie_cbrs;

EXPORT BusinessLocationConfirmation_BatchService_Layouts := MODULE

	EXPORT Input := RECORD
		UNSIGNED  acctno := 0;
		STRING120 company_name := '';
	  STRING20	owner_name_first := '';
	  STRING20	owner_name_middle := '';
	  STRING20	owner_name_last := '';
		STRING9   fein := '';
	  STRING10  prim_range := '';
	  STRING2   predir := '';
	  STRING28  prim_name := '';
	  STRING4   addr_suffix := '';
	  STRING2   postdir := '';
	  STRING10  unit_desig := '';
	  STRING8   sec_range := '';
		STRING25  p_city_name := '';
		STRING2   st := '';
		STRING5   z5 := '';
		STRING4   zip4 := '';
	END;
	
	EXPORT BatchInput := RECORD
		UNSIGNED  acctno := 0;
		UNSIGNED8 seq := 0;
		STRING120 input_comp_name := '';
	  STRING20	input_owner_name_first := '';
	  STRING20	input_owner_name_middle := '';
	  STRING20	input_owner_name_last := '';
		STRING9   input_fein := '';
	  STRING10  input_prim_range := '';
	  STRING2   input_predir := '';
	  STRING28  input_prim_name := '';
	  STRING4   input_addr_suffix := '';
	  STRING2   input_postdir := '';
	  STRING8   input_sec_range := '';
		STRING25  input_p_city_name := '';
		STRING2   input_st := '';
		STRING5   input_z5 := '';
		STRING120 company_name := '';
	  STRING20  owner_name_first := '';
	  STRING20	owner_name_middle := '';
	  STRING20	owner_name_last := '';
		STRING9   fein := '';
	  STRING10  prim_range := '';
	  STRING2   predir := '';
	  STRING28  prim_name := '';
	  STRING4   addr_suffix := '';
	  STRING2   postdir := '';
	  STRING10  unit_desig := '';
	  STRING8   sec_range := '';
		STRING25  p_city_name := '';
		STRING2   st := '';
		STRING5   z5 := '';
		STRING4   zip4 := '';
	  STRING10  phone10 := '';
	END;

	EXPORT Final := RECORD
		UNSIGNED  acctno := 0;
    UNSIGNED6 bdid := 0;
		STRING120 best_company_name := '';
		STRING10  best_prim_range := '';
		STRING2   best_predir := '';
		STRING28  best_prim_name := '';
		STRING4   best_addr_suffix := '';
		STRING2   best_postdir := '';
		STRING10  best_unit_desig := '';
		STRING8   best_sec_range := '';
		STRING25  best_city := '';
		STRING2   best_state := '';
		STRING5   best_zip := '';
		STRING4   best_zip4 := '';
		STRING10  best_phone := '';
		STRING9   best_fein := '';
		STRING8   best_sic_code := '';
		STRING70  business_status := '';
		STRING1   multiple_corp_status_found := '';
		STRING1   existing_business_status_is_active := '';
		STRING1   new_business_status_is_active := '';
		STRING1   business_name_match := '';
		STRING1   fein_match := '';
		STRING1   full_address_match := '';
		STRING1   phone_verified_real_time := '';
		STRING1   business_phone_verified_at_address := '';
		STRING1   business_phone_verified_at_different_address := '';
		STRING1   active_corporate_filing_for_business_within_input_state := '';
		STRING1   active_business_registration_for_business_within_input_state := '';
		STRING1   business_location_verified_active := '';
		STRING1   address_vacant_indicator := '';
		STRING1   throw_back_indicator := '';
		STRING1   delivery_point_business_family_served_count := '';
		STRING1   delivery_type_indicator := '';
		STRING70  delivery_type_indicator_description := '';
		UNSIGNED4 date_first_seen := 0;
		UNSIGNED4 date_last_seen := 0;
		STRING1   date_last_seen_less_than_six_months := '';
		STRING1   date_last_seen_greater_than_twelve_months := '';
		STRING9   fein := '';
	  STRING20	business_contact_first1 := '';
	  STRING20	business_contact_middle1 := '';
	  STRING20	business_contact_last1 := '';
		STRING60  business_contact_title1 := '';
		STRING80  address1 := ''; 
		STRING25  city1 := '';
		STRING2   state1 := '';
		STRING5   zip1 := '';
		STRING10  phone1 := '';
	  STRING20	business_contact_first2 := '';
	  STRING20	business_contact_middle2 := '';
	  STRING20	business_contact_last2 := '';
		STRING60  business_contact_title2 := '';
		STRING80  address2 := ''; 
		STRING25  city2 := '';
		STRING2   state2 := '';
		STRING5   zip2 := '';
		STRING10  phone2 := '';
	  STRING20	business_contact_first3 := '';
	  STRING20	business_contact_middle3 := '';
	  STRING20	business_contact_last3 := '';
		STRING60  business_contact_title3 := '';
		STRING80  address3 := ''; 
		STRING25  city3 := '';
		STRING2   state3 := '';
		STRING5   zip3 := '';
		STRING10  phone3 := '';
	  STRING20	business_contact_first4 := '';
	  STRING20	business_contact_middle4 := '';
	  STRING20	business_contact_last4 := '';
		STRING60  business_contact_title4 := '';
		STRING80  address4 := ''; 
		STRING25  city4 := '';
		STRING2   state4 := '';
		STRING5   zip4 := '';
		STRING10  phone4 := '';
	  STRING20	business_contact_first5 := '';
	  STRING20	business_contact_middle5 := '';
	  STRING20	business_contact_last5 := '';
		STRING60  business_contact_title5 := '';
		STRING80  address5 := ''; 
		STRING25  city5 := '';
		STRING2   state5 := '';
		STRING5   zip5 := '';
		STRING10  phone5 := '';
		STRING120 error_message := '';
	END;
	
	EXPORT Final_Plus := RECORD
    Final;
		STRING120 input_comp_name := '';
	  STRING20	input_owner_name_first := '';
	  STRING20	input_owner_name_middle := '';
	  STRING20	input_owner_name_last := '';
		STRING9   input_fein := '';
	  STRING10  input_prim_range := '';
	  STRING2   input_predir := '';
	  STRING28  input_prim_name := '';
	  STRING4   input_addr_suffix := '';
	  STRING2   input_postdir := '';
	  STRING8   input_sec_range := '';
		STRING25  input_p_city_name := '';
		STRING2   input_st := '';
		STRING5   input_z5 := '';
		UNSIGNED8 seq := 0;
		UNSIGNED8 real_time_phone_acctno := 0;
		UNSIGNED1 contact_score := 0;
		STRING1   address_only := 'N';
		UNSIGNED1 number_corp_status_found := 0;
		STRING30  corp_key := '';
		STRING2   corp_state_origin := '';
		STRING2   corp_addr1_state := '';
		UNSIGNED4 corp_dt_last_seen := 0;
		UNSIGNED4 corp_status_date := 0;
	END;
	
	EXPORT Date := RECORD
	  Final_Plus;
		STRING120 company_name  := '';
		UNSIGNED4 dt_first_seen := 0;
		UNSIGNED4 dt_last_seen  := 0;
  END;

	EXPORT Business_Registration_Date := RECORD
	  Final_Plus;
		STRING8   actual_file_date := '';
		STRING15  business_registration_status := '';
		STRING2   status_code := '';
		STRING2   business_registration_state := '';
		UNSIGNED6 br_id := 0;
  END;
  	
  EXPORT Address := RECORD
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING25  city;
		STRING2   state;
		STRING5   zip;									
	END;

	EXPORT Corp_Count_Rec := RECORD
    UNSIGNED6 bdid := 0;
		UNSIGNED2 the_count := 0;
	END;	

  EXPORT Contact := RECORD
	  doxie_cbrs.layout_contacts;
		STRING    stored_title;
		STRING    display_title;
		UNSIGNED2 title_rank;
	END;

END;
