import LN_PropertyV2, ffd;

export layout_deed_records := record
	boolean current;
	integer3 address_seq_no := -1;
	string1  source_code;
	unsigned6	did;
	unsigned6	bdid;
	LN_PropertyV2.layout_deed_mortgage_common_model_base - vendor_source_flag;
	string5 vendor_source_flag;
	string18 buyer_county := '';
	
	// difference notes:  
	//		1.  vendor_source_flag is now only 1 character instead of 5
	//
	// check on the rest of these fields from common_model_base that were 

	string80   buyer1;
	string2    buyer1_id_code;
	string80   buyer2;
	string2    buyer2_id_code;
	string2    buyer_vesting_code;
	string1    buyer_addendum_flag;
	string150  visf_buyer_address;
	string40   buyer_mailing_address_care_of_name;
	string70   buyer_mailing_full_street_address;
	string6    buyer_mailing_address_unit_number;
	string51   buyer_mailing_address_citystatezip;
	string80   borrower1;
	string2    borrower1_id_code;
	string80   borrower2;
	string2    borrower2_id_code;
	string2    borrower_vesting_code;
	string70   borrower_mailing_full_street_address;
	string6    borrower_mailing_unit_number;
	string51   borrower_mailing_citystatezip;
	string1    borrower_address_code;

	string150  visf_seller_address;
	string150  visf_property_address;
	string10   hawaii_property_address_unit_number;
	string51  hawaii_legal; //though separated in the okc layout, it should be able to map to legal_brief_description

	string1    dummy_seg;
	string1    lexis_number;
	string1    page_number;
	string1    township;
	string1    land_use_code;
	string1    audit_trail;
	string1    audit1;
	string1    audit2;
	string1    audit3;
	string1    file_code;
	string1    fs_profile;
	string1    on_lexis;
	string1    report_number;
	string12   source;
	string12   content;
	string21   lxdseg;

	// fares fields 
	string1    fares_corporate_indicator;
	string3    fares_transaction_type;
	string60   fares_lender_address;
	string8    fares_mortgage_date;
	string6    fares_mortgage_deed_type;
	string4    fares_mortgage_term_code;
	string5    fares_mortgage_term;
	string9    fares_building_square_feet;
	string1    fares_foreclosure;
	string1    fares_refi_flag;
	string1    fares_equity_flag;
	string60   fares_iris_apn;

	//despite having some data - in V2 these were removed because OKC confirms these fields have no value and should be ignored
	string1   OKCTY_DEED_filler;
	string12  OKCTY_DEED_reserved;
	string29  OKCTY_DEED_reserved2;
	string71  OKCTY_MORT_filler;
	string68  OKCTY_MORT_filler2;
 
	FFD.Layouts.CommonRawRecordElements;

end;