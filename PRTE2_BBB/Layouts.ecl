IMPORT BBB2, bipv2, address;

EXPORT Layouts := MODULE

	SHARED Common := RECORD
			unsigned6	bdid;
			unsigned4	date_first_seen;
			unsigned4	date_last_seen;
			unsigned4	dt_vendor_first_reported;
			unsigned4	dt_vendor_last_reported;
			unsigned4	process_date_first_seen;
			unsigned4	process_date_last_seen;
			string1		record_type;
	END;
	
	EXPORT Member_Base_Layout := RECORD
		bipv2.IDlayouts.l_xlink_ids;
		unsigned8 source_rec_id := 0;
		Common;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		string7		bbb_id;
		string100	company_name;
		string100	address;
		string12	country;
		string14	phone;
		string8		phone_type;
		string8		report_date;
		string255	http_link;
		string100	member_title;
		string8		member_since_date;
		string100	member_category;
		address.Layout_Clean182_fips;
		string10	phone10;
		BBB2.Layouts_Files.Base.Layout_Addr_AID;
		STRING 		link_inc_date;
		STRING 		link_fein;
		STRING 		cust_name;
		STRING 		bug_num;
	END;
	
	EXPORT Member_Key_Bdid := RECORD
		Common;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		STRING7 	bbb_id;
		STRING100 company_name;
		STRING100 address;
		STRING12 	country;
		STRING14 	phone;
		STRING8 	phone_type;
		STRING8 	report_date;
		STRING255 http_link;
		STRING100 member_title;
		STRING8 	member_since_date;
		STRING100 member_category;
		address.Layout_Clean182_fips;
		STRING10 	phone10;
	END;
	
	EXPORT Member_Key_Linkids := RECORD
		bipv2.IDlayouts.l_xlink_ids;
		UNSIGNED8 source_rec_id;
		Common;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		STRING7 bbb_id;
		STRING100 company_name;
		STRING100 address;
		STRING12 country;
		STRING14 phone;
		STRING8 phone_type;
		STRING8 report_date;
		STRING255 http_link;
		STRING100 member_title;
		STRING8 member_since_date;
		STRING100 member_category;
		address.Layout_Clean182_fips;
		STRING10 phone10;
	END;
	
	EXPORT NonMember_Base_Layout := RECORD
		bipv2.IDlayouts.l_xlink_ids;
		UNSIGNED8 source_rec_id := 0;
		Common;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		STRING7		bbb_id;
		STRING100	company_name;
		STRING100	address;
		STRING12	country;
		STRING14	phone;
		STRING8		phone_type;
		STRING8		report_date;
		STRING255 	http_link;
		STRING100	non_member_title;
		STRING100	non_member_category;
		address.Layout_Clean182_fips;
		STRING10	phone10;
		BBB2.Layouts_Files.Base.Layout_Addr_AID;
		STRING link_inc_date;
		STRING link_fein;
		STRING cust_name;
		STRING bug_num;
	END;

	EXPORT Nonmember_Key_Bdid := RECORD
		Common;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		STRING7 bbb_id;
		STRING100 company_name;
		STRING100 address;
		STRING12 country;
		STRING14 phone;
		STRING8 phone_type;
		STRING8 report_date;
		STRING255 http_link;
		STRING100 non_member_title;
		STRING100 non_member_category;
		address.Layout_Clean182_fips;
		STRING10 phone10;
	END;
	
	EXPORT Nonmember_Key_Linkids := RECORD
		bipv2.IDlayouts.l_xlink_ids;
		UNSIGNED8 source_rec_id;
		Common;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		STRING7 bbb_id;
		STRING100 company_name;
		STRING100 address;
		STRING12 country;
		STRING14 phone;
		STRING8 phone_type;
		STRING8 report_date;
		STRING255 http_link;
		STRING100 non_member_title;
		STRING100 non_member_category;
		address.Layout_Clean182_fips;
		STRING10 phone10;
	END;
	
	EXPORT temp_address_layout := RECORD 
    STRING70  prep_addr_line1;
    STRING70  prep_addr_line_last;
    UNSIGNED8 member_row_id;
    UNSIGNED8 nonmember_row_id;
  END;
	
END;