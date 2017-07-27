
IMPORT BatchDatasets, BatchServices, Batchshare, DidVille;

EXPORT Layouts := MODULE
	
	EXPORT batch_in_raw := RECORD
		STRING20 acctno;
		STRING4  tax_year;
		STRING50 owner_name_1;
		STRING9  owner_ssn_1;
		STRING8  owner_dob_1;
		STRING50 owner_name_2;
		STRING9  owner_ssn_2;
		STRING8  owner_dob_2;
		STRING80 street_addr;
		STRING30 city;
		STRING2  state;
		STRING5  zip;
	END;

	EXPORT batch_in_raw_with_seq := RECORD (batch_in_raw)
		STRING20	orig_acctno 	:= ''; // [internal]
		Batchshare.Layouts.ShareErrors;
			// i.e.:
			// string6 	err_addr 	 	:= ''; // for address cleaner error messages ONLY 
			// unsigned	err_search 	:= 0;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
			// integer1	error_code 	:= 0;  // for any general purpose of "this" service. Can contain any value.
	END;

	EXPORT batch_in_raw_normed := RECORD
		STRING20 acctno;
		STRING4 tax_year;
		STRING owner_name;
		STRING owner_ssn;
		STRING owner_dob;
		STRING street_addr;
		STRING city;
		STRING state;
		STRING zip;
	END;
		
	EXPORT batch_in := RECORD(BatchDatasets.Layouts.batch_in)
		STRING4 tax_year;
		STRING50 record_err_msg := '';
		BOOLEAN is_rejected_rec := FALSE;
	END;

	// =================== temp record layouts ====================
	
	EXPORT layout_temp_PII_recs := RECORD
		STRING20 acctno;
		UNSIGNED6 did;
		STRING owner_age;
		STRING owner_ssn;
	END;

	EXPORT layout_temp_ADLBest_recs := RECORD
		STRING20 acctno;
		UNSIGNED6 did;
		DidVille.Layout_Best_fields;
	END;
	
	EXPORT layout_temp_deceased_recs := RECORD
		STRING20 acctno;
		STRING owner_isDeceased;
		STRING owner_date_of_death;
	END;
	
	EXPORT layout_temp_dl_recs := RECORD
		STRING20 acctno;
		STRING dl_state;
		STRING dl_activation_date;
	END;

	EXPORT layout_temp_voter_recs := RECORD
		STRING20 acctno;
		STRING res_st;
		STRING voter_status_exp;
		STRING active_status_exp;
	END;

	EXPORT layout_temp_intermediate := RECORD
		STRING20 acctno;
		// ----------[ Best ADL ]----------
		layout_temp_PII_recs AND NOT acctno;
		// ----------[ Deceased ]----------
		layout_temp_deceased_recs AND NOT acctno;
		// ----------[ DL data ]----------
		layout_temp_dl_recs AND NOT acctno;
		// ----------[ Voter data ]----------
		layout_temp_voter_recs AND NOT acctno;	
	END;
	
	EXPORT layout_prop_batch_plus	:= RECORD
	  STRING4 in_tax_year;
		STRING20 in_name_last;
		STRING20 in_name_first;
		UNSIGNED6 did;
		STRING50 clean_parcelID;
		STRING18 county_property;
		BOOLEAN isHomesteadExcemption;
		STRING2 homestead_exemption_flag;
		STRING2 homestead_count_years;
		STRING1 business_owner_flag;
		STRING1 business_seller_flag;
		STRING1 property_coownership;
		STRING1 coowner_mult_exemption;
		STRING8  sale_date ;
		STRING20 seller_first;
		STRING20 seller_last;
		STRING80 seller_company;
		STRING8 purchase_date;
		STRING1 owner_occupied;
		STRING2 ownership_length;
		STRING10 property_phone;
		STRING80 prop_full_address;
		batchServices.layout_Property_Batch_out
	END;	 
	// ----------[ 1 property of data ]----------
	EXPORT layout_temp_property_rec := RECORD
		STRING20 acctno;
		STRING20 owner_1_first_name;
		STRING20 owner_1_middle_name;
		STRING20 owner_1_last_name;
		STRING5  owner_1_name_suffix;
		STRING80 owner_1_company_name;
		STRING20 owner_2_first_name;
		STRING20 owner_2_middle_name;
		STRING20 owner_2_last_name;
		STRING5  owner_2_name_suffix;
		STRING80 owner_2_company_name;
		STRING45 parcel;
		STRING18 county_property;
		STRING50 property_address1;
		STRING20 property_address2;
		STRING25 property_p_city_name;
		STRING2  property_st;
		STRING5  property_zip;
		STRING4  property_zip4;
		STRING10 property_phone;
		STRING80 prop_full_address;
		STRING2  homestead_exemption_flag;
		STRING2  homestead_count_years;
		STRING2  owner_occupied;
		STRING20 seller_first;
		STRING20 seller_last;
		STRING80 seller_company;
		STRING8  sale_date ;
		STRING1  business_owner_flag;
		STRING1  business_seller_flag;
		STRING1  property_coownership;
		STRING1  coowner_mult_exemption;
		STRING8  purchase_date;
		STRING2  ownership_length;
	END;
	// =================== intermediate record layouts ====================
	
	EXPORT layout_PII_recs := RECORD
		STRING20 acctno;
		STRING8 owner_1_age;
		STRING8 owner_2_age;
		STRING9 owner_1_SSN;
		STRING9 owner_2_SSN;
	END;
	
	EXPORT layout_deceased_recs := RECORD
		STRING20 acctno;
		STRING1 owner_1_isDeceased;
		STRING1 owner_2_isDeceased;
		STRING8 owner_1_Date_of_death;
		STRING8 owner_2_Date_of_death;	
	END;
	
	EXPORT layout_dl_recs := RECORD
		STRING20 acctno;
		STRING2 dl_state_1;
		STRING8 dl_activation_date_1;
		STRING2 dl_state_2;
		STRING8 dl_activation_date_2;	
	END;
	
	EXPORT layout_voter_recs := RECORD
		STRING20 acctno;
		STRING2  res_st_1;
		STRING50 voter_status_exp_1;
		STRING20 active_status_exp_1;
		STRING2  res_st_2;
		STRING50 voter_status_exp_2;
		STRING20 active_status_exp_2;	
	END;

	EXPORT layout_property_recs := RECORD
		STRING20 acctno;
		STRING20 owner_1_first_name_1;
		STRING20 owner_1_middle_name_1;
		STRING20 owner_1_last_name_1;
		STRING5  owner_1_name_suffix_1;
		STRING80 owner_1_company_name_1;
		STRING20 owner_2_first_name_1;
		STRING20 owner_2_middle_name_1;
		STRING20 owner_2_last_name_1;
		STRING5  owner_2_name_suffix_1;
		STRING80 owner_2_company_name_1;
		STRING45 parcel_1;
		STRING18 county_property_1;
		STRING50 property_address1_1;
		STRING20 property_address2_1;
		STRING25 property_p_city_name_1;
		STRING2  property_st_1;
		STRING5  property_zip_1;
		STRING4  property_zip4_1;
		STRING10 property_phone_1;
		STRING80 prop_full_address_1;
		STRING2  homestead_exemption_flag_1;
		STRING2  homestead_count_years_1;
		STRING2  owner_occupied_1;
		STRING20 seller_first_1;
		STRING20 seller_last_1;
		STRING80 seller_company_1;
		STRING8  sale_date_1 ;
		STRING1  business_owner_flag_1;
		STRING1  business_seller_flag_1;
		STRING1  property_coownership_1;
		STRING1  coowner_mult_exemption_1;
		STRING8  purchase_date_1;
		STRING2  ownership_length_1;
		STRING20 owner_1_first_name_2;
		STRING20 owner_1_middle_name_2;
		STRING20 owner_1_last_name_2;
		STRING5  owner_1_name_suffix_2;
		STRING80 owner_1_company_name_2;
		STRING20 owner_2_first_name_2;
		STRING20 owner_2_middle_name_2;
		STRING20 owner_2_last_name_2;
		STRING5  owner_2_name_suffix_2;
		STRING80 owner_2_company_name_2;
		STRING45 parcel_2;
		STRING18 county_property_2;
		STRING50 property_address1_2;
		STRING20 property_address2_2;
		STRING25 property_p_city_name_2;
		STRING2  property_st_2;
		STRING5  property_zip_2;
		STRING4  property_zip4_2;
		STRING10 property_phone_2;
		STRING80 prop_full_address_2;
		STRING2  homestead_exemption_flag_2;
		STRING2  homestead_count_years_2;
		STRING2  owner_occupied_2;
		STRING20 seller_first_2;
		STRING20 seller_last_2;
		STRING80 seller_company_2;
		STRING8  sale_date_2;
		STRING1  business_owner_flag_2;
		STRING1  business_seller_flag_2;
		STRING1  property_coownership_2;
		STRING1  coowner_mult_exemption_2;
		STRING8  purchase_date_2;
		STRING2  ownership_length_2;
		STRING20 owner_1_first_name_3;
		STRING20 owner_1_middle_name_3;
		STRING20 owner_1_last_name_3;
		STRING5  owner_1_name_suffix_3;
		STRING80 owner_1_company_name_3;
		STRING20 owner_2_first_name_3;
		STRING20 owner_2_middle_name_3;
		STRING20 owner_2_last_name_3;
		STRING5  owner_2_name_suffix_3;
		STRING80 owner_2_company_name_3;
		STRING45 parcel_3;
		STRING18 county_property_3;
		STRING50 property_address1_3;
		STRING20 property_address2_3;
		STRING25 property_p_city_name_3;
		STRING2  property_st_3;
		STRING5  property_zip_3;
		STRING4  property_zip4_3;
		STRING10 property_phone_3;
		STRING80 prop_full_address_3;
		STRING2  homestead_exemption_flag_3;
		STRING2  homestead_count_years_3;
		STRING2  owner_occupied_3;
		STRING20 seller_first_3;
		STRING20 seller_last_3;
		STRING80 seller_company_3;
		STRING8  sale_date_3;
		STRING1  business_owner_flag_3;
		STRING1  business_seller_flag_3;
		STRING1  property_coownership_3;
		STRING1  coowner_mult_exemption_3;
		STRING8  purchase_date_3;
		STRING2  ownership_length_3;
		STRING20 owner_1_first_name_4;
		STRING20 owner_1_middle_name_4;
		STRING20 owner_1_last_name_4;
		STRING5  owner_1_name_suffix_4;
		STRING80 owner_1_company_name_4;
		STRING20 owner_2_first_name_4;
		STRING20 owner_2_middle_name_4;
		STRING20 owner_2_last_name_4;
		STRING5  owner_2_name_suffix_4;
		STRING80 owner_2_company_name_4;
		STRING45 parcel_4;
		STRING18 county_property_4;
		STRING50 property_address1_4;
		STRING20 property_address2_4;
		STRING25 property_p_city_name_4;
		STRING2  property_st_4;
		STRING5  property_zip_4;
		STRING4  property_zip4_4;
		STRING10 property_phone_4;
		STRING80 prop_full_address_4;
		STRING2  homestead_exemption_flag_4;
		STRING2  homestead_count_years_4;
		STRING2  owner_occupied_4;
		STRING20 seller_first_4;
		STRING20 seller_last_4;
		STRING80 seller_company_4;
		STRING8  sale_date_4;
		STRING1  business_owner_flag_4;
		STRING1  business_seller_flag_4;
		STRING1  property_coownership_4;
		STRING1  coowner_mult_exemption_4;
		STRING8  purchase_date_4;
		STRING2  ownership_length_4;
		STRING20 owner_1_first_name_5;
		STRING20 owner_1_middle_name_5;
		STRING20 owner_1_last_name_5;
		STRING5  owner_1_name_suffix_5;
		STRING80 owner_1_company_name_5;
		STRING20 owner_2_first_name_5;
		STRING20 owner_2_middle_name_5;
		STRING20 owner_2_last_name_5;
		STRING5  owner_2_name_suffix_5;
		STRING80 owner_2_company_name_5;
		STRING45 parcel_5;
		STRING18 county_property_5;
		STRING50 property_address1_5;
		STRING20 property_address2_5;
		STRING25 property_p_city_name_5;
		STRING2  property_st_5;
		STRING5  property_zip_5;
		STRING4  property_zip4_5;
		STRING10 property_phone_5;
		STRING80 prop_full_address_5;
		STRING2  homestead_exemption_flag_5;
		STRING2  homestead_count_years_5;
		STRING2  owner_occupied_5;
		STRING20 seller_first_5;
		STRING20 seller_last_5;
		STRING80 seller_company_5;
		STRING8  sale_date_5;
		STRING1  business_owner_flag_5;
    STRING1  business_seller_flag_5;
    STRING1  property_coownership_5;
    STRING1  coowner_mult_exemption_5;
		STRING8  purchase_date_5;
		STRING2  ownership_length_5;
		STRING20 owner_1_first_name_6;
		STRING20 owner_1_middle_name_6;
		STRING20 owner_1_last_name_6;
		STRING5  owner_1_name_suffix_6;
		STRING80 owner_1_company_name_6;
		STRING20 owner_2_first_name_6;
		STRING20 owner_2_middle_name_6;
		STRING20 owner_2_last_name_6;
		STRING5  owner_2_name_suffix_6;
		STRING80 owner_2_company_name_6;
		STRING45 parcel_6;
		STRING18 county_property_6;
		STRING50 property_address1_6;
		STRING20 property_address2_6;
		STRING25 property_p_city_name_6;
		STRING2  property_st_6;
		STRING5  property_zip_6;
		STRING4  property_zip4_6;
		STRING10 property_phone_6;
		STRING80 prop_full_address_6;
		STRING2  homestead_exemption_flag_6;
		STRING2  homestead_count_years_6;
		STRING2  owner_occupied_6;
		STRING20 seller_first_6;
		STRING20 seller_last_6;
		STRING80 seller_company_6;
		STRING8  sale_date_6;
		STRING1  business_owner_flag_6;
    STRING1  business_seller_flag_6;
    STRING1  property_coownership_6;
    STRING1  coowner_mult_exemption_6;
		STRING8  purchase_date_6;
		STRING2  ownership_length_6;
		STRING20 owner_1_first_name_7;
		STRING20 owner_1_middle_name_7;
		STRING20 owner_1_last_name_7;
		STRING5  owner_1_name_suffix_7;
		STRING80 owner_1_company_name_7;
		STRING20 owner_2_first_name_7;
		STRING20 owner_2_middle_name_7;
		STRING20 owner_2_last_name_7;
		STRING5  owner_2_name_suffix_7;
		STRING80 owner_2_company_name_7;
		STRING45 parcel_7;
		STRING18 county_property_7;
		STRING50 property_address1_7;
		STRING20 property_address2_7;
		STRING25 property_p_city_name_7;
		STRING2  property_st_7;
		STRING5  property_zip_7;
		STRING4  property_zip4_7;
		STRING10 property_phone_7;
		STRING80 prop_full_address_7;
		STRING2  homestead_exemption_flag_7;
		STRING2  homestead_count_years_7;
		STRING2  owner_occupied_7;
		STRING20 seller_first_7;
		STRING20 seller_last_7;
		STRING80 seller_company_7;
		STRING8  sale_date_7;
		STRING1  business_owner_flag_7;
    STRING1  business_seller_flag_7;
    STRING1  property_coownership_7;
    STRING1  coowner_mult_exemption_7;
		STRING8  purchase_date_7;
		STRING2  ownership_length_7;
		STRING20 owner_1_first_name_8;
		STRING20 owner_1_middle_name_8;
		STRING20 owner_1_last_name_8;
		STRING5  owner_1_name_suffix_8;
		STRING80 owner_1_company_name_8;
		STRING20 owner_2_first_name_8;
		STRING20 owner_2_middle_name_8;
		STRING20 owner_2_last_name_8;
		STRING5  owner_2_name_suffix_8;
		STRING80 owner_2_company_name_8;
		STRING45 parcel_8;
		STRING18 county_property_8;
		STRING50 property_address1_8;
		STRING20 property_address2_8;
		STRING25 property_p_city_name_8;
		STRING2  property_st_8;
		STRING5  property_zip_8;
		STRING4  property_zip4_8;
		STRING10 property_phone_8;
		STRING80 prop_full_address_8;
		STRING2  homestead_exemption_flag_8;
		STRING2  homestead_count_years_8;
		STRING2  owner_occupied_8;
		STRING20 seller_first_8;
		STRING20 seller_last_8;
		STRING80 seller_company_8;
		STRING8  sale_date_8;
		STRING1  business_owner_flag_8;
    STRING1  business_seller_flag_8;
    STRING1  property_coownership_8;
    STRING1  coowner_mult_exemption_8;
		STRING8  purchase_date_8;
		STRING2  ownership_length_8;
		STRING20 owner_1_first_name_9;
		STRING20 owner_1_middle_name_9;
		STRING20 owner_1_last_name_9;
		STRING5  owner_1_name_suffix_9;
		STRING80 owner_1_company_name_9;
		STRING20 owner_2_first_name_9;
		STRING20 owner_2_middle_name_9;
		STRING20 owner_2_last_name_9;
		STRING5  owner_2_name_suffix_9;
		STRING80 owner_2_company_name_9;
		STRING45 parcel_9;
		STRING18 county_property_9;
		STRING50 property_address1_9;
		STRING20 property_address2_9;
		STRING25 property_p_city_name_9;
		STRING2  property_st_9;
		STRING5  property_zip_9;
		STRING4  property_zip4_9;
		STRING10 property_phone_9;
		STRING80 prop_full_address_9;
		STRING2  homestead_exemption_flag_9;
		STRING2  homestead_count_years_9;
		STRING2  owner_occupied_9;
		STRING20 seller_first_9;
		STRING20 seller_last_9;
		STRING80 seller_company_9;
		STRING8  sale_date_9;
		STRING1  business_owner_flag_9;
    STRING1  business_seller_flag_9;
    STRING1  property_coownership_9;
    STRING1  coowner_mult_exemption_9;
		STRING8  purchase_date_9;
		STRING2  ownership_length_9;
		STRING20 owner_1_first_name_10;
		STRING20 owner_1_middle_name_10;
		STRING20 owner_1_last_name_10;
		STRING5  owner_1_name_suffix_10;
		STRING80 owner_1_company_name_10;
		STRING20 owner_2_first_name_10;
		STRING20 owner_2_middle_name_10;
		STRING20 owner_2_last_name_10;
		STRING5  owner_2_name_suffix_10;
		STRING80 owner_2_company_name_10;
		STRING45 parcel_10;
		STRING18 county_property_10;
		STRING50 property_address1_10;
		STRING20 property_address2_10;
		STRING25 property_p_city_name_10;
		STRING2  property_st_10;
		STRING5  property_zip_10;
		STRING4  property_zip4_10;
		STRING10 property_phone_10;
		STRING80 prop_full_address_10;
		STRING2  homestead_exemption_flag_10;
		STRING2  homestead_count_years_10;
		STRING2  owner_occupied_10;
		STRING20 seller_first_10;
		STRING20 seller_last_10;
		STRING80 seller_company_10;
		STRING8  sale_date_10;
		STRING1  business_owner_flag_10;
    STRING1  business_seller_flag_10;
    STRING1  property_coownership_10;
    STRING1  coowner_mult_exemption_10;
		STRING8  purchase_date_10;
		STRING2  ownership_length_10;
END;			
	// =================== final output record layout ====================
	
	EXPORT batch_out := RECORD
		STRING20 acctno;
		UNSIGNED6 did1;
		UNSIGNED6 did2;
		// ----------[ Best ADL data ]----------
		layout_PII_recs AND NOT acctno;
		// ----------[ Deceased data ]----------
		layout_deceased_recs AND NOT acctno;
		// ----------[ DL data ]----------
		layout_dl_recs AND NOT acctno;
		// ----------[ Voter data ]----------
		layout_voter_recs AND NOT acctno;	
		// ----------[ Property data ]----------
		layout_property_recs AND NOT acctno;
		Batchshare.Layouts.ShareErrors;
	END;
	
END;