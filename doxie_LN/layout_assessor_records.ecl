import LN_PropertyV2, ffd;

export layout_assessor_records := record
	boolean current;
	integer3 address_seq_no := -1;
	string1  source_code;
	unsigned6	did;
	unsigned6	bdid;
	LN_PropertyV2.Layout_Property_Common_Model_BASE - vendor_source_flag;
	string5 vendor_source_flag;
	
	string18 mailing_county := '';
	string50 land_use_decoded;
	
	// difference notes:  
	//		1.  vendor_source_flag is now only 1 character instead of 5
	//		2.  tax_amount changed to string13 in v2, was string11 in v1
	
	// check on the rest of these fields from common_model_base that were in V1
	string150	visf_mailing_address;
	string150	visf_prop_address;

	string60  fares_iris_apn;
	string60	fares_non_parsed_assessee_name;
	string60	fares_non_parsed_second_assessee_name;	
	string250	fares_legal2;
	string250	fares_legal3;	
	string10	fares_land_use;	
	string60	fares_seller_name;
	string11	fares_calculated_land_value;
	string11	fares_calculated_improvement_value;
	string11	fares_calculated_total_value;  
	string7	fares_living_square_feet;
	string7	fares_adjusted_gross_square_feet;  
	string5	fares_no_of_full_baths;
	string5	fares_no_of_half_baths;
	string1	fares_pool_indicator;  
	string3	fares_frame;
	string3	fares_electric_energy;
	string3	fares_sewer;
	string3	fares_water;
	string3	fares_condition; 

	string1	dummy_seg;
	string1	lexis_no;
	string1	page_no;
	string1	owner_2;
	string1	message_1;
	string1	message_2;
	string1	vdi;
	string1	audit_trail;
	string1	audit_1;
	string1	audit_2;
	string1	audit_3;
	string1	file_code;
	string1	on_lexis;
	string1	source;
	string1	content;
	string1	copy_2;
	string1	lxdseg;
	string85 filler2;
	
	FFD.Layouts.CommonRawRecordElements;
end;