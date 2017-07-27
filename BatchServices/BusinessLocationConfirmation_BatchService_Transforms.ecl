IMPORT Address, Advo, Business_Header, BusReg, Corp2, doxie_cbrs, ut;

  BLC_Layouts := BusinessLocationConfirmation_BatchService_Layouts;
  BLC_Functions := BusinessLocationConfirmation_BatchService_Functions;
  BLC_Constants := BusinessLocationConfirmation_BatchService_Constants;
	UCase := StringLib.StringToUpperCase;

EXPORT BusinessLocationConfirmation_BatchService_Transforms := MODULE

  SHARED STRING8 zero_pad := '00000000';

	EXPORT BLC_Layouts.BatchInput xfm_clean_input(BLC_Layouts.Input L, UNSIGNED C) := TRANSFORM
		SELF.input_comp_name := L.company_name;
		SELF.input_owner_name_first := L.owner_name_first;
		SELF.input_owner_name_middle := L.owner_name_middle;
		SELF.input_owner_name_last := L.owner_name_last;
		SELF.input_fein := L.fein;
		SELF.input_prim_range := L.prim_range;
		SELF.input_predir := L.predir;
		SELF.input_prim_name := L.prim_name;
		SELF.input_addr_suffix := L.addr_suffix;
		SELF.input_postdir := L.postdir;
		SELF.input_sec_range := L.sec_range;
		SELF.input_p_city_name := L.p_city_name;
		SELF.input_st := L.st;
		SELF.input_z5 := L.z5;
		SELF.seq := C;
		SELF.company_name := UCase(L.company_name);
		SELF.owner_name_first := UCase(L.owner_name_first);
		SELF.owner_name_middle := UCase(L.owner_name_middle);
		SELF.owner_name_last := UCase(L.owner_name_last);
		SELF.prim_range := UCase(L.prim_range);
		SELF.predir := UCase(L.predir);
		SELF.prim_name := UCase(L.prim_name);
		SELF.addr_suffix := UCase(L.addr_suffix);
		SELF.postdir := UCase(L.postdir);
		SELF.unit_desig := UCase(L.unit_desig);
		SELF.sec_range := UCase(L.sec_range);
		SELF.p_city_name := UCase(L.p_city_name);
		SELF.st := UCase(L.st);
		SELF := L;
	END;

	BLC_Layouts.Address xfm_key_bh_best_address (Business_Header.Key_BH_Best L) := TRANSFORM
	  SELF.zip := (STRING5)L.zip;
	  SELF := L;
	END;
	
	EXPORT BLC_Layouts.Final_Plus xfm_input_to_best(BLC_Layouts.Final_Plus L, Business_Header.Key_BH_Best R) := TRANSFORM
    best_address_rec := PROJECT(R, xfm_key_bh_best_address(LEFT));
    address_penalty := IF(R.prim_name = '', 1000, BLC_Functions.fn_calc_address_penalty(L, best_address_rec, TRUE));
    fein_penalty := IF(R.fein = 0, 1000, BLC_Functions.fn_calc_fein_penalty(L, R));
		
		SELF.best_fein := IF(0 = R.fein, '', INTFORMAT(R.fein, 9, 1));
		SELF.fein := ''; // This is figured out from the business contacts
		SELF.best_company_name := R.company_name;
	  SELF.best_prim_range := R.prim_range;
	  SELF.best_predir := R.predir;
	  SELF.best_prim_name := R.prim_name;
	  SELF.best_addr_suffix := R.addr_suffix;
	  SELF.best_postdir := R.postdir;
	  SELF.best_unit_desig := R.unit_desig;
	  SELF.best_sec_range := R.sec_range;
		SELF.best_city := R.city;
		SELF.best_state := R.state;
		SELF.best_zip := IF(R.zip = 0, '', INTFORMAT(R.zip, 5, 1));
		SELF.best_zip4 := IF(R.zip4 = 0, '', INTFORMAT(R.zip4, 4, 1));
		SELF.best_phone := (STRING10)R.phone;
		SELF.business_name_match :=
		  CASE(
			  L.input_comp_name,
				   '' => '',
				   IF(ut.CompanySimilar(UCase(L.input_comp_name),
					                      R.company_name,
																TRUE) <= BLC_Constants.PENALT_THRESHOLD, 'Y', 'N'));
		SELF.full_address_match := IF(address_penalty <= BLC_Constants.PENALT_THRESHOLD, 'Y', 'N');
		SELF.fein_match :=
		  CASE(
			  L.input_fein,
				   '' => '',
					 // The check for the != 9 is because the fein penalty maxes out at a declared constant(10) - 1
					 IF(fein_penalty <= BLC_Constants.PENALT_THRESHOLD AND fein_penalty != 9, 'Y', 'N'));
    SELF.address_only :=
		  CASE(
			  L.address_only,
				   '' => IF(L.input_comp_name = '', 'Y', 'N'),
					 L.address_only);
		SELF := L;
	END;

	BLC_Layouts.Address xfm_key_contact_address (Business_Header.Key_Business_Contacts_BDID L) := TRANSFORM
	  SELF.prim_range := L.company_prim_range;
		SELF.predir := L.company_predir;
		SELF.prim_name := L.company_prim_name;
		SELF.addr_suffix := L.company_addr_suffix;
		SELF.postdir := L.company_postdir;
		SELF.city := L.company_city;
		SELF.state := L.company_state;
		SELF.zip := (STRING5)L.company_zip;									
	  SELF := [];
	END;
	
	EXPORT BLC_Layouts.Final_Plus xfm_owner_name_input(BLC_Layouts.Final_Plus L, Business_Header.Key_Business_Contacts_BDID R) := TRANSFORM
    best_address_rec := PROJECT(R, xfm_key_contact_address(LEFT));
    address_penalty := IF(R.company_prim_name = '', 1000, BLC_Functions.fn_calc_address_penalty(L, best_address_rec, TRUE));
		
		SELF.best_fein := IF(0 = R.company_fein, '', INTFORMAT(R.company_fein, 9, 1));
		SELF.fein := ''; // This is figured out from the business contacts
		SELF.best_company_name := R.company_name;
	  SELF.best_prim_range := R.company_prim_range;
	  SELF.best_predir := R.company_predir;
	  SELF.best_prim_name := R.company_prim_name;
	  SELF.best_addr_suffix := R.company_addr_suffix;
	  SELF.best_postdir := R.company_postdir;
	  SELF.best_unit_desig := R.company_unit_desig;
	  SELF.best_sec_range := R.company_sec_range;
		SELF.best_city := R.company_city;
		SELF.best_state := R.company_state;
		SELF.best_zip := IF(R.company_zip = 0, '', INTFORMAT(R.company_zip, 5, 1));
		SELF.best_zip4 := IF(R.company_zip4 = 0, '', INTFORMAT(R.company_zip4, 4, 1));
		SELF.best_phone := (STRING10)R.company_phone;
		SELF.full_address_match := IF(address_penalty <= BLC_Constants.PENALT_THRESHOLD, 'Y', 'N');
    SELF.date_last_seen := R.dt_last_seen; // temporarily used for sorting/deduping purposes
		SELF.contact_score := (UNSIGNED1)R.contact_score; // also used for sorting/deduping purposes
		SELF.address_only := 'N';
		SELF := L;
	END;

  EXPORT BLC_Layouts.Date PadDate(BLC_Layouts.Date L) := TRANSFORM
	  SELF.dt_first_seen := (UNSIGNED4)((STRING8)(L.dt_first_seen + zero_pad));
	  SELF.dt_last_seen := (UNSIGNED4)((STRING8)(L.dt_last_seen + zero_pad));
    SELF := L;
  END;

  EXPORT BLC_Layouts.Date DetermineDateSeen(BLC_Layouts.Final_Plus L, DATASET(BLC_Layouts.Date) R) := TRANSFORM
	  SELF.date_first_seen := MIN(R(dt_first_seen != 0), R.dt_first_seen);
	  SELF.date_last_seen := MAX(R, R.dt_last_seen);
	  SELF := L;
  END;

	EXPORT BLC_Layouts.Final_Plus xfm_date_last_seen_fields(BLC_Layouts.Date L) := TRANSFORM
	  todays_date := StringLib.GetDateYYYYMMDD();
		
	  SELF.date_last_seen_less_than_six_months :=
		  CASE(
			  L.date_last_seen,
				   0 => '',
				   IF(ut.monthsApart_YYYYMMDD(todays_date, (STRING8)L.date_last_seen, BLC_Constants.ROUND_UP_PARTIAL_MONTH) < 6, 'Y', 'N'));
	  SELF.date_last_seen_greater_than_twelve_months :=
		  CASE(
			  L.date_last_seen,
				   0 => '',
				   IF(ut.monthsApart_YYYYMMDD(todays_date, (STRING8)L.date_last_seen, BLC_Constants.ROUND_UP_PARTIAL_MONTH) > 12, 'Y','N'));
	  SELF := L;
	END;

	EXPORT BLC_Layouts.Final_Plus xfm_advo_input(BLC_Layouts.Final_Plus L, Advo.Key_Addr1 R) := TRANSFORM
	  SELF.address_vacant_indicator := R.address_vacancy_indicator;
		SELF.business_location_verified_active :=
		  CASE(
			  R.address_vacancy_indicator,
				   '' => '',
		       'Y' => 'N',
					 'Y');
		SELF.delivery_point_business_family_served_count :=
		  CASE(
			  R.address_vacancy_indicator, // If there isn't an indicator, then we found no Advo data
				   '' => '',
					 IF(R.dbpc = '', 'N', 'Y'));
		SELF.throw_back_indicator := R.throw_back_indicator;
		SELF.delivery_type_indicator := R.Mixed_Address_Usage;
		SELF.delivery_type_indicator_description := Advo.Lookup_Descriptions.Delivery_Type_Description_lookup(R.Mixed_Address_Usage);
	  SELF := L;
	END;

	EXPORT BLC_Layouts.Business_Registration_Date xfm_file_date(BLC_Layouts.Final_Plus L, BusReg.key_busreg_company_bdid R) := TRANSFORM
	  SELF.actual_file_date := IF(R.ccyymmdd != '', R.ccyymmdd, R.file_date);
		SELF.business_registration_status := TRIM(R.ofc1_type, LEFT, RIGHT);
		SELF.status_code := R.status;
		SELF.business_registration_state :=
		  MAP(R.loc_state != '' => R.loc_state,
			    R.state_code);
		SELF.br_id := R.br_id;
	  SELF := L;
	END;

	EXPORT BLC_Layouts.Final_Plus xfm_bus_reg_input(BLC_Layouts.Business_Registration_Date L) := TRANSFORM
	  todays_date := StringLib.GetDateYYYYMMDD();
		
	  SELF.active_business_registration_for_business_within_input_state :=
		  CASE(
			  L.br_id,
				   0 => '',
		       IF(L.business_registration_status = 'CURRENT'
			        AND ut.monthsApart_YYYYMMDD(todays_date, L.actual_file_date, BLC_Constants.ROUND_UP_PARTIAL_MONTH) < 60
			        AND L.status_code IN BLC_Constants.ACCUTREND_ACTIVE_STATUS
				      AND L.business_registration_state = L.best_state,
				      'Y', 'N'));
	  SELF := L;
	END;

	EXPORT BLC_Layouts.Final_Plus get_corp_fields(BLC_Layouts.Final_Plus L, Corp2.Key_Corp_BdidPL R) := TRANSFORM
				SELF.corp_key := R.corp_key;
		    SELF.corp_state_origin := R.corp_state_origin;
		    SELF.corp_addr1_state := R.corp_addr1_state;
				SELF.corp_dt_last_seen := R.dt_last_seen;
				SELF.corp_status_date := (UNSIGNED4)R.corp_status_date;
			  SELF.business_status := R.corp_status_desc;
				SELF := L;	
	END;
	
  EXPORT BLC_Layouts.Final_Plus xfm_corp2_input(BLC_Layouts.Final_Plus L, BLC_Layouts.Corp_Count_Rec R) := TRANSFORM
    business_is_active := IF(BLC_Functions.fn_is_business_active(L.corp_state_origin, L.business_status), 'Y', 'N');
		number_found := IF(L.corp_key = '', 0, R.the_count);
    existing_active :=
		  MAP(
			  L.corp_key = '' => '',
				L.address_only = 'Y' => '',
				business_is_active);
    new_active :=
		  MAP(
			  L.corp_key = '' => '',
				L.address_only = 'N' => '',
				business_is_active);
		
	  SELF.existing_business_status_is_active := existing_active;
	  SELF.new_business_status_is_active := new_active;
		SELF.active_corporate_filing_for_business_within_input_state :=
		  CASE(
			  L.corp_key,
				   '' => '',
		       IF((existing_active = 'Y' OR new_active = 'Y') AND L.best_state = L.corp_addr1_state, 'Y', 'N'));
	  SELF.number_corp_status_found := number_found; // this is here in case the customer wants it at a later date
	  SELF.multiple_corp_status_found :=
		  CASE(
			  number_found,
			     0 => '',
				   1 => 'N',
				   'Y');
	  SELF := L;
  END;

	// Keep the first five owners and their information
	EXPORT BLC_Layouts.Final_Plus xfm_contacts(BLC_Layouts.Final_Plus L, BLC_Layouts.Contact R, INTEGER C) := TRANSFORM
			STRING80 combined_address := Address.Addr1FromComponents(R.company_prim_range, R.company_predir, R.company_prim_name,
			                                                         R.company_addr_suffix, R.company_postdir, R.company_unit_desig,
																											         R.company_sec_range);
																															 
			// Take the first non-blank fein from only those contacts we are showing in the final output
			SELF.fein := IF(C IN [1, 2, 3, 4, 5] AND L.fein = '' AND R.company_fein != 0, (STRING9)R.company_fein, L.fein),
			SELF.business_contact_first1 := IF(C = 1, R.fname, L.business_contact_first1),
			SELF.business_contact_middle1 := IF(C = 1, R.mname, L.business_contact_middle1),
			SELF.business_contact_last1 := IF(C = 1, R.lname, L.business_contact_last1),
			SELF.business_contact_title1 := IF(C = 1, R.display_title , L.business_contact_title1),
			SELF.address1 := IF(C = 1, combined_address, L.address1),
			SELF.city1 := IF(C = 1, R.company_city, L.city1),
			SELF.state1 := IF(C = 1, R.company_state, L.state1),
			SELF.zip1 := IF(C = 1, (STRING5)R.company_zip, L.zip1),
			SELF.phone1 := IF(C = 1, (STRING10)R.company_phone, L.phone1),
			SELF.business_contact_first2 := IF(C = 2, R.fname, L.business_contact_first2),
			SELF.business_contact_middle2 := IF(C = 2, R.mname, L.business_contact_middle2),
			SELF.business_contact_last2 := IF(C = 2, R.lname, L.business_contact_last2),
			SELF.business_contact_title2 := IF(C = 2, R.display_title , L.business_contact_title2),
			SELF.address2 := IF(C = 2, combined_address, L.address2),
			SELF.city2 := IF(C = 2, R.company_city, L.city2),
			SELF.state2 := IF(C = 2, R.company_state, L.state2),
			SELF.zip2 := IF(C = 2, (STRING5)R.company_zip, L.zip2),
			SELF.phone2 := IF(C = 2, (STRING10)R.company_phone, L.phone2),
			SELF.business_contact_first3 := IF(C = 3, R.fname, L.business_contact_first3),
			SELF.business_contact_middle3 := IF(C = 3, R.mname, L.business_contact_middle3),
			SELF.business_contact_last3 := IF(C = 3, R.lname, L.business_contact_last3),
			SELF.business_contact_title3 := IF(C = 3, R.display_title , L.business_contact_title3),
			SELF.address3 := IF(C = 3, combined_address, L.address3),
			SELF.city3 := IF(C = 3, R.company_city, L.city3),
			SELF.state3 := IF(C = 3, R.company_state, L.state3),
			SELF.zip3 := IF(C = 3, (STRING5)R.company_zip, L.zip3),
			SELF.phone3 := IF(C = 3, (STRING10)R.company_phone, L.phone3),
			SELF.business_contact_first4 := IF(C = 4, R.fname, L.business_contact_first4),
			SELF.business_contact_middle4 := IF(C = 4, R.mname, L.business_contact_middle4),
			SELF.business_contact_last4 := IF(C = 4, R.lname, L.business_contact_last4),
			SELF.business_contact_title4 := IF(C = 4, R.display_title , L.business_contact_title4),
			SELF.address4 := IF(C = 4, combined_address, L.address4),
			SELF.city4 := IF(C = 4, R.company_city, L.city4),
			SELF.state4 := IF(C = 4, R.company_state, L.state4),
			SELF.zip4 := IF(C = 4, (STRING5)R.company_zip, L.zip4),
			SELF.phone4 := IF(C = 4, (STRING10)R.company_phone, L.phone4),
			SELF.business_contact_first5 := IF(C = 5, R.fname, L.business_contact_first5),
			SELF.business_contact_middle5 := IF(C = 5, R.mname, L.business_contact_middle5),
			SELF.business_contact_last5 := IF(C = 5, R.lname, L.business_contact_last5),
			SELF.business_contact_title5 := IF(C = 5, R.display_title , L.business_contact_title5),
			SELF.address5 := IF(C = 5, combined_address, L.address5),
			SELF.city5 := IF(C = 5, R.company_city, L.city5),
			SELF.state5 := IF(C = 5, R.company_state, L.state5),
			SELF.zip5 := IF(C = 5, (STRING5)R.company_zip, L.zip5),
			SELF.phone5 := IF(C = 5, (STRING10)R.company_phone, L.phone5),
			SELF := L;
	END;

END;