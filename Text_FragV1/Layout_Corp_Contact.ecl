IMPORT Corp2,BIPV2;
EXPORT Layout_Corp_Contact := RECORD
	Corp2.Layout_Corporate_Direct_Cont_Base.dt_first_seen;
	Corp2.Layout_Corporate_Direct_Cont_Base.dt_last_seen;
	Corp2.Layout_Corporate_Direct_Cont_Base.dt_vendor_first_reported;
	Corp2.Layout_Corporate_Direct_Cont_Base.dt_vendor_last_reported;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_key;			// Link key fro document
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_supp_key; // new
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_vendor;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_vendor_subcode; // new
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_state_origin;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_legal_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_address1_line1;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_address1_line2;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_address1_line3;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_address1_line4;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_address1_line5;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_address1_line6;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_phone_number;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_fax_nbr; // new
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_title_desc;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_ssn;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_dob;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_address_line1;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_address_line2;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_address_line3;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_address_line4;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_address_line5;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_address_line6;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_phone_number;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_fax_nbr; // new
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_email_address;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_web_address;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_prim_range;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_predir;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_prim_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_addr_suffix;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_postdir;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_unit_desig;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_sec_range;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_p_city_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_v_city_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_state;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_zip5;
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_addr1_zip4;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_title;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_fname;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_mname;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_lname;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_name_suffix;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_cname;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_prim_range;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_predir;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_prim_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_addr_suffix;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_postdir;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_unit_desig;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_sec_range;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_p_city_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_v_city_name;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_state;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_zip5;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_zip4;
	UNSIGNED6 bdid := 0;       
	UNSIGNED6 did := 0;
	UNSIGNED6 rid := 0;
	UNSIGNED6 sid;
	STRING2 source;		// fCorpV2(string pCorpKey	,string pcorp_state_origin = '')
	BIPV2.IDlayouts.l_xlink_ids;
END;