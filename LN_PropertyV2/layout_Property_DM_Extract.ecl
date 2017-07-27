export layout_Property_DM_Extract := record
		layout_deed_mortgage_common_model_base.ln_fares_id;
		layout_property_common_model_base.vendor_source_flag;
		layout_deed_mortgage_common_model_base.process_date;
		layout_deed_mortgage_common_model_base.state;
		layout_deed_mortgage_common_model_base.county_name;
		layout_deed_mortgage_common_model_base.apnt_or_pin_number;	
		layout_deed_mortgage_common_model_base.fares_unformatted_apn;
		layout_deed_mortgage_common_model_base.buyer_or_borrower_ind; //new - 'O' for buyer, 'B' for borrower
		layout_deed_mortgage_common_model_base.name1; //new
		layout_deed_mortgage_common_model_base.name1_id_code; //new
		layout_deed_mortgage_common_model_base.name2; //new
		layout_deed_mortgage_common_model_base.name2_id_code; //new
		layout_deed_mortgage_common_model_base.mailing_care_of; //new
		layout_deed_mortgage_common_model_base.mailing_street; //new
		layout_deed_mortgage_common_model_base.mailing_unit_number; //new
		layout_deed_mortgage_common_model_base.mailing_csz; //new
		layout_deed_mortgage_common_model_base.mailing_address_cd; //new 
		layout_deed_mortgage_common_model_base.seller1;
		layout_deed_mortgage_common_model_base.seller1_id_code;
		layout_deed_mortgage_common_model_base.seller2;
		layout_deed_mortgage_common_model_base.seller2_id_code;
		layout_deed_mortgage_common_model_base.seller_addendum_flag;
		layout_deed_mortgage_common_model_base.seller_mailing_full_street_address;
		layout_deed_mortgage_common_model_base.seller_mailing_address_unit_number;
		layout_deed_mortgage_common_model_base.seller_mailing_address_citystatezip;
		layout_deed_mortgage_common_model_base.property_full_street_address;
		layout_deed_mortgage_common_model_base.property_address_unit_number;
		layout_deed_mortgage_common_model_base.property_address_citystatezip;
		layout_deed_mortgage_common_model_base.property_address_code;
		layout_deed_mortgage_common_model_base.contract_date;
		layout_deed_mortgage_common_model_base.recording_date;
		layout_deed_mortgage_common_model_base.main_record_id_code; //new - in okc deed	
	  layout_deed_mortgage_common_model_base.lender_name;
    layout_deed_mortgage_common_model_base.lender_dba_aka_name;   		
    layout_deed_mortgage_common_model_base.lender_full_street_address;
    layout_deed_mortgage_common_model_base.lender_address_unit_number;
    layout_deed_mortgage_common_model_base.lender_address_citystatezip;		
    layout_deed_mortgage_common_model_base.legal_city_municipality_township;
    layout_deed_mortgage_common_model_base.legal_sec_twn_rng_mer;
    layout_deed_mortgage_common_model_base.legal_brief_description;
    layout_deed_mortgage_common_model_base.recorder_map_reference;   
    layout_deed_mortgage_common_model_base.document_number;
    layout_deed_mortgage_common_model_base.loan_number;		
    layout_deed_mortgage_common_model_base.recorder_book_number;
    layout_deed_mortgage_common_model_base.recorder_page_number;
		string1 separator :='/';  
    layout_deed_mortgage_common_model_base.hawaii_condo_name;
    layout_deed_mortgage_common_model_base.sales_price;    
    layout_deed_mortgage_common_model_base.city_transfer_tax;
    layout_deed_mortgage_common_model_base.county_transfer_tax;
    layout_deed_mortgage_common_model_base.total_transfer_tax;
    layout_deed_mortgage_common_model_base.excise_tax_number;
    layout_deed_mortgage_common_model_base.timeshare_flag;
    layout_deed_mortgage_common_model_base.rate_change_frequency;
    layout_deed_mortgage_common_model_base.change_index;
    layout_deed_mortgage_common_model_base.adjustable_rate_index;
    layout_deed_mortgage_common_model_base.first_td_loan_amount;
    layout_deed_mortgage_common_model_base.second_td_loan_amount;
    layout_deed_mortgage_common_model_base.type_financing;
    layout_deed_mortgage_common_model_base.first_td_interest_rate;
    layout_deed_mortgage_common_model_base.first_td_due_date;
    layout_deed_mortgage_common_model_base.title_company_name;
    layout_deed_mortgage_common_model_base.partial_interest_transferred;
    layout_addl_fares_deed.fares_mortgage_date;
    layout_addl_fares_deed.fares_mortgage_deed_type;
		layout_addl_fares_deed.fares_mortgage_term;
		string330 legal_lot_desc := '';
		string330 document_type_desc := '';
		string330 hawaii_condo_cpr_desc := '';
		string330 sales_price_desc := '';
		string330 assessment_match_land_use_desc := '';
		string330 property_use_desc := '';
		string330 condo_desc := '';
		string330 first_td_lender_type_desc := '';
		string330 second_td_lender_type_desc := '';
		string330 first_td_loan_type_desc := '';
		string330 record_type_desc := '';
		string330 type_financing_desc := '';
		string330 mortgage_deed_type_desc := '';				
		string30	legal_lot_number;
		string25	legal_land_lot;	
		string20	legal_block;
		string20	legal_section;
		string30	legal_district;
		string20	legal_unit;
		string60	legal_subdivision_name;
		string20	legal_phase_number;
		string20	legal_tract_number;
		string35 	 hawaii_tct;
		string25   adjustable_rate_rider;
	  string30   graduated_payment_rider;
	  string20   balloon_rider;
	  string25   fixed_step_rate_rider;
		string25   condominium_rider;
	  string35   planned_unit_development_rider;
	  string30   rate_improvement_rider;
	  string25   assumability_rider;
	  string25   prepayment_rider;
	  string25   one_four_family_rider;
	  string30   biweekly_payment_rider;
	  string25   second_home_rider;
    string15	 loan_term_months;
		string15	 loan_term_years;
		 //extra fields
		string80   buyer1;
		string80   buyer2;
		string70   buyer_mailing_full_street_address;
		string6    buyer_mailing_address_unit_number;
		string51   buyer_mailing_address_citystatezip;
		string80   borrower1;
		string80   borrower2;
		string70   borrower_mailing_full_street_address;
		string6    borrower_mailing_unit_number;
		string51   borrower_mailing_citystatezip;	 
		layout_search_out.title;
		layout_search_out.fname;
		layout_search_out.mname;
		layout_search_out.lname;
		layout_search_out.name_suffix;
		layout_search_out.cname;
		layout_search_out.nameasis;
		layout_search_out.prim_range;
		layout_search_out.predir;
		layout_search_out.prim_name;
		layout_search_out.suffix;
		layout_search_out.postdir;
		layout_search_out.unit_desig;
		layout_search_out.sec_range;
		layout_search_out.v_city_name;
		layout_search_out.st;
		layout_search_out.zip;
		layout_search_out.zip4;
		layout_search_out.phone_number;
		layout_search_out.dt_first_seen; //new
		layout_search_out.dt_last_seen; //new
		layout_search_out.dt_vendor_first_reported; //new
		layout_search_out.dt_vendor_last_reported; //new		
		STRING2	 source;
		/* fields from assessor */
		STRING8 date_from_assesor;
    STRING field_from_assesor;
    STRING8 transfer_date;
    STRING8 sale_date;
		
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED6 rid;
		UNSIGNED6 sid;   
end;